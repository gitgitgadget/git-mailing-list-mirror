Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76732145A11
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 21:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736200032; cv=none; b=UJ7VXFb5pszliIiHl6nca9JlQwrAn3pFRo4SqRx9Pp4HF/bKEyBq+nzd0nAXrNDzdXaRwB0G+K0a6a3+BGL15p+dkDASUrNI2Fflfflofx+tP95CRyfzrBW6EmmGgAjyb6hJUthgzUT9Qb7oVuzkIL0j3rUO2LFAJzdulu6zziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736200032; c=relaxed/simple;
	bh=nzHPfNjO2qNUbLknKs4zm8JciB8WwDmKmZI3X0F8zS4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=mFaqczkMLOGinhtFgjdYE3veCjRDtn6+rMQjM3sivsgZq/MUYvMT2fM2kWciA9FlueGsBF+hjf3v70ExQ0pMSqy5/znAYj1YIcw5f66Nlt4GHUejFqcCBSt28/okTzqbnnOM447k2T7AACCNF7dCXE2Iy91Plp9TAKro5ygDSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eH2P2IvD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eH2P2IvD"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e2880606so10749308f8f.3
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 13:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736200028; x=1736804828; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iTEL+JIqeTbOik0UCdua0S+XOeytGMXtNUfj9raQMs=;
        b=eH2P2IvDI9gfCl7f4xqKaQeelolx9YIyi2SoO/QgnGdwKEn1MfbdjcZ5s4CkMxWjo8
         Bjovjew+jC7reuU2/KDkJwyKUcv8U3aThQZ1Xd5PEN8xvneVm2XCv9uFKYbdXfDinx9I
         qyhNbQYgOmfDGYj3lApBshP5mcK0wGidmjYfoKhFxBBE/UMMagTqIcaNIwbtfeRWj89+
         o9KPnHj7r65th+QL+ZHX+L7BiccRVtbanIxlMgGN4s9RW8BI11HtVnbmcgQzxrmXUHfM
         U6KQWGzq4EjmWxdxRp7l0jeSRtg1ak9sDzugrz5sr/gR+S/8vHmhKxCpr1o28OjZHf/f
         tO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736200028; x=1736804828;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iTEL+JIqeTbOik0UCdua0S+XOeytGMXtNUfj9raQMs=;
        b=dU1njVzmB2mmi4g67gRFWrY50cUuudcIriB2Ln+2fwgNEqA53kTWQxF1k4lrPLQcLB
         a/R6Qkd+lBi3XHTUOJbMLUhxSteVIKWFH0SxrqzzKtEGBnmflwgjPxFwjCnD9CGny44H
         qujZt1evIF4365ez2s0Zua0hHTraDwgVJDw+DyqqHRpV8SgOcjmHlj3DcTtJvOY10Y0r
         vC8p883+avH/uzkw1+RlAc92ioam6S/gSEkxIjgUYOCETT6qS8zO1mRLxPa72t4GM/LC
         8Fx+oIseSAPba4N+NwAMBgBSw1PP44u9rskckINx6dVbS0xnRQ72PvZdSQkxfBSzF1ck
         y0rQ==
X-Gm-Message-State: AOJu0YzSBMvmCSLAiSFsrH+mpcjsAs79HbeVoA6b7Ibx1hfIqt7yXZbe
	VkiE8pmO2S89zlCq54/frdpwW7A829OHZ5O+k3jtq4ZWIivEon4/Du0gtQ==
X-Gm-Gg: ASbGncs3u+LLu0fPfNHBJs5jiBCkjqWl6subkd2oza8vRRbqQ0rNGGCy83bis1c/MOl
	kFryEwKTjb/j5/elZX4enXZLWaM3+c3bxzZplwmCIsDm67hHvsN9Nwu6vO6xUpD103ox4YZz4fg
	rxb6sxzrFnUVaTGlxQF3JV59bTxyCzkMeZudfm9cg72xvvXHG0jz3BDZ5lnmAFBBJgT2lNJ7ccF
	a52eaysmU5/QBoyCw9Cb81/1YBWZU6iLmpreFOcPB33iyF7MxiBrbEPMg==
