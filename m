Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B681C4321E
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 01:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiK0BS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 20:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiK0BS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 20:18:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658FA13F80
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 17:18:56 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b12so11729496wrn.2
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 17:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kANyRaHit6OCQ9QbD5Oas1SseNgvvqhPKEr8gF/avZA=;
        b=L4epgvJ2XNyJNblltIt0oneo/7vfQt2mPOidvLPrZm45ttdbWgx9f1GEDjMPfGrF9r
         VFzVMFLH7IZtomPMNV5o3CdSqMh+zW5EWssLd37EKNs5GIYUg6rVufN2FHucY5P/7zXR
         ps4jzi+kr4TTW4LSnyj9NdNh9zZYRAQp+hWhxeDwi3Cw2NcYvIDPG3RJhHieLZiijAS4
         aWB8TEMIU0axkmtbWqv7pBSgGzNyc35ZL9oezH5AXsGp26JMguLTAnaFx/FrsP4rGWDX
         9LRwN1q3goWxzorihIVEdwhkJ8UapeoVqjmF0uzBu2Mmi+g7Pm0Bj+PK6+PYKcrwkyUJ
         N8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kANyRaHit6OCQ9QbD5Oas1SseNgvvqhPKEr8gF/avZA=;
        b=4V5PUTnAhFBodEE80XH5YX5q260FxRUPMGrSUes08kfJsC1aoWWiQ1NcjQpFkGTmGS
         lMIYlCVsDAIh2xGZeSvWV1F1Fzd3SsWoTRfYfERCkNhXDPqmdzFSrkARvAuX9eUoMVGV
         Ef/FPhxe2jJMnMxc5QF2jL8P3Xl83oPnulXeJTlSUz0qRsTkz/qBpIaQEcBBlDAXikCJ
         1PD1EKiIluwMjabHNCBe1LhEyWxqVvSgksOxnyq2Mc6ATEN0djDSXKo3uJM4/F+WScpq
         h9n34HAh+y7huEB9UdXffKUD6ISmJyqCI2OIbeDsMbTibEY8qI9bg4VyPPkwoiAf9n2q
         NFaQ==
X-Gm-Message-State: ANoB5pkWG9tK7/hGMyJlvxP1qL95CDCvpb8+jtR4cocoX3NuNqIaO/vv
        w0f3NtHxK6BRvPvffUypgoZRSc+Yaxo=
X-Google-Smtp-Source: AA0mqf57fq6oDFoeT0OedtRUffejVA0+qLgr8JsY5wb7Hh3Fyxx5v3yg5y8ONZkbhCZwXU7Dz9lBUA==
X-Received: by 2002:a05:6000:71e:b0:241:df3f:f5d6 with SMTP id bs30-20020a056000071e00b00241df3ff5d6mr16299016wrb.288.1669511934697;
        Sat, 26 Nov 2022 17:18:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c1d9000b003b3307fb98fsm10117846wms.24.2022.11.26.17.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 17:18:54 -0800 (PST)
Message-Id: <pull.1423.v8.git.1669511933.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
References: <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
From:   "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Nov 2022 01:18:50 +0000
Subject: [PATCH v8 0/3] git-jump: support Emacs
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

Jeff King (1):
  git-jump: move valid-mode check earlier

Yoichi Nakayama (2):
  git-jump: add an optional argument '--stdout'
  git-jump: invoke emacs/emacsclient

 contrib/git-jump/README   | 10 ++++++++-
 contrib/git-jump/git-jump | 45 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 4 deletions(-)


base-commit: eea7033409a0ed713c78437fc76486983d211e25
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1423%2Fyoichi%2Fgit-jump-emacs-support-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1423/yoichi/git-jump-emacs-support-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/1423

Range-diff vs v7:

 1:  446777d300d ! 1:  afface9b010 git-jump: add an optional argument '--stdout'
     @@ contrib/git-jump/git-jump: mode_ws() {
      +	case "$1" in
      +	--stdout)
      +		use_stdout=t
     -+		shift
      +		;;
      +	--*)
      +		usage >&2
     @@ contrib/git-jump/git-jump: mode_ws() {
      +		break
      +		;;
      +	esac
     ++	shift
      +done
       if test $# -lt 1; then
       	usage >&2
 2:  972d51888ba = 2:  e9aa6fdf836 git-jump: move valid-mode check earlier
 3:  d8233f96175 ! 3:  048f508ca99 git-jump: invoke emacs/emacsclient
     @@ contrib/git-jump/git-jump: EOF
      +		#
      +		# Wait for completion of the asynchronously executed process
      +		# to avoid race conditions in case of "emacsclient".
     -+		eval "$editor --eval \"(let ((buf (compilation-start \\\"cat \$1\\\" 'grep-mode))) (pop-to-buffer buf) (select-frame-set-input-focus (selected-frame)) (while (get-buffer-process buf) (sleep-for 0.1)))\""
     ++		eval "$editor --eval \"(let ((buf (grep \\\"cat \$1\\\"))) (pop-to-buffer buf) (select-frame-set-input-focus (selected-frame)) (while (get-buffer-process buf) (sleep-for 0.1)))\""
      +		;;
      +	*)
      +		# assume anything else is vi-compatible

-- 
gitgitgadget
