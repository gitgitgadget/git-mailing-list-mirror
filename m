Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75CD20248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfDKNNs (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:13:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45779 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKNNs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:13:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so3385014plb.12
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bdb8mvEBPu5UGyZoTJdN5btCt2lqdJmqQQ47/rWjgCA=;
        b=jpLjMXy/eWGv3SkDVmx2yV/ZW07p0gV6yhmHosS+CRsM4KDKr3Wk+LjCX1xU8uvae4
         uAzEFeBHQoGttn16vorRotdCfqSoY0CPTH1Ejd2v5Jmm4/TYBXt6cHcbAq1ybOzSjSdS
         vLZkMPECb/HRK2tD4nK32xPknXMdWKEuVj+qx9KiZvACgowJI97MibaHSB7P1rF4NdJ6
         TjM6ERsnBf8xVhYD3Dv77SZSj4fXFbSzenZB1qmnHR4VymVGlLLqAcTt/0CBiar/8JE2
         o6/xR2/3dVxGC1mmghu3Kjkttbjw6pcpbT0FdMwe1xh8msK6s+1toql0OgbbQl4PsLvO
         LxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bdb8mvEBPu5UGyZoTJdN5btCt2lqdJmqQQ47/rWjgCA=;
        b=Kdb3HLsUNMXspsL1ZV+Kgu33Vq5vNduojZKUOV/GISrbeU/e4lNAUecmY4UN1XR/3L
         BpP435d0iO/Zw881kDxUgEm9bFrIk5gfqZ2OY6NOQBt2zLnO6Btt1oM8/BiZibPe9/iN
         ThhOYPavzQX5DDKBjT/McmqEH5N3s7VbTLOJI99z/MldkismFMqGRs4AK/rxGvwQXQnU
         5CndB+U85OeHvmUx3z4t7sFvJTxSzvFWY0fGBsGiw9F/2ozak1HL/QjFo+YiWqcXdNXi
         AjKj0FctmYShyYb8NTVwHegUTdFWN0DLkkGY3DllPwwP/iBTCPvsKSUgRnXNZCxjfHCQ
         p0sQ==
X-Gm-Message-State: APjAAAVjwtOqc2slauAK3vq4YEWrZCf/XdRJyJoMn7EVKFD7I+OX8PbQ
        pmKIbv1SlY8/ShOuUYQnk9A=
X-Google-Smtp-Source: APXvYqzCJKiJBhUSaltn1c3fGvcUHlTHBk9z80l9xBTkwNpxOXPtfco2X83ariX0xSRkvUZuzB1TAA==
X-Received: by 2002:a17:902:e709:: with SMTP id co9mr50882773plb.86.1554988427874;
        Thu, 11 Apr 2019 06:13:47 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id y12sm104484356pgq.64.2019.04.11.06.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:13:47 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 20:13:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: [PATCH v2 12/16] completion: support restore
Date:   Thu, 11 Apr 2019 20:12:14 +0700
Message-Id: <20190411131218.19195-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190411131218.19195-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Completion for restore is straightforward. We could still do better
though by giving the list of just tracked files instead of all present
ones. But let's leave it for later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b24bc48276..58d18d41a2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2491,6 +2491,21 @@ _git_reset ()
 	__git_complete_refs
 }
 
+_git_restore ()
+{
+	case "$cur" in
+	--conflict=*)
+		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
+		;;
+	--source=*)
+		__git_complete_refs --cur="${cur##--source=}"
+		;;
+	--*)
+		__gitcomp_builtin restore
+		;;
+	esac
+}
+
 __git_revert_inprogress_options="--continue --quit --abort"
 
 _git_revert ()
-- 
2.21.0.682.g30d2204636

