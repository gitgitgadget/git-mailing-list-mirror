Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45CB61F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfA3JuE (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:50:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36131 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfA3JuD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:50:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so10126570pgm.3
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uiwH6ChY8DaDH9/oTCrsEMxtBwi3+v3tCgHe6diYWzM=;
        b=Rbuhiwkhjh1AmYd4SOlGNHR6R42pA7Scz1AyemDwqoZn59cxFPG5vpbqq2UyKFvnhh
         GGWFE1Mdj8YCyJtK6fuQJi2rTLNpV+GX0oWMb8Gfv5IOpVFADDLAtodFoS4XonM0IpP5
         nK+B2zuSvjsX1HTjSBpMjOf4swgAI/Wnc9SzYtk2rDN5svZYZ0JkNsa1HGBryTMUs2ri
         g5dPRC0IiKk75ijrdml5ern6Cde07+6g6QLClOkRNR3/cHv26qMKkudSMqT8MOP66wl1
         bd3CjvknEIlwAn/egEOvZXxsjKarvUqEWvuSv2lQlyK73CmErwHC2jgK0Q6jRDuk6dGP
         LuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uiwH6ChY8DaDH9/oTCrsEMxtBwi3+v3tCgHe6diYWzM=;
        b=ZWwlD+7quVtIK/r9kWxg1Klj4mnwAiPW+UqR7vNaltczXIOHmlsE/x6xBECZbgac3F
         Y6KANEyM9Pc5nByzVsz4+QytSMrnEiSNlpsCZzPHdxb7VTV9aZGutn+RDyVd4hWViLne
         WBjuX6NVUCqExzxoTq8SDP9eh1w68T6/uP4BclFNVMuB0DzcGRSG13cuxvkg9ItMiqWS
         L4MC4JS9MzZA3CbYpDhzPm2nPpylRr6R5EwTQWfmIOQ8DSvXf2ldGX9wocxJXhWNb64V
         lDJ5T1yHRpLbNIxTQaODliyfrsyrKQWmu0YPeAD8y42GaPIiPDoBfFqcdyuTDWx9t21r
         tPAw==
X-Gm-Message-State: AJcUukfQVUaKsr867etFsTVRQDuA2MtGJbZ3O7SQiBgcM1lJuHippgL7
        2R4Ng1pa67j9WrQLh/uQUNYdnsag
X-Google-Smtp-Source: ALg8bN7vhpZkbRISDvumf1qQv3y/LdEuLgB9buiTi23vg+Dsu+gaNnmK+gLfqip1rFxt3gvxyxRlOg==
X-Received: by 2002:a62:cf84:: with SMTP id b126mr29539474pfg.98.1548841802936;
        Wed, 30 Jan 2019 01:50:02 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 24sm7829314pfl.32.2019.01.30.01.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:50:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:49:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/19] completion: support switch
Date:   Wed, 30 Jan 2019 16:48:30 +0700
Message-Id: <20190130094831.10420-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
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

