Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C37149DFA
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723886772; cv=none; b=VdbJ7hkmIuZRaR6jkAEGjZHME1i61pw5DWQlygdNkRNzDfIFy0S2K+VYxsf4o3AdiobenBAAnERLxNcjBWKa0clBUxdhGqqUA+KpSao5uVgc+7iNYJrNFDd6m50jhJBOahoWOkcM3y6lDf6Q9D9h44KILjZaIN6fIwxO1z7uQq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723886772; c=relaxed/simple;
	bh=Y2btUPlnWF9x450ZcUCJVsOoWZUW+2KGM+sT5G0fyQ4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jD+3P6UkVtU1FLggD4AlLCGiCQQuCWslSRkBw3OazH+nm77lfDTGiSeSz8oh7spF9OdDlMPprgP+pxCfd106tEv3uR5zBB0PbDz6falttKGs0lA8PQKZv5Up05OPXLi3r9TEzw3BuL2Hj9ohtdBPRwjhnCjyLzlsDuN16jAEOvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYwWlon+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYwWlon+"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42803bbf842so28037635e9.1
        for <git@vger.kernel.org>; Sat, 17 Aug 2024 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723886768; x=1724491568; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59NEmS/bFLhtsv9T4v3SS4TYomtN8k2v3x2e1iHe8Q8=;
        b=SYwWlon+LvwjZ7hhTL2xw0e1TRQmTOAaTZ8egi2T0rxvpGUlLAkdw8qfkrbFcbXZRW
         WecgtxfmDzTfJBfeByt30vqydUooeR1wYAzLWoPBiCqksmIeKmRPU/WtNXIuzbXUHmsb
         PS9J84IJAfVc3pvonCK39AJIdVD/jYPvlYK2JjpjU+Q8FLDWd1u6pjwniDUyS1IgGVJ/
         NC6GS0qy+BI8xJ6VD37lMJIdGk9tylFXlTSgfQwHGZwqCllqHUCgsZeBoYgpb7kvpbPJ
         Q/NQm+OA39uH7E2EFu1T9AqcOAFYZsAncsI+3oWBDUegmmLKK9mxRB0ZM3plMzk0lU94
         b36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723886768; x=1724491568;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59NEmS/bFLhtsv9T4v3SS4TYomtN8k2v3x2e1iHe8Q8=;
        b=N+pcs9buGIdZnRFxnGmH2bEthh3i8fpGI4bZdXZg4AQGimCgvVnmbcQcs6dBgcGEkW
         reYh8TCSsOKHG2w6Ac8yH205kTAVV+tS07Dr4emItV2L6UNcwtLt+ESAD8Wc5rkB9/vZ
         pbYFWZA0HcyrY1Pl2fiPvyhKkrepDc/C/NpfZkpx+b8DfTwht/hBu4OEK4Nf4AvS8FE0
         MEdetlpLrVZiQpJBe3TP2HfeN2FyOIEwgdpSngQ0vfz+HEadTp3gjGQQmA6Lya9hqreR
         ptYx7CQlXd9CGZhAb0pcvslxWTatg2INVWNzfNliIXfgqHvmEjEtnzL587Bbj0fFbRo7
         fGjg==
X-Gm-Message-State: AOJu0YwtPLGNMxGjFpiPTe7Xek9/Lf8v8Rc7MKohtMae/8J3ivSYXSDe
	QZtd2PiOTLGhKGsQn80YASI3eds60wO+hdwPXY3ZwnZYoD6Ds2v6ZqijhQ==
X-Google-Smtp-Source: AGHT+IHfJxhPzDfWrwGhKmrZbp9iFrmkkCU1+skGfTvHnm0ePYnmEYYkqjseYt10L6X9bsQBfHWsMA==
X-Received: by 2002:a05:600c:3104:b0:426:6ee7:d594 with SMTP id 5b1f17b1804b1-429ed784076mr39524165e9.7.1723886767982;
        Sat, 17 Aug 2024 02:26:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded285easm97942245e9.11.2024.08.17.02.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 02:26:07 -0700 (PDT)
Message-Id: <e70440e669a7151cc49df2f5fa7accafb31a3f44.1723886761.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
References: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
	<pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Aug 2024 09:25:59 +0000
Subject: [PATCH v3 7/8] git-prompt: ta-da! document usage in other shells
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

With one big exception, git-prompt.sh should now be both almost posix
compliant, and also compatible with most (posix-ish) shells.

