Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F61487D5
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723886769; cv=none; b=S89543o4L8OrRaehRKK8c10hPg0jdYkKm6uahN+QgJkOaxEx/xV2hL2A+gkVX9GOO4tewzN69IeZr6AyY4ASNynG9ihwn1nEJnuZHBpQrE4fnx74wvjCla22B+ACFW+gL+wNvJn+4Tfk/7XOiceAlV/JmaxAAPS0uMzP80dcrV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723886769; c=relaxed/simple;
	bh=p/jqA9gX8l00DDL8hIGrnZJ3zN3+zLxdtSLBkGRh4Gs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HysXijV/HaE0re8c77nUM1jKx+eN/sPyRVWg6JXV7AxYQdGGVv50SzvymDgXhuSUi7+jRsfkUkRzUAQgJeXYH5qAiPGqMF76fCzDwJWj40OGM0ZXJpDQItmW+39YfVq1I3APtyhyXF0GdoJPnd3JMK+iV9QRPnON5kX/QZ0xJUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qo2wYrQL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo2wYrQL"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-429c4a4c6a8so20567035e9.0
        for <git@vger.kernel.org>; Sat, 17 Aug 2024 02:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723886765; x=1724491565; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scQQcYhZj7QegWybZvw4rIUqVDfa3YFL+8LLt/4ZwzY=;
        b=Qo2wYrQLF2bAUxb4QTN45rFzVGi5/kxQlLGuF/NPNn+81fdxTjTThniMqKTn3gLQZj
         jDoLfcjzIz0Xipf5hUmMKU3z0YBeVGrEZfRlW9m0d0/y45PhhomjoQVapPa6/Q6mmWaw
         r6Y3fmX4xm1mZltOTQUDb9kHauMFpl317Gvh7XYSVyviTHxskf0iTRNk1nAoTcCG3yty
         AuT6Oa9gE+Sqq4D9E+Njh/4JClsCqCwsyYs5Ernt029n3X3pzQqZu3xX/AdCcBuANe7a
         tlbRGd6hvesrWnVK2wPqtUKrv5DkqzcrwuHfWan8WWoGfg7s2wNFehxX6gXWaRTeIbWb
         03dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723886765; x=1724491565;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scQQcYhZj7QegWybZvw4rIUqVDfa3YFL+8LLt/4ZwzY=;
        b=jXIwcC7ehMD2MpSjqqJpF7svTnLwO+HqiVN5SnEXI0BuGMqtTM+6hQJ4wetWt96erm
         VniSTxHR1+nJiFHyCS1k9VNKZrLyn3+hGE/bYv9qSt5LUmefpd1a4/U2QttJKl7S8Opy
         wfmamMmVfIoLZFcrybcrCohM082wFGeWdON5qW1OwDB2H+R+82thFytRqmeOQ1lCxHro
         Ogu2DUkc3UTB6oBtkXVoZ63LqFN2ri6iFy4gFc8SjuJg/mJcHlN0BGQAF36oB50uw+qM
         0nTWPq3fUb2NYiCzyFa9H9BGe6OviWAluvu4tIu5IEAw7GoFVE1yxnPfZJvnM0NCmgQL
         fvFQ==
X-Gm-Message-State: AOJu0Yy5UYK5z4orTfi0U3cE+c2T1eDQL4KsaWA4YqL49irRd3/LDNPW
	mbQQpMmIHqNpe54bNFLtwh28QVxDO+IXk5V+uvux59XnAwm8b+S3eApsPg==
X-Google-Smtp-Source: AGHT+IETgo8nX4eIylgHBu51Gek20ZiWP3/zV44CrV+f23JWVdcjYlrLWaNcsEJbZxa8PlzSGi3ayA==
X-Received: by 2002:a05:600c:500a:b0:426:5416:67de with SMTP id 5b1f17b1804b1-429ed7e44c3mr33421485e9.30.1723886765040;
        Sat, 17 Aug 2024 02:26:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded71ef0sm98358415e9.36.2024.08.17.02.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 02:26:04 -0700 (PDT)
Message-Id: <7e994eae7bc3dfa021262410c801ddb124ce24f1.1723886760.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
References: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
	<pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Aug 2024 09:25:55 +0000
Subject: [PATCH v3 3/8] git-prompt: don't use shell arrays
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

Arrays only existed in the svn-upstream code, used to:
- Keep a list of svn remotes.
- Convert commit msg to array of words, extract the 2nd-to-last word.

Except bash/zsh, nearly all shells failed load on syntax errors here.

Now:
- The svn remotes are a list of newline-terminated values.
- The 2nd-to-last word is extracted using standard shell substrings.
- All shells can digest the svn-upstream code.

