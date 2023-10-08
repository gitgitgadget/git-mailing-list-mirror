Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D70EE95A8E
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 22:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344726AbjJHWDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 18:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHWDg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 18:03:36 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C583CA3
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 15:03:35 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d8a000f6a51so4267245276.3
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 15:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696802615; x=1697407415; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XKJqil+aFkiwefa+F2atBD3DsME2HCuzyz+jJxzTEz4=;
        b=S8LQCvAYicn6O4uOPPLv48SbwD2tIxxu21+26sx9FSOjYkLQirMjZ4AcWxtDjJIS0V
         JbFvZAMDgbz4j+KHMwj0dCeFcKn+Z7wdWFghX26b4ej8g+ECrb+MDHm6+IfRMpKLo+xm
         kOQp1F/e7NCGCGRqyP0wjTFEuN0HaTZZ2CkXPioxNZJvDmkTTgh8IWH/pBfYQ4mNdWiY
         x/NvXfjdbBGcSA1Xic4ZI1j0kMUs18G5wGW3y8yzlP83Cv9aimdzU6IivG8Lc1yaDOY5
         Eo5B6hAhq5+55ZoASOerNFsw7CcYC707jREM1V7v/bgXPzGh0DdnzZKaAeXRRbtKiamz
         Ggfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696802615; x=1697407415;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKJqil+aFkiwefa+F2atBD3DsME2HCuzyz+jJxzTEz4=;
        b=UJxEOegss+utyO4PaESXAtFiz5e9XiMgWucfpLainBLYbS+Cp+cmARBtgLBDwdUqNi
         2+Egg7cmyd4Jv22Gb2wJx8wk8wQctNQfijC8zrhM6hjeh9koH6EYNmzuopjUhBzhvmbF
         qXFiWqCfigYwDKEoi7Tlwc8GWymW9qol+tgL5VsNioYc1zDb6fllJBdLdBNuSHgJ51OJ
         OgAq+AaBD4cpXAOknxEB7B0YJ32VT020BbwCKlk32AxUykuockD4K2A2iKHCl4oqkikw
         5QFO9dMnDt2JVUsAfELBGK1Mwt5e+M/w4xS+NEY24YidWgr45lZBY2w4YqcW4xAhxlxi
         rHfA==
X-Gm-Message-State: AOJu0YyjnBdJKsST7PscSjAmW4RUqEOfSdt+FbxRT67Ad3EtzwzUKrB4
        v6bH/mFG1/90/Dwzls6e6goyLF300v/A23jDX2xxAi7F8k1QB6o=
X-Google-Smtp-Source: AGHT+IGHDOP4cG01iesQftGjdias5WF5qh9DoSuY2Qwli20JtzksEmqaky4iCRZ6Ukch3Zv5IJhiBL7W0LV0tHMvGO8=
X-Received: by 2002:a25:aac8:0:b0:d85:b07d:e2f8 with SMTP id
 t66-20020a25aac8000000b00d85b07de2f8mr12479701ybi.15.1696802614773; Sun, 08
 Oct 2023 15:03:34 -0700 (PDT)
MIME-Version: 1.0
From:   Naomi Ibe <naomi.ibeh69@gmail.com>
Date:   Sun, 8 Oct 2023 22:59:52 +0100
Message-ID: <CACS=G2xBNMMTSCSsVFe3M3jFN0m0pZ-j_TAz3r6xmQrgdRujfQ@mail.gmail.com>
Subject: [OUTREACHY] git send-email issues
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been able to edit the add.c file since friday and I've created my
patches too. The error I keep getting when I run either "git
send-email --to=naomi.ibeh69@gmail.com
builtin/0001-OUTREACHY-Fixed-add.c-file-to-conform-to-guidelines-.patch"
or "git send-email --to=git@vger.kernel.org
builtin/0001-OUTREACHY-Fixed-add.c-file-to-conform-to-guidelines-.patch"
is this:

**Unable to initialize SMTP properly. Check config and use
--smtp-debug. VALUES: server=smtp.gmail.com encryption=tls
hello=localhost.localdomain port=587 at C:/Program
Files/Git/mingw64/libexec/git-core\git-send-email line 1725, <FIN>
line 1.**

I've used the --smtp-debug tag, checked the official docs and other
docs too, plus stackoverflow,google and even chatgpt, but nothing
seems to be working. I've even had to change my gmail password tonight
but it still doesn't work. Any tips at all would be greatly
appreciated at this point. Thank you
