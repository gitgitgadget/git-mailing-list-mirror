Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5922B21256C
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144877; cv=none; b=FJ/MEt7YVyFxLsmB4E08XUBFu66KoEqTD9NEhMQJ3+fJHwRVEIai0HmDUiFVI5f9eTjZZRtn9iY6KJHXhYZzsPJ0+1S7amP3WzRzqx7VE6w5gz4/3sGt2Q1LIa2g1cxDUCPaAniDVc63+Fe/7acyY2NDyjrGjNJNrrqOOoH0d9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144877; c=relaxed/simple;
	bh=HzK5nTWhWr01mIMqEmKA8Y4Pzomu+qTA9dE1hDIml4E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=R7evHO+9euDR/EqUwaAs1L/om25bAWkE8K4sv4zq59dK2CtPZt8tJuxBpg8QwiDWYmqkV8ltGREE3S97p64VytYsvDCbqIWU0tFJWULe3rXRwcBgXQlCHKrJZl6pY7Oe69NC6UXfSg63BwGBewdqBihan5/4/ordwmrvVmtfVrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCCDUmt/; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCCDUmt/"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8f256eaedf8so12757926d6.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 06:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787144874; x=1787749674; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SwuNZlIlAdqOt2kjAwdpKqElT2k47huhW+skiQP0Yww=;
        b=VCCDUmt/l7Qfye++y+7/QyKYZcuqFJwMc7ZKuh8zsJItTypFA8SYhMDilVn/aC5n85
         N5XHGHTqyKJnp+oZsnzKOhPk7uVm0TJSIt78ebaMDyc6TcYCoECGzt/7Fr8K7CAEaKxQ
         9qPb33cdvNS8ik++/ZsML4cyxOsMZcT/CcI4+X49hKygB+e0fKm7FsgooFQmYgRy86dn
         3yEtULOHQg8c/rqqbw+i7xzQ36U5fg7cUvCImGKy/qxX2R7z64iuHTMC/zXqjHLtOg8j
         maw3LhT9olU1SrTXJIu1r2BoOPoqGYeLoYacvaEddjp/5EcWjKghjaio7aYKWQc3DSRG
         ag2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787144874; x=1787749674;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SwuNZlIlAdqOt2kjAwdpKqElT2k47huhW+skiQP0Yww=;
        b=Wh0RJDZUZUKuR05OC6Z3dJh2gCUA1SBRuxsz+0dacUA1xbwKWcZYBtqHpj9s+jb+cZ
         oW2Ffgx6G714TxD29OIvzJpZKSpbyJY9bMpOWbZFwKEO+7mrYjwm0g+UXY9lgqg1Zkp+
         kQPV5SVoW+6GgDoMfThaUrQK5TXJbyVLAz95qXxCnNZ9TeHgGyhEP1fhRnfcZZRpzVL7
         kz/yn3YDKwWxCkyplM+PfWE6P5kXQzC6kCRL/kwo5Ug6RDZS9X2oaIlgW7OcWx3nIQx3
         CYwxUKfKrOtn7rmozDNpFUw+qHv5SJMLnLBmiQ4hKelmYgvwUfN7loPDIdaUaGyElrme
         uDAA==
X-Gm-Message-State: AFuF++knHCbzHvA8tt5kJAkEYQ/FzdyAe/cR2vcFPqKTKuL0diWNSDxl
	SI/3X1NQ02wym96VtcjiuexmJGmY1qP69cT9OkHRbDb2QDVZ4PPU2O6cukzvrg==
X-Gm-Gg: AR+sD12VsLUvyoCdmjVP7eiB5leukPlKcTRw3jPkl/Ct9wawNzph9PCIVg68cbNhNxt
	GRADUQxonMf5GLZchZidMDS6TG64tWm3e0eNiUnNxOqu/MWMLQ7G5JHbwQeOzXGPsXg9/ijchsM
	h9d/yTlkFd3NZsIjd7i9MwKSVv2YSORXhgG5rFHynyG9FRrbv5FyGIeCNfdvHgxL+yIm8Ek+CEX
	sMd1eIbv1QEeDhytx2g/Up987z/BTJ7cR+a9hcnwEQP6jmrrLzmp2aE3FlZIjCNiFl6SAYk0sBf
	19ST0uSEav43Ai5IHycdqCfOirfBR8VFFPXm3MpiG7YQkdyOssb/23qFXFIWrRz9vtalmVx/87O
	Vx+qCqZ+kVD6CthwJtb/DkbDwvbx+8RX1R2nsgcCKDYy11BoTZNtlSiyXIe5PSOQjBQfqxBCS+8
	xgHkSusSt0uuWUqJrWfA/fTUO+ugTxGuXrnGd2qbHlxL0LGXsuiGYOn3JHx1NXVseC11cv4pkAw
	Rl0
