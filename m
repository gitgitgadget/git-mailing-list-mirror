Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AD2C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 12:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiKUM1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 07:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKUM1F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 07:27:05 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E608FA65AC
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:27:03 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p16so8347030wmc.3
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hEE/RztJMox3t5ZalE+rmJ3ktcyHnO8EdR8kF8gFYY=;
        b=c+/uR7YIYFLP0VvCy3Xza0d7QxrgGg94Q23bRU2GgBGdcB4CImKI7U+DkbdeXov/hZ
         81FanqClAlojEGVVv1RWWqNyhJt9yKcWTIdSY4UK56lSn8iX728xn4OH8fpabjB/4mPv
         Jfp4Fr00ao6opsDoEv1Q+FZjkuBUr4XO6caSo7kWD0ndWsnTnGe8utm0We81shF14ZnP
         m+nXu2GHKyirEl/OFTVFV+sJb1cvtNuLkZ8mWTMcSbhhS3ziN5xEsK6P7mNPVS8TNOQq
         Ltelo77/5/cmKtWsl1taRMH4FI/O6r5cT/jP/SbvAzMJezu5qpY6AunWczhzRIuOkCNG
         CHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hEE/RztJMox3t5ZalE+rmJ3ktcyHnO8EdR8kF8gFYY=;
        b=vPwh+F9kcNJmvbCGfFv/5vRdo/9lFLDqHuTl5aczz3u7CEFZ+kUtwRO7aXKr8Jkjbw
         RVYBKhyCdCjbSWQsjh6dQ/Yn65W0xHZI8kphv/pe6qhNWbLqoMwOvd1HScjlG8BUjP6W
         Kd7YgX3+pGz3XO5IXJe0rPN2C1eSlpSLaVIkqY4CPFfdirrA3wo+jrLt4RZxKvtZHc4L
         MQgcmwQ3KTb4Hi1yc2QrTawIV3XT5eVJ+W3aQqn5MjY+51JbyBnpDOR3xDcbD5rG5XaX
         167YbWI0P2DaH55TnKoG7/XM/Z3EAwuGCyHpOJ3rf1eWmIIN5q4+NngoLpdoxPTl13ZO
         UqWA==
X-Gm-Message-State: ANoB5pkblmAnQfxSDIzQt6YCkb5Z/6V9p/I7HQ1iP1ZEMbl61NvwXTiK
        iHRh7oo2gp8yt2EMOs3Q9289HaWiel4=
X-Google-Smtp-Source: AA0mqf6hwMUBurj2OVhfIhPmdeHnBXOi2DS1mClCQXmx9sFXtt17cA6QAaT3TEuiiaQqqnI7Z4LtZQ==
X-Received: by 2002:a1c:f712:0:b0:3cc:a9be:d9e9 with SMTP id v18-20020a1cf712000000b003cca9bed9e9mr12154123wmh.173.1669033622157;
        Mon, 21 Nov 2022 04:27:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b003c6b7f5567csm26779457wms.0.2022.11.21.04.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 04:27:01 -0800 (PST)
Message-Id: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
References: <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
From:   "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Nov 2022 12:26:58 +0000
Subject: [PATCH v3 0/2] git-jump: support Emacs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an optional argument 'stdout' to print the quickfix lines to standard
output. It can be used with M-x grep on Emacs.

Detect emacsclient by GIT_EDITOR and invoke the function. Tested with
EDITOR="emacsclient" and EDITOR="emacsclient -t".

Yoichi Nakayama (2):
  git-jump: add an optional argument '--stdout'
  git-jump: invoke emacs/emacsclient

 contrib/git-jump/README   | 10 +++++++++-
 contrib/git-jump/git-jump | 23 ++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)


base-commit: eea7033409a0ed713c78437fc76486983d211e25
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1423%2Fyoichi%2Fgit-jump-emacs-support-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1423/yoichi/git-jump-emacs-support-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1423

