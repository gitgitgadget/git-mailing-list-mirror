Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F19341F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 09:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJJRHi (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 13:07:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44278 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeJJRHh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 13:07:37 -0400
Received: by mail-qt1-f195.google.com with SMTP id c56-v6so4871213qtd.11
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 02:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+gG+I9J9Ds3EbwSq/2EMwUnBT/6Go7riGftkmJa6ns=;
        b=RMSUb/sAZIkEwgY3O/ixErPP9losB5ksaqKJ9VUUR3zNbQIqqvE1I1JtIOc5pRAh7D
         wBES+zzKQ4vO4vydsI5sPfJdcWXztUWV/wxfqgo6tWBVAICbFIo7coMjJf8tvvpysNjl
         573lQzW2elFIYvYCzEW4/SoO/58ojG550OtVzy0U+MU8pszyKOu9Fd7QO9j9KJOX4bb5
         dSf1CKpGfJhC8p9rwq60gHNmpM4/PdeaTV5sFt62NeSjHuwTt1krHr5etB27Nu8PbRPP
         aPts7GT0bdrZv4Ywk++eqmqX7rPeIG6flrueayqRTTeXclFl965MV+5nrSEzOadop9yv
         6Yow==
X-Gm-Message-State: ABuFfogR3KeV9yBstlqVTy8sTzXGRki7M+AX/nhWwEJCNACiOH8HZZ4l
        4x3k/fXKPJnNZM6sMuIQSbo5ag9u4l/rnQiw/0g=
X-Google-Smtp-Source: ACcGV616B90X+8KWfhXT3ddeEx3ixN/WslJFXWghDKP2lf/vD5ZIWrIu3HS08l/mtTF/enUqMvm280VGRGSd3/qEJWw=
X-Received: by 2002:a0c:9de1:: with SMTP id p33-v6mr26038353qvf.82.1539164775355;
 Wed, 10 Oct 2018 02:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.43.git.gitgitgadget@gmail.com> <pull.43.v2.git.gitgitgadget@gmail.com>
 <2eefdb4874d36f14aac79b24c0f6216911f2143e.1539161632.git.gitgitgadget@gmail.com>
In-Reply-To: <2eefdb4874d36f14aac79b24c0f6216911f2143e.1539161632.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 10 Oct 2018 05:46:04 -0400
Message-ID: <CAPig+cRMOOqGdiCqprUqiSXCa5SZDRy-kJSvdRmwY_uvynwoXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rebase -i: clarify what happens on a failed `exec`
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 4:54 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> We had not documented previously what happens when an `exec` command in
> an interactive rebase fails. Now we do.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> @@ -420,7 +420,8 @@ idea unless you know what you are doing (see BUGS below).
>  --exec <cmd>::
>         Append "exec <cmd>" after each line creating a commit in the
>         final history. <cmd> will be interpreted as one or more shell
> -       commands.
> +       commands. Anz command that fails will interrupt the rebase,
> +       withe exit code 1.

s/Anz/Any/
s/withe/with/
