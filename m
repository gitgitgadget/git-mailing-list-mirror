Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F35267AFD
	for <git@vger.kernel.org>; Tue, 20 May 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732999; cv=none; b=TmhNeaQ3TqKeTYCsAPjlX0yr+2FX8Thy/geHRJ948b55M8tT2hY0U8XU24W6zeX3CdndYxSEvlBj8t9/xPSa2DSMwWSZdVbFx2+o79gVYDgbKw/nDhVJ3J+O9ho+pekTfu85BftDXqiJMfWQbzRkeec9xro8Rb0/RIwCC319jF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732999; c=relaxed/simple;
	bh=3qIkpHO1MFQzfshle/RL924tVd8jKmbzhjJ5dm9ssrM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZzxG6pjgXb03giqa6CfAreAsgDnlC8OWLYgl4V3oFepfL9g0qdZbRhzyyHbVhh1hLe7SkVL9cEi5nO91ETWY+wDvcRiPSsI3ZgY/vrQ34N0uk2jGAiNWZxBdi03i1EqZI+7mBK0XjuywVGhMUOnmfKNGhxYRzWZWNaT1M6jKRDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkqQuxTv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkqQuxTv"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a375d758a0so1152856f8f.0
        for <git@vger.kernel.org>; Tue, 20 May 2025 02:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747732995; x=1748337795; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38Nqbc/b0v9r9Gg21zBEWGo77DzQRbstcDPAXzqg1As=;
        b=AkqQuxTvKgTvpTojovZVg2wGPXFf6k9V75148aS2JifMRH3RPnpiJuEmUZxfS1u547
         sGQ+pvyU6dx7OHTQOMeYxYHUxdkF2Y6+jbzMZlbnqfkpDnTfZ4OlzJ02f0ywLPjDV02I
         +g3DrPwY0uTFr4e9rjEVpgmLhdKd6EOVbrgEEOy7yM3KwrjFQs/mZzbH8FNBHA3XE7A/
         17fspnOOk2SUMjHijRTHSATxkcF44en7WZCitDr2x+n8I1I1yM6Mcc8la9u2WBCN2BNR
         IsABdxeL0Dq/33MsxSfQUrK9HxaepRsyMd9mJ2LoAWt9IlPBCsw6iWe/X1JfS7gJDBb4
         7RcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732995; x=1748337795;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38Nqbc/b0v9r9Gg21zBEWGo77DzQRbstcDPAXzqg1As=;
        b=fMxveNaJfFxXhid9Gcr9dJoIKas5LW/yDOFGF9kwH7s+yP70mif59gv6mI65oVxyw0
         tRbIj6SkeBPTumnCTHqXdczJusqGt+9VktSdbTzlnMj5NtElS6PmetSOfyWmXoc/ED3a
         O4PbCuCu4lcn6ev0SjBx7bQMbRs+Pnlng6Rflz0hOzzy1oIOmT81il2WOTAz+vS/z5XO
         3SnnpIZwOmpiUvsx8RS/ANp6+SWJlh/9CHDHRPh47QFE+2xF22xGVwmuuvKSUeTWTkjW
         Spy5cKHr8FwX/5psVEyEt7h6gfoG2tjeFqHFh539tm3Bzc4XPCepjEwj7Bsjwa4SZmk0
         iq+w==
X-Gm-Message-State: AOJu0Yw1fRUSAQUzP8L/VvgashM392nuq1mqKcoKlpSNvpMQ+O6SOVm5
	MKVl4ijDxvZJZ78c382WUaQc2lH5kLPgpA8LAwaRTkCP9nHoxplkM5SG+1x5Xw==
