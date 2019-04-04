Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFDC720248
	for <e@80x24.org>; Thu,  4 Apr 2019 18:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfDDSZQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 14:25:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36251 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfDDSZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 14:25:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so1776068pfn.3
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 11:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=voowj3RONJ4uHPH68FNLqoBMHSF0KBEqRpaRDtmLJl8=;
        b=QqUf8+ODZeQMAwgRVrjBvLJSDhny38A6dSm0QDAY857/Xo7JN2s/48NyZgdru2u5U4
         PqYeMFFM6HYiLLOOCGtlKh81+adxdgwkGEfbFAhh320J1YgSkyf4kkVDmvr1i5wKcMFB
         NFUWa7c/NZoCK5OjZgC1xmmIqSsU6pGRL2DykMvt7Ngi70BINrbMiV94vuDt4p8XzIRM
         TvvccwpVuzMs3FZqnZ+hQ6OQJppYWmHJ7YQRoortFiD5C0YKJVvIPEyjbu5198W0mrQ2
         3S3ZY9eeWvOviBrlq3esLuIcgymZp/O8uhIZv1RV34rWNZvZlgdYhZm7dgM8wNHiMWIo
         5zCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=voowj3RONJ4uHPH68FNLqoBMHSF0KBEqRpaRDtmLJl8=;
        b=pXtm/iw4iwOGwHk+P940coCXU0+sXA3PoAFu7lSYfzBrY1SdClb8nvJqN3/MJXCstf
         Xsa+7v8WSf/bVu/z+pjM6ThGkzfEm91fyBnoPXgEFSzdG8GvpJyVIBoiDXwI7PeR40H9
         a4eoQj1u1iotFSvIBVtjiiemqp9AU/4foQEcNV1rq3NqqePESxFKQjg3IPpXDV5gq4Kf
         cX2UW+5UYSIQ4BrccmoE709waQSGlub76yWdZS/ALoFzJmIJ+ybynqMLO98JmsPeOt9c
         ik0A/h9PwrW/MU8EXvfy52ipK/N2emnT7Q/I8i4Vbg0xuStfJk/aCdTgh5CqSuGO3tQC
         IGxg==
X-Gm-Message-State: APjAAAV1iI9Tjovt5Syu55p1jdL+tKHIVQiWQZfS4p75GWAlAKmuRajp
        wKm3oPXbglKNt3VKBPC23y/InTUP
X-Google-Smtp-Source: APXvYqyU1B4Oqd0ZORd79XaIvtxlGTiJos+ORqgjuS2PVcku0lLGO4qcfWhnGjIo5YVyzMRJaszs9A==
X-Received: by 2002:aa7:87c5:: with SMTP id i5mr768045pfo.20.1554402315196;
        Thu, 04 Apr 2019 11:25:15 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id d68sm10963347pfg.16.2019.04.04.11.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 11:25:14 -0700 (PDT)
Date:   Thu, 4 Apr 2019 11:25:13 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/2] tag: fix formatting
Message-ID: <20190404182513.GA29747@dev-l>
References: <cover.1554183429.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554183429.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap usage line at '<tagname>'. Also, wrap strings with '\n' at the end
of string fragments instead of at the beginning of the next string
fragment.

Convert a space-indent into a tab-indent for style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/tag.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 02f6bd1279..faae364e0f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -22,10 +22,11 @@
 #include "ref-filter.h"
 
 static const char * const git_tag_usage[] = {
-	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
+	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
+		"\t\t<tagname> [<head>]"),
 	N_("git tag -d <tagname>..."),
-	N_("git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--points-at <object>]"
-		"\n\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
+	N_("git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--points-at <object>]\n"
+		"\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
 	N_("git tag -v [--format=<format>] <tagname>..."),
 	NULL
 };
@@ -215,7 +216,7 @@ static void create_tag(const struct object_id *object, const char *tag,
 
 	type = oid_object_info(the_repository, object, NULL);
 	if (type <= OBJ_NONE)
-	    die(_("bad object type."));
+		die(_("bad object type."));
 
 	strbuf_addf(&header,
 		    "object %s\n"
-- 
2.21.0.843.gd0ae0373aa