X-Received: by 2002:a05:6214:ccd:b0:8f2:4723:d88d with SMTP id 6a1803df08f44-90c5e961ed8mr41976866d6.4.1787144874087;
        Wed, 19 Aug 2026 06:07:54 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.165.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2a2d57sm13917736d6.37.2026.08.19.06.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 06:07:53 -0700 (PDT)
Message-Id: <pull.2155.v2.git.1787144872870.gitgitgadget@gmail.com>
In-Reply-To: <pull.2155.git.1781710256081.gitgitgadget@gmail.com>
References: <pull.2155.git.1781710256081.gitgitgadget@gmail.com>
From: "Lutz Lengemann via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Aug 2026 13:07:51 +0000
Subject: [PATCH v2] completion: zsh: support completion after "git -C <path>"
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
Cc: Lutz Lengemann <lutz@lengemann.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Lutz Lengemann <lutz@lengemann.net>,
    Lutz Lengemann <lutz@lengemann.net>

From: Lutz Lengemann <lutz@lengemann.net>

The zsh completion wrapper does not handle the global -C option, so

	git -C <path> <command> <TAB>

offers nothing.  -C is not part of the _arguments specification, and the
wrapper hard-codes __git_cmd_idx=1, i.e. it assumes that the command is
the first argument, so the bash helpers look at the wrong word.  The
latter is not specific to -C; the assumption breaks after any global
option, e.g. "git -p checkout <TAB>" does not complete branch names.

Add -C to the specification, and find the command by skipping over the
global options and, where they take one, their arguments, as __git_main
in git-completion.bash does.  The index is one less than zsh's, as the
helpers count the words from zero.  Collect the paths given to -C into
__git_C_args, or else the helpers run git in the current directory and
fail to resolve the aliases and refs of the repository the command runs
in.

The argument of a -C is still completed without regard for the -C
options before it, i.e. "git -C dir -C <TAB>" offers the directories in
".", not the ones in "dir".

Signed-off-by: Lutz Lengemann <lutz@lengemann.net>
---
    completion: zsh: support completion after "git -C "
    
     * The command is now located by walking the global options in front of
       it, mirroring the loop at the beginning of __git_main in
       git-completion.bash, instead of skipping only leading -C options.
       This also fixes argument completion after other global options, e.g.
       git -p checkout <TAB>.
     * The log message uses the present tense for the pre-image and notes
       that the argument of a -C is completed without regard for the -C
       options before it.
    
    cc: Ben Knoble ben.knoble@gmail.com cc: Junio C Hamano gitster@pobox.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2155%2Fmobilutz%2Fzsh-complete-global-C-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2155/mobilutz/zsh-complete-global-C-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2155

