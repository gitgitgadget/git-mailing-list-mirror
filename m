Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DCEC1FF6D
	for <e@80x24.org>; Mon, 28 Nov 2016 01:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753264AbcK1Bq0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Nov 2016 20:46:26 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35414 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbcK1BqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2016 20:46:25 -0500
Received: by mail-pf0-f171.google.com with SMTP id i88so21351753pfk.2
        for <git@vger.kernel.org>; Sun, 27 Nov 2016 17:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mjelgj/4MLbPKXAQIQzHEd/KSAlYzQBgwRu6Y3hKFmI=;
        b=nrKhhL67Ioo5qW+u9/YpBmN/+Bh1MN5MH0wlybcdd97cEllbINAC/AyYzjFtKNxm2a
         ONWlbsQiKeHZmz31SYukJqAKCeHMwRtAVvabKD+ANA2JWUAHNiP2tMzzFVZru4tutbb2
         cNYPvfTSdsJrwXkZwOSn0hUU8kC4T0IIEl6E2mbdnwJBIQvrAg4DQg3fPnGWRqerPoej
         86/SK5AieBEdm6hHLw9ACP+jorDoRIpnwMClomwQye2oIlRNoZmWK3b/sqCGvQBDCR+d
         yqozAItzrn0n34Wfw27UXYWenx2e3lw1YjIdb6ZiLxDicBJGVBxJEmnJJyjo7rZMYsKw
         UmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mjelgj/4MLbPKXAQIQzHEd/KSAlYzQBgwRu6Y3hKFmI=;
        b=WhxQBL2HeJnCoW+3tGqVGWiM/RMam9/V2wWzndZTACPDiOItENdG0g2lREuIc96Kkh
         QqVk0JCn8+eSzV50Tzd3GoAcyP/Mx7wBCVyklAHwa4ZzsMZrG1dWzjNfmyNLKx+fh7FX
         fYvr4JDDW1yv+U0Pi1o1pvYTJYahQ2Z6o70HUh3F3UbTLvwl5y1Jhq5LXEhSgspHr9QL
         g1uSB73qC/VM+htpPJFAkgA8+F/iMVRW8H6vJemcbU4p57g9Ajy5J0996Ekxj8RQvQ6K
         r4cxyweikFX3x+P7gPu1NDJtn8CPoAKN9MojRXY+mzGwGVQ6dT+CErM47KbfIMQGxVRz
         Jhdg==
X-Gm-Message-State: AKaTC01cKSJ73S/FeyzXC31NB/NWFY05E28vPS4JwGwdzH8MDX/YRbIUXzFmMWnGWDEu2w==
X-Received: by 10.99.44.84 with SMTP id s81mr35266243pgs.153.1480297543977;
        Sun, 27 Nov 2016 17:45:43 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id b126sm82524071pfg.90.2016.11.27.17.45.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Nov 2016 17:45:41 -0800 (PST)
Date:   Sun, 27 Nov 2016 17:45:38 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Dun Peal <dunpealer@gmail.com>, Git ML <git@vger.kernel.org>
Subject: Re: trustExitCode doesn't apply to vimdiff mergetool
Message-ID: <20161128014538.GA18691@gmail.com>
References: <CAD03jn5PAZcFeesaq2osjo7cYd1frWZeN0odNqTh+AMxSEmLgQ@mail.gmail.com>
 <20161127050818.rmjpvha64y4wosq2@sigill.intra.peff.net>
 <CAD03jn7gU9g7NyDk_3wYTKsYQUtRGg6msvumZqUDs44hMOVX7w@mail.gmail.com>
 <20161127165559.j5okxyztwescheug@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161127165559.j5okxyztwescheug@sigill.intra.peff.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 27, 2016 at 11:55:59AM -0500, Jeff King wrote:
