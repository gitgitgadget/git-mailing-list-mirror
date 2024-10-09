Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE5A1E2855
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505890; cv=none; b=UTY6duOYeejMWMosGj2HpeQMTx93JjUTpD7SlR+P5DRbuujmGj8XD+zyIThwZ8A4lN9BeUYB1bF3VWU27YQOh4jnjDAxInFtqUwlxK21mM5BTIgfUyphmLXVp8R/R8hzt7OxKvggXEXCsDX2p++N4X6jinm0DJ7HbK+NVgndbb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505890; c=relaxed/simple;
	bh=k+N1XOmHuUK+j7SeX37AmbB3XcpZkf3DyULU74FkWEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EI3C2FHl7zJ3KH/nruQeQASCdLEIgiT5C42Wrf3QwjfOW9bos4fO1Oo6qebqKwiRz1ff2TCXo+LmUbByXptH7hRDalWBeeQckQzgNujO+2qL1IR5GSqj6CZ3TfFR7O/Yp9L07KVnGsFTF4e7BTMJ5e6CGCIgGVbJWl5XOicxTr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=YxamRsLe; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="YxamRsLe"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6db836c6bd7so2534487b3.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 13:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728505885; x=1729110685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vQ+WiuPlVa7Y3KzKAJXuhMYUT3b1gkJjevd9YJHSVYE=;
        b=YxamRsLec2dWdKdKs1bdgbeXRcWbOPmvH7Bse7I7c0hVHPx5b1cCCPyMWQkPXB9aSU
         ABJ3BuPo2lOgaBW9x4eFifuXbY+/ZomddXjDDczBVVtRptdV7qI/X4wNpEDg/T4BnCyO
         vVLH4M5oQMvGoHJm/nv+95xpx1PPDE7/zu7zcmYRftXYbNCpZAd4rf6pizAdnTI25N0s
         daqZ3mnTME+e8C5IWev/OWD1mrbYCdjJ++kXCYbeT+6HuhTV/z0RaijVWJSEJxTZdIGc
         CmkVXKUDaFLmGeELkDQy//ZVEs1pAGUPZsjs3/x7QUQsWKD8h0y5bS4PlPuCnDKiB8Le
         2EBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728505885; x=1729110685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQ+WiuPlVa7Y3KzKAJXuhMYUT3b1gkJjevd9YJHSVYE=;
        b=FDOJqOT6VyB8X7n6qIsuEHPE/ssz0YV46HlAKPDfehhSosDbvUb9754EBHbhiEQpfN
         XNJRMySLauYWmMIrFLUhAsZWXVlnhKcE0BuR2VOQRzDSSHy5VZiY5Sas4SdFCG2V6ZLI
         cFC035Cztfo/dQDeWJsS/x0hQCFoiEKzsndJvxkI4GAcnFTPk4FEsn8BDNTfA4mEOwtr
         yFgoLqSPaRozjZcReMRXJPPRy/zfOE2QC+NK1A/HHaxTsBozsJcbGvKcV37F4yEGPrfY
         /n2SqoBxEt9hIPiYF4ow5VX4ipYMuMElr7xvUY7ttWUJ/SErk5qhcXkn3JgdceKMRLjO
         yn9Q==
X-Gm-Message-State: AOJu0Yxz6gKWWBAenaNpg1LDP7FTPdBtyJ/69VGSJxQfjpgN6SgwshvX
	/o9a4U9NyCb98HZauCRN41jgVwmuzyGcdVlb32xqcePLf2LAMQY+oOVTazg4SRrLB4arzij8Ih7
	kZKc=
X-Google-Smtp-Source: AGHT+IEeaOwRLYFjEEl2s/Zx5fBNMadN5BRO57RcIyXYV7kP6bpnwTEMalhTBxYmkUbfHDDns9TGoA==
X-Received: by 2002:a05:690c:6604:b0:6b0:70fc:f6e4 with SMTP id 00721157ae682-6e32e1fe41emr21686007b3.15.1728505885667;
        Wed, 09 Oct 2024 13:31:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d9387dabsm20219867b3.63.2024.10.09.13.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:31:25 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:31:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 08/11] t5332: enable OFS_DELTAs via test_pack_objects_reused
Message-ID: <9d81d890402f94f4126aedef0845d615d10455bc.1728505840.git.me@ttaylorr.com>
References: <cover.1728505840.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1728505840.git.me@ttaylorr.com>

Back when test_pack_objects_reused was introduced via commit
7c01878eeb (t5332-multi-pack-reuse.sh: extract pack-objects helper
functions, 2024-02-05), we converted bare pack-objects invocations
into one of two wrapped variants, either test_pack_objects_reused or
test_pack_objects_reused_all.

The latter passes `--delta-base-offset`, allowing pack-objects to
generate OFS_DELTAs in its output pack. But the former does not, for
no good reason.

As we do not want to convert OFS_DELTAs to REF_DELTAs unnecessarily,
let's unify these two and pass `--delta-base-offset` to both.

Instrumenting the codepath
where we convert OFS_DELTAs to REF_DELTAs with a BUG() like so:

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0fc0680b402..0f1b22b8674 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1051,6 +1051,8 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 			uint32_t base_pos;
 			struct object_id base_oid;

+			BUG("tested");
+
 			if (offset_to_pack_pos(reuse_packfile, base_offset, &base_pos) < 0)
 				die(_("expected object at offset %"PRIuMAX" "
 				      "in pack %s"),

, and seeing what test(s) fail yields the following.

    Test Summary Report
    -------------------
    t5326-multi-pack-bitmaps.sh                      (Wstat: 256 (exited 1) Tests: 357 Failed: 6)
      Failed tests:  46, 91, 167, 220, 265, 341
      Non-zero exit status: 1
    t5310-pack-bitmaps.sh                            (Wstat: 256 (exited 1) Tests: 227 Failed: 6)
      Failed tests:  46-47, 120-121, 197-198
      Non-zero exit status: 1
    t5327-multi-pack-bitmaps-rev.sh                  (Wstat: 256 (exited 1) Tests: 314 Failed: 6)
      Failed tests:  46, 91, 157, 203, 248, 314
      Non-zero exit status: 1

So the OFS_DELTA to REF_DELTA conversion is still tested thoroughly in
t5310, t5326, and t5327.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5332-multi-pack-reuse.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 955ea42769b..8bcb736c75a 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -43,7 +43,7 @@ test_pack_objects_reused_all () {
 test_pack_objects_reused () {
 	: >trace2.txt &&
 	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
-		git pack-objects --stdout --revs >got.pack &&
+		git pack-objects --delta-base-offset --stdout --revs >got.pack &&
 
 	test_pack_reused "$1" <trace2.txt &&
 	test_packs_reused "$2" <trace2.txt &&
-- 
2.47.0.11.g487258bca34

