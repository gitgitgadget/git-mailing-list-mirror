Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3704949FA
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710268; cv=none; b=ZPCAI6SQkomxY2JLftcx7felDle8XecWwH+E+p9aN0tGaT9bNphCsL4zpkUrpnf9OkjXAb1gTOjrJxZCoEaOlz6gvGQy3HWrzgsriNNo8J0psR8+3B20BahSUpdS0uA1V6tnOQNVQZI1/impUkLv8G28x8l0qNg+JYfzTSqfz4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710268; c=relaxed/simple;
	bh=SOEfoLoL/dntQbdlk29p25CUT1uMwnCKGpstv+U4icw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=q8HrxngMpdC0Zrah7db06kud29+3fGdfNPxfFyw75M+vyU/+PlIKJDnvX7fbcdeuSa+fJbH6CkpmmEuWL3ZPSSuMeu7lm3CekA08K21wOI//p2S/9ajmJA4GBpFoCbNgM46WzMkL9NL5+PFgNa80YtQV9CbWGAxf+DIsmGuHq+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgUWMZdx; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgUWMZdx"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-13807d2f898so6326009c88.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 08:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781710258; x=1782315058; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NnTxg2uDUqptCs2rFl1sU53oZEGJ+XsnaXY6Dn7tBFs=;
        b=PgUWMZdx6k1BH0xQD5TLk6JOemJKQ25XaR7fsd6xcagfZJg6oCYJDCilZG2eYP49S4
         w8Bu6j4aOAYv8uGXZHLlxw3VglkjNu6s4hz+P59u//F792mnbLqK0wUIefQHRW2XKbp9
         A6wQGyASvfDQ1CGLYstGnLlznKDu1hNCy5lFcRAty8xcny39hdXuOw2zzYCx4HNWE/Ek
         pOaYby3FIbiSUP0bTaxN4PAlRDr5wFie539ERxLD7AUqCy9yFELNemIel1Y/GR8jBhXO
         nTH7xoUTjmfEzkF5NY660I4iGOoI3ir8DBn6O7A+4MJaOT6gJE+rUQrmCQDw9yvO5TP3
         +IZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781710258; x=1782315058;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnTxg2uDUqptCs2rFl1sU53oZEGJ+XsnaXY6Dn7tBFs=;
        b=V+smkvr+HqdLCPwXBaEgCoUnpjNgBB2OGKi2fLS7X1r/jeZPz+sZR1lIVvRqy0a8xj
         B0rHLRtGTGitx+JS2aC071NqB57dGAn8ap2TnJgEySElqeoB9rxIh8IrZzJQ+LfpY7pe
         xUW3KMJ9ywh4hK1i1bEnNvF1mW2SXJzIdd5pvZENom6Q5ZjBPMfuNlXy+GSUZi3patas
         LLrF42CsYbhzquq6/eoqMOgY4zsctIs8WSRNjnqSlrcvxeTC3wKyMyO2Jgxx0vhAvQaI
         qV21T5e0gGimgeu0LjxHPZR81QpKUXfIo0Y9lx+bpns3GuqFimFuDyH+JvUh3TZsZc35
         yRWA==
X-Gm-Message-State: AOJu0Yywo1+JxO9/4zhlEZyB+wZ09iqMRJ0VekS5sim6CdSJvjXsc2sd
	/RZpPU1LLnOz7qAs6xC2pQv53at22517zl8/RfgdZ3ubx9IWpmlbuXrNYMagBQ==
X-Gm-Gg: Acq92OGreWofQIjBqO5xL2QOxJq0w1lVy1sK0y0+EumqIOZ5UzSzquamQ20k74OWo9K
	qawQABZ8PFGlc8R6pXCv0N8rjZ/AwPpmesWsJ/JqYHPaj/j6jpqOJyaZezDNyOd5uaZ1ZgzZ9Je
	3xXJCu1u28pZy23u4R5zU6poUZx+WazoHQdiMgHlIJJb52zxQTg0ZzSgKEqOxR/DNugY3N3t1V8
	mPKTBSFeP8xLa6KkVj3kJrVYcNmMzTDvpYEuINJNwP/5CcJ+TeHFIL/8BGssgaPmZQkVirnb9M/
	+OnzD55Z+Xpr1bZ0s2vWnrUAx7oTTFx6g/Tuxe8EbGhhcSke7cw2CrBaF4z0U0Qguohl9eOg0AU
	rqngmzxB9cmbTfcx/f/KYPxfKDnZYYkBmYpFgXKQTuWjRIhejTXQqQjQqy1bzaYnqTdwYKpxnbZ
	HUlhzMv2xz37CO9D8=
