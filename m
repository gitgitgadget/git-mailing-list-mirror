Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E83C4332F
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 13:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJONJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 09:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJONJA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 09:09:00 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CB9537E6
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 06:08:57 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n73so5885467iod.13
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 06:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qtc0IogvgrHzpntZ69UY/ACfNSjp/PHzitNN4yMV7bE=;
        b=OucwycHSo+d9PJqg0TiDal7P1kYVPtYbJTtGV4hzSI9di+ZYNUvUzg7/LvnLZH5ss1
         mNP8bKZzzLvwOBK7umqkDI+RMrt209ulBTDzbgwEy2MkrAv9YYBSXjg3KueTHKWQZCl2
         I52dGLLLGQAtkcAb61VLi4U+i4xuNxg38a5zJSGF9oH8tM/ZHX5bEc3pDGzP1My/rmmG
         rMeW2+CS/VOnp5vd+uZfkeWRj9hNLAXsLw8Cm9KWLrjjYxJE/F71ZRrQVai5KrSsi5pb
         ZzHXIWWG+GPk7epw96S7WILEr/ubqK2VH4KSNWatUTeSX6AUFTdfmwGOqbPScp38mTRO
         JtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qtc0IogvgrHzpntZ69UY/ACfNSjp/PHzitNN4yMV7bE=;
        b=BO3zb0PiN8cNqi9iHlXYF1qpKUdGCSaWp4bHQ32/YUtvpkxgTM7D6t+JXawf8xSbZM
         eUqIgwb1j+2ZAGcaKUeYjEMbrKlw4UxD3/7lS1XEhlLTuVp03KfVrTsD5QWCnwl1Cvrm
         BMEdL4nXRE6duRiFkf8ZdAPNT9U35SpI25+Ep65YoVrxpokdiiDe6AzMAq/me3927lIo
         ffZINNpDLq5/kT6fcm+M1E8lytz9DSMuULXZ9Oh92A7HiDqnUSjGel8QUg4ZQ8KEs0mo
         JhxYbN3nVCZ7xe8WJ/SH9o8KlmedJyBvSJfEDYhXD+ipdHl1okdC3yd1YcD/gogFoWOW
         g9ow==
X-Gm-Message-State: ACrzQf0riBAkh+tXc/ACkUpy9JUK7CbiZz9rTJfTHlmgh/V2mMSe2T49
        cT5DEl4ED/srOha2kE2KDLI4nppLuZjVLrKXaYmF3H7b+ls=
X-Google-Smtp-Source: AMsMyM7YMrsZZxac4SjkwHFhLic7nSagYloyReJTjN56d5n5WMaAvtKkN8kqUACXe1d493dw/fYZZD4T3bc3TNEIGvE=
X-Received: by 2002:a6b:d009:0:b0:6a5:410b:45ee with SMTP id
 x9-20020a6bd009000000b006a5410b45eemr1102395ioa.112.1665839336384; Sat, 15
 Oct 2022 06:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
In-Reply-To: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Sat, 15 Oct 2022 08:08:45 -0500
Message-ID: <CANaDLW+xgfEFHWX9T45MT-WaPOXHeij80K17PCnuzJU636rMkQ@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor: long status advice adapted to the fsmonitor
 use case
To:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I considered just suppressing that piece of advice entirely for
repositories with fsmonitor disabled

Sorry, I just noticed that I misspoke here. I meant repositories with
fsmonitor *enabled*, of course.
