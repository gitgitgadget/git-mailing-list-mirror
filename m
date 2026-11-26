Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702611;
	b=mRiIlqVFUPt0W/S3G0nP2d2/R1RRXHkpBjufa47Blwj8WZgdc37QnvjgCJ/blGE0Jni0
	 5BINaDmSX54VbI5LA8q2pOH/UrwVAlGIZ1zcXZ/W56dYTlw2MV7igZP6Fm8ZbYh4MkBTP
	 cvFnelVllgl9j560le6UOetDpDhNZ4uDElIMJNgDkAycr/Yuv50GoBcmzrde1PKgM052y
	 eA5bz66xk6o0bqfbccqPap5HF+NCKB2aFR/lso8a8CuJnoShCM0OoC3OGl4p6/qq3r4vY
	 q0t2l/nDrq05T043J6f8OrxZXZ0I/Be7kNbICcTHYIP/wT9GevZKKpDzOal8DpUcyuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7Ws6WCq7eglNoYpgFH0MFNYhmyBzO9dLz0jtv+U4dUg=;
	b=zGaAe3/vU6alv+gWR+nLY2A6dY5Fm7pbxfDqrwPWdcHhkUdVN34zrnrWW0L2qaZUh7U5
	 0YUkHacEnQV7nYWhBchEcNPNLunZzcD5TqwWXel087HvmXlbgDi7tHQ7HX6UTR7G09KfO
	 BVVDY3oQT2DgwF4NqlUEVbaDKurp6aX/Elq4b6quUiUKPhJsTbyo5GJM5XYhNlyahq6YU
	 ZlmBulfm20+KNAGdKAQC/WYB+Ij9b5X19xsSlBLa9zceapJogk4/TN+dFeJtW4TMbKXpZ
	 cYVWTXNqgg/yy15GXjIj386hrl7ve9XFXsWft3q5oIsnJFROkj7OHDkgVlgaUkVli8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a+kHTnUQ;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94FE606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 14:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B94FE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a+kHTnUQ
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e3b22e971so3733255f8f.0
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 06:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795702609; x=1796307409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Ws6WCq7eglNoYpgFH0MFNYhmyBzO9dLz0jtv+U4dUg=;
        b=a+kHTnUQyCy1cfXmx5vzLtZ5NMZ0lSl24k5hZSIm/sQMGMdzChH1PBwD8V2RQqUYBm
         /K6dV6dfRrm52D+9PtXXBf/93JNojyCNFH4yv3cGgAUCOA+BXUr3TalFGyF+uhqWxHqd
         tW1fla2Zi3AYSHRKMUU/MV1NBP39i47k9d+Zm5ruhNHNbvMvMDFEyOSgFMf2LiH+D5Ju
         DeQpB3F2wXIUJZwFDquTns8TZDdY0n5yS27hDmssq2SmpYxMMKsTMntD8j4aMRx+TV1e
         fx+L/Qj+0K0DODfsEewXl/uy6+fVQHnFUNg2ki8THR2m13GVG7ARoF/sYSAbxbvaDabn
         gRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702609; x=1796307409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Ws6WCq7eglNoYpgFH0MFNYhmyBzO9dLz0jtv+U4dUg=;
        b=pXDtQrx7QTt7FqhlnCxhv4n5WL89DIyjNZuKX2DIqMHp0J1CrBkzBluY5MFCf6cuRv
         bXpAUt92rwpeoWPV/MEGwY72ky4fu0hIdBE3FCqn4MmN9h6yB5m0UsJ0QyCrC7aV+kKz
         UX7E7qqMf1y3l/vtc/3tAJiLOg92LqqdabprQ5+6KxaT3ltz+Hw2gS6pAqneqGZwKPnI
         chPM/z+5bgZeQUy8h9+S/w9EKVfoGuUD/KxFf1D1Ygm0AJ+btgcbaIBguE4Agt0nlWac
         v+047BHRw28u6z9JGCHtDkwLvmRxw3l6Jmk9Il/P/5iS4A+Nzxg09/gIg4h1FTlVgCpv
         ut9A==
X-Gm-Message-State: APuU4Z+skHXzqrQaSDiH8sfu7iLzIHc/FCVZ2CMgSfLNtawUHT2nk6FI
	LF/RbEy1AF7b+WlEpR9uPKZsY4lZEd+WNU3Tnx52xhgSVzOOIKY/PGvY4dIvSQ==
