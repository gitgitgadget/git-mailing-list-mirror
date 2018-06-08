Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7E9E1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 21:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeFHVQu (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 17:16:50 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34447 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbeFHVQt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 17:16:49 -0400
Received: by mail-wr0-f193.google.com with SMTP id a12-v6so14646901wro.1
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 14:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=djF5Q0YF7VMW43qsgOhi7hERZeGkeg2ikRrJt0kdkIY=;
        b=urbpoYZgJvwMZcTfE55b6+t/j6j0vYyb9CsT/YzAhEL6+8y4T/NTLRW4We+I1zJVx1
         5z8s0vhT/EWEYEFBVD8YNUl5wcFY8E2nNlJnxwait0BjAEDMhxQ4kQQ93C7CSmhvM4VS
         ySupprOB1gSYG/H5WdPhVB/usxqyW+RjWxXbRfs2l9NiS7ZQ2MRKlj7MlQ2nXxTzK2OT
         rDicfOX2g2dOMJ8mZqD42u/eglG86PoAG7GTnC8cv1UsMzSN+SeF5A+U+WanON5Zh7Jg
         5XASgLIQ+a5rexoKQRG+8NtHdWl1FoaevsizlhVxSMPiuhS5cftwA40h7MksPge640r+
         UIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djF5Q0YF7VMW43qsgOhi7hERZeGkeg2ikRrJt0kdkIY=;
        b=WZrfCe/eMtWYyF2rkPUZ/lNMEg4LwFIlLN/BNZU6P38FHMn2s7gJE+8oLXUEwInZFn
         B4ipdsREAJNgMc3EsWnuogDGSsrlUzfvpbs23N1K8hbW1Cdw/7q5/GtG0uD1nbd8ndxq
         mJXVzc6hHwX/8g6yl3yiW1cReLcFAvVhIaT7otC+kVOvWhEAxuryPN5xETeXTutlS+WQ
         MxDURpZr6eIhTpVd32OPBq2/HfxKvgeo36Ewm0VG1jytJnVBshCBtSZMtQCpJXhvJboz
         ohWz0M9bp1vRmfdQL3vB3fe17xuxvecTkKGIspkD98dU+pGvXiw4GoYB9xPcCcPbB8qc
         2t3g==
X-Gm-Message-State: APt69E1m5XJW1iwLdUaO9yppEea327qS8MzAwbayH+nWcbx0pnb9FulM
        xRymo4WpkdyZq/Vn1nMe1fQ=
X-Google-Smtp-Source: ADUXVKLwTOOZ0iuTeQOliQ4+uvwAJkwoulvGjk6UkYvwYvh5VRMA/nmApBrWBQ54OjKuJug2k3u6mA==
X-Received: by 2002:adf:824e:: with SMTP id 72-v6mr6453923wrb.127.1528492608215;
        Fri, 08 Jun 2018 14:16:48 -0700 (PDT)
Received: from localhost.localdomain (x590e2083.dyn.telefonica.de. [89.14.32.131])
        by smtp.gmail.com with ESMTPSA id 12-v6sm4194237wmn.27.2018.06.08.14.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 14:16:47 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        git@vger.kernel.org, Rick van Hattem <wolph@wol.ph>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH v2] completion: reduce overhead of clearing cached --options
Date:   Fri,  8 Jun 2018 23:16:39 +0200
Message-Id: <20180608211639.7611-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <20180607054834.GB6567@aiede.svl.corp.google.com>
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com> <20180417220219.30445-1-szeder.dev@gmail.com> <20180607054834.GB6567@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Related question: what would it take to add a zsh completion sanity
> check to t/t9902-completion.sh?

I don't know.  What I do know is that we can't just run our tests with
ZSH, e.g. running 'zsh ./t0000-basic.sh' shows mostly failures.  So it
won't be as simple as modifying 't/lib-bash.sh' to somehow support ZSH
as well.

> Here's a minimal fix, untested.  As a followup, as Gábor suggests at [2],
> it would presumably make sense to stop overriding ZSH_VERSION, using
> this GIT_ scoped variable everywhere instead.
> 
> Thoughts?
> 
> Reported-by: Rick van Hattem <wolph@wol.ph>
> Reported-by: Dave Borowitz <dborowitz@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> [1] https://public-inbox.org/git/01020163c683e753-04629405-15f8-4a30-9dc3-e4e3f2a5aa26-000000@eu-west-1.amazonses.com/
> [2] https://public-inbox.org/git/20180606114147.7753-1-szeder.dev@gmail.com/
> 
> diff --git i/contrib/completion/git-completion.bash w/contrib/completion/git-completion.bash
> index 12814e9bbf..e4bcc435ea 100644
> --- i/contrib/completion/git-completion.bash
> +++ w/contrib/completion/git-completion.bash
> @@ -348,7 +348,7 @@ __gitcomp ()
>  
>  # Clear the variables caching builtins' options when (re-)sourcing
>  # the completion script.
> -if [[ -n ${ZSH_VERSION-} ]]; then
> +if [[ -n ${ZSH_VERSION-} || -n ${GIT_SOURCING_ZSH_COMPLETION-} ]]; then
>  	unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null
>  else
>  	unset $(compgen -v __gitcomp_builtin_)
> diff --git i/contrib/completion/git-completion.zsh w/contrib/completion/git-completion.zsh
> index 53cb0f934f..c7be9fd4dc 100644
> --- i/contrib/completion/git-completion.zsh
> +++ w/contrib/completion/git-completion.zsh
> @@ -39,7 +39,7 @@ if [ -z "$script" ]; then
>  		test -f $e && script="$e" && break
>  	done
>  fi
> -ZSH_VERSION='' . "$script"
> +GIT_SOURCING_ZSH_COMPLETION=1 ZSH_VERSION='' . "$script"
>  
>  __gitcomp ()
>  {
> 

Being in RC phase, I'm all for aiming for a minimal solution.
However, I don't think that the better fix would be erm.. any "less
minimal":

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f2aa484758..7aeb575cd1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3244,7 +3244,10 @@ __gitk_main ()
 	__git_complete_revlist
 }
 
-if [[ -n ${ZSH_VERSION-} ]]; then
+if [[ -n ${ZSH_VERSION-} ]] &&
+   # Don't define these functions when sourced from 'git-completion.zsh',
+   # it has its own implementations.
+   [[ -z "${GIT_SOURCING_ZSH_COMPLETION}" ]] ; then
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
