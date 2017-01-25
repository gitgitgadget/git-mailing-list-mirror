Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AFAC1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbdAYWDj (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:03:39 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35437 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbdAYWDb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:03:31 -0500
Received: by mail-pf0-f169.google.com with SMTP id f144so60960811pfa.2
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LsPlgYKmD4DFZFzepxfwY/tXOjURqYwCv+Wkyhk7Dro=;
        b=UOOM3nd6Fd1QVGbs18oAohAxBjczoou5jB87yNtslOGubsSpW9NigE9ulIdGiYVmLE
         FGuesNA9pNQeWyoXJ3/wqJGkiU6mFL9WUuRzY8FfCoqGzOhuvd1IGXg9NWoilYg4e+oB
         AWg1IoYdSZKrpusUC+D21ZoKTyR1tciRgD0kqVhFoZf2Oamu30JCGsKXpx/argXEliGJ
         f1DygPBnEqvwo4xz30p2J08TzVmSXnxjHDNdz7XC564kspw+ItTOPTMiBGfDA2EK6ZkN
         kjfHhXu7bY7B+TrVYEcHPMwH8u0mX0WCu02XswIsnhr9H5BLFhyEHGsQi4js97GWaxah
         NaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LsPlgYKmD4DFZFzepxfwY/tXOjURqYwCv+Wkyhk7Dro=;
        b=qSMyGe9+S0pje/vmIBYKt2mz0j7slz1p9E2BbfG6+9CgMoPcg735YH0hf5zkr5KZov
         7SrACh640SNnu6rCwC/u30E+LuHmBe6dKl+8496Hnftf/43vnvep8i3N6mgJIzJi5PQA
         uiyY6R8MYM5Ics+DqkE3JSsBsY2JRXK+rPCDZR7WypmGkMxhzu/6l81DTL1Otws+wYap
         n70xGrg1TlNxs+bL1B8FCi0G5GlOTZlgOjRvYZ/iE8B11vlrR233vtJcr1a48BguZoUw
         88m7HhFgR+ATxWUX053bLmn2jwtlVjC9SCVk5c9lch63qLog6pIoG+LTrdep8VuJne/K
         D6xw==
X-Gm-Message-State: AIkVDXJy3KnMbkiRxxX3WkVKgxxNnklip3ocgqdQQ9tJ5otK5nGGELQxbhpET7PK4gdZJbht
X-Received: by 10.99.112.6 with SMTP id l6mr1665494pgc.33.1485381810693;
        Wed, 25 Jan 2017 14:03:30 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id o24sm3357308pfj.78.2017.01.25.14.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 14:03:30 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 14/14] DONT USE advertise_ref_in_want=1
Date:   Wed, 25 Jan 2017 14:03:07 -0800
Message-Id: <a2262f625eb68cadc82ce042372111c05b4aca32.1485381677.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 t/t5500-fetch-pack.sh | 2 ++
 upload-pack.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 18fe23c97..f39dbcab8 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -551,6 +551,7 @@ test_expect_success 'fetch-pack can fetch refs using a partial name' '
 	git init server &&
 	(
 		cd server &&
+		git config uploadpack.advertiseRefInWant false
 		test_commit 1 &&
 		test_commit 2 &&
 		git checkout -b one
@@ -587,6 +588,7 @@ test_expect_success 'fetch-pack can fetch refs using a glob' '
 	git init server &&
 	(
 		cd server &&
+		git config uploadpack.advertiseRefInWant false
 		test_commit 1 &&
 		test_commit 2 &&
 		git checkout -b ona &&
diff --git a/upload-pack.c b/upload-pack.c
index 0678c53d6..4998a8c7e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -62,7 +62,7 @@ static int use_sideband;
 static int advertise_refs;
 static int stateless_rpc;
 static const char *pack_objects_hook;
-static int advertise_ref_in_want;
+static int advertise_ref_in_want = 1;
 
 static void reset_timeout(void)
 {
-- 
2.11.0.483.g087da7b7c-goog

