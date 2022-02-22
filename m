Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9329CC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 18:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiBVSyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiBVSyF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 13:54:05 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D3611475E
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:53:40 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso2567253wmj.2
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 10:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RWt+ewUhKb4KlpjppHFVMNRVqK33c9kyxe9170BIAvI=;
        b=exNVIkL99Ee1DCK8v8GQ4V6GufBQsFG4xwcW3sdiV1huLe3IXRPe1NwBA0kfe2p5Lx
         uay9PD32LbUXPlhfGBRtCTICKZg5QFZ+iut82Bza1PBgMQqg+p62wat8h5tYW1A3jmK2
         II1l9BQADTDWdjLbK13PgrigmxFXTkDQ/M9Rd/2oGR1vMUx8ZDkOcZV9R9zsqFPNyyGt
         KFBcVkv5b/9bgEjzpbaSIrBpRwLa2LgIuTG5xU9izym2YSdZXVgRWsFa5wcC31KM/b9c
         BHVxRhPvgnpnJz43L7wuaUHIhRkVn0U6iHMCyZasVbxAG05QjnXhoLlI2pT+oaVhpdT6
         62wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RWt+ewUhKb4KlpjppHFVMNRVqK33c9kyxe9170BIAvI=;
        b=0tp+rZt3N1SXEfWcN85rFEK9LA3SuLPzJc1wVtJRjjgFxb1+Z0U28n6LBYfJhqdHL3
         o1Wgj1zWXq0S3aBL7z6j/YrURjDZ2kEOjVTuD04SxGrCJCeON1eF+JRteTInRnUfX7D4
         PaM4xLi+kdJqKFbyafIolHfhgikPmfgPlV1B6BdhSQ32gynSgNimgvp2wgu5QOPrTA4I
         CPc5y0tsXs6Y9VH1+6xr4QHVLupJ4g5YByAulb0vn6W+S/pzEaIxaN6zCD3NCm0rz83z
         9XpkJrT4SxnJ8cHg0zvh322il5aKBN5Nx7EiVvKE+wucFE54GtkBUH5mAkeVpyn5kldF
         eVMg==
X-Gm-Message-State: AOAM533nV833cv99TS8AmFRpQeccrTq8lTe3PtOiYa2V9YWBTB60Mc2l
        qGjh/mrU+yfe+Hdh2yOephg7nJ1vKcg=
X-Google-Smtp-Source: ABdhPJwcFvv4X+CmRjMTn3RIf0nJnoZdhNnTIBw67A9FDBIcjJTc4XHbybWVqDsArvznbpxqml4Y6A==
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr4380198wmk.58.1645556018632;
        Tue, 22 Feb 2022 10:53:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba14sm32110268wrb.56.2022.02.22.10.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:53:38 -0800 (PST)
Message-Id: <7ae9b2365542b68d7d75f39b126d2acec3e223ff.1645556015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1146.v2.git.1645556015.gitgitgadget@gmail.com>
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
        <pull.1146.v2.git.1645556015.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 18:53:34 +0000
Subject: [PATCH v2 3/4] terminal: set VMIN and VTIME in non-canonical mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If VMIN and VTIME are both set to zero then the terminal performs
non-blocking reads which means that read_key_without_echo() returns
EOF if there is no key press pending. This results in the user being
unable to select anything when running "git add -p".  Fix this by
explicitly setting VMIN and VTIME when enabling non-canonical mode.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 compat/terminal.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 11288cfe5c9..3620184e790 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -57,6 +57,10 @@ static int disable_bits(tcflag_t bits)
 	t = old_term;
 
 	t.c_lflag &= ~bits;
+	if (bits & ICANON) {
+		t.c_cc[VMIN] = 1;
+		t.c_cc[VTIME] = 0;
+	}
 	if (!tcsetattr(term_fd, TCSAFLUSH, &t))
 		return 0;
 
@@ -159,7 +163,11 @@ static int disable_bits(DWORD bits)
 
 		if (bits & ENABLE_LINE_INPUT) {
 			string_list_append(&stty_restore, "icanon");
-			strvec_push(&cp.args, "-icanon");
+			/*
+			 * POSIX allows VMIN and VTIME to overlap with VEOF and
+			 * VEOL - let's hope that is not the case on windows.
+			 */
+			strvec_pushl(&cp.args, "-icanon", "min", "1", "time", "0", NULL);
 		}
 
 		if (bits & ENABLE_ECHO_INPUT) {
-- 
gitgitgadget

