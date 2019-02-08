Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20FAA1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfBHJGD (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:06:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35409 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfBHJGC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:06:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so1393575pfi.2
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uiwH6ChY8DaDH9/oTCrsEMxtBwi3+v3tCgHe6diYWzM=;
        b=jGtFelgdGOZhpvA6AthCBk2EQzYoSiALFMwgpJP/BkHM8g0b+DehoiHPNmeouOsVJY
         2VTUIYkeekJQPh2LXq1pCHTlP/t8iOcq7Kmst34b1lwo/NTxdkJEdALe2Ke4FukRjhbq
         zDSEnofdR7qNb/LxQ0pYS0nzJGPoL6qMh3GWA/Nor0lxTk/t1QZaNLBGIqURwZET9Wkz
         cHQ4C6iZqOeTnvojcoOzcJLxvHGYy2HFmMtLgndkZ0ef5jeYhuWYjuulZMXYt1qnNDeH
         Qd+csA4OSg5uaTS2Huh2X4Rq6tJMW+izXFSDhWquKErQ3wn+W/iAUIDa+eXDI0sz0Xqm
         An6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uiwH6ChY8DaDH9/oTCrsEMxtBwi3+v3tCgHe6diYWzM=;
        b=NeTGFo5SMy17sgF+tZwYE2RcIj28bGEeqlGcZdM8nrhpS+uB+j1RIzHYCkfn2VIKy6
         4o/4gi6wsgkdGUvgnoJv43sWvT2fhWgYkj7xjkznL3ySyCSB1YsHxkpfwe+mow7neSZM
         +bE/q6h2zhG4pZlCofqTf24n6LFNt6ZVT9rLzsYh33N127n8TAjNh84XZZ1EPwBPbwdb
         rFgyI/nz6eUHRoScKtUmwIQ3CWa1NGxkFb5hbn4yNB8Yg9cTuml9dV3FJtbSmOsvS1/K
         yG195gqHnpCgebtulfMAxkijGJGzjngbpq81Pxqim9V6cGD/wsZLJuomElUopI9+ROhV
         y/zA==
X-Gm-Message-State: AHQUAuYs+khjRVytZ8VxDSaJBsw4Guhb2WRnAhB1MPfLXK0KdmjgfcET
        nUhuEKMUOxliNiOdPBZtsobvunYW
X-Google-Smtp-Source: AHgI3IaBd6rYQ7CyHJDSwTyiTkQF7bS9QmHTgkabglAKoDCLTtKSs1PriXAivI+jKxnSRFdO+X2YDg==
X-Received: by 2002:a65:6151:: with SMTP id o17mr2077427pgv.285.1549616761997;
        Fri, 08 Feb 2019 01:06:01 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 4sm1930420pfq.10.2019.02.08.01.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:06:01 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:05:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 18/19] completion: support switch
Date:   Fri,  8 Feb 2019 16:04:00 +0700
Message-Id: <20190208090401.14793-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190208090401.14793-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190208090401.14793-1-pclouds@gmail.com>
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
 contrib/completion/git-completion.bash | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 499e56f83d..891abb72d7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2126,6 +2126,32 @@ _git_status ()
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
+		# check if ---guess was specified to enable DWIM mode
+		local track_opt= only_local_ref=n
+		if [ -n "$(__git_find_on_cmdline "-g --guess")" ]; then
+			track_opt='--track'
+		elif [ -z "$(__git_find_on_cmdline "-d --detach")" ]; then
+			only_local_ref=y
+		fi
+		if [ $only_local_ref = y ]; then
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
2.20.1.682.gd5861c6d90

