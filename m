Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A201F403
	for <e@80x24.org>; Mon, 11 Jun 2018 18:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934142AbeFKSVh (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 14:21:37 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44820 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933481AbeFKSVg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 14:21:36 -0400
Received: by mail-pg0-f67.google.com with SMTP id p21-v6so10138305pgd.11
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Rhxah9RvyNZShV2QpGubPpRfBBPpOAAZcODR7hRUb1Q=;
        b=NN58RsyoixkURP2VU/0tdvN6D+VnWG7mBugK7w1KFc5plpbGcEAc9Bb7qAONcyOEUL
         XAtFKD+4QsISruLeKkc3VIgdaNs3/PtdE5McL3Bd3kdyLDJeEMPzIRwHeuLqJsOOGn9M
         BifiE+/UPbgDlxf2nRTUDI4f3Ymmx0e4UzHsxdMVGDGEGcqE6YjRGpUlt4bmMHZucQ6y
         d+udqIjKLOAkoqUV5nUMBpaZs9MDRCMHBAO16KlOPwvnLZsVySLPBPmjVsZ6aOAKAM+j
         2VxAWZX1Z/ogNKJtisLC2a2eymtu6p1xHbCTvjmcKW/q7CsWJgPnbkQMm7RHwTrmak2b
         liYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Rhxah9RvyNZShV2QpGubPpRfBBPpOAAZcODR7hRUb1Q=;
        b=q1vtUvAu/R3A54Bng9XvCBAPQx3g+7CWPi+muz3OaPbnRZ1iGpMxrHUwYWsNsjwvwv
         K4hJ2exJvDyYQBY/Sixpw1BJJNiFOhjZ7AbGsZXZCpPVnqydcOZcIVKy1T8UhzuKw4Q4
         +5NRg9HnXhM6MFaZqcjq1+VfTMuqLdZGwovZT2ZDyL9+3tsMf9pZqFWDCGCo5R2rJWx8
         GgXcxykXgj2wviLgpUyY8tNl8VT85c2IRBNFu3Ky91wFaOe+/ZzFM7z9uUCXe/L/XJg+
         0L+S6eAykxyUJ1oABlzJErKDqGFY3ehpn2EHmJIb7m/8dZ6uFl7CP8Iwm6aB1qkEwzJN
         KEbA==
X-Gm-Message-State: APt69E1r7zjncoaT6tUQcfYUWN/b/RQN8a3CzNjQvLwUzgkcKECOEt1v
        Ofo7nRkxQ0FNanxqoBQiC1bHZVHx
X-Google-Smtp-Source: ADUXVKJYIFCHwj0lVoy13wS/qGVHJix9eLAYGIAtFf4MKAazHvX980WisTp6iOGr9PRLa1Sm/wRm/A==
X-Received: by 2002:a63:ba56:: with SMTP id l22-v6mr211283pgu.161.1528741295403;
        Mon, 11 Jun 2018 11:21:35 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t3-v6sm46607280pfk.161.2018.06.11.11.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 11:21:34 -0700 (PDT)
Date:   Mon, 11 Jun 2018 11:20:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        git@vger.kernel.org, Rick van Hattem <wolph@wol.ph>,
        Dave Borowitz <dborowitz@google.com>
Subject: [PATCH] completion: correct zsh detection when run from
 git-completion.zsh (Re: [PATCH v2] completion: reduce overhead of clearing
 cached --options)
Message-ID: <20180611182053.GA20665@aiede.svl.corp.google.com>
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com>
 <20180417220219.30445-1-szeder.dev@gmail.com>
 <20180607054834.GB6567@aiede.svl.corp.google.com>
 <20180608211639.7611-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180608211639.7611-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER Gábor <szeder.dev@gmail.com>
Subject: completion: correct zsh detection when run from git-completion.zsh

v2.18.0-rc0~90^2 (completion: reduce overhead of clearing cached
--options, 2018-04-18) worked around a bug in bash's "set" builtin on
MacOS by using compgen instead.  It was careful to avoid breaking zsh
by guarding this workaround with

	if [[ -n ${ZSH_VERSION-}} ]]

Alas, this interacts poorly with git-completion.zsh's bash emulation:

	ZSH_VERSION='' . "$script"

Correct it by instead using a new GIT_SOURCING_ZSH_COMPLETION shell
variable to detect whether git-completion.bash is being sourced from
git-completion.zsh.  This way, the zsh variant is used both when run
from zsh directly and when run via git-completion.zsh.

Reproduction recipe:

 1. cd git/contrib/completion && cp git-completion.zsh _git
 2. Put the following in a new ~/.zshrc file:

 	autoload -U compinit; compinit
	autoload -U bashcompinit; bashcompinit
	fpath=(~/src/git/contrib/completion $fpath)

 3. Open zsh and "git <TAB>".

With this patch:
Triggers nice git-completion.bash based tab completion

Without:
 contrib/completion/git-completion.bash:354: read-only variable: QISUFFIX
 zsh:12: command not found: ___main
 zsh:15: _default: function definition file not found
 _dispatch:70: bad math expression: operand expected at `/usr/bin/g...'
 Segmentation fault

Reported-by: Rick van Hattem <wolph@wol.ph>
Reported-by: Dave Borowitz <dborowitz@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
SZEDER Gábor wrote:

> Being in RC phase, I'm all for aiming for a minimal solution.
> However, I don't think that the better fix would be erm.. any "less
> minimal":

Thanks again. May we have your sign-off?

 contrib/completion/git-completion.bash | 5 ++++-
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 12814e9bbf..f4a2e6774b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3223,7 +3223,10 @@ __gitk_main ()
 	__git_complete_revlist
 }
 
-if [[ -n ${ZSH_VERSION-} ]]; then
+if [[ -n ${ZSH_VERSION-} ]] &&
+   # Don't define these functions when sourced from 'git-completion.zsh',
+   # it has its own implementations.
+   [[ -z ${GIT_SOURCING_ZSH_COMPLETION-} ]]; then
 	echo "WARNING: this script is deprecated, please see git-completion.zsh" 1>&2
 
 	autoload -U +X compinit && compinit
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 53cb0f934f..049d6b80f6 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -39,7 +39,7 @@ if [ -z "$script" ]; then
 		test -f $e && script="$e" && break
 	done
 fi
-ZSH_VERSION='' . "$script"
+GIT_SOURCING_ZSH_COMPLETION=y . "$script"
 
 __gitcomp ()
 {
-- 
2.18.0.rc1.242.g61856ae69a