X-Gm-Gg: ASbGnct9L6YBBpHXfRNOzzmJOCxhnUpHHzrnI0Mi/oge3FlUaForsTTYA9zkGAKVzYa
	3ylGPMr2ntvbJNi855ZiJTt8JpnXK9CJZDlqdUnsUg4HghkwUL+dHzLPiaAdVo4X7rDkNZJK8x0
	cOwqPuFJHu84jvGabGdp24LHj9kPXfnRhg2JgoVDoYGXOzc0hbhmjILcC+7MbXdoaDTXDnv5CLj
	1VWFvFPM4SrMaL9iJNF+5orHr8Er575mCcIIlwXaIX1FdK+Mr2LwefM6Vh8aCIHGKkuw4SLQy7A
	ShMmcO+gb/ypKkSUROOAIx06NWh3qfj/2coMg8pZ3WmBKs4biplp
X-Google-Smtp-Source: AGHT+IFWCofh23kj5TLQT0uO+t2s7rLgwMGnch3lN4DZB6bVa0V0Zw4t9DEs67MtneIzVmXCLzp4zg==
X-Received: by 2002:a05:6000:1a88:b0:3a3:6595:921f with SMTP id ffacd0b85a97d-3a3659592b3mr9526831f8f.41.1747732995134;
        Tue, 20 May 2025 02:23:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5abaesm15760372f8f.39.2025.05.20.02.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:23:14 -0700 (PDT)
Message-Id: <5be22d563af714ebb902506f12b4468a5348896c.1747732991.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
References: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
	<pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 May 2025 09:23:10 +0000
Subject: [PATCH v2 3/3] pack-bitmap: add loading corrupt bitmap_index test
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
Cc: Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

This patch add "load corrupt bitmap" test case in t5310-pack-bitmaps.sh.

This test case intentionally corrupt the "xor_offset" field of the first
entry. To find position of first entry in *.bitmap, we need to skip 4
ewah_bitmaps before entries. And I add a function `skip_ewah_bitmap()`
to do this.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 t/t5310-pack-bitmaps.sh | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index a62b463eaf09..537a507957bb 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -26,6 +26,18 @@ has_any () {
 	grep -Ff "$1" "$2"
 }
 
+skip_ewah_bitmap() {
+	local bitmap="$1" &&
+	local offset="$2" &&
+	local size= &&
+
+	offset=$(($offset + 4)) &&
+	size=0x$(od -An -v -t x1 -j $offset -N 4 $bitmap | tr -d ' \n') &&
+	size=$(($size * 8)) &&
+	offset=$(($offset + 4 + $size + 4)) &&
+	echo $offset
+}
+
 # Since name-hash values are stored in the .bitmap files, add a test
 # that checks that the name-hash calculations are stable across versions.
 # Not exhaustive, but these hashing algorithms would be hard to change
@@ -486,6 +498,44 @@ test_bitmap_cases () {
 			grep "ignoring extra bitmap" trace2.txt
 		)
 	'
+
+	# A `.bitmap` file has the following structure:
+	# | Header | Commits | Trees | Blobs | Tags | Entries... |
+	#
+	# - The header is 32 bytes long when using SHA-1.
+	# - Commits, Trees, Blobs, and Tags are all stored as EWAH bitmaps.
+	#
+	# This test intentionally corrupts the `xor_offset` field of the first entry
+	# to verify robustness against malformed bitmap data.
+	test_expect_success 'load corrupt bitmap' '
+		rm -fr repo &&
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+
+			test_commit base &&
+
+			git repack -adb &&
+			bitmap="$(ls .git/objects/pack/pack-*.bitmap)" &&
+			chmod +w "$bitmap" &&
+
+			hdr_sz=$((12 + $(test_oid rawsz))) &&
+			offset=$(skip_ewah_bitmap $bitmap $hdr_sz) &&
+			offset=$(skip_ewah_bitmap $bitmap $offset) &&
+			offset=$(skip_ewah_bitmap $bitmap $offset) &&
+			offset=$(skip_ewah_bitmap $bitmap $offset) &&
+			offset=$((offset + 4)) &&
+
+			printf '\161' |
+				dd of=$bitmap count=1 bs=1 conv=notrunc seek=$offset &&
+
+			git rev-list --count HEAD > expect &&
+			git rev-list --use-bitmap-index --count HEAD > actual &&
+			test_cmp expect actual
+		)
+	'
 }
 
 test_bitmap_cases
-- 
gitgitgadget
