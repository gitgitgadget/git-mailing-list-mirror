Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342F0C433ED
	for <git@archiver.kernel.org>; Sun,  2 May 2021 05:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0676661423
	for <git@archiver.kernel.org>; Sun,  2 May 2021 05:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhEBFuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 01:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhEBFuh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 01:50:37 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE00C06174A
        for <git@vger.kernel.org>; Sat,  1 May 2021 22:49:45 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id w6-20020a4a9d060000b02901f9175244e7so544418ooj.9
        for <git@vger.kernel.org>; Sat, 01 May 2021 22:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2KaUAc5EFlpFhJQ5csGULHmjAdj/qV5OCyyIzVaGXts=;
        b=A3hUn8QHVjmXjiLOem9wRJIXO9stWVPS9uOsIr4dIRL37BIBKDRagHuDI6PUREa7ZR
         W4dkmHkxESQiaBMIMtMohwPrygBt2cVfRX3mTw7USl2rZmeTPn66jp6sMHZU9+wFWLe4
         6EYJt/FiBEAXEyRKfPE0zgUh2ttRyKSg75sB81Ttnzh+ve2yi/it0PuSGdFNd/8TBdlV
         7duD48qyb7GhpwQ2WK1+0X8h2owWw2fuKT5MmdUbguqp3KmQydg7bhKuLHfrtBypEN6V
         zS1l2mlKeENjt0V0nN1icjztLfuqPrzS7my8Ws/sEEmN/Q4lqerAXV1vL5eMAji4heqV
         lKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2KaUAc5EFlpFhJQ5csGULHmjAdj/qV5OCyyIzVaGXts=;
        b=YrlnsuLhSZDwLFGBXeujhmPGg4nH2P4LVQGCqHPZAR99X/6+G0SmLqpjqOH9j2zyXb
         op1TLbXQYxuwy/tODnIqtHk2pK66fcka4gwVLHhfvLDWj55sBJHFDcQKOBErmAzRapKy
         aDiqvlxf9Wf180xZo4A8mWOiqFtufKl58WULL5qJspsAEuM7bzfeGvzXGAiNi0/pA2VB
         1045KI3ekMk0Wp7rA9usnyCF8vX37RIOIcK6i4Z7LhPCfA9PZWxVTKOW1rSEedSWcJI+
         N4P2zF0E7EKHITQ7K4J3Sj1Wkfxg1PD2Vz19pHv2zFbeInROYGVLriosfizQyoeW0I/1
         fFUw==
X-Gm-Message-State: AOAM5327hkZo8lUDKphkdmoZIkb2DSRdQOtev+geo1mpjkK6KCFJo7PS
        fi5DIuqdjAIvzYNFehtYHsMLWLShn1lgdQxG2/ukGxr/
X-Google-Smtp-Source: ABdhPJzhbJpDJHSvFsMAD3dkhWisT6TURpxR3EG826UzcPA6vcrtjWFHxVr3LuPt6xhWF7LeOrQyYFbN30qPV/3+N00=
X-Received: by 2002:a4a:e386:: with SMTP id l6mr10671842oov.81.1619934584665;
 Sat, 01 May 2021 22:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <gitgitgadget/git/pull/934@github.com> <gitgitgadget/git/pull/934/c830744540@github.com>
In-Reply-To: <gitgitgadget/git/pull/934/c830744540@github.com>
From:   Josh Soref <jsoref@gmail.com>
Date:   Sun, 2 May 2021 01:49:33 -0400
Message-ID: <CACZqfqA8u8cRM5xSdnArUW7tGOJX9dVO41FsmQU4-d2NyiNCiA@mail.gmail.com>
Subject: Re: [gitgitgadget/git] git-merge: rewrite already up to date message (#934)
To:     "gitgitgadget/git" 
        <reply+AAQFMLC42KHLQTLKSC5H3XV6TILQ3EVBNHHDGQXBRY@reply.github.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:
> diff --git a/notes-merge.c b/notes-merge.c
> index d2771fa3d4..321155fc87 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -628,7 +628,7 @@ int notes_merge(struct notes_merge_options *o,
>   if (oideq(&remote->object.oid, base_oid)) {
>   /* Already merged; result == local commit */
>   if (o->verbosity >= 2)
> - printf("Already up to date!\n");
> + printf_ln("Already up to date.");
>   oidcpy(result_oid, &local->object.oid);
>   goto found_result;
>   }

Should this have `_(...)` decorations?
