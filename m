Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90491C004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 17:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjASRcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 12:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjASRcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 12:32:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC228693
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 09:32:08 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m3-20020a17090a414300b00229ef93c5b0so1762404pjg.2
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 09:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qyFPbgel+b4r/DXLNbbowc3GkeAQR6cY4u/fhmjfdjE=;
        b=TdU6i4O/e5J/YTvOx9/XjitajYHuIocwfNa2nVM/xUFc0rOM56QAQlim/2hNie3TwU
         cGknR+7crNoRS2E0EK2S7gkI56OWoJmRsrQ/DEWoJpGXqX/XWfDsWZ4gFb0oQpRVQx+i
         2Y9Emj2oy190m5WcHE8FQ8qa3w7+iT5jf2IMu70vFti0q4EsKqgZ20enO82EPw8+Cs8r
         bA8e+p0HI8rjqSrbsO1Wnjw8k/wZsVNX95PglAaMpjVUNXnWym+2Xly6fqdbLnRhj46m
         OEeU72hs9kj91YDhGWh7WTtlea6KBmykQWV26hpq55pN7lBcoQAINJoTk+yzl7YVdkSV
         j5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyFPbgel+b4r/DXLNbbowc3GkeAQR6cY4u/fhmjfdjE=;
        b=X1BSqeZTmuwOtDNc8AMlD6wKsksh5hzRW8HQGbeMbv9XLCHeznalQ/E4bbRGAM69OZ
         +s3xxtz39ouatEqaM/MzPbm6NeXKvGlakebyo3mgi4ns5zvz2MOEc8FhUX51Y6BUHTWR
         I9mdOIZjmr18CK1vfK7qeZ523UNMtpPyXv34QUs3h57HHTb6yeJ3dKuw3/Izv/FZw33d
         X2fJmc4ljTEDCV8NpaOXoKftnKtR9NDhOvHFy4XPklbZfpxhJlLNUts3pgSkDfGZzras
         l40j2PeRavJRIX7Q17MDGv0x40ejFPGmwii2i37xeh6PeX8UUv0mRvaztOMFX+4EU8Cn
         gdzA==
X-Gm-Message-State: AFqh2krFU8yK8JRIohBSq6W7TAxX8vBv7/2MwxmPLyNCbm4I5Uq7R/8C
        gR3zHLN/bAOvwRaXS+eg8cZeMKcznVE=
X-Google-Smtp-Source: AMrXdXvMDA0WfAXvwOXnNboRq1lQA8FS2sehcF0Fovz7LC3NRUDQhOAopi9MCR/y27q1VJWxzP+6kw==
X-Received: by 2002:a05:6a21:7888:b0:b5:d63e:a9d7 with SMTP id bf8-20020a056a21788800b000b5d63ea9d7mr16498589pzc.60.1674149528314;
        Thu, 19 Jan 2023 09:32:08 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h26-20020a63211a000000b0042988a04bfdsm21040420pgh.9.2023.01.19.09.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:32:07 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Is GGG mislabeling topics?
Date:   Thu, 19 Jan 2023 09:32:07 -0800
Message-ID: <xmqqpmba1ld4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These comments from GGG bot

    https://github.com/git/git/pull/1435#issuecomment-1386301994
    https://github.com/git/git/pull/1435#issuecomment-1386302018

add 'next' and 'seen' labels, citing merges e3ead5f and c52b021
respectively, but these merges are of a topic that has little to do
with this pull request (#1435).  Is this expected?

