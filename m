Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980219F13C
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571470; cv=none; b=eSXtRcsl7A/KMMhMNV8zFv6KlwaXVa4elQ7D9ZZ5N6sIj5+vetcQpsbt+7PKn7NeDWPq6Vltg6NTNPDoru7gZEIhWmqMGCQLsqu6OhUgggDEbFNEU+uWj2WBgA+iw8iiWYpO+571kv90e/T9I8tdJfc02TswNKbdj5WJH/zzfTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571470; c=relaxed/simple;
	bh=ur/kT205FPc0yAIMtlpIcow4EGEVb8d9JBS+HDAK3H8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N2/vwnyBst9Ta9nj8B2W/ljg5/ilyi3xVvygMoFlhqbMSl5aZFmtM48/duh/6+7EykWRm/6gkgGPcSpuXCdQ1GD3oT8jK4/wSLcUvy69zYor4cFZkHkgEdzTSbs40p2nHFfimLNQB4x++ILb5KBiKx3X9jnhofASXKXgoDAxI0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQLax2Kk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQLax2Kk"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac297cbe017so114235966b.0
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 18:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741571467; x=1742176267; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLtNXTXgBQW5QreJixogHQ3druYa3351VMaoOoIx+HE=;
        b=cQLax2KkZOmYxKLr3yw/Z0m61uwg3fQdF1pMnwdT93igOoISEGIvxY0sOhx4m8Ru2r
         7fjBYVTWE/K/ITVQz83YGkjkwBxaV5x+LFIibJjJ/pU4YgS6IJVtSIPUL0n2KZ0jyhBh
         G9m69YVivJBpTQrolXmShguolRJaxL+LPcJEUU2y8UuGG/V83LdIhk8VXQhplF11etPl
         ThmOdmx/xMofYFlUoB7DNkpxorDRfO56VmWK7nNmKZtAfXMcpqvnMOYWtNtvbSqbnw2P
         eQWiBRaLpFsHBc9NLEMnO+6xT3Jd5YMy8OaMOn0MCOR8jXp9GwHcGO+P6/6VxLsINpQu
         7D6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741571467; x=1742176267;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLtNXTXgBQW5QreJixogHQ3druYa3351VMaoOoIx+HE=;
        b=Uto1OTMobekm0BM+zsdbIeRULEPuJvf/5sz8ozlmRsj1wTIhar8qoU0q24kHgblNAH
         rlr94AdAPMBugeiLSv1p7TGZCKO0HFrrMOkj+uPu2UHQZbjirc45RIFiQ6I58P7wVEOh
         GVJi6qRIo1rzx62BebS58bvaBPIou/EAd79mDGP2eie20mWjpteeaI2KEmZh7nz3Zybp
         LVn9pl3DGt8vPzRY9/ax+dD3CTsxTb2lDT52qY9yLV5Cb7CKkLG7usmCInoSJTWnsSj3
         XicaXbpGrUUpaESSpPsHhxaXF+CypWmB9B5OxMbgs4OLd4wTDPtz/Me+7RioUWgqDS0P
         rPmg==
X-Gm-Message-State: AOJu0YyYbnI+w1we1/Ww0A6uD/j0yMfNBABdvPY27f6s4LFcwuIBxkjN
	XMnU+3Rg61rWP5suFN25AVuwAyKepN2dTxVZ2HL+5uJimD2j+7u+pI6NTA==
X-Gm-Gg: ASbGncvYcfQSIAtJ9bA7nFXC5ygxiB/8hubJM7PKEEmFAwBXmoiVIwEyJL3voPpFZBc
	VPcpEbuEYsJgQfc4gbuGYZWv6q4YhScouCQItDB1bmPrVe3EotVxeEzqEKZl4GbQSVsDBiP10DF
	5oWHrEw+c3A4BNtHg8gP4ORE3fynAz4fZXpJEHfmb74TZ8IKZKitmOkMVsNDBKgp3d/0v4+76Q6
	26voHiAGhzAPilJDP2i333Igx+V1K/d7EFloN+qDELUHEJlnnQNglUcVFD2Ea44x95Yr+d0M7Hq
	4TkrxMJ6IQb1Y0P2Q6s3tJFQpLYoLElcOI9bpj0vdLAmFw==
X-Google-Smtp-Source: AGHT+IEcedKPsRn/3hpqX55jdotatiMZGa0iM1JPfqbDtVtb5hvcj1cQ6smcClHh4LsuIqDhEDU5yg==
X-Received: by 2002:a17:907:7b03:b0:abf:6d6e:7728 with SMTP id a640c23a62f3a-ac26cbbf092mr746805466b.19.1741571467014;
        Sun, 09 Mar 2025 18:51:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac287653d1esm237861666b.125.2025.03.09.18.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 18:51:06 -0700 (PDT)
Message-Id: <2eb92507213fca6dc7630ace20878eb288440bdf.1741571455.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Mar 2025 01:50:55 +0000
Subject: [PATCH 13/13] pack-objects: allow --shallow and --path-walk
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

There does not appear to be anything particularly incompatible about the
--shallow and --path-walk options of 'git pack-objects'. If shallow
commits are to be handled differently, then it is by the revision walk
that defines the commit set and which are interesting or uninteresting.

However, before the previous change, a trivial removal of the warning
would cause a failure in t5500-fetch-pack.sh when
GIT_TEST_PACK_PATH_WALK is enabled. The shallow fetch would provide more
objects than we desired, due to some incorrect behavior of the path-walk
API, especially around walking uninteresting objects.

The recently-added tests in t5538-push-shallow.sh help to confirm this
behavior is working with the --path-walk option if
GIT_TEST_PACK_PATH_WALK is enabled. These tests passed previously due to
the --path-walk feature being disabled in the presence of a shallow
clone.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e8b1b057ec3..4bd943728b4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -209,6 +209,7 @@ static int keep_unreachable, unpack_unreachable, include_tag;
 static timestamp_t unpack_unreachable_expiration;
 static int pack_loose_unreachable;
 static int cruft;
+static int shallow = 0;
 static timestamp_t cruft_expiration;
 static int local;
 static int have_non_local_packs;
@@ -4483,6 +4484,7 @@ static void get_object_list_path_walk(struct rev_info *revs)
 	 * base objects.
 	 */
 	info.prune_all_uninteresting = sparse;
+	info.edge_aggressive = shallow;
 
 	if (walk_objects_by_path(&info))
 		die(_("failed to pack objects via path-walk"));
@@ -4684,7 +4686,6 @@ int cmd_pack_objects(int argc,
 		     struct repository *repo UNUSED)
 {
 	int use_internal_rev_list = 0;
-	int shallow = 0;
 	int all_progress_implied = 0;
 	struct strvec rp = STRVEC_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
@@ -4872,10 +4873,6 @@ int cmd_pack_objects(int argc,
 		warning(_("cannot use delta islands with --path-walk"));
 		path_walk = 0;
 	}
-	if (path_walk && shallow) {
-		warning(_("cannot use --shallow with --path-walk"));
-		path_walk = 0;
-	}
 	if (path_walk) {
 		strvec_push(&rp, "--boundary");
 		 /*
-- 
gitgitgadget