Range-diff vs v2:

 1:  e56858a3eb2 ! 1:  ccfea26de33 git-jump: add an optional argument 'stdout'
     @@ Metadata
      Author: Yoichi Nakayama <yoichi.nakayama@gmail.com>
      
       ## Commit message ##
     -    git-jump: add an optional argument 'stdout'
     +    git-jump: add an optional argument '--stdout'
      
          It can be used with M-x grep on Emacs.
      
     @@ contrib/git-jump/README: git jump grep -i foo_bar
       git config jump.grepCmd "ag --column"
       --------------------------------------------------
       
     -+You can use the optional argument 'stdout' to print the listing to
     -+standard output. You can use it with M-x grep on Emacs.
     ++You can use the optional argument '--stdout' to print the listing to
     ++standard output instead of feeding it to the editor. You can use the
     ++argument with M-x grep on Emacs:
      +
      +--------------------------------------------------
     -+# In Emacs, M-x grep and invoke "git jump stdout <mode>"
     -+Run grep (like this): git jump stdout diff
     ++# In Emacs, M-x grep and invoke "git jump --stdout <mode>"
     ++Run grep (like this): git jump --stdout diff
      +--------------------------------------------------
       
       Related Programs
     @@ contrib/git-jump/git-jump
       usage() {
       	cat <<\EOF
      -usage: git jump <mode> [<args>]
     -+usage: git jump [stdout] <mode> [<args>]
     ++usage: git jump [--stdout] <mode> [<args>]
       
       Jump to interesting elements in an editor.
       The <mode> parameter is one of:
     @@ contrib/git-jump/git-jump: grep: elements are grep hits. Arguments are given to
       
       ws: elements are whitespace errors. Arguments are given to diff --check.
      +
     -+If the optional argument `stdout` is given, print the quickfix
     -+lines to standard output.
     ++If the optional argument `--stdout` is given, print the quickfix
     ++lines to standard output instead of feeding it to the editor.
       EOF
       }
       
     @@ contrib/git-jump/git-jump: if test $# -lt 1; then
       	exit 1
       fi
       mode=$1; shift
     -+if test "$mode" = "stdout"; then
     ++if test "$mode" = "--stdout"; then
      +	mode=$1; shift
      +	type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
      +	"mode_$mode" "$@" 2>/dev/null
 2:  72c4fd5532b ! 2:  b4ad4c083c9 git-jump: invoke emacsclient
     @@ Metadata
      Author: Yoichi Nakayama <yoichi.nakayama@gmail.com>
      
       ## Commit message ##
     -    git-jump: invoke emacsclient
     +    git-jump: invoke emacs/emacsclient
      
     -    It works with GIT_EDITOR="emacsclient" or GIT_EDITOR="emacsclient -t"
     +    It works with GIT_EDITOR="emacs", "emacsclient" or "emacsclient -t"
      
          Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
      
     @@ contrib/git-jump/git-jump: open_editor() {
       	eval "$editor -q \$1"
       }
       
     -+open_emacsclient() {
     ++open_emacs() {
      +	editor=`git var GIT_EDITOR`
     -+	eval "$editor -e \"(prog1 (switch-to-buffer-other-frame (grep \\\"git jump stdout $@\\\")) (delete-other-windows) (select-frame-set-input-focus (selected-frame)))\""
     ++	eval "$editor --eval \"(prog1 (switch-to-buffer-other-frame (compilation-start \\\"git jump --stdout $@\\\" 'grep-mode)) (delete-other-windows) (select-frame-set-input-focus (selected-frame)))\""
      +}
      +
       mode_diff() {
       	git diff --no-prefix --relative "$@" |
       	perl -ne '
     -@@ contrib/git-jump/git-jump: if test "$mode" = "stdout"; then
     +@@ contrib/git-jump/git-jump: if test "$mode" = "--stdout"; then
       	exit 0
       fi
       
     -+if git var GIT_EDITOR | grep emacsclient >/dev/null; then
     ++# For emacs/emacsclient, call "git jump --stdout" from inside of them.
     ++if git var GIT_EDITOR | grep emacs >/dev/null; then
      +	type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
     -+	open_emacsclient "$mode" "$@"
     ++	open_emacs "$mode" "$@"
      +	exit 0
      +fi
      +

-- 
gitgitgadget