X-Received: by 2002:a05:7022:990:b0:134:dfd0:9760 with SMTP id a92af1059eb24-1398f630d78mr1955708c88.5.1781710257626;
        Wed, 17 Jun 2026 08:30:57 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.13.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b97570asm16062182c88.12.2026.06.17.08.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:30:56 -0700 (PDT)
Message-Id: <pull.2155.git.1781710256081.gitgitgadget@gmail.com>
From: "Lutz Lengemann via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jun 2026 15:30:55 +0000
Subject: [PATCH] completion: zsh: support completion after "git -C <path>"
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
    Lutz Lengemann <lutz@lengemann.net>

From: Lutz Lengemann <lutz@lengemann.net>

The zsh completion wrapper (__git_zsh_main) did not handle the global -C
option, so "git -C <path> <command> <TAB>" offered nothing and could not
complete a command's arguments.

Three things are needed to make it work, all scoped to -C:

  - Add -C to the _arguments specification, so completion no longer stops
    at it.

  - Advance __git_cmd_idx past any leading "-C <path>" options. The index
    is hard-coded to 1, i.e. the command is assumed to be the first
    argument; with -C present the command sits two words later for each
    -C, so the bash helpers otherwise look at the wrong word and produce
    nothing.

  - Collect the -C paths into __git_C_args, as __git_main does. The bash
    helpers run git to resolve aliases and list refs; without the -C
    paths they run in the current directory, so completion fails whenever
    the cwd is not the target repository or the command is an alias.

With these, "git -C <path> <command> <TAB>" completes the command, its
options and its arguments, including outside the repository, through
aliases, and with repeated -C options.

Signed-off-by: Lutz Lengemann <lutz@lengemann.net>
---
    completion: zsh: support completion after "git -C "
    
    This patch is intentionally scoped to -C, but the underlying problem is
    more general. The zsh wrapper hard-codes __git_cmd_idx=1, i.e. it
    assumes the command is always the first argument. That assumption breaks
    argument completion after any global option that precedes the command,
    not just -C — e.g. --git-dir, --work-tree, --namespace, -c, and
    -p/--paginate. After those, git <opt> <command> <TAB> currently
    completes the command name but not its arguments.
    
    The same approach generalizes cleanly: instead of skipping only leading
    -C options, walk all leading global options and their arguments to
    locate the command and its true index (mirroring the option scan in
    __git_main in git-completion.bash), while collecting -C into
    __git_C_args and --git-dir into __git_dir as today.
    
    I kept this revision narrow for reviewability and because git -C is the
    case where I miss the completion, but I'm happy to extend it to cover
    the other global options in a follow-up (or fold it into this patch) if
    that's preferred.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2155%2Fmobilutz%2Fzsh-complete-global-C-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2155/mobilutz/zsh-complete-global-C-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2155

 contrib/completion/git-completion.zsh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index c32186a977..323049be8b 100644
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
@@ -252,6 +253,14 @@ __git_zsh_main ()
 		;;
 	(arg)
 		local command="${words[1]}" __git_dir __git_cmd_idx=1
+		local -a __git_C_args
+		local -i i=2
+
+		while [[ ${orig_words[i]} == -C ]]; do
+			__git_C_args+=(-C ${orig_words[i+1]})
+			(( __git_cmd_idx += 2 ))
+			(( i += 2 ))
+		done
 
 		if (( $+opt_args[--bare] )); then
 			__git_dir='.'

base-commit: 0fae78c9d55efe705877ea537fe42c59164ccd94
-- 
gitgitgadget
