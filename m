Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEFB1EB27
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+/tMTp3"
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E62D75
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 05:10:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso1238290566b.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 05:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697717429; x=1698322229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTrEXOeFol6AmaA9KXR+u1DxcdpMVWbMe6+zVa2nt9I=;
        b=f+/tMTp30E5CGNqn+1gW66ZROAx6pbQDTCgjoa+foy74Vtx7PmQwgWB4T6KDA++51V
         ZILWAP3/KaJ9zN9al6VXg4EE7BcJ8GjnauC0VvoISHbk/5KYd9qT7nbI+HLpzkb5nxtB
         097q6ERC1GxpkoNaF2fEmlNzQxZkBTwPVJ5Xc8j8+U2pqKwQitiqotoeIIsABOxgk+dg
         RcFRKUaUDW4Te8/HUOcUllhR6oWkUXA1kCEQ3nfMY9VevdP8cdLEmZZvBDDxgCR23BA3
         vvglNYXKlP+/FVqKjPhXpD9y0NBV6ytB6lR9/1d78hK+noq9uFRF8Qar0sLe2XX0LafQ
         Xm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697717429; x=1698322229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTrEXOeFol6AmaA9KXR+u1DxcdpMVWbMe6+zVa2nt9I=;
        b=a5U0/UJTGqDPKH7du8VMmb9p+pIBLJPj19x7scSeQUptdq2HoEn/kiNm+/asgdC18I
         k+TnSmDBgTeoWfnMN/nbvdF85DOQyL5oZsdvSRosvDMftynD605a/b8Dk+4o1/LonwGl
         9ezFeT8bxdegMF8SGgCxh3chFLS1enZQI7pNz3FG0ahp38ByQYnKnC613d60x8EmyuvS
         gzdVDwz3gGuUqvQbAJuX1i7IpgqF6Ils8SmaqmgdEo3VbLztaY79sFAcF83ZJeFbHfb6
         jvg4fVPaGcbY/DHdXuAj7zVmdKCdr7iVqmWh2N8VQgbZ3ttTWl7KxDW1LES1zgAu+cDg
         LTYw==
X-Gm-Message-State: AOJu0YzC59njmfLm0Q06+NJF7QuuhDo1u9xl6wLxmUWSfpeC8rEbnXLF
	LUlVOIOXKJG4AqDQRnHAqjdDgJOmCQJO5Q==
X-Google-Smtp-Source: AGHT+IGwCd8AcWFcRicpMOAbBIUvigKAQt64lUfuiNOzfiSTFDfN/ZR7ttKpSPYWeIUbTpMUe6w9sw==
X-Received: by 2002:a17:907:7211:b0:9b2:df16:851d with SMTP id dr17-20020a170907721100b009b2df16851dmr1670614ejc.57.1697717428748;
        Thu, 19 Oct 2023 05:10:28 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2454:56d:f00:d5ee:6231:6f45:fa9b])
        by smtp.gmail.com with ESMTPSA id oz6-20020a170906cd0600b0099ddc81903asm3469212ejb.221.2023.10.19.05.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 05:10:28 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v3 1/3] revision: rename bit to `do_not_die_on_missing_objects`
Date: Thu, 19 Oct 2023 14:10:22 +0200
Message-ID: <20231019121024.194317-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019121024.194317-1-karthik.188@gmail.com>
References: <20231016103830.56486-1-karthik.188@gmail.com>
 <20231019121024.194317-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bit `do_not_die_on_missing_tree` is used in revision.h to ensure the
revision walker does not die when encountering a missing tree. This is
currently exclusively set within `builtin/rev-list.c` to ensure the
`--missing` option works with missing trees.

In the upcoming commits, we will extend `--missing` to also support
missing commits. So let's rename the bit to
`do_not_die_on_missing_objects`, which is object type agnostic and can
be used for both trees/commits.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/reflog.c   |  2 +-
 builtin/rev-list.c |  2 +-
 list-objects.c     |  2 +-
 revision.h         | 17 +++++++++--------
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index df63a5892e..9e369a5977 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -298,7 +298,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		struct rev_info revs;
 
 		repo_init_revisions(the_repository, &revs, prefix);
-		revs.do_not_die_on_missing_tree = 1;
+		revs.do_not_die_on_missing_objects = 1;
 		revs.ignore_missing = 1;
 		revs.ignore_missing_links = 1;
 		if (verbose)
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff715d6918..ea77489c38 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -561,7 +561,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	}
 
 	if (arg_missing_action)
-		revs.do_not_die_on_missing_tree = 1;
+		revs.do_not_die_on_missing_objects = 1;
 
 	argc = setup_revisions(argc, argv, &revs, &s_r_opt);
 
diff --git a/list-objects.c b/list-objects.c
index c25c72b32c..47296dff2f 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -177,7 +177,7 @@ static void process_tree(struct traversal_context *ctx,
 		    is_promisor_object(&obj->oid))
 			return;
 
-		if (!revs->do_not_die_on_missing_tree)
+		if (!revs->do_not_die_on_missing_objects)
 			die("bad tree object %s", oid_to_hex(&obj->oid));
 	}
 
diff --git a/revision.h b/revision.h
index 50091bbd13..c73c92ef40 100644
--- a/revision.h
+++ b/revision.h
@@ -212,18 +212,19 @@ struct rev_info {
 
 			/*
 			 * Blobs are shown without regard for their existence.
-			 * But not so for trees: unless exclude_promisor_objects
+			 * But not so for trees/commits: unless exclude_promisor_objects
 			 * is set and the tree in question is a promisor object;
 			 * OR ignore_missing_links is set, the revision walker
-			 * dies with a "bad tree object HASH" message when
-			 * encountering a missing tree. For callers that can
-			 * handle missing trees and want them to be filterable
+			 * dies with a "bad <type> object HASH" message when
+			 * encountering a missing object. For callers that can
+			 * handle missing trees/commits and want them to be filterable
 			 * and showable, set this to true. The revision walker
-			 * will filter and show such a missing tree as usual,
-			 * but will not attempt to recurse into this tree
-			 * object.
+			 * will filter and show such a missing object as usual,
+			 * but will not attempt to recurse into this tree/commit
+			 * object. The revision walker will also set the MISSING
+			 * flag for such objects.
 			 */
-			do_not_die_on_missing_tree:1,
+			do_not_die_on_missing_objects:1,
 
 			/* for internal use only */
 			exclude_promisor_objects:1;
-- 
2.42.0

