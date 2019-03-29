Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 282AA20248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfC2Kmg (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:42:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45802 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbfC2Kmf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:42:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so861391pfi.12
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VUexM+j7LobfYxhgBY1HSFfTrWqLQkESvG9b0ii4EoA=;
        b=iuTA1kGHAxrhq+7J8NW1BRtazDM2Rn3MQIm92NyDejJGogMaYneDAPR0q5EcgbvSEe
         NYhXj4zLcfHPCzquxzTQtty4YlkTeZvt4May16raAaYrbWn7KvM2b7LCKQDhGc8A+BqI
         h/+1X3hU4se/QRcQSVDjvkrRLPTeNsC3BVp9UJa65tUbhNQPf434B8XfN4C0o3IldHgl
         9dBAkdw302X4/Wn7xMxFKwH7whIwZ2E6qSgLd3Ou/5GbrXT4vpPHjp9cE/HSVcaMWDdo
         G0P0qD3IcAd0hdub1OJuCxd2yymdEtKfvQZuBQDIYLjQsDHZnbtBkh+sgY5qVTBOoDhZ
         n5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VUexM+j7LobfYxhgBY1HSFfTrWqLQkESvG9b0ii4EoA=;
        b=pV4/LrhAET6hAfwtE36ZaM4FoSaswoYDQxCNEQnLRp+udHdz0Pf5+wYCwSmXLsnZsz
         pKzu0sBFRlLgX/KRaFRMzb2bACQLPtKRRCBDUNCSjrjd7+vtHGmlYzuG9AyD/yVIl5qo
         xcKFDwMIg/nLy17EtSjZqlzkjjrn5Ji5APa83K+mis7bJlOv4dUtXzMTuPch8zfxKQZh
         jDPGkKXjXb0ycfuiD7mrYIRAS3LWb98j/C+NTeIl8wm5qimNdbNz9YTLhD1YAgGY2n96
         bw6Hb954Qozzx2SGeYAnbM+mts9d+G/0yVPb3do36K2dVqZiRfw4HtakOrtxzVts050w
         VVFQ==
X-Gm-Message-State: APjAAAXEVGXByaXdGWcfeZ7qjSyFg0EUhPoezPx4Fiz4UTJbQB4vnyz3
        YjiJ1w7rnzGwB+whz1QJtJPhaPSh
X-Google-Smtp-Source: APXvYqyJ0rLRTXx/2dpDvKhxc0Wd3YSl76vwxtxn+H1OFL9KPQFYC2+BUIRngvId7b/ZBq9r0MbIXA==
X-Received: by 2002:a65:6108:: with SMTP id z8mr31141776pgu.106.1553856155328;
        Fri, 29 Mar 2019 03:42:35 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id b63sm6038349pfj.54.2019.03.29.03.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:42:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:42:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 26/27] completion: support switch
Date:   Fri, 29 Mar 2019 17:39:18 +0700
Message-Id: <20190329103919.15642-27-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Completion support for --guess could be made better. If no --detach is
given, we should only provide a list of refs/heads/* and dwim ones,
not the entire ref space. But I still can't penetrate that
__git_refs() function yet.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 37 +++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 976e4a6548..b24bc48276 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -37,7 +37,8 @@
 #   GIT_COMPLETION_CHECKOUT_NO_GUESS
 #
 #     When set to "1", do not include "DWIM" suggestions in git-checkout
-#     completion (e.g., completing "foo" when "origin/foo" exists).
+#     and git-switch completion (e.g., completing "foo" when "origin/foo"
+#     exists).
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -2158,6 +2159,40 @@ _git_status ()
 	__git_complete_index_file "$complete_opt"
 }
 
+_git_switch ()
+{
+	case "$cur" in
+	--conflict=*)
+		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
+		;;
+	--*)
+		__gitcomp_builtin switch
+		;;
+	*)
+		# check if --track, --no-track, or --no-guess was specified
+		# if so, disable DWIM mode
+		local track_opt="--track" only_local_ref=n
+		if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
+		   [ -n "$(__git_find_on_cmdline "--track --no-track --no-guess")" ]; then
+			track_opt=''
+		fi
+		# explicit --guess enables DWIM mode regardless of
+		# $GIT_COMPLETION_CHECKOUT_NO_GUESS
+		if [ -n "$(__git_find_on_cmdline "--guess")" ]; then
+			track_opt='--track'
+		fi
+		if [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
+			only_local_ref=y
+		fi
+		if [ $only_local_ref = y -a -z "$track_opt" ]; then
+			__gitcomp_direct "$(__git_heads "" "$cur" " ")"
+		else
+			__git_complete_refs $track_opt
+		fi
+		;;
+	esac
+}
+
 __git_config_get_set_variables ()
 {
 	local prevword word config_file= c=$cword
-- 
2.21.0.479.g47ac719cd3