Range-diff vs v1:

 1:  9739cde6fc ! 1:  9984228f1f completion: zsh: support completion after "git -C <path>"
     @@ Metadata
       ## Commit message ##
          completion: zsh: support completion after "git -C <path>"
      
     -    The zsh completion wrapper (__git_zsh_main) did not handle the global -C
     -    option, so "git -C <path> <command> <TAB>" offered nothing and could not
     -    complete a command's arguments.
     +    The zsh completion wrapper does not handle the global -C option, so
      
     -    Three things are needed to make it work, all scoped to -C:
     +            git -C <path> <command> <TAB>
      
     -      - Add -C to the _arguments specification, so completion no longer stops
     -        at it.
     +    offers nothing.  -C is not part of the _arguments specification, and the
     +    wrapper hard-codes __git_cmd_idx=1, i.e. it assumes that the command is
     +    the first argument, so the bash helpers look at the wrong word.  The
     +    latter is not specific to -C; the assumption breaks after any global
     +    option, e.g. "git -p checkout <TAB>" does not complete branch names.
      
     -      - Advance __git_cmd_idx past any leading "-C <path>" options. The index
     -        is hard-coded to 1, i.e. the command is assumed to be the first
     -        argument; with -C present the command sits two words later for each
     -        -C, so the bash helpers otherwise look at the wrong word and produce
     -        nothing.
     +    Add -C to the specification, and find the command by skipping over the
     +    global options and, where they take one, their arguments, as __git_main
     +    in git-completion.bash does.  The index is one less than zsh's, as the
     +    helpers count the words from zero.  Collect the paths given to -C into
     +    __git_C_args, or else the helpers run git in the current directory and
     +    fail to resolve the aliases and refs of the repository the command runs
     +    in.
      
     -      - Collect the -C paths into __git_C_args, as __git_main does. The bash
     -        helpers run git to resolve aliases and list refs; without the -C
     -        paths they run in the current directory, so completion fails whenever
     -        the cwd is not the target repository or the command is an alias.
     -
     -    With these, "git -C <path> <command> <TAB>" completes the command, its
     -    options and its arguments, including outside the repository, through
     -    aliases, and with repeated -C options.
     +    The argument of a -C is still completed without regard for the -C
     +    options before it, i.e. "git -C dir -C <TAB>" offers the directories in
     +    ".", not the ones in "dir".
      
          Signed-off-by: Lutz Lengemann <lutz@lengemann.net>
      
     @@ contrib/completion/git-completion.zsh: __git_zsh_main ()
       		'(- :)--version[prints the git suite version]' \
       		'--exec-path=-[path to where your core git programs are installed]:: :_directories' \
      @@ contrib/completion/git-completion.zsh: __git_zsh_main ()
     + 		done
       		;;
       	(arg)
     - 		local command="${words[1]}" __git_dir __git_cmd_idx=1
     +-		local command="${words[1]}" __git_dir __git_cmd_idx=1
     ++		local command="${words[1]}" __git_dir __git_cmd_idx
      +		local -a __git_C_args
      +		local -i i=2
      +
     -+		while [[ ${orig_words[i]} == -C ]]; do
     -+			__git_C_args+=(-C ${orig_words[i+1]})
     -+			(( __git_cmd_idx += 2 ))
     -+			(( i += 2 ))
     ++		while (( i <= $#orig_words )); do
     ++			case ${orig_words[i]} in
     ++			-C)
     ++				__git_C_args+=(-C ${orig_words[i+1]})
     ++				(( i++ ))
     ++				;;
     ++			-c|--git-dir|--work-tree|--namespace)
     ++				(( i++ ))
     ++				;;
     ++			-*)
     ++				;;
     ++			*)
     ++				break
     ++				;;
     ++			esac
     ++			(( i++ ))
      +		done
     ++
     ++		__git_cmd_idx=$(( i - 1 ))
       
       		if (( $+opt_args[--bare] )); then
       			__git_dir='.'


 contrib/completion/git-completion.zsh | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index c32186a977..d5c526665b 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -227,6 +227,7 @@ __git_zsh_main ()
 		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
 		'(-p --paginate)--no-pager[do not pipe git output into a pager]' \
 		'--git-dir=-[set the path to the repository]: :_directories' \
+		'*-C[run as if git was started in <path>]: :_directories' \
 		'--bare[treat the repository as a bare repository]' \
 		'(- :)--version[prints the git suite version]' \
 		'--exec-path=-[path to where your core git programs are installed]:: :_directories' \
@@ -251,7 +252,29 @@ __git_zsh_main ()
 		done
 		;;
 	(arg)
-		local command="${words[1]}" __git_dir __git_cmd_idx=1
+		local command="${words[1]}" __git_dir __git_cmd_idx
+		local -a __git_C_args
+		local -i i=2
+
+		while (( i <= $#orig_words )); do
+			case ${orig_words[i]} in
+			-C)
+				__git_C_args+=(-C ${orig_words[i+1]})
+				(( i++ ))
+				;;
+			-c|--git-dir|--work-tree|--namespace)
+				(( i++ ))
+				;;
+			-*)
+				;;
+			*)
+				break
+				;;
+			esac
+			(( i++ ))
+		done
+
+		__git_cmd_idx=$(( i - 1 ))
 
 		if (( $+opt_args[--bare] )); then
 			__git_dir='.'

base-commit: 0fae78c9d55efe705877ea537fe42c59164ccd94
-- 
gitgitgadget
