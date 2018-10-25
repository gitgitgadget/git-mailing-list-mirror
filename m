Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09F131F453
	for <e@80x24.org>; Thu, 25 Oct 2018 23:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJZIHV (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 04:07:21 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:45303 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeJZIHU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 04:07:20 -0400
Received: by mail-vk1-f201.google.com with SMTP id 80so3011324vki.12
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B00n941xueuBWwdXzRKPIBl5kroqyU94J3aafKflOrg=;
        b=qnv2Glrt03GXRTysa4i17kviPQk/kpbpbWu5RrcXr3d22nX/YeqOMaFMD0dcJDHjwM
         bsRPAZStNOapG35JZpyiH75ZLyFyiXEM2dTYnALNVyqE651pDBOd+JVDib3XrWbCJlhj
         jCvGP6jlq9UVRHmaTwBydf/Rnv5dlQIQWcEYevB2f7A0Yti87z0WHt/jmtQO4B4nNfk4
         34+AgO1FkYkP8LciRMqK7hpXBJkm7ZzCeyW+p8xCcIvwzc+l0NOakzhW8FjDc6qcbFgN
         YfURKJnTcZYTbYuO+Lnb1WivqfkCoDsRpn2a1RNhdyEDjyEeI8uL4ukF+oM3Y9okXkzc
         PnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B00n941xueuBWwdXzRKPIBl5kroqyU94J3aafKflOrg=;
        b=mEMEzsALh+MPVFGC/i02VtpvY2dTTiAavGaT68pStgPVTGQRvA3RvA/uuxqHe+zn5z
         rYNk3pgnnFMrl1SwaWBYbnKAwxu4jj96i2MqP/91yRY5Cex6Bbs2v9/oSaPh6fhUNBgy
         vxiFdyOdTO/Q0hfGeJMzfPfF/94zdpzuChthXOFggr1tF+GTviU7O/Wwppxa60eIQR1Q
         KnH9tKb3TheQuyqjzxOiLA2o4BtQQj9qghqUAYDHuNgMvp5kHtgpv7RIgOHxXXJVbPVe
         wlgqPQE8JokFipd1V3jgBAYskfFDrcGMZnV/GfnwShsAH2SZNvD4oRYD1tux4C3rqZvI
         iwUg==
X-Gm-Message-State: AGRZ1gLUwLBYNcksKnMwSoFmo42ZKzOiu2N3jKP/HLM8v+6Gjgf9kyEo
        4oG3z/Jr6YlPIVWU5RJo3m19DLo4/yzJ
X-Google-Smtp-Source: AJdET5cL5ML8L6UpZ5lQary25WOQf/f3qdVf4OEPCTDSDulouNb3fncR3vTWdzIKnMk8koo5DpB7xwdrBA+p
X-Received: by 2002:ab0:185f:: with SMTP id j31mr1269480uag.9.1540510361600;
 Thu, 25 Oct 2018 16:32:41 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:32:23 -0700
In-Reply-To: <20181025233231.102245-1-sbeller@google.com>
Message-Id: <20181025233231.102245-3-sbeller@google.com>
Mime-Version: 1.0
References: <20181025233231.102245-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 02/10] submodule.c: fix indentation
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule subsystem is really bad at staying within 80 characters.
Fix it while we are here.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 2b7082b2db..e145ebbb16 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1258,7 +1258,8 @@ static int get_next_submodule(struct child_process *cp,
 		if (!submodule) {
 			const char *name = default_name_or_path(ce->name);
 			if (name) {
-				default_submodule.path = default_submodule.name = name;
+				default_submodule.path = name;
+				default_submodule.name = name;
 				submodule = &default_submodule;
 			}
 		}
@@ -1268,8 +1269,10 @@ static int get_next_submodule(struct child_process *cp,
 		default:
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
-			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
-							 submodule->name))
+			if (!submodule ||
+			    !unsorted_string_list_lookup(
+					&changed_submodule_names,
+					submodule->name))
 				continue;
 			default_argv = "on-demand";
 			break;
-- 
2.19.0