That exception is the use of "local" vars in functions, which happens
extensively in the current code, and is not simple to replace with
posix compliant code (but also not impossible).

Luckily, almost all shells support "local" as used by the current
code, with the notable exception of ksh93[u+m], but also the Schily
minimal posix sh (pbosh), and yash in posix mode.

See assessment below that "local" is likely the only blocker in those.

So except mainly ksh93, git-prompt.sh now works in most shells:
- bash, zsh, dash since at least 0.5.8, free/net bsd sh, busybox-ash,
  mksh, openbsd sh, pdksh(!), Schily extended Bourne sh (bosh), yash.

which is quite nice.

As an anecdote, replacing the 1st line in __git_ps1() (local exit=$?)
with these 2 makes it work in all tested shells, even without "local":

  # handles only 0/1 args for simplicity. needs +5 LOC for any $#
  __git_e=$?; local exit="$__git_e" 2>/dev/null ||
    {(eval 'local() { export "$@"; }'; __git_ps1 "$@"); return "$__git_e"; }

Explanation:

  If the shell doesn't have the command "local", define our own
  function "local" which instead does plain (global) assignents.
  Then use __git_ps1 in a subshell to not clober the caller's vars.

  This happens to work because currently there are no name conflicts
  (shadow) at the code, initial value is not assumed (i.e. always
  doing either 'local x=...'  or 'local x;...  x=...'), and assigned
  initial values are quoted (local x="$y"), preventing word split and
  glob expansion (i.e. assignment context is not assumed).

  The last two (always init, quote values) seem to be enough to use
  "local" portably if supported, and otherwise shells indeed differ.

  Uses "eval", else shells with "local" may reject it during parsing.
  We don't need "export", but it's smaller than writing our own loop.

While cute, this approach is not really sustainable because all the
vars become global, which is hard to maintain without conflicts
(but hey, it currently has no conflicts - without even trying...).

However, regardless of being an anecdote, it provides some support to
the assessment that "local" is the only blocker in those shells.

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 33 ++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index c3dd38f847c..6be2f1dd901 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -8,8 +8,8 @@
 # To enable:
 #
 #    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
-#    2) Add the following line to your .bashrc/.zshrc:
-#        source ~/.git-prompt.sh
+#    2) Add the following line to your .bashrc/.zshrc/.profile:
+#        . ~/.git-prompt.sh   # dot path/to/this-file
 #    3a) Change your PS1 to call __git_ps1 as
 #        command-substitution:
 #        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
@@ -30,6 +30,8 @@
 #        Optionally, you can supply a third argument with a printf
 #        format string to finetune the output of the branch status
 #
+#    See notes below about compatibility with other shells.
+#
 # The repository status will be displayed only if you are currently in a
 # git repository. The %s token is the placeholder for the shown status.
 #
@@ -106,6 +108,33 @@
 # directory is set up to be ignored by git, then set
 # GIT_PS1_HIDE_IF_PWD_IGNORED to a nonempty value. Override this on the
 # repository level by setting bash.hideIfPwdIgnored to "false".
+#
+# Compatibility with other shells (beyond bash/zsh):
+#
+#    We require posix-ish shell plus "local" support, which is most
+#    shells (even pdksh), but excluding ksh93 (because no "local").
+#
+#    Prompt integration might differ between shells, but the gist is
+#    to load it once on shell init with '. path/to/git-prompt.sh',
+#    set GIT_PS1* vars once as needed, and either place $(__git_ps1..)
+#    inside PS1 once (0/1 args), or, before each prompt is displayed,
+#    call __git_ps1 (2/3 args) which sets PS1 with the status embedded.
+#
+#    Many shells support the 1st method of command substitution,
+#    though some might need to first enable cmd substitution in PS1.
+#
+#    When using colors, each escape sequence is wrapped between byte
+#    values 1 and 2 (control chars SOH, STX, respectively), which are
+#    invisible at the output, but for bash/readline they mark 0-width
+#    strings (SGR color sequences) when calculating the on-screen
+#    prompt width, to maintain correct input editing at the prompt.
+#
+#    Currently there's no support for different markers, so if editing
+#    behaves weird when using colors in __git_ps1, then the solution
+#    is either to disable colors, or, in some shells which only care
+#    about the width of the last prompt line (e.g. busybox-ash),
+#    ensure the git output is not at the last line, maybe like so:
+#      PS1='\n\w \u@\h$(__git_ps1 " (%s)")\n\$ '
 
 # check whether printf supports -v
 __git_printf_supports_v=
-- 
gitgitgadget

