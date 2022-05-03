Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262FAC433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 10:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiECKa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 06:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiECKa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 06:30:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AAEC56
        for <git@vger.kernel.org>; Tue,  3 May 2022 03:26:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 125-20020a1c1983000000b003941f354c62so1027475wmz.0
        for <git@vger.kernel.org>; Tue, 03 May 2022 03:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bVj5kjC97dXIGOeKdz6N2KACmQPsxzaytf3UGy/noJ8=;
        b=XQaJ7sQ4IAY+PpdYM22dXjGzAn/S4+co6bvbcQ43SLABgMbNOPXDCxP0v6nDFX+aTe
         OaMvVM1ZJf3hLMGoPTGwvGf03L5iGLOznz39V8+lon+qc8FG4xHmmf4W3Z3jcCKpCH2x
         NHzfE6KHKq1isMeFoV8YrSi8ukC97FI/yaiNj3J3HOjM4AWXa8lw08S3Yp+LPAzbYgYG
         Mmn5zBJf/q2M8n5nfbvUqrjjUxOI5WU1fOFXXt3GXPOrFYoE7YfAN0pOXxhfIdSiOb2l
         WFumvf08Mu1PstB4GH7MkxVN4xqTO4/2pltZFyH/pFHYAcsnxBglToFFwZ9inbX7dXKN
         zlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bVj5kjC97dXIGOeKdz6N2KACmQPsxzaytf3UGy/noJ8=;
        b=GJqmuaUotjq+DWNl+0V+BmxFlzpVPyqX9E395Jk1p+M0MOc7AyPqFXhRjpl1AFmFpB
         yHWn0/gGmXbKVcorA7dmR4tL3wdHzdQGWkUfddNcmGMS3Ic6TJNaVA87fOLDCsK5enpk
         Rc/NMDHMoSB+LsaJJMZd7RCU3xck96/PjX5t38KMFd/fdEbciPVBgut+vKZQrCACGrrq
         kPJCv4uE+AZ0Azi7Ym3tt9Wq2JQyDiteen+M7Nr1CnR38UEbem8YpIjy3dSogLbS1e/V
         AklyxfOUv1r0SXHevkXaq5W8R5OHh+/YGMLh0C8YaEqZwqdCeRjsyMg1hSHTl251KVaH
         Uctg==
X-Gm-Message-State: AOAM533AjqbMcpDCSB+/uGHD1dheZYOp1TM/zVOEWfrQzrz5n0QwVOl8
        4VyrPqo70jQZEgsv/P9zYzebGe+Iskc=
X-Google-Smtp-Source: ABdhPJxAicth3ivfsVv/9KpbWBckOF4loNUy6jYiqwy/cv70tqyDjpSa+AkQdTOuE7YInQ+1DHcvkA==
X-Received: by 2002:a05:600c:9:b0:393:ea67:1c68 with SMTP id g9-20020a05600c000900b00393ea671c68mr2797779wmc.92.1651573609793;
        Tue, 03 May 2022 03:26:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l20-20020adfc794000000b0020c5253d8dfsm9918755wrg.43.2022.05.03.03.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:26:48 -0700 (PDT)
Message-Id: <pull.1172.v2.git.1651573607.gitgitgadget@gmail.com>
In-Reply-To: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 May 2022 10:26:41 +0000
Subject: [PATCH v2 0/6] A couple of fixes for the Trace2 documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While verifying a suggestion for a contributor before sending it, I noticed
that the Trace2 documentation contained an incorrect example. Looking
around, I found a couple other things I wanted to fix, so here are the
patches.

Note: This patch series is not intended to be perfectionist. I just want the
result to be good enough, and move on to more important things.

Changes since v1:

 * Added an Oxford comma (at least I think it is a stylistic one, not a
   required one, but then, all three people involved in the discussion are
   non-native speakers, so there).
 * Added a patch to use a consistent style for function names.
 * I now surround even more terms in backticks.
 * I spotted and fixed a missing full stop, too.