X-Google-Smtp-Source: AGHT+IGngO57/36rcZqp1OVC9J4/kxscrJ0lyXv0/W2VABM5raoaILW1SMcyZF2tcp6PUCpsgfKtIg==
X-Received: by 2002:a5d:5e09:0:b0:385:e4a7:df09 with SMTP id ffacd0b85a97d-38a223f75fbmr65888437f8f.44.1736200028201;
        Mon, 06 Jan 2025 13:47:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c515sm581692835e9.30.2025.01.06.13.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 13:47:07 -0800 (PST)
Message-Id: <pull.1860.v3.git.git.1736200026899.gitgitgadget@gmail.com>
In-Reply-To: <pull.1860.v2.git.git.1736002073641.gitgitgadget@gmail.com>
References: <pull.1860.v2.git.git.1736002073641.gitgitgadget@gmail.com>
From: "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jan 2025 21:47:06 +0000
Subject: [PATCH v3] completion: repair config completion for Zsh
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Junio Hamano <gitster@pobox.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    "D. Ben Knoble" <ben.knoble+github@gmail.com>,
    "D. Ben Knoble" <ben.knoble+github@gmail.com>

From: "D. Ben Knoble" <ben.knoble+github@gmail.com>

Commit 1e0ee4087e (completion: add and use
__git_compute_first_level_config_vars_for_section, 2024-02-10) uses an
indirect variable syntax that is only valid for Bash, but the Zsh
completion code relies on the Bash completion code to function. Zsh
supports a different indirect variable expansion using ${(P)var}, but in
`emulate ksh` mode does not support Bash's ${!var}.

This manifests as completing strange config options like
"__git_first_level_config_vars_for_section_remote" as a choice for the
command line

    git config set remote.

Using Zsh's C-x ? _complete_debug widget with the cursor at the end of
that command line captures a trace, in which we see (some details
elided):

    +__git_complete_config_variable_name:7> __git_compute_first_level_config_vars_for_section remote
     +__git_compute_first_level_config_vars_for_section:7> local section=remote
     +__git_compute_first_level_config_vars_for_section:7> __git_compute_config_vars
      +__git_compute_config_vars:7> test -n $'add.ignoreErrors\nadvice.addEmbeddedRepo\nadvice.addEmptyPathspec\nadvice.addIgnoredFile[…]'
     +__git_compute_first_level_config_vars_for_section:7> local this_section=__git_first_level_config_vars_for_section_remote
     +__git_compute_first_level_config_vars_for_section:7> test -n __git_first_level_config_vars_for_section_remote
    +__git_complete_config_variable_name:7> local this_section=__git_first_level_config_vars_for_section_remote
    +__git_complete_config_variable_name:7> __gitcomp_nl_append __git_first_level_config_vars_for_section_remote remote. '' ' '
     +__gitcomp_nl_append:7> __gitcomp_nl __git_first_level_config_vars_for_section_remote remote. '' ' '
      +__gitcomp_nl:7> emulate -L zsh
      +__gitcomp_nl:7> compset -P '*[=:]'
      +__gitcomp_nl:7> compadd -Q -S ' ' -p remote. -- __git_first_level_config_vars_for_section_remote

We perform the test for __git_compute_config_vars correctly, but the
${!this_section} references are not expanded as expected.

Instead, portably expand indirect references through the new
__git_indirect. Contrary to some versions you might find online [1],
this version avoids echo non-portabilities [2] [3] and correctly quotes
the indirect expansion after eval (so that the result is not split or
globbed before being handed to printf).

[1]: https://unix.stackexchange.com/a/41409/301073
[2]: https://askubuntu.com/questions/715765/mysterious-behavior-of-echo-command#comment1056038_715769
[3]: https://mywiki.wooledge.org/CatEchoLs

The following demo program demonstrates how this works:

    b=1
    indirect() {
      eval printf '%s' "\"\$$1\""
    }
    f() {
      # Comment this out to see that it works for globals, too. Or, use
      # a value with spaces like '2 3 4' to see how it handles those.
      local b=2
      local a=b
      test -n "$(indirect $a)" && echo nice
    }
    f

When placed in a file "demo", then both
    bash -x demo
and
    zsh -xc 'emulate ksh -c ". ./demo"' |& tail
