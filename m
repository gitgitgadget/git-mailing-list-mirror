Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B13B202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 20:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751081AbdKSUe0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 15:34:26 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:39898 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbdKSUeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 15:34:25 -0500
Received: by mail-it0-f42.google.com with SMTP id y15so9619461ita.4
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 12:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7YNtF85QffQXWeMw80ldPm/pC2mH0SYQV1bWPiMgDQc=;
        b=IA16478KE9p1a3EQLEhJnaISUfsfkWYyy3e1q+5tlmIN7McY1AjoCvXXaHsjjIDkx8
         DJZQqlSUUFHN0TDQqXAayfPednipKnfMFvpm6tNWlLmfG+cwUUKpXMvse4t/JqaXj0zq
         1GbQ0Kk/bYEr99NSgJGPfPNFp+zHWq+jPJ6RieYFkWRXMXjEeEeTl6zhQK/dRdqyNu6q
         wQ8l9hH/nmygSCWIBILQqfl1P8N+Sm/WLdvcMFw8olwknhqz4BlsaPpRgH2V6OJdJZIz
         8MtGM0CYjlMPvm1X5MhVmn1n1dblOTHVZpb8LXtNRhvN3Qys/NhM/jYcxvicH2fdhuMT
         ofmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7YNtF85QffQXWeMw80ldPm/pC2mH0SYQV1bWPiMgDQc=;
        b=dnZ7lYJvzQxBAFgyDLjYnJ5rnszjQtpbY0jkum5pO/kWWDKcQxzjtdQV9gzLiCV6Nb
         d08O39sFKYUoKpXHFY/zDyk4XbsvkyhxdfcPoB8WOwMKlrBoR39Mh0kackY+6ieFMxZ+
         L7g7nY9DQgfX+II/LHTE8gdhEYdMps9lqqzzi+yTggPD866mLFvCODD+TODhgqwjhNJ4
         I+hPvtnOHsWHM2sPc+4P6CxJSxkLceUx6B2psE+zBBqzHppxYhKA8lhsBq6/Mw9cBpCV
         eBtqTw8RF17GitKVesfgXxOkQ4dWgoHq58L0aC1YM/Gd/qLPISZ7xv4XJk+3AJJMTtdD
         pQ2g==
X-Gm-Message-State: AJaThX5F0SxUDWCp9SkJyT4BuyDYBLMoxGdRopWpgNKWjGb+epQMEVJS
        rpj/UPQSlWODLq/65aoS2Y2Djj5iDTiGLH4nGnJeezAK
X-Google-Smtp-Source: AGs4zMaB/mQcjWtGKdmtNawg6NSMbZUWWpl9Q+9ucBPXs/bBMXMMLPZSIs/2rgZ/ULApeQXC2LkDfCbw+1mEGo4ifQA=
X-Received: by 10.36.53.15 with SMTP id k15mr16449541ita.75.1511123664730;
 Sun, 19 Nov 2017 12:34:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sun, 19 Nov 2017 12:34:24 -0800 (PST)
In-Reply-To: <0102015ecc65d76b-124658b5-5b79-4321-a6cc-01be807c62aa-000000@eu-west-1.amazonses.com>
References: <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
 <0102015ecc65d76b-124658b5-5b79-4321-a6cc-01be807c62aa-000000@eu-west-1.amazonses.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 19 Nov 2017 21:34:24 +0100
Message-ID: <CAP8UFD3SYU_+MOT-TGCV4uJ-cxrd9VhgOOprkq-XP0CUhtGTig@mail.gmail.com>
Subject: Re: [PATCH v16 6/6] bisect--helper: `is_expected_rev` &
 `check_expected_revs` shell function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 8:49 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Reimplement `is_expected_rev` & `check_expected_revs` shell function in
> C and add a `--check-expected-revs` subcommand to `git bisect--helper` to
> call it from git-bisect.sh .

It looks like this patch forgot to add the `--check-expected-revs`
subcommand to the usage string.

Pranit could you send a fix for that?

Thanks,
Christian.
