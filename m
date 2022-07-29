Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7BAC19F2C
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 15:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbiG2Pl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 11:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbiG2PlT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 11:41:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE0B8213A
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 08:41:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so6474992wrh.3
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 08:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6Ah+aGQHV7ixipzUGhvaAiaxT9cl9SBqWdgCgpyiYDc=;
        b=Bsx+EPhtdMTDZmSSmk47EBxwD7jeUBypBXT1o93YAuAubtPUvmtaeBPTd5WlZUfCrz
         2FmLHhBRFM7foWBsmeq29VbA0hRvq2nWetlM7I0yU1SNZeU1n2Xrk5B+oFDgg3YM6HXp
         Lb1M2z2fDIP4JbGMhH2ygmtbDze7rYmN2FVUkTqBvrynLB6yeVAVoP38C1Tcxz0keBYK
         T9E8O+/5/o/ADrXX//4Y9xlDTw7Gp0boKp/5yneQt/1JGocb6/mWZ4wwRo6v2yBTxvJr
         EDh7WejzZav7zPDBP7IPwAZx85bVe9THpisdAdE7lv24/gVqc21PNHRyrAUU3uoJWK2m
         KX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6Ah+aGQHV7ixipzUGhvaAiaxT9cl9SBqWdgCgpyiYDc=;
        b=1VPz6j272BbHI+9gbfuRangPHgDJIl+RF0mKnaNVuL37XC4f+Z/nfD1cZ/lnJvHIOt
         tRcjC2wpCV+Mz0wdC3exNka7OfAm9aj1JyH7gATNR8zClnM+UarNA4k0U4OOnuXb5SQT
         XR0VSMqw8LDkNxzJKMEmX1nmR/PDukufYi21rlNTVZUdviAp1xThgi8Mvk7S7UeEJzgy
         1LkmymPaABu2fwSCtVbSRELTXaP2qSgxcQeN7+ev6u4kyGRYN5sMc3F+38j60Bqwa+1r
         BZGY3mIuHcb7874t48/rK7lBuwUKkA+AV4o9sGCWAZ/m0ehoD6EreGTIX6o1zuPpXXMc
         MrbQ==
X-Gm-Message-State: ACgBeo2ClTkCzxAsoqxtaIpVB3sTwbMjgMJf86zv2Ds7uEHB8BjjXehE
        OgxGli9QNWV63BGA6o+0tmXchpW2BZ0=
X-Google-Smtp-Source: AA6agR6ptyjJ0AIaUC3q89Td9Bv83Syn1ZyDEkCPyMKbUyBn6E7seqGcSTRgieZkbm41wwnwHAXDSg==
X-Received: by 2002:a05:6000:1151:b0:21e:dd58:de08 with SMTP id d17-20020a056000115100b0021edd58de08mr2767788wrx.493.1659109274303;
        Fri, 29 Jul 2022 08:41:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7-20020adfeb07000000b0021d6d9c0bd9sm3865011wrn.82.2022.07.29.08.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 08:41:13 -0700 (PDT)
Message-Id: <pull.1306.v2.git.1659109272.gitgitgadget@gmail.com>
In-Reply-To: <pull.1306.git.1659016906707.gitgitgadget@gmail.com>
References: <pull.1306.git.1659016906707.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 15:41:08 +0000
Subject: [PATCH v2 0/3] mingw: include the Python parts in the build
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've actually had a variation of the patch to include th Python bits in Git
for Windows's build ever since February 2015.

Changes since v1:

 * Instead of setting and then overriding NO_PYTHON, it is now only defined
   in the relevant parts of the Windows-specific section of
   config.mak.uname.
 * As Junio pointed out, there is an unneeded empty definition of
   NO_GETTEXT; Let's remove it.
 * The same holds for NO_CURL: No need to define it to the empty value.

Johannes Schindelin (3):
  windows: include the Python bits when building Git for Windows
  mingw: remove unneeded `NO_GETTEXT` directive
  mingw: remove unneeded `NO_CURL` directive

 config.mak.uname | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)


base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1306%2Fdscho%2Fmsys2-python-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1306/dscho/msys2-python-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1306

Range-diff vs v1:

 -:  ----------- > 1:  5d9b087625a windows: include the Python bits when building Git for Windows
 -:  ----------- > 2:  019fb837d68 mingw: remove unneeded `NO_GETTEXT` directive
 1:  a5739b9cce8 ! 3:  7dc0a1a9aa8 mingw: include the Python parts in the build
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    mingw: include the Python parts in the build
     +    mingw: remove unneeded `NO_CURL` directive
      
     -    While Git for Windows does not _ship_ Python (in order to save on
     -    bandwidth), MSYS2 provides very fine Python interpreters that users can
     -    easily take advantage of, by using Git for Windows within its SDK.
     +    In df5218b4c30 (config.mak.uname: support MSys2, 2016-01-13), we
     +    introduced support for building Git for Windows in the then-brand new
     +    Git for Windows v2.x build environment that was based off of MSYS2.
     +
     +    To do that, we split the non-msysGit part (that targeted MSys1) in two,
     +    and instead of sharing the `NO_CURL = YesPlease` setting with MSys1, we
     +    overrode it for MSYS2 with the empty value because we very much want to
     +    build Git for Windows with libcurl.
     +
     +    But that was unnecessary: we never set that variable beforehand,
     +    therefore there is no need to override it.
     +
     +    Let's just remove that unnecessary line.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## config.mak.uname ##
      @@ config.mak.uname: else
     + 		HAVE_LIBCHARSET_H = YesPlease
     + 		USE_GETTEXT_SCHEME = fallthrough
       		USE_LIBPCRE = YesPlease
     - 		NO_CURL =
     +-		NO_CURL =
       		USE_NED_ALLOCATOR = YesPlease
     -+		NO_PYTHON =
       		ifeq (/mingw64,$(subst 32,64,$(prefix)))
       			# Move system config into top-level /etc/
     - 			ETC_GITCONFIG = ../etc/gitconfig

-- 
gitgitgadget
