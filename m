Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A729B1487ED
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723886771; cv=none; b=SxZLaQL8+8i4rT48/nvmzGstEDM+adfR4SY7c6k2wMyB0dCbf2b6mT1KWD6e8NRekQEXETWf9Of1C/JSYcJHc+kiqL9Y9mUGvvStePrF2hwgRfbUjk9yY9gZkA8AF2P+A9RvtEVoXYpfZgH4BJGX8W0ABib7OObMDnTXiaNMKgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723886771; c=relaxed/simple;
	bh=+OzamXJet4poQcDjfbocCqRQTImWRURbURYBdomHj0o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PRplpUz8/7MNC8dKPxa60yvhpfX+Tflkjtk6lzGKl5zH0l1mCQe9ND+17EcmiYVR5cePRJSNc4NGlmKuDOcDLHDRrSjqxdPCIA9/XZqN9PYIWqWWCnugXTKZ9fCQVg1WEzu+MuLLWbq/4gNysz9bRi64TzmaBNY37L3sW6K5Nc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/jF8m8D; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/jF8m8D"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-371aa511609so164602f8f.1
        for <git@vger.kernel.org>; Sat, 17 Aug 2024 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723886767; x=1724491567; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUEdTvj/rTiuXZmr7VJNrLRqDEkcl3gCFHL3SGDS+Mc=;
        b=F/jF8m8DU3LrmYT0u3UYylFuwdoRlw0vRzqvfu1YvWXetzOFJRRDjNB1V1dsbqbs0u
         FaWw120CcVbfe5tvHt2ViJ+Pso5KFNMS1e0yLd4gvuIpBGdLj+vbkWw9D9SFa3P0xSTL
         JIHGbllTKzAuhucWHuG/vlikkhkey5uqGft+/twxovEXqx/ebC3gLfhUiQfrWZyk4aHd
         e9jCAsu3ldbocr9NLlGpzjDhQT6TsZ2wfIf45oX+Xmv7v9ynYzALdDGCSvoymXs1IlEx
         AIJyAeIktkVWQiVGuj1xu386qKYUHwHAeBpkCyElWWu0y4LL13pKeo1rHil0wEiyKnHI
         oonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723886767; x=1724491567;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUEdTvj/rTiuXZmr7VJNrLRqDEkcl3gCFHL3SGDS+Mc=;
        b=qq1EpsxfSDZFQ/33uupr+AUGxJB0eE0/2jcqWYX+yzBpu28kG/UuzgRadN65W98elv
         H4ExiBW0Tp/OjWeo5HAFXIq3TePbkMVHyXyPrkNLcu78jvAUnCJSlERLuHoCffYQk2RK
         p7AvaKKyG6gGgD/urvTek7j6T6qF1erBn4CYoGSTxryjqR4385VsTXLmxpX96dWmKxPq
         f/9MnaigkUgQwRgTMnKSD+gBrmlHwHPJSb7gYlJD9916+T/tpjnaCesNllU7jMlXCIAw
         /CduTlGkmV4tmTb1lKuikmHRbwvo7W40IO6IQkcfr1zIaI2C/Mvy9+mrFmb5YN1/SXEo
         DzSw==
X-Gm-Message-State: AOJu0YxcDWSNRfiA3AgGLjsVMo0vBOxc/6ef4Ytkfwf66y97jBDi138o
	Zj4+NZ/w3iBt3EW6EzzJndAwG+qpanLiA1nBF0LOm50r0mH281Om5DnlTA==
X-Google-Smtp-Source: AGHT+IHTqDLMibpIAvbzsj3oI1OL7vII/GhnySp/Jk1wRhEsW6KyUo9FDTduyikB9Y4FBkyx4KGuxA==
X-Received: by 2002:adf:a29c:0:b0:371:8e91:77dc with SMTP id ffacd0b85a97d-371946dcc52mr3116902f8f.63.1723886767248;
        Sat, 17 Aug 2024 02:26:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a2eesm5455161f8f.19.2024.08.17.02.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 02:26:06 -0700 (PDT)
Message-Id: <e735a1696a05eeeb24bd7eb79a55b575c59bd62b.1723886761.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
References: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
	<pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Aug 2024 09:25:58 +0000
Subject: [PATCH v3 6/8] git-prompt: don't use shell $'...'
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
Cc: "Junio C. Hamano" <gitster@pobox.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Patrick Steinhardt <ps@pks.im>,
    Avi Halachmi <avihpit@yahoo.com>,
    "Avi Halachmi (:avih)" <avihpit@yahoo.com>

From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>

