Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 093F01F954
	for <e@80x24.org>; Fri, 17 Aug 2018 22:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeHRBMX (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 21:12:23 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:45285 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeHRBMX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 21:12:23 -0400
Received: by mail-pl0-f53.google.com with SMTP id j8-v6so4278390pll.12
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 15:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lcnKl09Tv65SR7f4XwFXBV7PY1qAhtwLeH0IOQTePoU=;
        b=PbcOhUugKov+eBEt2PD6oc9GXBBw0g4GHOFcB6WvOqLCpSjckTNZZTX1qbXccyw0RF
         r85X1AKdoc9A3EeT0ePTP1pEkxE+5IpnIFWwZpes+nrLrLa8yrtnAIs+P53fgRogT6pe
         cQdQlE93nGjjbQVtHBOREN6hT5yNhkyLfPe4N39wluTYtNn07bAmTKwKf5ECzFpbISAk
         WjZiuWlE50OS/iw6BpDOgyZZiYdIkvtBGwuErqi/pLQsShxgieY1/Z8v8El4WsuNrp+4
         oMlsWznZ9vtt+Ih1fCbPO8EfpJhyYNY21ArwHlcxJrvaPmwVvjng9fgZE7Y9UfjZ6Yl+
         uguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lcnKl09Tv65SR7f4XwFXBV7PY1qAhtwLeH0IOQTePoU=;
        b=rv3d+7YGrlfVQw2Ei9+2Ynz6g0+IVZx3u20kS2zIOpZVm79x3aPdG4R2h5uptiwtx5
         2Ui0Z1XXAgQIlrwKerQ/YO6uK5rs2tPg471IbuU31GYpjNQK20ytZAWLDYlnLAaqr1aU
         UH26tbsOtoR5qXtHxqO+FmjIU2owsxK5Dwd67MtoLoXrqVAbozaofizP1/B7BFZ/T6zV
         5Rx34zFkxT2drg8c/SoGHaTstqsX6azdGQaBOQZPoqNfpO0bP8wDb+pvmF/pq2gEJKl3
         n3UaI9nDh82LGUA0PnudAZ//r0eJWgllPvEkGnVg3+UzSc1HIbVysn+xpIuTWF4s9n7N
         +Www==
X-Gm-Message-State: AOUpUlGkskNLXI9Tdb5J/s42rJQRVYoIEzmxHF/m88el8uI0HED+DCBT
        HlnTwzp6RFQ+opt6ouq6Q9YxZ2DOnNvN+1ClBeruqvQk
X-Google-Smtp-Source: AA+uWPzfZnJxRt1jYGlWIwBA4I7U020/JWoFMAHFzj8uDer//sHpU3F1SeSLI/jELt9nVZHvHMychrO46dB1B6RHCVw=
X-Received: by 2002:a17:902:7b97:: with SMTP id w23-v6mr35656678pll.66.1534543636033;
 Fri, 17 Aug 2018 15:07:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de05:0:0:0:0 with HTTP; Fri, 17 Aug 2018 15:06:35
 -0700 (PDT)
From:   =?UTF-8?Q?Michael_Mur=C3=A9?= <batolettre@gmail.com>
Date:   Sat, 18 Aug 2018 00:06:35 +0200
Message-ID: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
Subject: git-bug: Distributed bug tracker embedded in git
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I released today git-bug, a distributed bug tracker that embeds in
git. It use git's internal storage to store bugs information in a way
that can be merged without conflict. You can push/pull to the normal
git remote you are already using to interact with other people. Normal
code and bugs are completely separated and no files are added in the
regular branches.

Someone suggested in the Hacker News thread [0] to post it here as well.

The project is here [1].

It's a all-in-one binary that is picked up by git as a porcelain
command. It features a set of CLI command for simple interaction, an
interactive terminal UI and a rich web UI.

For more information about the internal design, please read this
document [2]. In short, bugs are stored as a series of edit operations
stored in git blobs and assembled in a linear chain of commits. This
allow to have conflict-free merge and to not pollute the regular
branches with bug data. Media embedding is also possible but not yet
finished.

I'd love to have some feedback from you. Contribution are also very
much welcomed.

Best regards,

[0]: https://news.ycombinator.com/item?id=3D17782121
[1]: https://github.com/MichaelMure/git-bug
[2]: https://github.com/MichaelMure/git-bug/blob/master/doc/model.md

--=20
Michael Mur=C3=A9
