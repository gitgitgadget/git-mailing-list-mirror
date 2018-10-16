Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 226431F453
	for <e@80x24.org>; Tue, 16 Oct 2018 18:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeJQCFO (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 22:05:14 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38203 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQCFO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 22:05:14 -0400
Received: by mail-pg1-f201.google.com with SMTP id e6-v6so17931122pge.5
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B00n941xueuBWwdXzRKPIBl5kroqyU94J3aafKflOrg=;
        b=ZCkKjCz4QQ9Fr9WT3kO6outpxHmJERqg8Y0hkmUQTJPg677rE4uTsBERtEDQgqhUWR
         Fonl1ySNHHS+205zHhUvUEpDrY+Plo5IUvKy8ggf9b2c/d785wl7BZCGnKsstBo75C5g
         uJcagjTsEU/ymz90DoSyEjO4E0kT1BxM21KdZcocbX8Dm/yF7YKy75scoAa/XI12WW/z
         mcSVqygeXwlikE+qNlKXTBc9D8ZN4liHslHGTfWc8NqRDmNANo+39BKvj6YHNN9PWC52
         ooOYAXb+IiKko8pGG2F5IxEo/uAjtnxu5zVuqx3kWTowc6rC8N+SYaQC3E1FdgrE3RPD
         f7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B00n941xueuBWwdXzRKPIBl5kroqyU94J3aafKflOrg=;
        b=p4+7TVFYAyJyILF0gMQn6R4yCIR1iaWo1NuaQOBZaXG/qYAoNb2we9wDk1up+g16Ss
         c8mr9r843tXU7isM9bz5OZTKlESsLMt8JQWShoIv5mF48VuD4G8+9XW9hSgeqTVOzz7x
         Cr2XyLXHFHgU1VvcHEOt+uE+q2EOwOPU3Uj7h7zo+HBnm31RJ/LfZfVfzd4Ex7jQKP6R
         QZbvCJQo9eqpj/15WtpBoCNjuUlfcGLVl6qz02/kZbAy1870D5LfPoJtVXzDDulFz2dd
         ud/8WiNAXtbw2OZqmp96KP5m18D3qcBpgpjXG1dJkwJHM4zw0N4xibqNBC1RzrO0MUn9
         eouQ==
X-Gm-Message-State: ABuFfohLx7Vg99lzu5IWwmO6sTokNiZ0+yETxtTEDdLXjli2TjyxEMVA
        D71ylCiCuXFBOArFzwcN0rrhPvvzvk1t
X-Google-Smtp-Source: ACcGV62K2oJ/RFl+Suvul/+pGWLZVTMRLweuEIndFdHDLX/39FN4h0wUtAt1E/xKoYUiFHPnDXmdjUUG2a4W
X-Received: by 2002:a62:4285:: with SMTP id h5-v6mr11038147pfd.37.1539713615071;
 Tue, 16 Oct 2018 11:13:35 -0700 (PDT)
Date:   Tue, 16 Oct 2018 11:13:20 -0700
In-Reply-To: <20181016181327.107186-1-sbeller@google.com>
Message-Id: <20181016181327.107186-3-sbeller@google.com>
Mime-Version: 1.0
References: <20181016181327.107186-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 2/9] submodule.c: fix indentation
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
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

