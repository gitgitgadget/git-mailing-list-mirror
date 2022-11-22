Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D95C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 14:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiKVOS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiKVOS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 09:18:27 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CD058BDB
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:18:26 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so15332119wmb.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 06:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jIcHiZKOwD9b6QoKA/c82OntNfLukwVD8cnivrE2hE=;
        b=KjdVdwXQHbXYv28d9Q0cRD8iybeXDgpSuG5PoCT3lH+noBVTG4yun1dbRfP0nxOfS1
         urYn5FdnxTlhgm0hq4OFu048V0RpjxrcjMf3NgjjeBWDqOy7i53qv6mwsj91Ld31fOBh
         xFkjPKhlm4irMx3DHj8YgkRCe4W50bkBdEnijm0qKD4S9fn+WISznQ2P4V6MAjGpB8DC
         +6f34PgaTHcQduFWfRQu2s59b+Ri1PToHcIowVcrFujowGckAiB9Pt6erOZsftzEv2qE
         xCXr4RUk0JwtitUZjn6qonPgwJqFVBuAuuF0O7rMnwXOtj8qrOjH0BBggE+DnJUIaiDI
         EPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jIcHiZKOwD9b6QoKA/c82OntNfLukwVD8cnivrE2hE=;
        b=IO/+pS5k0omEAG1JBU0ozD9jKy4ENwEuUBRro8xhAkAi7keg2uCsIH1SbFrPS9TFz/
         SL+Hdt5oMBrD//OQ7SSTBNf+32aZJfow6ylc7IyYtEyq29hpuL960Y+xU4uh4kcMwGOY
         vvfSPW4kq7wSPUPKyor2ppJnAxpG+cAGFXyvHvFxwNgz8A9PxmoZiMr+Qt6z279GFYTK
         gG8bHRESrEaEMrot+VKRsNM+JlOnwRQuDgSK6ruqQanNCg+unczLy1cR1NqOjo+13jLa
         vH+chVpJlN6n4PoqMYT/GyBh2EF+JVLPtMPF4RrVSjAmwRd9LbgIqO/vPhEjcQCs/HyX
         Tllw==
X-Gm-Message-State: ANoB5pm48rrskz/uGG/YXjdqk7SwWXKAv95KLaGDX94gZGokLAsHXIIJ
        wA+ng2C8dacgJeVPlRsuTjuFtpR2IH8=
X-Google-Smtp-Source: AA0mqf5p/ItrrSzZG5ss3Q27fqYypdETJBC3cnSR33i08VqyoKe+l/HrbIRNVRujffI7f8oFhspB4Q==
X-Received: by 2002:a05:600c:288:b0:3cf:758f:161f with SMTP id 8-20020a05600c028800b003cf758f161fmr15524315wmk.54.1669126704809;
        Tue, 22 Nov 2022 06:18:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2-20020adffec2000000b00241d544c9b1sm7231352wrs.90.2022.11.22.06.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 06:18:24 -0800 (PST)
Message-Id: <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
References: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
From:   "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Nov 2022 14:18:21 +0000
Subject: [PATCH v4 0/2] git-jump: support Emacs
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
 contrib/git-jump/git-jump | 40 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 2 deletions(-)


base-commit: eea7033409a0ed713c78437fc76486983d211e25
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1423%2Fyoichi%2Fgit-jump-emacs-support-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1423/yoichi/git-jump-emacs-support-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1423

Range-diff vs v3:

 1:  ccfea26de33 ! 1:  446777d300d git-jump: add an optional argument '--stdout'
     @@ contrib/git-jump/README: git jump grep -i foo_bar
      +
      +--------------------------------------------------
      +# In Emacs, M-x grep and invoke "git jump --stdout <mode>"
     -+Run grep (like this): git jump --stdout diff
     ++M-x grep<RET>git jump --stdout diff<RET>
      +--------------------------------------------------
       
       Related Programs
     @@ contrib/git-jump/git-jump: grep: elements are grep hits. Arguments are given to
       EOF
       }
       
     -@@ contrib/git-jump/git-jump: if test $# -lt 1; then
     +@@ contrib/git-jump/git-jump: mode_ws() {
     + 	git diff --check "$@"
     + }
     + 
     ++use_stdout=
     ++while test $# -gt 0; do
     ++	case "$1" in
     ++	--stdout)
     ++		use_stdout=t
     ++		shift
     ++		;;
     ++	--*)
     ++		usage >&2
     ++		exit 1
     ++		;;
     ++	*)
     ++		break
     ++		;;
     ++	esac
     ++done
     + if test $# -lt 1; then
     + 	usage >&2
       	exit 1
       fi
       mode=$1; shift
     -+if test "$mode" = "--stdout"; then
     -+	mode=$1; shift
     -+	type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
     -+	"mode_$mode" "$@" 2>/dev/null
     ++if test "$use_stdout" = "t"; then
     ++	"mode_$mode" "$@"
      +	exit 0
      +fi
       
 2:  b4ad4c083c9 ! 2:  2f0bffb484b git-jump: invoke emacs/emacsclient
     @@ contrib/git-jump/git-jump: open_editor() {
       }
       
      +open_emacs() {
     ++	# Supported editor values are:
     ++	# - emacs
     ++	# - emacsclient
     ++	# - emacsclient -t
      +	editor=`git var GIT_EDITOR`
     -+	eval "$editor --eval \"(prog1 (switch-to-buffer-other-frame (compilation-start \\\"git jump --stdout $@\\\" 'grep-mode)) (delete-other-windows) (select-frame-set-input-focus (selected-frame)))\""
     ++	# Wait for completion of the asynchronously executed process
     ++	# to avoid race conditions in case of "emacsclient".
     ++	eval "$editor --eval \"(prog1 (switch-to-buffer-other-frame (compilation-start \\\"cat $@\\\" 'grep-mode)) (delete-other-windows) (while (get-buffer-process (current-buffer)) (sleep-for 0.1)) (select-frame-set-input-focus (selected-frame)))\""
      +}
      +
       mode_diff() {
       	git diff --no-prefix --relative "$@" |
       	perl -ne '
     -@@ contrib/git-jump/git-jump: if test "$mode" = "--stdout"; then
     - 	exit 0
     - fi
     - 
     -+# For emacs/emacsclient, call "git jump --stdout" from inside of them.
     +@@ contrib/git-jump/git-jump: tmp=`mktemp -t git-jump.XXXXXX` || exit 1
     + type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
     + "mode_$mode" "$@" >"$tmp"
     + test -s "$tmp" || exit 0
      +if git var GIT_EDITOR | grep emacs >/dev/null; then
     -+	type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
     -+	open_emacs "$mode" "$@"
     ++	open_emacs "$tmp"
      +	exit 0
      +fi
     -+
     - trap 'rm -f "$tmp"' 0 1 2 3 15
     - tmp=`mktemp -t git-jump.XXXXXX` || exit 1
     - type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
     + open_editor "$tmp"

-- 
gitgitgadget
