Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4555B1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 17:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbeCVRgA (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 13:36:00 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33485 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbeCVRf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 13:35:58 -0400
Received: by mail-lf0-f49.google.com with SMTP id x205-v6so14406063lfa.0
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eWde3pkv7GwEWCLjKR4Z4Mxz8i9bwdrTFixgBKn+oMc=;
        b=qJPE5pCWyE6w+uoYsdRWAuGnjQON6OAE4W0qjE2lPzHXmxh34ZEVtkxF0qtxUu2MzB
         MyvWuq5yC1Ax2AKVq7THT4LdZyB1b1FGo93bbKq2D0CsqnDx1WL7ooH8c1YW9H7b8U9f
         WRbdI/aZl/l3V2itICs+e1sOXNN6GRrQ6oM3F5C5rF+GI2HSWtZSedwpLdXEko00hhJR
         xv8nkEaKefaDaLhVR/uUErfdKJB90h7ehVpft+cYTHJMQBgG7Zkvs14srFMiAPTM70z+
         0oREQRrdLF50593xmf9MKICsImBb9H09NQgmBqbihYIh4fwWkbztEZL7WV8hmagHcSJO
         lcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eWde3pkv7GwEWCLjKR4Z4Mxz8i9bwdrTFixgBKn+oMc=;
        b=NazIo/FVJK338zkABNF+6oLtfpQheDnYyBZU5MxN3yyKsBXKm7V4vdnc8F68W7yNA7
         7dMDunNDP3DHAqbrNu7UdC+YvZDDaSph/54XyXkmG9yzQPGdoA79CM98dmxSE9oPzR4H
         Mnkh2U0Ys4PBlUSiqkJyHoXq9KovS2rtguiQaVDCBEk/obVPa6sVBgSo/aJM4vGVuQ78
         J3+pTYJPReWRZKm7YNUADv9KrDbPmUz6friIjx+Erl5ogNWsWLn0Xfgl03RkxNmQB79T
         3Y1ot3oCJuXiqFNaaafcaxl3dnFcG1G+gcByZqEbqucFlY+F+L8WvlgQGXEcDu7U3LTA
         xKXg==
X-Gm-Message-State: AElRT7GRLQYUT0MzWo49HgBrrguYwv0ljRQPGpkOpW6BEYhUS6+rhFLp
        ul7l7qYWfXbDZdqeOgaVg4h0Hw==
X-Google-Smtp-Source: AG47ELsiUU1dH6hNl00OlMaZ8FU6Da1u47um3FNXXC4CpPE0GYULvMQtYAyKH734UKvaVSkvqkU6+Q==
X-Received: by 10.46.70.18 with SMTP id t18mr17921373lja.62.1521740157504;
        Thu, 22 Mar 2018 10:35:57 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b8sm867804ljj.44.2018.03.22.10.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 10:35:56 -0700 (PDT)
Date:   Thu, 22 Mar 2018 18:35:54 +0100
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: add option completion for most builtin
 commands
Message-ID: <20180322173553.GA20984@duynguyen.home>
References: <20180321193039.19779-1-pclouds@gmail.com>
 <xmqqd0zxno0j.fsf@gitster-ct.c.googlers.com>
 <CACsJy8CWWSixQpXDh+q108j4xF8vpm5gsj2u3gJEgW=2bnXQHA@mail.gmail.com>
 <xmqqy3ikkpba.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3ikkpba.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 22, 2018 at 10:11:53AM -0700, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> >> And that pattern repeats throughout the patch.  I wonder if we can
> >> express the same a lot more concisely by updating the caller that
> >> calls these command specific helpers?
> >
> > Yeah. I almost went to just generate and eval these functions. But we
> > still need to keep a list of "bultin with --git-completion-helper"
> > support somewhere, and people may want to complete arguments without
> > double dashes (e.g. read-tree should take a ref...) which can't be
> > helped by --git-completion-helper.
> 
> Hmph, I actually did not have 'eval' in mind.
> 
> Rather, I was wondering if it is cleaner to update __git_main where
> it computes $completion_func by mangling $command and then calls
> it---instead call __gitcomp_builtin directly when the $command
> appears in such a "list of builtins that knows --completion-helper
> and no custom completion".

Ah. Something like this? Seems to work fine and definitely not as ugly
as eval.

-- 8< --
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6da95b8095..960e26e09d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3032,6 +3032,32 @@ _git_worktree ()
 	fi
 }
 
+__git_main_with_parseopt_helper='
+	blame cat-file check-attr check-ignore
+	check-mailmap checkout-index column count-objects fast-export
+	hash-object index-pack interpret-trailers merge-file mktree
+	pack-objects pack-refs prune prune-packed read-tree repack
+	send-pack show-ref stripspace symbolic-ref update-index
+	update-ref verify-commit verify-tag write-tree
+'
+__git_complete_command() {
+	local command="$1"
+	local completion_func="_git_${command//-/_}"
+	if declare -f $completion_func >/dev/null 2>/dev/null; then
+		$completion_func
+	elif echo $__git_main_with_parseopt_helper | git grep -w "$command" >/dev/null; then
+		case "$cur" in
+		--*)
+			__gitcomp_builtin "$command"
+			return 0
+			;;
+		esac
+		return 0
+	else
+		return 1
+	fi
+}
+
 __git_main ()
 {
 	local i c=1 command __git_dir __git_repo_path
@@ -3091,14 +3117,12 @@ __git_main ()
 		return
 	fi
 
-	local completion_func="_git_${command//-/_}"
-	declare -f $completion_func >/dev/null 2>/dev/null && $completion_func && return
+	__git_complete_command "$command" && return
 
 	local expansion=$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
 		words[1]=$expansion
-		completion_func="_git_${expansion//-/_}"
-		declare -f $completion_func >/dev/null 2>/dev/null && $completion_func
+		__git_complete_command "$expansion"
 	fi
 }
 
-- 8< --

