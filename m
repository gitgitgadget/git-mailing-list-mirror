Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57346207B3
	for <e@80x24.org>; Fri,  5 May 2017 23:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbdEEXq6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 19:46:58 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34357 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752338AbdEEXqz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 19:46:55 -0400
Received: by mail-pg0-f50.google.com with SMTP id 12so9637801pgc.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 16:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sf7JQ5kr4beuEJJ0olzUu9fKaWfXlbJ8M8JpjPSb/AE=;
        b=J7eOARobWKFnhy9UbKilrpntXB5o75xp2th7iGbHvlwKrDhvqQ35O745b7A9JyrXC7
         HzgY2IOrYT4ji4MqDSVvxDQb9R4uGAANorYcj25qrxVC1tfR0i4p/3m+r7BIbWFUmZnz
         Iivb3qqMOOStihbQmQVYsmxtvqdck5bqZ4hXsKDyZlaVHubPPVoChxOYlVJK1Z3jmY/q
         kbiCwYDnAIBhTxsd7eX2ERdIwKkjiL1hmpuMkezbeIK9s7lUR4AP5DeUfSw1lwb1fHhO
         slATfmoaREDm2y5GQVRhCRf6GbtQbiddOEnGsqIcFWte2GfbxZNGB/FkHH7Hr+xbhC0g
         iP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sf7JQ5kr4beuEJJ0olzUu9fKaWfXlbJ8M8JpjPSb/AE=;
        b=ZPQh21f+FbS7my3LxfeyqbTLVQZf+0vP25PMIfTC8OwVQjclvO4YMBRz1t8gJsMg04
         lxfeKodY0KWt1p7NqiO0w1Bf9iCFZOJdn8Ua+fCnMOY6hJg7XNms2PBSxmOy9EKYgXLk
         RPSS9eldRU4liTAs+lbMcZLor47PVYVr+KXzdYQdkwQY0YwTr4OccQmOWTT7ypEH6ThY
         ncPbQLtJbVqsciOxhjexHfuf98l/9UG67rNjXYL71QpOzzWy4SL3gMe/bJhc9MSV75L2
         guBvQm38hwn2/TB8E7j3YRBEMtEA+W0eOx3lhHjKtEaYP/2kisDoxqR5GTcWdYqrO9fa
         plew==
X-Gm-Message-State: AN3rC/6Bnk5zgtL5GRb2wWUzXubQYWacGh6SUIM4x3TwYcdn8h4MXWQn
        C8hyc+qC3EDU3gmjS8BloQ==
X-Received: by 10.84.193.3 with SMTP id e3mr33199662pld.21.1494028014018;
        Fri, 05 May 2017 16:46:54 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id c77sm11096576pfe.37.2017.05.05.16.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 16:46:52 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [PATCH 3/3] protocol docs: explain receive-pack push options
Date:   Fri,  5 May 2017 16:46:44 -0700
Message-Id: <615007182a5e205a7074317a4c8788aa4eb009ff.1494027001.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <cover.1494027001.git.jonathantanmy@google.com>
References: <cover.1494027001.git.jonathantanmy@google.com>
In-Reply-To: <cover.1494027001.git.jonathantanmy@google.com>
References: <cover.1494027001.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Support for push options in the receive-pack protocol (and all Git
components that speak it) have been added over a few commits, but not
fully documented (especially its interaction with signed pushes). Update
the protocol documentation to include the relevant details.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/pack-protocol.txt | 32 +++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 5b0ba3ef2..cf7cb48c3 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -473,13 +473,10 @@ that it wants to update, it sends a line listing the obj-id currently on
 the server, the obj-id the client would like to update it to and the name
 of the reference.
 
-This list is followed by a flush-pkt. Then the push options are transmitted
-one per packet followed by another flush-pkt. After that the packfile that
-should contain all the objects that the server will need to complete the new
-references will be sent.
+This list is followed by a flush-pkt.
 
 ----
-  update-request    =  *shallow ( command-list | push-cert ) [packfile]
+  update-request    =  *shallow ( command-list | push-cert )
 
   shallow           =  PKT-LINE("shallow" SP obj-id)
 
@@ -500,12 +497,35 @@ references will be sent.
 		      PKT-LINE("pusher" SP ident LF)
 		      PKT-LINE("pushee" SP url LF)
 		      PKT-LINE("nonce" SP nonce LF)
+		      *PKT-LINE("push-option" SP push-option LF)
 		      PKT-LINE(LF)
 		      *PKT-LINE(command LF)
 		      *PKT-LINE(gpg-signature-lines LF)
 		      PKT-LINE("push-cert-end" LF)
 
-  packfile          = "PACK" 28*(OCTET)
+  push-option       =  1*CHAR
+----
+
+If the server has advertised the 'push-options' capability and the client has
+specified 'push-options' as part of the capability list above, the client then
+sends its push options followed by a flush-pkt.
+
+----
+  push-options      =  *PKT-LINE(push-option) flush-pkt
+----
+
+For backwards compatibility with older Git servers, if the client sends a push
+cert and push options, it SHOULD send its push options both embedded within the
+push cert and after the push cert. (Note that the push options within the cert
+are prefixed, but the push options after the cert are not.) Both these lists
+SHOULD be consistent.
+
+After that the packfile that
+should contain all the objects that the server will need to complete the new
+references will be sent.
+
+----
+  packfile          =  "PACK" 28*(OCTET)
 ----
 
 If the receiving end does not support delete-refs, the sending end MUST
-- 
2.13.0.rc1.294.g07d810a77f-goog

