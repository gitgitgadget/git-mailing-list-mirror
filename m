Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED542B9CD
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 01:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118523; cv=none; b=PXoih6Hyuk95xoIMg+yjHwO/E1qE40lV8ICx9ks3l4YLJ/9NQrB8xqu9bzedruabQJOl1uveDOaRLXxJPkO27kF95ZogGzk8KC7BP52ENc+IjfpXEnY/IV6rkNsb5aZ2A5OIKAt5+ZZRPCvlhv4oXfGRcg7gPnNMjghHagR7dpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118523; c=relaxed/simple;
	bh=M/Fo7zXTNw9Y/Hs97vlrJ4YjHA1DEGeiTDJiw/MrEJg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JK6twMIZ8AhA3M2dryAYhtDC/GT5RYIFHdHTSwrpUwnB+vaOJjDzJqfWBYNi3ljgTSakR35f0ae8ZTGzKzTnf310pGIFkLcAf5px74W4mv75i6ayuH0qPxLaJlAt8G46qcHS6NAYXd1Zpl3WXAsUVyTTRsAWqlbFnzb+zOdyjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTLWBVXg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTLWBVXg"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso41422635e9.1
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 18:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724118520; x=1724723320; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vs3xzSHBsIumh6tvWhdotqxT8hZDQyuHe3M7Qqg3wy4=;
        b=iTLWBVXg9Yr6ssa5j0sNX9vkxvvvOgTu8pREXwhXxyadljJci+KsQNR2Bcxgu4gqJD
         sdudt1qsy/Y2vCHF3a70n0PxQoWp2rncK1fd9TXsvTbeH3G6n6QnRiSZ6KJ8SR7NHJ2V
         +rRzXK0rCz4XmWf+HuKbdud73ozQ7UUxoeRTes9ujDyIlN4SIGzpKx2CZHoabraOHc2g
         iNJFE/cTUU6grEqnNF6aEnpyRdcPA4P/lH8ZU7SacKDsx2AMPHYh/ddkbuw/eE9IhrAN
         lD2k0AD6TXmxVH3o3Tj0n1khtg+6ay5u3fOOT8/VlrRMGXA8Uju9fuRlxR5P9zMHvmol
         AsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724118520; x=1724723320;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vs3xzSHBsIumh6tvWhdotqxT8hZDQyuHe3M7Qqg3wy4=;
        b=LczEGmQh5WgCGDcF/Gnf5dpp5Qw8bG88td2WVAFLHGDwe4lRzkuyxlrQliwZw1MXtF
         RXZ8pnnBvTvqym2l3B0KIG5NREntCLScPC0+RO99YO07rynXO6RDf1U9w0NllzidliV1
         xBORvsuzBKoQ2593FOogd5PgLHNp+01TFeX5uAN3mJJZwRVgBwPgz3vkIyTaLWnqeqBT
         35sVTs3Qth9ORDpjEhbW+DEdgVZQEtCJLnP0A6XXc5Q+ZiTnjs8plq0J9gUFhZO8JJOX
         a/Y8xczhMdu6mE03biI+aHwSzQ7p6asJmm0GDxhXc9BgdcJP/QMDEs5gWYEO5x7ugcvf
         rzww==
X-Gm-Message-State: AOJu0Yw76Tfd8jb7qRfd5SPTMPZmhd2dvl8g5fDsWH+ANSoynmUFpDa5
	4xXl1lDCgyoYvfG4pKnhPmAF1ya3ELvDZBLJUrK+inVJFAvynWxshTc0ZQ==
X-Google-Smtp-Source: AGHT+IH1p4eKBqtr9ZNAB/0Sk9/tpmMyV8zrTUWj/SobZofuFf2I5aJHscmQm+ocgu4JQHruAp/hfg==
X-Received: by 2002:adf:ed83:0:b0:36b:a3f1:6333 with SMTP id ffacd0b85a97d-371c5fcb478mr276324f8f.24.1724118519168;
        Mon, 19 Aug 2024 18:48:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86475b0f69sm34665966b.198.2024.08.19.18.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:48:38 -0700 (PDT)
