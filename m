Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 234411F51C
	for <e@80x24.org>; Sun, 20 May 2018 13:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbeETNY3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 09:24:29 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:38594 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbeETNY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 09:24:28 -0400
Received: by mail-ua0-f180.google.com with SMTP id y8-v6so8275573ual.5
        for <git@vger.kernel.org>; Sun, 20 May 2018 06:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z4DgqsHOES9btSykJRqlzpgeGfUXIGi+hdn8mlaj5VQ=;
        b=jllc5+20mdAaEddfm2g5m7Xjbavr3dKnzZ2Gp7lDSvshA9lBRqSj1OvDHNtPQkFz22
         63g2CW1b5m9r6/WQXwG7aBp1AEwLu/v02kiDHw3IvFsMVmBJlf7wrl8Q/EItzqyG524D
         9JaA2L4OuzpxeQKoSUKtwvZB12++TxybMcln+FUxEEPtMXkLb0OxstQZdL1ftHOnbBkf
         jWGgxPLjso55jGAnLXjCUU2W5NlwllLbqx2p/9eQ4bTk08CpqjcduJADZI2u/AsZqkui
         9mkYyYqtBsoA4Y5GkSON/IgOWza70EBrYKUNA9TjueMBAB1EGtUVyPuFQhDhrSlWiATT
         PEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z4DgqsHOES9btSykJRqlzpgeGfUXIGi+hdn8mlaj5VQ=;
        b=UKoge/+jcJnqZz3yB6ZdyeMV1UZPQFP4AaBohEkxWgdy6iol0yZnJX2kHh648EsnTA
         XHEhUmnWNkXreAQI1izQzWGujbnZyjm0JKYPHgnpc1RVNJU18eCfcZEb82nJrgTT9lhz
         1MQBzyL6vf/emfxAcpqqEb3bIRLlDL4U+OQ0O93KJ6Qf2Dsb/pL1CIE6onyoa6TL8VST
         S16Vit+uIvdzU+6vHBZ1cokbvFGtvApxF6/gzshD77FP50VW5tHDLp8OeGZUfUNg/q2X
         XAX6xbVveFbFSdk5uPmND381BiVaSziHFfstrHsXTTrsD0YQRpyo5ChJPPTNcIYUxmwn
         RjFw==
X-Gm-Message-State: ALKqPwdg9s42fWRLrfRJApZxuGzxdLdjh1K0YkyLBDtXE+pMEf/54cog
        EUnfYfI818AMvbFJ928hXXwTVeDc0wuM3EnZL3g=
X-Google-Smtp-Source: AB8JxZqBSBK6FA6BQHzhIGuakOkMCUTZenjh9TI1Y1FkWwxgrYdtjnjEy+I9cXrfr2CGyhC+LaRjLFQrpNJ5V4UIGP8=
X-Received: by 2002:ab0:5bd6:: with SMTP id z22-v6mr12956480uae.48.1526822667512;
 Sun, 20 May 2018 06:24:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.22.212 with HTTP; Sun, 20 May 2018 06:24:27 -0700 (PDT)
In-Reply-To: <20180519042752.8666-14-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com> <20180519042752.8666-14-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sun, 20 May 2018 15:24:27 +0200
Message-ID: <CAM0VKjnq9rm_72SLRY0WzSO=1uvGLSUV7QW0BThKMFBia-t45Q@mail.gmail.com>
Subject: Re: [PATCH 13/14] completion: reduce completable command list
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 19, 2018 at 6:27 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> The following commands are removed from the complete list:
>
> - annotate             obsolete, discouraged to use
> - filter-branch        not often used
> - get-tar-commit-id    not often used
> - imap-send            not often used
> - interpreter-trailers not for interactive use
> - p4                   too short and probably not often used (*)
> - svn                  same category as p4 (*)
> - verify-commit        not often used
>

> @@ -127,7 +127,7 @@ git-mktree                              plumbingmanip=
ulators
>  git-mv                                  mainporcelain           worktree
>  git-name-rev                            plumbinginterrogators           =
complete

Since 'git name-rev' is plumbing, and since it's functionality is
fully covered by the 'git describe' porcelain, shouldn't it be removed
as well?