> On Sun, Nov 27, 2016 at 08:46:40AM -0500, Dun Peal wrote:
> 
> > Ignoring a non-zero exit code from the merge tool, and assuming a
> > successful merge in that case, seems like the wrong default behavior
> > to me.
> 
> Yeah, I'm inclined to agree. But like I said, I'm not too familiar with
> this area, so maybe there are subtle things I'm missing.

I think this may have been an oversight in how the
trust-exit-code feature is implemented across builtins.

Right now, specific builtin tools could in theory opt-in to the
feature, but I think it should be handled in a central place.
For vimdiff, the exit code is not considered because the
scriptlet calls check_unchanged(), which only cares about
modifciation time.

I have a patch that makes it so that none of the tools do the
check_unchanged logic themselves and instead rely on the
library code to handle it for them.  This makes the
implementation uniform across all tools, and allows tools to
opt-in to trustExitCode=true.

This means that all of the builtin tools will default to
trustExitCode=false, and they can opt-in by setting the
configuration variable.

For tkdiff and kdiff3, this is a subtle change in behavior, but
not one that should be problematic, and the upside is that we'll
have consistency across all tools.

In this scenario specifically, what happens is that the
scriptlet is calling check_unchanged(), which checks the
modification time of the file, and if the file is new then it
assumes that the merge succeeded.  check_unchanged() is clearing
the exit code.

Try the patch below.  I tested it with vimdiff and it seems to
provide the desired behavior:
- the modificaiton time behavior is the default
- setting mergetool.vimdiff.trustExitCode = true will make it
  honor vim's exit code via :cq

One possible idea that could avoid the subtle tkdiff/kdiff3
change in behavior would be to allow the scriptlets to advertise
their preference for the default trustExitCode setting.  These
tools could say, "default to true", and the rest can assume
false.

If others feel that this is worth the extra machinery, and the
mental burden of tools having different defaults, then that
could be implemented as a follow-up patch.  IMO I'd be okay with
not needing it and only adding it if someone notices, but if
others feel otherwise we can do it sooner rather than later.

Thoughts?

--- 8< ---
Date: Sun, 27 Nov 2016 17:26:55 -0800
Subject: [PATCH] mergetool: honor mergetool.<tool>.trustExitCode for all tools

The built-in mergetools originally required that each tool scriptlet
opt-in to the trustExitCode behavior, based on whether or not the tool
called check_unchanged() itself.

Refactor the functions so that run_merge_cmd() (rather than merge_cmd())
takes care of calling check_unchanged() so that all tools handle
the trustExitCode behavior uniformly.

Remove the check_unchanged() calls from the scriptlets.
A subtle benefit of this change is that the responsibility of
merge_cmd() has been narrowed to running the command only,
rather than also needing to deal with the backup file and
checking for changes.

Reported-by: Dun Peal <dunpealer@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool--lib.sh    | 24 ++++++++++++++----------
 mergetools/araxis        |  2 --
 mergetools/bc            |  2 --
 mergetools/codecompare   |  2 --
 mergetools/diffuse       |  2 --
 mergetools/ecmerge       |  2 --
 mergetools/examdiff      |  2 --
 mergetools/meld          |  3 +--
 mergetools/opendiff      |  2 --
 mergetools/p4merge       |  2 --
 mergetools/tortoisemerge |  2 --
 mergetools/vimdiff       |  2 --
 mergetools/winmerge      |  2 --
 mergetools/xxdiff        |  2 --
 14 files changed, 15 insertions(+), 36 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 9abd00be2..3d8a873ab 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -125,16 +125,7 @@ setup_user_tool () {
 	}
 
 	merge_cmd () {
-		trust_exit_code=$(git config --bool \
-			"mergetool.$1.trustExitCode" || echo false)
-		if test "$trust_exit_code" = "false"
-		then
-			touch "$BACKUP"
-			( eval $merge_tool_cmd )
-			check_unchanged
-		else
-			( eval $merge_tool_cmd )
-		fi
+		( eval $merge_tool_cmd )
 	}
 }
 
