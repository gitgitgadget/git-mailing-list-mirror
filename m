Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1666C1F576
	for <e@80x24.org>; Mon,  5 Feb 2018 09:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeBEJ4R (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 04:56:17 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40277 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbeBEJ4O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 04:56:14 -0500
Received: by mail-pg0-f68.google.com with SMTP id g2so2244332pgn.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 01:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=W8Pa7ID1wmxK2Of7bGVrHYmoVlnvhcHsZq8lhblugyM=;
        b=VZ6rp8E6ZxhYXdevKVWf4bJBnytvUKOxDek3sQDUhExewbN0zAuu1Sb3QFjTJxvJwZ
         hjOAkEI/xIQZ6ou18YEq+SqIQLmN1of3Yk4Iizek+2JL3KQ2zeGcNRmcf7O9z35iJC18
         WkVv3R9MdFgQjsCsCcyKPnCmtC6fWBmSFEzqeBToUWG0SCy+yIUUKOsn4yvj/enmr0Co
         shWZ4NwLp5Uls6eppi5Jx4Q7ZnyYwH+V1wrOzkuTCM3qU6FSViw6yfykzby+TED49jgk
         fvIyA23mEo/NifKgHyamUB19FqmffoIYJADTGu1HVNtUqmJd5DwPTb0zawXHcecINlxG
         dcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W8Pa7ID1wmxK2Of7bGVrHYmoVlnvhcHsZq8lhblugyM=;
        b=Xv76EjKa5z331uRhNUGPjObwS8F9dNgz2ftjtk5RY4R75wDkVR5lNyeeJ52uTWS5hw
         XW4NgxQ0S0AWdRBgF1Z6lI9vUBAx4sBW8sGBwVDwO+l0NvU8qoIL+TyhXfbzvQbEevd2
         5QbsDdYxYOz9ZKC/ExFx6aVKrL0n7n/PATl+YI547LHuTu03x/Bwy/n5ce74ixMOLt67
         Z0H5fjNj1aVUScTIXEt8GD4oCECC4LbawB0cDrEIOzeX9OlVYMxk0VZ6zf+4LfbDqGAP
         XSxxPzQ6sIxOOkRQt4RRjTh9eXV9jkLsmwAwmHwcZPDODgSzHyI3ZQWi6lbv3hJof3kL
         0kEQ==
X-Gm-Message-State: APf1xPDCyXtOb0ia5AJVkpQqy3QYmxtt40lUK93705Oq4AE9j72D7aA5
        ZwfEIbJSjk6kJ4unOxn1EoWPAQ==
X-Google-Smtp-Source: AH8x224vNxKCC+/KCeX881T8C7PXv3Y+kKDokmUfKnx5XYUbJHq/cVkCKANE2rY6S6/cppiei3QLig==
X-Received: by 10.98.181.14 with SMTP id y14mr7184009pfe.216.1517824574094;
        Mon, 05 Feb 2018 01:56:14 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id s5sm16940473pfg.29.2018.02.05.01.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2018 01:56:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 05 Feb 2018 16:56:08 +0700
Date:   Mon, 5 Feb 2018 16:56:08 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 01/41] parse-options: support --git-completion-helper
Message-ID: <20180205095608.GA12370@ash>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180131110547.20577-2-pclouds@gmail.com>
 <CAPig+cT5GkhFJ9XFDSirGjfoji4qUCM8LA6abdRsaT=g3prznQ@mail.gmail.com>
 <CACsJy8B0D=u5fGA2QWuG6QG-fmReg=GayC54+pSFjXHDrnKh3w@mail.gmail.com>
 <CAPig+cSLYDJaxCyAH_zK0cat2-60OZGWGy_ZLHwitHfZ7oA78w@mail.gmail.com>
 <CACsJy8D5iGVDHKoMeQjm+Seea_pTixsb8Xq6D1w17Y9M42iAPw@mail.gmail.com>
 <CAPig+cRWzvcDUjw7CR78nZ0cbE-mPkB1a4UZqiChR0NUKSZOVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRWzvcDUjw7CR78nZ0cbE-mPkB1a4UZqiChR0NUKSZOVw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 01, 2018 at 02:16:46PM -0500, Eric Sunshine wrote:
> On Thu, Feb 1, 2018 at 5:21 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Thu, Feb 1, 2018 at 4:54 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> >> I don't see that as convincing argument for two classes of "no
> >> complete". Since git-completion.bash already special-cases
> >> rebase/am/cherry-pick for --continue|--abort|--skip, it is not far
> >> fetched that that special-case treatment can be extended slightly to
> >> also filter out those three options from the list returned by
> >> --git-completion-helper.
> >
> > I agree that is possible, but it's a bit tricky to do the filtering
> > right in bash (all options are sent back as one line instead of one
> > per line, which is easier to process by command line tools).
> 
> Perhaps I'm missing something, but wouldn't filtering out those
> options directly in Bash require only this?
> 
>     % x='--foo --bar --snoo'
>     % echo ${x/--bar}
>     --foo --snoo

OK how about some thing like this fixup patch? __gitcomp_builtin now
allows to add extra options as well as remove some.

-- 8< --
Subject: [PATCH] fixup! git-completion.bash: introduce __gitcomp_builtin

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cfd24c5764..ecd5896064 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -284,24 +284,31 @@ __gitcomp ()
 #
 #    __gitcomp "$(git xxx --git-completion-helper) ..."
 #
-# except that the value from $(git) is cached
+# except that the output is cached. Accept 1-3 arguments:
+# 1: the git command to execute, this is also the cache key
+# 2: extra options to be added on top (e.g. negative forms)
+# 3: options to be excluded
 __gitcomp_builtin ()
 {
 	# spaces must be replaced with underscore for multi-word
 	# commands, e.g. "git remote add" becomes remote_add.
 	local cmd="$1"
-	shift
+	local incl="$2"
+	local excl="$3"
 
 	local var=__gitcomp_builtin_"${cmd/-/_}"
 	local options
 	eval "options=\$$var"
 
 	if [ -z "$options" ]; then
-		declare -g "$var=$(__git ${cmd/_/ } --git-completion-helper)"
-		eval "options=\$$var"
+		options="$(__git ${cmd/_/ } --git-completion-helper) $incl "
+		for i in $excl; do
+			options="${options/$i /}"
+		done
+		eval "$var=\"$options\""
 	fi
 
-	__gitcomp "$options $*"
+	__gitcomp "$options"
 }
 
 # Variation of __gitcomp_nl () that appends to the existing list of
-- 
2.16.1.207.gedba492059

-- 8< --

Usage would be something like this

-- 8< --
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ecd5896064..049bfc3320 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1103,12 +1103,13 @@ __git_count_arguments ()
 }
 
 __git_whitespacelist="nowarn warn error error-all fix"
+__git_am_inprogress_options="--skip --continue --resolved --abort"
 
 _git_am ()
 {
 	__git_find_repo_path
 	if [ -d "$__git_repo_path"/rebase-apply ]; then
-		__gitcomp "--skip --continue --resolved --abort"
+		__gitcomp "$__git_am_inprogress_options"
 		return
 	fi
 	case "$cur" in
@@ -1117,7 +1118,8 @@ _git_am ()
 		return
 		;;
 	--*)
-		__gitcomp_builtin am "--no-utf8"
+		__gitcomp_builtin am "--no-utf8" \
+			"$__git_am_inprogress_options"
 		return
 	esac
 }
-- 8< --

I think I'm keeping the flag name PARSE_OPT_NOCOMPLETE for now
though. There are a few options that don't fit in "dangerous"
category, e.g.

- "gc --auto" is hidden because it does not make sense to type it
  directly. Same story for "push --thin".

- "grep --ext-grep" is no-op

- --null, --exit-code and others are for scripting and not that often
  typed.
--
Duy