While using shell field splitting to extract the word is simple, and
doesn't even need non-standard code, e.g. set -- $(git log -1 ...),
it would have the same issues as the old array code: it depends on IFS
which we don't control, and it's subject to glob-expansion, e.g. if
the message happens to include * or **/* (as this commit message just
did), then the array could get huge. This was not great.

Now it uses standard shell substrings, and we know the exact delimiter
to expect, because it's the match from our grep just one line earlier.

The new word extraction code also fixes svn-upstream in zsh, because
previously it used arr[len-2], but because in zsh, unlike bash, array
subscripts are 1-based, it incorrectly extracted the 3rd-to-last word.
symptom: missing upstream status in a git-svn repo: u=, u+N-M, etc.

The breakage in zsh is surprising, because it was last touched by
  commit d0583da838 (prompt: fix show upstream with svn and zsh),
claiming to fix exactly that. However, it only mentions syntax fixes.
It's unclear if behavior was fixed too. But it was broken, now fixed.

Note LF=$'\n' and then using $LF instead of $'\n' few times.
A future commit will add fallback for shells without $'...', so this
would be the only line to touch instead of replacing every $'\n' .

Shells which could run the previous array code:
- bash

Shells which have arrays but were broken anyway:
- zsh: 1-based subscript
- ksh93: no "local" (the new code can't fix this part...)
- mksh, openbsd sh, pdksh: failed load on syntax error: "for ((...))".

More shells which Failed to load due to syntax error:
- dash, free/net bsd sh, busybox-ash, Schily Bourne shell, yash.

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 48 ++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 4cc2cf91bb6..75c3a813fda 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -116,10 +116,10 @@ printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
 __git_ps1_show_upstream ()
 {
 	local key value
-	local svn_remote svn_url_pattern="" count n
+	local svn_remotes="" svn_url_pattern="" count n
 	local upstream_type=git legacy="" verbose="" name=""
+	local LF=$'\n'
 
-	svn_remote=()
 	# get some config options from git-config
 	local output="$(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
 	while read -r key value; do
@@ -132,7 +132,7 @@ __git_ps1_show_upstream ()
 			fi
 			;;
 		svn-remote.*.url)
-			svn_remote[$((${#svn_remote[@]} + 1))]="$value"
+			svn_remotes=${svn_remotes}${value}${LF}  # URI\nURI\n...
 			svn_url_pattern="$svn_url_pattern\\|$value"
 			upstream_type=svn+git # default upstream type is SVN if available, else git
 			;;
@@ -156,25 +156,37 @@ __git_ps1_show_upstream ()
 	case "$upstream_type" in
 	git)    upstream_type="@{upstream}" ;;
 	svn*)
-		# get the upstream from the "git-svn-id: ..." in a commit message
-		# (git-svn uses essentially the same procedure internally)
-		local -a svn_upstream
-		svn_upstream=($(git log --first-parent -1 \
-					--grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null))
-		if [[ 0 -ne ${#svn_upstream[@]} ]]; then
-			svn_upstream=${svn_upstream[${#svn_upstream[@]} - 2]}
-			svn_upstream=${svn_upstream%@*}
-			local n_stop="${#svn_remote[@]}"
-			for ((n=1; n <= n_stop; n++)); do
-				svn_upstream=${svn_upstream#${svn_remote[$n]}}
-			done
+		# successful svn-upstream resolution:
+		# - get the list of configured svn-remotes ($svn_remotes set above)
+		# - get the last commit which seems from one of our svn-remotes
+		# - confirm that it is from one of the svn-remotes
+		# - use $GIT_SVN_ID if set, else "git-svn"
 
-			if [[ -z "$svn_upstream" ]]; then
+		# get upstream from "git-svn-id: UPSTRM@N HASH" in a commit message
+		# (git-svn uses essentially the same procedure internally)
+		local svn_upstream="$(
+			git log --first-parent -1 \
+				--grep="^git-svn-id: \(${svn_url_pattern#??}\)" 2>/dev/null
+		)"
+
+		if [ -n "$svn_upstream" ]; then
+			# extract the URI, assuming --grep matched the last line
+			svn_upstream=${svn_upstream##*$LF}  # last line
+			svn_upstream=${svn_upstream#*: }    # UPSTRM@N HASH
+			svn_upstream=${svn_upstream%@*}     # UPSTRM
+
+			case ${LF}${svn_remotes} in
+			*"${LF}${svn_upstream}${LF}"*)
+				# grep indeed matched the last line - it's our remote
 				# default branch name for checkouts with no layout:
 				upstream_type=${GIT_SVN_ID:-git-svn}
-			else
+				;;
+			*)
+				# the commit message includes one of our remotes, but
+				# it's not at the last line. is $svn_upstream junk?
 				upstream_type=${svn_upstream#/}
-			fi
+				;;
+			esac
 		elif [[ "svn+git" = "$upstream_type" ]]; then
 			upstream_type="@{upstream}"
 		fi
-- 
gitgitgadget