@@ -225,7 +216,20 @@ run_diff_cmd () {
 
 # Run a either a configured or built-in merge tool
 run_merge_cmd () {
+	touch "$BACKUP"
+
 	merge_cmd "$1"
+	status=$?
+
+	trust_exit_code=$(git config --bool \
+		"mergetool.$1.trustExitCode" || echo false)
+	if test "$trust_exit_code" = "false"
+	then
+		check_unchanged
+		status=$?
+	fi
+
+	return $status
 }
 
 list_merge_tool_candidates () {
diff --git a/mergetools/araxis b/mergetools/araxis
index 64f97c5e9..e2407b65b 100644
--- a/mergetools/araxis
+++ b/mergetools/araxis
@@ -3,7 +3,6 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if $base_present
 	then
 		"$merge_tool_path" -wait -merge -3 -a1 \
@@ -12,7 +11,6 @@ merge_cmd () {
 		"$merge_tool_path" -wait -2 \
 			"$LOCAL" "$REMOTE" "$MERGED" >/dev/null 2>&1
 	fi
-	check_unchanged
 }
 
 translate_merge_tool_path() {
diff --git a/mergetools/bc b/mergetools/bc
index b6319d206..3a69e60fa 100644
--- a/mergetools/bc
+++ b/mergetools/bc
@@ -3,7 +3,6 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if $base_present
 	then
 		"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" \
@@ -12,7 +11,6 @@ merge_cmd () {
 		"$merge_tool_path" "$LOCAL" "$REMOTE" \
 			-mergeoutput="$MERGED"
 	fi
-	check_unchanged
 }
 
 translate_merge_tool_path() {
diff --git a/mergetools/codecompare b/mergetools/codecompare
index 3f0486bc8..9f60e8da6 100644
--- a/mergetools/codecompare
+++ b/mergetools/codecompare
@@ -3,7 +3,6 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if $base_present
 	then
 		"$merge_tool_path" -MF="$LOCAL" -TF="$REMOTE" -BF="$BASE" \
@@ -12,7 +11,6 @@ merge_cmd () {
 		"$merge_tool_path" -MF="$LOCAL" -TF="$REMOTE" \
 			-RF="$MERGED"
 	fi
-	check_unchanged
 }
 
 translate_merge_tool_path() {
diff --git a/mergetools/diffuse b/mergetools/diffuse
index 02e0843f4..5a3ae8b56 100644
--- a/mergetools/diffuse
+++ b/mergetools/diffuse
@@ -3,7 +3,6 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if $base_present
 	then
 		"$merge_tool_path" \
@@ -13,5 +12,4 @@ merge_cmd () {
 		"$merge_tool_path" \
 			"$LOCAL" "$MERGED" "$REMOTE" | cat
 	fi
-	check_unchanged
 }
diff --git a/mergetools/ecmerge b/mergetools/ecmerge
index 13c2e439d..6c5101c4f 100644
--- a/mergetools/ecmerge
+++ b/mergetools/ecmerge
@@ -3,7 +3,6 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if $base_present
 	then
 		"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" \
@@ -12,5 +11,4 @@ merge_cmd () {
 		"$merge_tool_path" "$LOCAL" "$REMOTE" \
 			--default --mode=merge2 --to="$MERGED"
 	fi
-	check_unchanged
 }
diff --git a/mergetools/examdiff b/mergetools/examdiff
index 7b524d408..e72b06fc4 100644
--- a/mergetools/examdiff
+++ b/mergetools/examdiff
@@ -3,14 +3,12 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if $base_present
 	then
 		"$merge_tool_path" -merge "$LOCAL" "$BASE" "$REMOTE" -o:"$MERGED" -nh
 	else
 		"$merge_tool_path" -merge "$LOCAL" "$REMOTE" -o:"$MERGED" -nh
 	fi
-	check_unchanged
 }
 
 translate_merge_tool_path() {
diff --git a/mergetools/meld b/mergetools/meld
index 83ebdfb4c..bc178e888 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -7,7 +7,7 @@ merge_cmd () {
 	then
 		check_meld_for_output_version
 	fi
-	touch "$BACKUP"
+
 	if test "$meld_has_output_option" = true
 	then
 		"$merge_tool_path" --output "$MERGED" \
@@ -15,7 +15,6 @@ merge_cmd () {
 	else
 		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
 	fi
-	check_unchanged
 }
 
 # Check whether we should use 'meld --output <file>'
diff --git a/mergetools/opendiff b/mergetools/opendiff
index 0942b2a73..b608dd6de 100644
--- a/mergetools/opendiff
+++ b/mergetools/opendiff
@@ -3,7 +3,6 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if $base_present
 	then
 		"$merge_tool_path" "$LOCAL" "$REMOTE" \
@@ -12,5 +11,4 @@ merge_cmd () {
 		"$merge_tool_path" "$LOCAL" "$REMOTE" \
 			-merge "$MERGED" | cat
 	fi
-	check_unchanged
 }
diff --git a/mergetools/p4merge b/mergetools/p4merge
index 5a608abf9..7a5b291dd 100644
--- a/mergetools/p4merge
+++ b/mergetools/p4merge
@@ -20,14 +20,12 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if ! $base_present
 	then
 		cp -- "$LOCAL" "$BASE"
 		create_virtual_base "$BASE" "$REMOTE"
 	fi
 	"$merge_tool_path" "$BASE" "$REMOTE" "$LOCAL" "$MERGED"
-	check_unchanged
 }
 
 create_empty_file () {
diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
index 3b89f1c82..d7ab666a5 100644
--- a/mergetools/tortoisemerge
+++ b/mergetools/tortoisemerge
@@ -5,7 +5,6 @@ can_diff () {
 merge_cmd () {
 	if $base_present
 	then
-		touch "$BACKUP"
 		basename="$(basename "$merge_tool_path" .exe)"
 		if test "$basename" = "tortoisegitmerge"
 		then
@@ -17,7 +16,6 @@ merge_cmd () {
 				-base:"$BASE" -mine:"$LOCAL" \
 				-theirs:"$REMOTE" -merged:"$MERGED"
 		fi
-		check_unchanged
 	else
 		echo "$merge_tool_path cannot be used without a base" 1>&2
 		return 1
diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 74ea6d547..a841ffdb4 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -4,7 +4,6 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	case "$1" in
 	gvimdiff|vimdiff)
 		if $base_present
@@ -31,7 +30,6 @@ merge_cmd () {
 		fi
 		;;
 	esac
-	check_unchanged
 }
 
 translate_merge_tool_path() {
diff --git a/mergetools/winmerge b/mergetools/winmerge
index f3819d316..74d03259f 100644
--- a/mergetools/winmerge
+++ b/mergetools/winmerge
@@ -6,10 +6,8 @@ diff_cmd () {
 merge_cmd () {
 	# mergetool.winmerge.trustExitCode is implicitly false.
 	# touch $BACKUP so that we can check_unchanged.
-	touch "$BACKUP"
 	"$merge_tool_path" -u -e -dl Local -dr Remote \
 		"$LOCAL" "$REMOTE" "$MERGED"
-	check_unchanged
 }
 
 translate_merge_tool_path() {
diff --git a/mergetools/xxdiff b/mergetools/xxdiff
index 05b443394..e284811ff 100644
--- a/mergetools/xxdiff
+++ b/mergetools/xxdiff
@@ -6,7 +6,6 @@ diff_cmd () {
 }
 
 merge_cmd () {
-	touch "$BACKUP"
 	if $base_present
 	then
 		"$merge_tool_path" -X --show-merged-pane \
@@ -21,5 +20,4 @@ merge_cmd () {
 			-R 'Accel.SearchForward: "Ctrl-G"' \
 			--merged-file "$MERGED" "$LOCAL" "$REMOTE"
 	fi
-	check_unchanged
 }
-- 
2.11.0.rc3.dirty
