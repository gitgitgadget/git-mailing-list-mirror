Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D953964CFB
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534890; cv=none; b=A5LyDIgVXtt/WNsXyCDOlSc3UcURZaTOdbm0E8f8G/E4sxDal67xvhZhFhXvikhWvxejUc2UlAAiYZgNhqqp14p4z6AeqW+mzF7fYcRN+91BcsKXofHr6nt5nlrj6KTqUHmqwBu5KkrU6M+RajgXKCZwL68/INo/CdrgWpNNt8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534890; c=relaxed/simple;
	bh=TwyeDdsOxKgszuWZL01yj8xfJwSkG3yb6d4+Z65WPgI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rpTzyX0iNFwaXRBdtopxLNEGS3h4vwwJ7hwrb6HSsolUuDk81MEFtzdC5hFIwjx3Pr0PgEZBerl2JztN26Crtfgd5U08RvqwF9T5qzsEH5Mj9xg/FIlVnbeZaBNsoJpQKEVEVRVskaDsjIo5YaI8w9cfpDAUEeHuhvXj0Ybb7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iax+fXk7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iax+fXk7"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ef64d8955so8987975e9.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 05:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706534887; x=1707139687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5byi4K+FqXpCK1PjPxawgqP73bKSooFEtJ77nWOXb4w=;
        b=iax+fXk7Qb+JN0Fu6sNF08ChAHASK5y/6gRlz0p/FCLerT/IoqMnqCbaYswWntQjv2
         DS3w82KQbhNea/RVm8DV6k7Y0wo96iqX4L5flO4dGIuf8IBEgxy7LBbtolKKlQQlCLSd
         qZii9c27cDs03cah7jmtY3JEJeVKAo37HPu1F/3itHMFVjUEMS1tBxY1Cp9vpW2CtgYV
         Xpm+9Mr0x/127xrqEqBQaLd29GHniUxTTv5TRRkXKVwhjmQ0cQtYmEIYuLNP6/OoJY73
         MaWzZ4IctRcnOJUSB6rut6n6oOXjPny/uXRUhtxyc/9VN/bVbIe4/L0i16Q/K7ArSUhn
         Q+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706534887; x=1707139687;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5byi4K+FqXpCK1PjPxawgqP73bKSooFEtJ77nWOXb4w=;
        b=LTtYSrkapXHSRQh4NOh7JUhXrGS9pbeweYAzm3sTAJj9NTX7dSO3r2cme82gcZ/9DD
         I+v1DcZkQdAkqHNsnXANWNgewCav4lUiwcPXUe+VBQYzKvVCZvSgg2UZsgkPTfSwyv6p
         RrS500CWeU1Tf4dGpRCOsqW1GqzZi/QpsXgNDLAla/V8naV+5TjAFwqxwZ4zvh6QPLhG
         YSIVxiZqeIt3hFmI6mwOfcctBxWbEYhD2STL8tXLUM/14Yp6lHXiPfPYI+U0rW6oMKtc
         eXyl2Lbv8hgyb+7qceYxvu8IwGsYvi+RxlYFi7WPWO9Zui3m23c+SjLuhraPVrfJSZ+q
         WG2Q==
X-Gm-Message-State: AOJu0YzOql+LqYF3fK4qTEB5WsMtdDbda5ejBWcnW6jVrkq+Tzqkm3vA
	9Q6Tj94d96LgBCVjwvJy/mZSeoQcb3R45gGqhb1q4G57vePDRkmvg7rvKPZU
X-Google-Smtp-Source: AGHT+IFQrRBDfKt/xxBvnSSYKOufFqvzmfOs61535oxoDnZP/m1242Khg+2jo3IztVBGT5ZiOLuIiQ==
X-Received: by 2002:a5d:4312:0:b0:337:c91d:e80b with SMTP id h18-20020a5d4312000000b00337c91de80bmr4244056wrq.13.1706534886445;
        Mon, 29 Jan 2024 05:28:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5-20020adfe985000000b00337d67a85c1sm8078525wrm.62.2024.01.29.05.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:28:04 -0800 (PST)
Message-ID: <838aabf2858b73361be8e8579bc80826e1cfd4c3.1706534882.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
	<pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Jan 2024 13:27:59 +0000
Subject: [PATCH v2 3/5] completion: add and use
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