provide traces showing that "$(indirect $a)" produces 2 (or 1, with the
global, or "2 3 4" as a single string, etc.).

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
Acked-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    completion: repair config completion for Zsh
    
    With apologies to both CC'd if I've misunderstood the flow in
    https://git-scm.com/docs/SubmittingPatches#_choosing_your_reviewers or
    Phillipe's comments on v1.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1860%2Fbenknoble%2Ffix-zsh-config-completion-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1860/benknoble/fix-zsh-config-completion-v3
Pull-Request: https://github.com/git/git/pull/1860

Range-diff vs v2:

 1:  daee7636106 ! 1:  13a42324658 completion: repair config completion for Zsh
     @@ Commit message
          global, or "2 3 4" as a single string, etc.).
      
          Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
     +    Acked-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## contrib/completion/git-completion.bash ##
      @@ contrib/completion/git-completion.bash: __git_compute_config_vars_all ()


 contrib/completion/git-completion.bash | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b3b6aa3bae2..413911be3be 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2737,12 +2737,17 @@ __git_compute_config_vars_all ()
 	__git_config_vars_all="$(git --no-pager help --config)"
 }
 
+__git_indirect()
+{
+	eval printf '%s' "\"\$$1\""
+}
+
 __git_compute_first_level_config_vars_for_section ()
 {
 	local section="$1"
 	__git_compute_config_vars
 	local this_section="__git_first_level_config_vars_for_section_${section}"
-	test -n "${!this_section}" ||
+	test -n "$(__git_indirect "${this_section}")" ||
 	printf -v "__git_first_level_config_vars_for_section_${section}" %s \
 		"$(echo "$__git_config_vars" | awk -F. "/^${section}\.[a-z]/ { print \$2 }")"
 }
@@ -2752,7 +2757,7 @@ __git_compute_second_level_config_vars_for_section ()
 	local section="$1"
 	__git_compute_config_vars_all
 	local this_section="__git_second_level_config_vars_for_section_${section}"
-	test -n "${!this_section}" ||
+	test -n "$(__git_indirect "${this_section}")" ||
 	printf -v "__git_second_level_config_vars_for_section_${section}" %s \
 		"$(echo "$__git_config_vars_all" | awk -F. "/^${section}\.</ { print \$3 }")"
 }
@@ -2907,7 +2912,7 @@ __git_complete_config_variable_name ()
 		local section="${pfx%.*.}"
 		__git_compute_second_level_config_vars_for_section "${section}"
 		local this_section="__git_second_level_config_vars_for_section_${section}"
-		__gitcomp "${!this_section}" "$pfx" "$cur_" "$sfx"
+		__gitcomp "$(__git_indirect "${this_section}")" "$pfx" "$cur_" "$sfx"
 		return
 		;;
 	branch.*)
@@ -2917,7 +2922,7 @@ __git_complete_config_variable_name ()
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
 		__git_compute_first_level_config_vars_for_section "${section}"
 		local this_section="__git_first_level_config_vars_for_section_${section}"
-		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
+		__gitcomp_nl_append "$(__git_indirect "${this_section}")" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
 	pager.*)
@@ -2934,7 +2939,7 @@ __git_complete_config_variable_name ()
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
 		__git_compute_first_level_config_vars_for_section "${section}"
 		local this_section="__git_first_level_config_vars_for_section_${section}"
-		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
+		__gitcomp_nl_append "$(__git_indirect "${this_section}")" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
 	submodule.*)
@@ -2944,7 +2949,7 @@ __git_complete_config_variable_name ()
 		__gitcomp_nl "$(__git config -f "$(__git rev-parse --show-toplevel)/.gitmodules" --get-regexp 'submodule.*.path' | awk -F. '{print $2}')" "$pfx" "$cur_" "."
 		__git_compute_first_level_config_vars_for_section "${section}"
 		local this_section="__git_first_level_config_vars_for_section_${section}"
-		__gitcomp_nl_append "${!this_section}" "$pfx" "$cur_" "${sfx:- }"
+		__gitcomp_nl_append "$(__git_indirect "${this_section}")" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
 	*.*)

base-commit: 306ab352f4e98f6809ce52fc4e5d63fb947d0635
-- 
gitgitgadget
