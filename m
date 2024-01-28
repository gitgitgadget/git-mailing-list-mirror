Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A3C3C062
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472182; cv=none; b=Fwv2pwDECyHkuKBQcteeG7mp5nOrLiOMW2YKdhoajdvNuQ1/CIheGA1V3o1NP79XVaKPKTufSBux/4MIuDq+u3azHfpz+E4mTZw7fIw7Lu2A1OYhviH4iJSzJ0qXKD+EQxTMn4B4pcSg9aYvIzqPkJo7ZmItrx85sfflN3rLYak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472182; c=relaxed/simple;
	bh=TwyeDdsOxKgszuWZL01yj8xfJwSkG3yb6d4+Z65WPgI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UzZ3pS2/bw/PNwE+J1G3kR7OFOxEzuosq+g95oZUomVxxMWTR2dWUmp77Csqw29RmdbRatcGPZOHwJnpk3jCX9t15iKE6cWkasuj2nbwpb6h+14IKcsFgN8BfxC2MMyJEQqmq2uE7MhvrNYiZY6vCkWRvOKxfLyHA0HSLmULwZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1aC1xc2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1aC1xc2"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33934567777so1960047f8f.1
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 12:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706472178; x=1707076978; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5byi4K+FqXpCK1PjPxawgqP73bKSooFEtJ77nWOXb4w=;
        b=j1aC1xc28+wfsVbC9svBNt0iRmkvC/gj8EUl8/iE32dCSKonPf9otv2vL5DMs3ZMnh
         p8KzOvgkQwnLQZhHhuPOepfEvYilSdEsW4rgvPNseSRijONcxApQHC6ce2Dp/8q9Z/KX
         VpeBMuzARxBcEgPcKqWi4bQIhjsBdhbPgqRCo3PGvotA4c14dlGg8OdRC7JKeFGtfk0y
         Zn9A+qGfpsBLJYN+yoxYnC5qXYI1PMgwadXV7cE3xzjLYtuoPpTUWwJpI7NsfD+vNPwM
         NtOQsw6s3YttfbzIg/+2J81bsWsu6DsPvr1mBIg2u46UpsfyUtu56xHTpfPxDArfT50y
         hhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706472178; x=1707076978;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5byi4K+FqXpCK1PjPxawgqP73bKSooFEtJ77nWOXb4w=;
        b=Qx6tozmkD7ADSml/dwpe7RVr2SxjtWQIQ5Q0MgUjYZZzmSCPYhWRVHk5SzcaK3cgQ1
         OFQasNomwHjApdQqojl5nfPlC0rKSf+7743ODoUsIiC+zzxLbzuI/cFGxFn1jXlMYPBg
         SR/hLg6wVw9LyAdFFwEO94d1FU92wVlq3MHtCBV/fFE8WDXINB4+COgilQ5Ebo5O+FdZ
         IpJlrdxkvQTlkMOpJ+5vcZc+Yuzt5qyvy+bV9vfE/dcHJECfuBYlmTmTnH5B5UobZEAf
         X4ld+gIjA+PRK2jY37R5q8CS+lhDIR621WmBCofx9En3XPsY7dWVIARljem6NxN4GLpB
         gP2g==
X-Gm-Message-State: AOJu0YyPD8DWIy1lwaM+sQistGIEFSfFtXcEsrSj5KLodAg+8qvyNffk
	eup3OrZ4VKaCU+ExCyWn2SHw7A6sjBM58gckty4sZFCzxYSDANUz9bTrJcD/
X-Google-Smtp-Source: AGHT+IF1FTwRQivwCIW2eT93v3WuuBhT9O4KF+0QlGYCXGDZR5wLsTrpZQwI0NIPP4QX0vkwk0djzA==
X-Received: by 2002:a5d:4312:0:b0:337:c91d:e80b with SMTP id h18-20020a5d4312000000b00337c91de80bmr2941132wrq.13.1706472178111;
        Sun, 28 Jan 2024 12:02:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11-20020adffa4b000000b0033aee139e26sm583889wrr.63.2024.01.28.12.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 12:02:57 -0800 (PST)
Message-ID: <dd9395bda322e3a84f6669f350e6892280cf6b35.1706472173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jan 2024 20:02:51 +0000
Subject: [PATCH 3/5] completion: add and use
 __git_compute_first_level_config_vars_for_section
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

