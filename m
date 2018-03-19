Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2330D1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933377AbeCSNdC (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:33:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55449 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755420AbeCSNcp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id t7so2356956wmh.5
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lV6ElI3wEIU7mQNMbfzP3zXfmNdre/9euNihamHmEl0=;
        b=uRnWDXmK0rHd/cmTqsdfypEJtl8uREC6hLQxj377I91559maUt0TmVLsKBpVpWeSR4
         gW+F2OrwSerXQLosf4Ve7vI15Mc/1ymTcmW7t/G//sq5mryQ8fbAlg5DjqWVzA+u2Hct
         tPCtWDq3P/gfydHh7lL1cHkg0Flfh7reqrlDNVgAvXPBu7XMzFmxR/fRh/wWyF4nmIFk
         7gwlZ03Bd+NJu971gRzLEh3CXr+AKy/BjjylOKA72GaXXCNqq/S9pRxssxqi5NPosdCL
         vA18dDEdKqTNNuQWhQ6ugnFWblkDvdVw4ge741XV+456ZhlW43HkJ8fKS4OV6dBBhNRg
         rQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lV6ElI3wEIU7mQNMbfzP3zXfmNdre/9euNihamHmEl0=;
        b=A2NpJ9efYLQzrtDSepgpKzjsA7Fhl/Hd+/gaAZ58vU6Ghqp3k+n4b7PJNXz66Z8ZpO
         snSoSn6sFvDTvDE7SQ3VvRDcywWcL9OB5Dk1gNoUTFenQ4bWjaYMLo1XZUga+rydN/mD
         T7lbpbZeN6rLfk9Xzk3bM4gK7rscfp3rynuJ9zvoN3MLu3M+PRpuOd8BpjLK5nrjnUuf
         XJvZIS5EPb6Fqk1wbdBI0/PkFvHL9jrpLOnnd3Je9gEca4ZyRY/lL6iV4+mWI/TaIjMh
         Rx9s6yv7EXygSE33yfDAp8z7SgNnOjG8shoKWo9sWS367n6IKLcm4JGg+wpjrma6zBd6
         Hu8A==
X-Gm-Message-State: AElRT7HiSAmlNetkl1/9zPFVVVqd1vI/Th5WYr+k7OT6T4OsLw+oTsX5
        7VAPAHGZ2eg1lra62jD8AmhKRqg4
X-Google-Smtp-Source: AG47ELtlwpCFJlw+7/MoX075HQVP1LvxxYDQAHKR9su+eFu57frZCshfZ0/NUQbgkeHDZM0NLwOnCQ==
X-Received: by 10.28.197.205 with SMTP id v196mr4279491wmf.39.1521466364180;
        Mon, 19 Mar 2018 06:32:44 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:43 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 26/36] pack-objects: don't pack objects in external odbs
Date:   Mon, 19 Mar 2018 14:31:37 +0100
Message-Id: <20180319133147.15413-27-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Objects managed by an external ODB should not be put into
pack files. They should be transfered using other mechanism
that can be specific to the external odb.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e9d3cfb9e3..59e12151e8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -28,6 +28,7 @@
 #include "argv-array.h"
 #include "list.h"
 #include "packfile.h"
+#include "external-odb.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
@@ -1026,6 +1027,9 @@ static int want_object_in_pack(const struct object_id *oid,
 			return want;
 	}
 
+	if (external_odb_has_object(oid->hash))
+		return 0;
+
 	list_for_each(pos, &packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		off_t offset;
-- 
2.17.0.rc0.37.g8f476fabe9

