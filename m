Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E353B34DCCD
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500620; cv=none; b=F+nS17TY234zbtvpe+gfMjqEyyG0Isg3OLXczkIBOHqlTZV+OyMnK6VJQhdgSiKy29TJG+mJNN4yli0hhwS3gJg1y50rH1pmK6kKumGl+SOBvSkV9OSUR6JMh4TVVoV3ugl5U38ywLBtICeK53H2swpl6tRM2ZAT3sJvGbULo5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500620; c=relaxed/simple;
	bh=VFJG1MwMyQ3sVQ2Co7AvhcrjVTc9xaZWOHX8SNT6IYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oLBOO2Y/6zOA1A6Lr2Cc5culP/Gg8Z9ICoX1X2jP9AlnPxOSbtFWvIHk52ryhB5Cn2jKr67gShZAy2eI6KqICZIqjGBZbmBjXgtxWCR6qjsbf75WhMQOOfBre3C1B3Iq9RivEy6YTMxnlsWoTHmwOBVpbtuQh15awwGwbJsjycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLR+G8qq; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLR+G8qq"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso114398a91.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789500618; x=1790105418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=noyV7WG9CoKS82NhsF1FcEpDi/pMs2Dr5z+MRc4V6pY=;
        b=TLR+G8qqSqogf4RANY18ZHZZcHhntLTgQuW7ifJb1OnFv6m5uzML2zBReojmhMev7+
         tthbYP0/bTLgo7pgIsEtRyciQA5CQAOARAKv9/n5+/WRY8+Wi9RAIQP0FOojhoSvwX+b
         PtdrW58AgTqQOL0uhDq1/nYRn40P3ai/8Zy/NkaGMa1dFYkzn68hD3mkNw1b9Jv5WLzd
         NqWPmpztX04hvlOfgAZH1quRHXbUUVM9eRSJXQEcItyS/2Elmn257T6OtmU5AAMileKl
         vhPYE8zkPrR7TCDOG4L/uO6zxHAoqRJSvAHnRGkHnxs76hmsS0zFe9NcqIfIdKa0GzXS
         DFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789500618; x=1790105418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=noyV7WG9CoKS82NhsF1FcEpDi/pMs2Dr5z+MRc4V6pY=;
        b=zBsm2yxcHGJelw++O+elUzh3pwYa93eB6Iov6U1AbQucjVLilO/tROy2W5uFE/814E
         VoZ5L5UN9pAeGknHh2V3yOMLG4ycO8DKdOyVTgj3OvstllE7gpXgljLDSv9G/KkydOsn
         8VfcPV6WFXQOb3ceRG7vcdEymTnVkSA1kUXGHHLPmcyO7iqLfYPJrB3TjvuHZlSWvB15
         LedkG6alRvJ4aBP/iWiawSAVchULVntRSkFDgFqWBNMPyFACTyBcvzpK0VJ19rLwZ0oj
         hEkfQf4Zwz/WgKqTPunmsurYv2OAjOdSMa3vHc7XCDN8j+tZuG+g67x9iyESiQ3yer6K
         qgqg==
X-Gm-Message-State: AFuF++nJs6sV37C9aqjVnFuFq9zf9mO28y5W+Dim2XatXdKcCh2A+b/w
	3MP9XyUAsUlnMOvVZXCKSfZYn09HE1tpfHO2hJBYotk5SaCBX4w12eFAjXvpNw==
X-Gm-Gg: AYBFou3L7faoObHXCl+JclCJQM3qwtI5MXXVp4bgZ8ZDAExzvyaDveUpgskmz7JPHnv
	PehzDRmxP4pCjlgupXhsLrqpQ/mdrOQdw477TekEkKqHPRJAF6QTi6IxwFxLCo5oWQNzE42HOxh
	18IBNPZOFOE8AtkOmCaBPeyk4wz4c4ijxr+JPNCPHqGSxc+TxpJdmYLDTyvuovWZDDRo/1dkg4z
	+YmWE8YKlHbtBxgViaW9136Ped+4bYOHIhCeE3yIQNZ9Kfx+uLts4Xg6VGZ8uwsu3Eq5KIuWULS
	Cq65VKB+KSCDRUBlAUwxyVbz0HfZapXyLDSicqLbZpUMfmvtao1LhQu4RIOt3vWIFxkYLtD+gNu
	ozL+F4fuJi0FS3x99CNWQFKBLhVzun7P+IL5MKb4Ieg3uWYgwjh99OVk2sHUt1LqvtFwnbFr/V6
	ZqajWN1f4fna3r1pxML5htl8Cy4ZYxge6yeD+9HGkUZKUYSU1FVNlBTotjlklqAucGo8wiT/dtM
	c0rYcEyuGBDeAZuyNbEmrA0AxMGnqZjsL0HHjmDQCoW+OMa
X-Received: by 2002:a17:90a:6d97:b0:39d:ec43:df74 with SMTP id 98e67ed59e1d1-39dec43dfbbmr11507874a91.12.1789500618153;
        Tue, 15 Sep 2026 12:30:18 -0700 (PDT)
Received: from royce-MS-7D09.lan (76-14-104-130.rk.wavecable.com. [76.14.104.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395bf6e8esm910139c88.0.2026.09.15.12.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 12:30:17 -0700 (PDT)
From: Royce Remer <royceremer@gmail.com>
To: git@vger.kernel.org
Cc: Royce Remer <royceremer@gmail.com>
Subject: [PATCH] [PATCH] Fix upload_pack_v2 response ordering for shallow fetch when server has uploadpack.allowRefInWant=true
Date: Tue, 15 Sep 2026 12:30:09 -0700
Message-Id: <20260915193009.222678-1-royceremer@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Royce Remer <royceremer@gmail.com>
---
 t/t5703-upload-pack-ref-in-want.sh | 18 ++++++++++++++++++
 upload-pack.c                      |  2 +-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 249137b467..9e2a090c9e 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -295,6 +295,24 @@ test_expect_success 'fetching with wildcard that matches multiple refs' '
 	grep "want-ref refs/heads/o/bar" log
 '
 
+test_expect_success 'shallow clone with ref-in-want' '
+       rm -rf local &&
+       GIT_TEST_PROTOCOL_VERSION=2 git clone --depth=1 "file://$REPO" local &&
+       git -C "$REPO" rev-parse main >expected &&
+       git -C local rev-parse refs/remotes/origin/main >actual &&
+       test_cmp expected actual &&
+       git -C local log --oneline refs/remotes/origin/main >log &&
+       test_line_count = 1 log
+'
+
+test_expect_success 'incremental shallow fetch with ref-in-want' '
+       rm -rf local &&
+       GIT_TEST_PROTOCOL_VERSION=2 git clone --depth=1 "file://$REPO" local &&
+       GIT_TEST_PROTOCOL_VERSION=2 git -C local fetch --depth=2 origin main &&
+       git -C local log --oneline refs/remotes/origin/main >log &&
+       test_line_count = 2 log
+'
+
 REPO="$(pwd)/repo-ns"
 
 test_expect_success 'setup namespaced repo' '
diff --git a/upload-pack.c b/upload-pack.c
index a52856d869..a70d237ad3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1812,8 +1812,8 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
 				state = UPLOAD_DONE;
 			break;
 		case UPLOAD_SEND_PACK:
-			send_wanted_ref_info(&data);
 			send_shallow_info(&data);
+			send_wanted_ref_info(&data);
 
 			if (data.uri_protocols.nr) {
 				create_pack_file(&data, &data.uri_protocols);
-- 
2.34.1