The function __git_complete_config_variable_name in the Bash completion
script hardcodes several config variable names. These variables are
those in config section where user-defined names can appear, such as
"branch.<name>". These sections are treated first by the case statement,
and the two last "catch all" cases are used for other sections, making
use of the __git_compute_config_vars and __git_compute_config_sections
function, which omit listing any variables containing wildcards or
placeholders. Having hardcoded config variables introduces the risk of
the completion code becoming out of sync with the actual config
variables accepted by Git.

To avoid these hardcoded config variables, introduce a new function,
__git_compute_first_level_config_vars_for_section, making use of the
existing __git_config_vars variable. This function takes as argument a
config section name and computes the matching "first level" config
variables for that section, i.e. those _not_ containing any placeholder,
like 'branch.autoSetupMerge, 'remote.pushDefault', etc.  Use this
function and the variables it defines in the 'branch.*', 'remote.*' and
'submodule.*' switches of the case statement instead of hardcoding the
corresponding config variables.  Note that we use indirect expansion
instead of associative arrays because those are not supported in Bash 3,
on which macOS is stuck for licensing reasons.

Add a test to make sure the new function works correctly by verfying it
lists all 'submodule' config variables. This has the downside that this
test must be updated when new 'submodule' configuration are added, but
this should be a small burden since it happens infrequently.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 24 +++++++++++++++++++++---
 t/t9902-completion.sh                  | 11 +++++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8af9bc3f4e1..2934ceb7637 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2596,6 +2596,15 @@ __git_compute_config_vars ()
 	__git_config_vars="$(git help --config-for-completion)"
 }
 
+__git_compute_first_level_config_vars_for_section ()
+{
+	section="$1"
+	__git_compute_config_vars
+	local this_section="__git_first_level_config_vars_for_section_${section}"
+	test -n "${!this_section}" ||
+	printf -v "__git_first_level_config_vars_for_section_${section}" %s "$(echo "$__git_config_vars" | grep -E "^${section}\.[a-z]" | awk -F. '{print $2}')"
+}
+
 __git_config_sections=
 __git_compute_config_sections ()
 {
@@ -2749,8 +2758,11 @@ __git_complete_config_variable_name ()
 	branch.*)
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
+		local section="${pfx%.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx:- }"
+		__git_compute_first_level_config_vars_for_section "${section}"
+		local this_section="__git_first_level_config_vars_for_section_${section}"
+		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
 	guitool.*.*)
@@ -2799,8 +2811,11 @@ __git_complete_config_variable_name ()
 	remote.*)
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
+		local section="${pfx%.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx:- }"
+		__git_compute_first_level_config_vars_for_section "${section}"
+		local this_section="__git_first_level_config_vars_for_section_${section}"
+		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
 	submodule.*.*)
@@ -2812,8 +2827,11 @@ __git_complete_config_variable_name ()
 	submodule.*)
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
+		local section="${pfx%.}"
 		__gitcomp_nl "$(__git config -f "$(__git rev-parse --show-toplevel)/.gitmodules" --get-regexp 'submodule.*.path' | awk -F. '{print $2}')" "$pfx" "$cur_" "."
-		__gitcomp_nl_append $'alternateErrorStrategy\nfetchJobs\nactive\nalternateLocation\nrecurse\npropagateBranches' "$pfx" "$cur_" "${sfx:- }"
+		__git_compute_first_level_config_vars_for_section "${section}"
+		local this_section="__git_first_level_config_vars_for_section_${section}"
+		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
 	url.*.*)
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 35eb534fdda..f28d8f531b7 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2583,6 +2583,17 @@ test_expect_success 'git config - variable name include' '
 	EOF
 '
 
+test_expect_success 'git config - variable name - __git_compute_first_level_config_vars_for_section' '
+	test_completion "git config submodule." <<-\EOF
+	submodule.active Z
+	submodule.alternateErrorStrategy Z
+	submodule.alternateLocation Z
+	submodule.fetchJobs Z
+	submodule.propagateBranches Z
+	submodule.recurse Z
+	EOF
+'
+
 test_expect_success 'git config - value' '
 	test_completion "git config color.pager " <<-\EOF
 	false Z
-- 
gitgitgadget

