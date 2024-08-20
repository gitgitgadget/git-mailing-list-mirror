Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DD31BC4E
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 01:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118525; cv=none; b=ZlME14us3VaqJDzFeZSn4fwhrx4gdZvfYNrQwkeEB3mEHzP2TA9WSF1pBdhjdmYjjnL6xJLCUWdc25hxAHYHq6+B5jQBDBp+gKqwov1JSHVrhfQQZ2XDkUBh3XwjXwy2kJWTBG2tVGcJnlP52xEA0MCLZJF6RLXdd8i51kxkBy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118525; c=relaxed/simple;
	bh=Y2btUPlnWF9x450ZcUCJVsOoWZUW+2KGM+sT5G0fyQ4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PPeJ994HZRYtXwtPlcpCEeXWXgYM7a0Dsu9C/xFBWKUUyieV87Iy5AqRoEezKTWlUB40sw3ZuJgSoIjfkrz/Fi7dBNMHK+4UiaQSbB8OPAadOxB5sP6IAt4gJD/FJxABBPTMPv46pQnB+4v5AjPsmcowXPzg+8CGdvJGobJEpaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABI9Zr1t; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABI9Zr1t"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso604946266b.2
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 18:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724118521; x=1724723321; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59NEmS/bFLhtsv9T4v3SS4TYomtN8k2v3x2e1iHe8Q8=;
        b=ABI9Zr1tiCiNnllWRLcdPmHpQWdjb60K8og0sxG5mcbyFBgP1vVwz7+pScvirRCumu
         iAEQaYtEcB/2MqjlDSq/C61u9vFE2WITMfAHOpMxaos8cwDO9YC3ZHgPX1a3Yf90WWT8
         G2ZCLALX+TGyUl1SWzcofj/KqgTi9BJAdeuyyBXiADiWeLLlt/KORd9YA2qQwD0yI2sn
         tVpiPE2hdTA3oZGJGg7f/P4xdD8oVFfJa/28L2Zokf4TFW07ruM2W+l5/XpbOlWlcN00
         VuaiLjBYVtCi0Xw5NhIRTPJiWA4vHg5FeTEDItp881dL6jI5MQ8hHKXYjZrEfyen2LWl
         ayiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724118521; x=1724723321;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59NEmS/bFLhtsv9T4v3SS4TYomtN8k2v3x2e1iHe8Q8=;
        b=rWF/kiupQINHbJSiPv9so/E7cPtlyUcl/GmP7R6at+TS93yyfdVtTC/b5jQ5+mgrno
         9j2UAF6XmOo9EGI1Z/22snwjXm2Iu9gf8SexToH4LmgRCLIczTm/MuqwJz/7MSESuXW7
         1xf/BQfWSk6F0Sbfu5hKOIojGRcpDCDNjbXfHmFNl1I9WCNlLSLqrkfNKGBJqnZlUWWD
         ov9r4IwRGa4SUe45wXlmaF7wd+7QeNUC+gfGtPnuwuqDicBgP75Q/0WxO+G6epp8BBpJ
         TjrocOlvs/StB5wDMMchDxyzRpPIB94GcQFnpVGwlMkBG0x41W477POSC1jND3QigGjM
         pp+w==
X-Gm-Message-State: AOJu0YwmE0cTwY/tNN0bST1++6rjd8hzv7a6gGFwGuZqkkNXNajVPIpx
	nfha9mUIRv/xEeepjW5cy3lo4Zct5kEPSlYj7hWJglgNiWsaZnac2nRJDg==
X-Google-Smtp-Source: AGHT+IEX63Pw85oiYdL7v4xsaIdYvXZiREGy/ul9NAnFWiDVMxT1RByN1+OPLVLXeeITikckKgTl5g==
X-Received: by 2002:a17:906:f5a7:b0:a7d:a00a:aa02 with SMTP id a640c23a62f3a-a83928a64fdmr858868466b.1.1724118520788;
        Mon, 19 Aug 2024 18:48:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396cfa5sm694192566b.207.2024.08.19.18.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:48:40 -0700 (PDT)
Message-Id: <cd20b830b24f236ee348ec549a7ae1e499f8c187.1724118513.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>
References: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
	<pull.1750.v4.git.git.1724118513.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Aug 2024 01:48:31 +0000
Subject: [PATCH v4 7/8] git-prompt: ta-da! document usage in other shells
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