$'...' is new in POSIX (2024), and some shells support it in recent
versions, while others have had it for decades (bash, zsh, ksh93).

However, there are still enough shells which don't support it, and
it's cheap to use an alternative form which works in all shells,
so let's do that instead of dismissing it as "it's compliant".

It was agreed to use one form rather than $'...' where supported and
fallback otherwise.

shells where $'...' works:
- bash, zsh, ksh93, mksh, busybox-ash, dash master, free/net bsd sh.

shells where it doesn't work, but the new fallback works:
- all dash releases (up to 0.5.12), older versions of free/net bsd sh,
  openbsd sh, pdksh, all Schily Bourne sh variants, yash.

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 47 ++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 5d7f236fe48..c3dd38f847c 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -111,6 +111,12 @@
 __git_printf_supports_v=
 printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
 
+# like __git_SOH=$'\001' etc but works also in shells without $'...'
+eval "$(printf '
+	__git_SOH="\001" __git_STX="\002" __git_ESC="\033"
+	__git_LF="\n" __git_CRLF="\r\n"
+')"
+
 # stores the divergence from upstream in $p
 # used by GIT_PS1_SHOWUPSTREAM
 __git_ps1_show_upstream ()
@@ -118,7 +124,7 @@ __git_ps1_show_upstream ()
 	local key value
 	local svn_remotes="" svn_url_pattern="" count n
 	local upstream_type=git legacy="" verbose="" name=""
-	local LF=$'\n'
+	local LF="$__git_LF"
 
 	# get some config options from git-config
 	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
@@ -271,12 +277,16 @@ __git_ps1_colorize_gitstring ()
 		local c_lblue='%F{blue}'
 		local c_clear='%f'
 	else
-		# Using \001 and \002 around colors is necessary to prevent
-		# issues with command line editing/browsing/completion!
-		local c_red=$'\001\e[31m\002'
-		local c_green=$'\001\e[32m\002'
-		local c_lblue=$'\001\e[1;34m\002'
-		local c_clear=$'\001\e[0m\002'
+		# \001 (SOH) and \002 (STX) are 0-width substring markers
+		# which bash/readline identify while calculating the prompt
+		# on-screen width - to exclude 0-screen-width esc sequences.
+		local c_pre="${__git_SOH}${__git_ESC}["
+		local c_post="m${__git_STX}"
+
+		local c_red="${c_pre}31${c_post}"
+		local c_green="${c_pre}32${c_post}"
+		local c_lblue="${c_pre}1;34${c_post}"
+		local c_clear="${c_pre}0${c_post}"
 	fi
 	local bad_color="$c_red"
 	local ok_color="$c_green"
@@ -312,7 +322,7 @@ __git_ps1_colorize_gitstring ()
 # variable, in that order.
 __git_eread ()
 {
-	test -r "$1" && IFS=$'\r\n' read -r "$2" <"$1"
+	test -r "$1" && IFS=$__git_CRLF read -r "$2" <"$1"
 }
 
 # see if a cherry-pick or revert is in progress, if the user has committed a
@@ -430,19 +440,20 @@ __git_ps1 ()
 		return "$exit"
 	fi
 
+	local LF="$__git_LF"
 	local short_sha=""
 	if [ "$rev_parse_exit_code" = "0" ]; then
-		short_sha="${repo_info##*$'\n'}"
-		repo_info="${repo_info%$'\n'*}"
+		short_sha="${repo_info##*$LF}"
+		repo_info="${repo_info%$LF*}"
 	fi
-	local ref_format="${repo_info##*$'\n'}"
-	repo_info="${repo_info%$'\n'*}"
-	local inside_worktree="${repo_info##*$'\n'}"
-	repo_info="${repo_info%$'\n'*}"
-	local bare_repo="${repo_info##*$'\n'}"
-	repo_info="${repo_info%$'\n'*}"
-	local inside_gitdir="${repo_info##*$'\n'}"
-	local g="${repo_info%$'\n'*}"
+	local ref_format="${repo_info##*$LF}"
+	repo_info="${repo_info%$LF*}"
+	local inside_worktree="${repo_info##*$LF}"
+	repo_info="${repo_info%$LF*}"
+	local bare_repo="${repo_info##*$LF}"
+	repo_info="${repo_info%$LF*}"
+	local inside_gitdir="${repo_info##*$LF}"
+	local g="${repo_info%$LF*}"
 
 	if [ "true" = "$inside_worktree" ] &&
 	   [ -n "${GIT_PS1_HIDE_IF_PWD_IGNORED-}" ] &&
-- 
gitgitgadget