X-Gm-Gg: AZFdTZdMO2E7Q9VjiIcweya0C+Sgm4RVH0wFa5gVgkl+1kU15yw5QGCEM9LK+GbsftB
	6RJwD2NNiftPaKsEJLfY17qtFni1rTVjfZeB7S3PnK+eAfMll5KBAXUv2coogcK8zQtaf5ozqRO
	1KCVFngMmPEziCkYZFsjHUcAV7b7cB75yL1dyoyEGxrusouFHJG4qWIixHZUNstoilrbnxpoUPp
	vvy77FGJPOyVuMToMajUVThZSQ7BmnBjHLX4Awzk0big1X/sd49s6n7zgdrpjq9AWidV2tFLNJM
	AKV7GcdImLYcwozVyxZUCEfKztNJibCB+rFcrF+AF1NmsRkPe+56Ply/VV6JxmKTB8woe+5z3Nt
	7JXHElcB7tGrOkqggSwRVQPgSzxaAZkS/LawMP6ZA/G6nkxEk/DLTvUhWk+wXmURKSSiWSjtuKx
	HJ9/rCzlP4kmCd6wVxX45n+X11Ao++MbX4nuocNJ23GrNdQqrRPvEKUY93moo1Z8EUI6NckMgRU
	3kxR3oPivtnt3SVkwZngThHRogNQHpOrz9oj7R3oL0w32hSD63FE6xYJLaqAg9AKmyB7zgtOSSJ
	DX2WKU9Fh2YsO6aozX4/7C7Db6x+xMavKqTTtbq6DiKNJiUIW3KMWooXbXKOPUS5vvSnbWo88Sv
	9bISZgTxpcl/b/qa3nSMzKrhW8e8aU+623ERsjVFJgOGF6WJIaRQ9NMd4Xg0HLvIoNdpIK4EXD1
	k108f+h3AnFVfWxxHhZPyYiRRMRFiBANNEv5DRS1c=
X-Received: by 2002:a05:6000:29d6:b0:4a8:bca4:f295 with SMTP id ffacd0b85a97d-4abb32a4173mr27810052f8f.38.1795702609009;
        Thu, 26 Nov 2026 06:16:49 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b8e564e39asm10127999f8f.57.2026.11.26.06.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:16:47 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 1/2] promisor-remote: pass a repository to promisor_remote_reply()
Date: Thu, 26 Nov 2026 15:16:28 +0100
Message-ID: <20261126141626.914848-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.1.472.g808159e44e.dirty
In-Reply-To: <20261126141626.914848-4-christian.couder@gmail.com>
References: <20261113000600.202744-2-christian.couder@gmail.com>
 <20261126141626.914848-4-christian.couder@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

promisor_remote_reply() uses `the_repository` when it calls
filter_promisor_remote(), even though filter_promisor_remote()
already takes a `struct repository *` argument.

Let's add a `struct repository *repo` parameter to
promisor_remote_reply() and pass it down to filter_promisor_remote().
Its two callers, send_capabilities() in "connect.c" and
do_fetch_pack_v2() in "fetch-pack.c", pass `the_repository` for now.

This is a small step towards getting rid of `the_repository`, and it
prepares for a following commit that will make promisor_remote_reply()
check the repository it is passed, to fix a crash when it's called
outside a repository.

No functional change intended.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 connect.c         | 2 +-
 fetch-pack.c      | 2 +-
 promisor-remote.c | 6 ++++--
 promisor-remote.h | 4 +++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/connect.c b/connect.c
index 87d2e8bccd..bcd9d65f6e 100644
--- a/connect.c
+++ b/connect.c
@@ -520,7 +520,7 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 	}
 	if (server_feature_v2("promisor-remote", &promisor_remote_info)) {
 		char *reply;
-		promisor_remote_reply(promisor_remote_info, &reply);
+		promisor_remote_reply(the_repository, promisor_remote_info, &reply);
 		if (reply) {
 			packet_write_fmt(fd_out, "promisor-remote=%s", reply);
 			free(reply);
diff --git a/fetch-pack.c b/fetch-pack.c
index 55d311c0c3..ff14c28f08 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1699,7 +1699,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	fsck_options_init(&fsck_options, the_repository, FSCK_OPTIONS_MISSING_GITMODULES);
 
 	if (server_feature_v2("promisor-remote", &promisor_remote_config))
-		promisor_remote_reply(promisor_remote_config, NULL);
+		promisor_remote_reply(the_repository, promisor_remote_config, NULL);
 
 	if (args->filter_options.choice == LOFC_AUTO) {
 		struct strbuf errbuf = STRBUF_INIT;
diff --git a/promisor-remote.c b/promisor-remote.c
index 316d9950aa..85adb66c80 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -1373,11 +1373,13 @@ static void filter_promisor_remote(struct repository *repo,
 	}
 }
 
-void promisor_remote_reply(const char *info, char **accepted_out)
+void promisor_remote_reply(struct repository *repo,
+			   const char *info,
+			   char **accepted_out)
 {
 	struct string_list accepted_remotes = STRING_LIST_INIT_NODUP;
 
-	filter_promisor_remote(the_repository, &accepted_remotes, info);
+	filter_promisor_remote(repo, &accepted_remotes, info);
 
 	if (accepted_out) {
 		if (accepted_remotes.nr) {
diff --git a/promisor-remote.h b/promisor-remote.h
index 301f5ac5cb..198fe768e5 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -65,7 +65,9 @@ char *promisor_remote_info(struct repository *repo);
  * the names of the accepted promisor remotes separated by ';' if
  * any. See gitprotocol-v2(5).
  */
-void promisor_remote_reply(const char *info, char **accepted_out);
+void promisor_remote_reply(struct repository *repo,
+			   const char *info,
+			   char **accepted_out);
 
 /*
  * Set the 'accepted' flag for some promisor remotes. Useful on the
-- 
2.56.0

