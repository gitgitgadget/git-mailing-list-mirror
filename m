Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5220FC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 11:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBILuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 06:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjBILuL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 06:50:11 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757E97697
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 03:36:51 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qw12so5491359ejc.2
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 03:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U/nXAac+HjJTvvbmh574WudKN9B/QxI9ACzxq4oWDEQ=;
        b=Wtm2LEaa7bqTQUILt0rLGHfL1/CjLYMyYYEiTJgR8Fja+i7I/uT+38Y2D075VanCYr
         zp5CAKemsMYLTg+eQrKTswFjB2+ya5IHsnTqGs9pBFaV6NsArFvhKGeRCS6hYZhz9vrN
         nLE6QnNNKRYuqPxGlXiNgkg1BW52j7QXlhExRM84Kk7+pZlb4fNH1H5NNvXdp06Yz9uJ
         BzZaXktQKbY6PWYnnOO3SEB0m7py6rfOuPL/OQA2jaC53CzYmr7hKl6s27Y46S2o9T/i
         1vECd8GUqVp0yTmktLhE3a006mJK0LK03RuE5VRoQBQ3XYmdTDTLWF8/bEpAVtks8Qvo
         K2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/nXAac+HjJTvvbmh574WudKN9B/QxI9ACzxq4oWDEQ=;
        b=HULPVPOizkyCfvSVVLJFNg0sKwsO6BKMdMAKLatXOrLMOO2YrW2qkjvgFEf7s7NQL8
         gd8gzKWW6m0kesHLNcWhRzJf5QLA1WS81/eplCMZch+fV4THW8HjM4SGlHCi8z/26vlY
         SuqGtuwflsQc2r8o3YqOhREWe1oWoYgv4hfzXPl6e/Z3VoZZR8cINI0mwWrTS0cRexLs
         pH7GaahbWgfGerr6bILn2HIIGr9R6D7X9hJyAzIOUyvSkgESVWaA1wvLwvZupPihi5fe
         boanVw8IuQTSECyavxmiDUCnWr/dvA3MJz0DggqCSTxMsbUrvvpjx7kGneZKwXMl/UE7
         nIDw==
X-Gm-Message-State: AO0yUKVBNWA2ZNITMJkrvnH2FrvypKerNanoEpJDatAGA+YFJUzkpxUY
        /HVF2ZFxDmyhW4p3/ntz51semRFI5pQV6XmYWfffqhfjF0A=
X-Google-Smtp-Source: AK7set96pFW9aw5VEC8zWjdhn2UYTtai7mY16TzJJbCJI0Hgm2DlChkB3P8YmqoiV/JEMIgKDZlKG0wq2bP+1S4yjdg=
X-Received: by 2002:a2e:2406:0:b0:290:660e:3fa7 with SMTP id
 k6-20020a2e2406000000b00290660e3fa7mr1905699ljk.52.1675941827513; Thu, 09 Feb
 2023 03:23:47 -0800 (PST)
MIME-Version: 1.0
References: <CADE8Narm5asbx_bdgT=Q_e1CiHUQqFSo3F2cWrataqq3O9YuKQ@mail.gmail.com>
 <230209.86cz6jxhat.gmgdl@evledraar.gmail.com>
In-Reply-To: <230209.86cz6jxhat.gmgdl@evledraar.gmail.com>
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Thu, 9 Feb 2023 16:53:35 +0530
Message-ID: <CADE8NapLKs4RsKMyCXxQh3PZXpUMk9E_ajDu2hPiq-fNiTP75w@mail.gmail.com>
Subject: Re: Doubt about skipped commits
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'm asking because if you mean that you have e.g.:
>
>         pick B
>         pick A
>         fixup D
>         pick C
>
> And we apply B, but then have a conflict with A, and drop you into the
> shell, you need to fix that etc. (maybe extensively), and you then want
> "D" to categorically fail to apply...
>
> ...then that's something that a lot of people definitely rely on working
> the way it does now.

Thanks for replying!
It does indeed look like the situation is intentional.
I was actually looking for a microprojet for GSoC, and found this
issue on GitGitGadget's git fork.

I think I might need more scrutiny of the source-code to find a
microproject, as most of the open issues seem to be already associated
with a PR.

P.S. If you have any suggestions, I would be very grateful!


Thanks a lot!
Vinayak Dev