Message-Id: <18ff70db6b3616a9b933b44bf4d44c4405038728.1724118513.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>
References: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
	<pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Aug 2024 01:48:29 +0000
Subject: [PATCH v4 5/8] git-prompt: add some missing quotes
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
    Eric Sunshine <sunshine@sunshineco.com>,
    Avi Halachmi <avihpit@yahoo.com>,
    "Avi Halachmi (:avih)" <avihpit@yahoo.com>

From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>

The issues which this commit fixes are unlikely to be broken
in real life, but the fixes improve correctness, and would prevent
bugs in some uncommon cases, such as weird IFS values.

Listing some portability guidelines here for future reference.

I'm leaving it to someone else to decide whether to include
it in the file itself, place it as a new file, or not.

---------

The command "local" is non standard, but is allowed in this file:
- Quote initialization if it can expand (local x="$y"). See below.
- Don't assume initial value after "local x". Either initialize it
  (local x=..), or set before first use (local x;.. x=..; <use $x>).
  (between shells, "local x" can unset x, or inherit it, or do x= )

Other non-standard features beyond "local" are to be avoided.

Use the standard "test" - [...] instead of non-standard [[...]] .

--------

Quotes (some portability things, but mainly general correctness):

Quotes prevent tilde-expansion of some unquoted literal tildes (~).
If the expansion is undesirable, quotes would ensure that.
  Tilds expanded: a=~user:~/ ;  echo ~user ~/dir
  not expanded:   t="~"; a=${t}user  b=\~foo~;  echo "~user" $t/dir

But the main reason for quoting is to prevent IFS field splitting
(which also coalesces IFS chars) and glob expansion in parts which
contain parameter/arithmetic expansion or command substitution.

"Simple command" (POSIX term) is assignment[s] and/or command [args].
Examples:
  foo=bar         # one assignment
  foo=$bar x=y    # two assignments
  foo bar         # command, no assignments
  x=123 foo bar   # one assignment and a command

The assignments part is not IFS-split or glob-expanded.

The command+args part does get IFS field split and glob expanded,
but only at unquoted expanded/substituted parts.

In the command+args part, expanded/substituted values must be quoted.
(the commands here are "[" and "local"):
  Good: [ "$mode" = yes ]; local s="*" x="$y" e="$?" z="$(cmd ...)"
  Bad:  [ $mode = yes ];   local s=*   x=$y   e=$?   z=$(cmd...)

The arguments to "local" do look like assignments, but they're not
the assignment part of a simple command; they're at the command part.

Still at the command part, no need to quote non-expandable values:
  Good:                 local x=   y=yes;   echo OK
  OK, but not required: local x="" y="yes"; echo "OK"
But completely empty (NULL) arguments must be quoted:
  foo ""   is not the same as:   foo