Johannes Schindelin (6):
  trace2 docs: a couple of grammar fixes
  trace2 docs: "printf" is not an English word
  trace2 docs: surround more terms in backticks
  trace2 docs: fix a JSON formatted example
  trace2 docs: clarify what `varargs` is all about
  trace2 docs: add missing full stop

 Documentation/technical/api-trace2.txt | 44 +++++++++++++-------------
 1 file changed, 22 insertions(+), 22 deletions(-)


base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1172%2Fdscho%2Ffix-trace2-docs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1172/dscho/fix-trace2-docs-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1172

Range-diff vs v1:

 1:  07f7ee46232 ! 1:  3b944102ff2 trace2 docs: a couple of grammar fixes
     @@ Documentation/technical/api-trace2.txt: for example.
       Trace2 is controlled using `trace2.*` config values in the system and
       global config files and `GIT_TRACE2*` environment variables.  Trace2 does
      -not read from repo local or worktree config files or respect `-c`
     -+not read from repo local or worktree config files nor does it respect `-c`
     - command line config settings.
     +-command line config settings.
     ++not read from repo local or worktree config files, nor does it respect
     ++`-c` command line config settings.
       
       == Trace2 Targets
     + 
      @@ Documentation/technical/api-trace2.txt: Format details are given in a later section.
       
       === The Normal Format Target
 -:  ----------- > 2:  3c1ca34927a trace2 docs: "printf" is not an English word
 2:  284c6a3df84 ! 3:  2ddd9ff4506 trace2 docs: surround more terms in backticks
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Documentation/technical/api-trace2.txt ##
     +@@ Documentation/technical/api-trace2.txt: Format details are given in a later section.
     + === The Normal Format Target
     + 
     + The normal format target is a traditional `printf()` format and similar
     +-to the GIT_TRACE format.  This format is enabled with the `GIT_TRACE2`
     ++to the `GIT_TRACE` format.  This format is enabled with the `GIT_TRACE2`
     + environment variable or the `trace2.normalTarget` system or global
     + config setting.
     + 
      @@ Documentation/technical/api-trace2.txt: $ cat ~/log.normal
     + === The Performance Format Target
       
       The performance format target (PERF) is a column-based format to
     - replace GIT_TRACE_PERFORMANCE and is suitable for development and
     +-replace GIT_TRACE_PERFORMANCE and is suitable for development and
      -testing, possibly to complement tools like gprof.  This format is
     ++replace `GIT_TRACE_PERFORMANCE` and is suitable for development and
      +testing, possibly to complement tools like `gprof`.  This format is
       enabled with the `GIT_TRACE2_PERF` environment variable or the
       `trace2.perfTarget` system or global config setting.
     @@ Documentation/technical/api-trace2.txt: take a `va_list` argument.
       See `trace2.h` for more details.  The following discussion will only
       describe the simplified forms.
       
     +@@ Documentation/technical/api-trace2.txt: as each thread starts and allocates TLS storage.
     + There are a few issues to resolve before we can completely
     + switch to Trace2.
     + 
     +-* Updating existing tests that assume GIT_TRACE format messages.
     ++* Updating existing tests that assume `GIT_TRACE` format messages.
     + 
     +-* How to best handle custom GIT_TRACE_<key> messages?
     ++* How to best handle custom `GIT_TRACE_<key>` messages?
     + 
     +-** The GIT_TRACE_<key> mechanism allows each <key> to write to a
     ++** The `GIT_TRACE_<key>` mechanism allows each <key> to write to a
     + different file (in addition to just stderr).
     + 
     + ** Do we want to maintain that ability or simply write to the existing
 3:  b893f6a7faf = 4:  1c5a7008382 trace2 docs: fix a JSON formatted example
 4:  2eecea50e51 = 5:  0c09fd000a6 trace2 docs: clarify what `varargs` is all about
 -:  ----------- > 6:  e1a94b0d1ae trace2 docs: add missing full stop

-- 
gitgitgadget
