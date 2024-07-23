Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69C143744
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721762321; cv=none; b=l2Pmf5s2GHUozkFUJnKJijvXosUnoJyHDzRH1kyvE4eTA6S95S0Juk6pxFb3PSOfGo0S5l9Xj43NIghoSYjbzJ8XBfJO0sYTzwDXmNeIhtFulgvsP1Uj1AxOp+FAvl65OqjIacUDYz4T9AiDKxSmird3Uefz/Eo44UE/OP7OHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721762321; c=relaxed/simple;
	bh=YlO6Rziadwtarg7y+G73ARa7gY76nZonO7yiui1+cWo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UUOFiWlx4Btfsf02FaSQ5ns0dKTGefO3nEztOAUzDMVzO1uTVMVe69tjfW9r4tLq8CohTwQW9aTyq9p0lhNNe3CT9o8syseCMFKb4zp7oOpenXR5oFSqXNGBb5tXGBKlfcZuVlaJlBdyx7GEpeXPAUECfOYeJYZdxFBhQNglrE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX8Q9dlT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX8Q9dlT"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso85027341fa.1
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721762317; x=1722367117; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZu+accr9EvkOwRR3yW09OfJTHbiSshn6eSaoB0Gf6A=;
        b=ZX8Q9dlTlu4I1/ZiVLbhNBQrtBJ7AD/ZBsvu0nefmKhcDnLh9GfAtvafea14QTQOvk
         vuYQmYlsE7BoShDeNdzx965f7tHilZQiFYLvGh9PLG5gk/0gjdCtnMb1xQG87o06kTpU
         GrFufWM7mq/fIyiPBIBzUPftyxq8OUlxoaHrEdWPKs/J3vjL08P6jTe/PsPk91aSn8Ou
         YIVB8lmfDbI9i76WzoeAm1CxRIzsw1LPwJQUWZBINuuWornoffcBxhbW7PjicW8HLoYC
         ilNW+c1Nv71nV6uezNeMQYjJJppzFJ5kRsQOJ0NVD3MGeq09vmkPZ5LJKXYeoAHYFvFX
         ZKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721762317; x=1722367117;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZu+accr9EvkOwRR3yW09OfJTHbiSshn6eSaoB0Gf6A=;
        b=TWhci3EM31V+/t6YfiE+RiShURYJYrf16PxRS0l295DK8bqz7Vgawaqe/Zs17juZ7u
         LhChG/Dm42wG/C2x3+toVvCfjJh1A99L1jh1pciU01thL8NWjojnWM0XRUHgX8mCSKO7
         wVPStazxLA0UevCz/O5eLm7ztgqhKX/Vkefj3KbH20tEQ+gAeezoLj5xnmkBDR+Sgw0U
         uS+3bGpWGAuwrztpa3jEaMH63JXWGmpZ3wCZ949gJdY93B1T9NOjnHP0X3fMzbDgiCX4
         Vug7onIb4cf9bFvb51yHT0fH7HCMjcUrx2WlxVknod/6IrGLRKfOHh+H6uqQps84vHTX
         CUnA==
X-Gm-Message-State: AOJu0Yw8lAq3G7ecMpETrJjrEZS+RgG2qc1/nmey1eeNQvA5+JFF58dp
	wGWlsL0k7qu34QaVD5q6/p7qruPsNVrAMhjrr5KdqbMfVRElC1SQkmFgbQ==
X-Google-Smtp-Source: AGHT+IHgiTJVQT5ul7/UVb8G/pp8WtVFTs+FP2L/RE3TSGqtAmpr5Fq7ZlPA6eTJ/IN+eQCWrW1crA==
X-Received: by 2002:a05:6512:402a:b0:52c:e326:f4cf with SMTP id 2adb3069b0e04-52fc403d250mr2747993e87.3.1721762317297;
        Tue, 23 Jul 2024 12:18:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c2f869dsm7903772a12.65.2024.07.23.12.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 12:18:35 -0700 (PDT)
Message-Id: <4a086ffc36033301095665530ab8f45cd1c4af36.1721762306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Jul 2024 19:18:25 +0000
Subject: [PATCH 7/8] git-prompt: ta-da! document usage in other shells
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
Cc: Avi Halachmi <avihpit@yahoo.com>,
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
index bbc16417ac9..5787eca28db 100644
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
+# Conpatibility with other shells (beyond bash/zsh):
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