Assignments in simple commands - with or without an actual command,
don't need quoting becase there's no IFS split or glob expansion:
  Good:   s=* a=$b c=$(cmd...)${x# foo }${y-   } [cmd ...]
  It's also OK to use double quotes, but not required.

This behavior (no IFS/glob) is called "assignment context", and
"local" does not behave with assignment context in some shells,
hence we require quotes when using "local" - for compatibility.

The value between 'case' and 'in' doesn't IFS-split/glob-expand:
  Good:       case  * $foo $(cmd...)  in ... ; esac
  identical:  case "* $foo $(cmd...)" in ... ; esac

Nested quotes in command substitution are fine, often necessary:
  Good: echo "$(foo... "$x" "$(bar ...)")"

Nested quotes in substring ops are legal, and sometimes needed
to prevent interpretation as a pattern, but not the most readable:
  Legal:  foo "${x#*"$y" }"

Nested quotes in "maybe other value" subst are invalid, unnecessary:
  Good:  local x="${y- }";   foo "${z:+ $a }"
  Bad:   local x="${y-" "}"; foo "${z:+" $a "}"
Outer/inner quotes in "maybe other value" have different use cases:
  "${x-$y}"  always one quoted arg: "$x" if x is set, else "$y".
  ${x+"$x"}  one quoted arg "$x" if x is set, else no arg at all.
  Unquoted $x is similar to the second case, but it would get split
  into few arguments if it includes any of the IFS chars.

Assignments don't need the outer quotes, and the braces delimit the
value, so nested quotes can be avoided, for readability:
  a=$(foo "$x")  a=${x#*"$y" }  c=${y- };  bar "$a" "$b" "$c"

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 4781261f868..5d7f236fe48 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -246,7 +246,7 @@ __git_ps1_show_upstream ()
 		if [ -n "$count" ] && [ -n "$name" ]; then
 			__git_ps1_upstream_name=$(git rev-parse \
 				--abbrev-ref "$upstream_type" 2>/dev/null)
-			if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
+			if [ "$pcmode" = yes ] && [ "$ps1_expanded" = yes ]; then
 				upstream="$upstream \${__git_ps1_upstream_name}"
 			else
 				upstream="$upstream ${__git_ps1_upstream_name}"
@@ -278,12 +278,12 @@ __git_ps1_colorize_gitstring ()
 		local c_lblue=$'\001\e[1;34m\002'
 		local c_clear=$'\001\e[0m\002'
 	fi
-	local bad_color=$c_red
-	local ok_color=$c_green
+	local bad_color="$c_red"
+	local ok_color="$c_green"
 	local flags_color="$c_lblue"
 
 	local branch_color=""
-	if [ $detached = no ]; then
+	if [ "$detached" = no ]; then
 		branch_color="$ok_color"
 	else
 		branch_color="$bad_color"
@@ -360,7 +360,7 @@ __git_sequencer_status ()
 __git_ps1 ()
 {
 	# preserve exit status
-	local exit=$?
+	local exit="$?"
 	local pcmode=no
 	local detached=no
 	local ps1pc_start='\u@\h:\w '
@@ -379,7 +379,7 @@ __git_ps1 ()
 		;;
 		0|1)	printf_format="${1:-$printf_format}"
 		;;
-		*)	return $exit
+		*)	return "$exit"
 		;;
 	esac
 
@@ -427,7 +427,7 @@ __git_ps1 ()
 	rev_parse_exit_code="$?"
 
 	if [ -z "$repo_info" ]; then
-		return $exit
+		return "$exit"
 	fi
 
 	local short_sha=""
@@ -449,7 +449,7 @@ __git_ps1 ()
 	   [ "$(git config --bool bash.hideIfPwdIgnored)" != "false" ] &&
 	   git check-ignore -q .
 	then
-		return $exit
+		return "$exit"
 	fi
 
 	local sparse=""
@@ -499,7 +499,7 @@ __git_ps1 ()
 			case "$ref_format" in
 			files)
 				if ! __git_eread "$g/HEAD" head; then
-					return $exit
+					return "$exit"
 				fi
 
 				case $head in
@@ -597,10 +597,10 @@ __git_ps1 ()
 		fi
 	fi
 
-	local z="${GIT_PS1_STATESEPARATOR-" "}"
+	local z="${GIT_PS1_STATESEPARATOR- }"
 
 	b=${b##refs/heads/}
-	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
+	if [ "$pcmode" = yes ] && [ "$ps1_expanded" = yes ]; then
 		__git_ps1_branch_name=$b
 		b="\${__git_ps1_branch_name}"
 	fi
@@ -612,7 +612,7 @@ __git_ps1 ()
 	local f="$h$w$i$s$u$p"
 	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}${conflict}"
 
-	if [ $pcmode = yes ]; then
+	if [ "$pcmode" = yes ]; then
 		if [ "${__git_printf_supports_v-}" != yes ]; then
 			gitstring=$(printf -- "$printf_format" "$gitstring")
 		else
@@ -623,5 +623,5 @@ __git_ps1 ()
 		printf -- "$printf_format" "$gitstring"
 	fi
 
-	return $exit
+	return "$exit"
 }
-- 
gitgitgadget

