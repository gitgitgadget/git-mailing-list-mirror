Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4093C1FD09
	for <e@80x24.org>; Sat, 27 May 2017 09:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755217AbdE0Jy3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 05:54:29 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:33893 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752822AbdE0Jy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2017 05:54:28 -0400
Received: by mail-it0-f43.google.com with SMTP id a10so4475188itg.1
        for <git@vger.kernel.org>; Sat, 27 May 2017 02:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WHrRsnH3F3zRNcBSVAyKq5u6SDQ8Lhkvjn2sYXc8UHs=;
        b=bFRY2/nQxmIkgTsCY9bbmA2q5iC7WyTZUSp4bXRBZwVjRyHorETnSEulQP8T0I1Wf/
         88IAcnVT20zTfRp46x2kIJJEhVcFOregEdOJ4GJXcC77rWaqprGY11RDDWJT0/Pp6h3W
         mu9ro7zNbUuF31cWc8ViF4a/xqOXpxLiCkK2uhPcqdEL5AeC5cLDnYzJUimqfKFvu9Fl
         kaHgF5S+++Wn2nmO8cIuHRnAYpxi8Zu1dfmiDQ+hQ32jjpyNeFjNmIILKCfxtn3SB5Ya
         4/Jz859CBIx59ZXgISyNJsSJvtEnBkSmC3jWO0g+3ho8aG3tTMdeN0J1vIEA85jpcA6I
         SRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WHrRsnH3F3zRNcBSVAyKq5u6SDQ8Lhkvjn2sYXc8UHs=;
        b=qiR2hnZNzFYga9zvvv4ElM15YIa13PyXIcn4/QTqKUmD79wm5Ef56AtIzxDIonXVO9
         x8Mr7RDtcIBIdZXoXhghFqIsgjz7xe24kaNirrkRfD3Cf7tEKt9raw3cgwyLEODWpAPx
         Ub0vgd97SP0sGq2HQn2vp7nfiJkFV/JeWfiyviFs8NvDPmKWwz3fsR4oBoSY11nA5W5s
         lpYFiTY+wAzuJotCm1Gd1ZE02ID1sxuNuGSAgEI+sx3VD693AS+dE2AsNu7hS1gn7eQ0
         OK/xMeiLR2jMFplV6lggDS2y+gqfJ6bt0mUzF4aWynC9YbhF/Sw2b2c8TYwid6GvEbaV
         TIUw==
X-Gm-Message-State: AODbwcCr6W6UDk1V97WQMsXrrYfEEUJkhfO/K1YPw+t/X9ijUxE/GUp9
        uuGWFdSOWVbJjTJF4TLHGpX4cFL5zsJa/HY=
X-Received: by 10.36.138.131 with SMTP id v125mr22524577itd.66.1495878867868;
 Sat, 27 May 2017 02:54:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 27 May 2017 02:54:07 -0700 (PDT)
In-Reply-To: <20170525152739.t63dbsq2dojy2y2h@sigill.intra.peff.net>
References: <20170525152739.t63dbsq2dojy2y2h@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 27 May 2017 11:54:07 +0200
Message-ID: <CACBZZX6K7ppVB0qYah76_+pjTKjsco3rHT0xRyKtF2H1dS4k_w@mail.gmail.com>
Subject: Re: [RFC/PATCH] recognize pathspec magic without "--" disambiguation
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 25, 2017 at 5:27 PM, Jeff King <peff@peff.net> wrote:
>         git log :/foo.*bar

Another option would be to deprecate the :/rx syntax over some period
in favor of ^{/rx}.

I think it's too ugly to live, and really useless. It's equivalent to
"--grep=<rx> --all". Does anyone use this and not really mean to use
^{/rx}? E.g. "git show :/fix" might show a fix on some unrelated
branch you recently rebased.

>       will be treated as a pathspec (if it doesn't match a
>       commit message) due to the wildcard matching in
>       28fcc0b71.

So it might DWYM after hanging there looking at your entire history
for a commit message matching foo.*bar? And if you make such a commit
it'll start meaning something else entirely?
