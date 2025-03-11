Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43711DA23
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741652505; cv=none; b=hAV6o1RDvLndm3/dUaP1cY6Cd1W2ji5RzNsuZlticLxMtnfvXHGirS6s6347o4Z60D0ryAqTTXPuvKdDYSVpGm6uHDGoDQ+jau4oDFkuWfTY+fEYBYwUH8PcPdADmsMf+woeOLYl97l6u5u9tZZUuReCLBlGYDZ/F5wXT0wVyw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741652505; c=relaxed/simple;
	bh=7eVrzaXCGC8d7NliRCiUtP4SC7Xf/1yGWTxcdMqyqiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0sCbUfQ2Ul2tChLtQCFddP5BN/drbCY9lOWEJ/JUfiPxadbEui+6E/DMVOGCYhsNrJtjY85lTgib2nm8kSNQmohPq6H+TCWDaLR6RxK5PWEyft5BUTJtL2x1M85J/RsdVNWdL+leU+r93URI7om4FJiYWCu0+1NyZ8OTutVGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=GmDvDIdt; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="GmDvDIdt"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6fedefb1c9cso16139567b3.0
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 17:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741652502; x=1742257302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6k0Sfy84J8eO6x3Z0kX+45fAR4zU5o2TBXCRbGhdfo=;
        b=GmDvDIdtLFAnnTkP650zZ8lNkF3SOxQzPx6GytWLrqpM6O91jVU8gsVGt5kI9xecsV
         tn5+JVl12oyNROIlU6Fsad809/0MOaTRtfqZuyuqr5PsdmJ02Q4Eu+pXMS9K1UnTIfcu
         YVc04uXXfoQQZCFOUQi+gMBUKVXqIXmBTghEf1ZiW073I0YQAocKHuv3PxvbuabAn1Y8
         SrDUhiYxaIe5BWz5CQXOg68z9ji0F93NP5p6y3EnonwEZar9kDF8Wdb9jxphgLevoU7u
         KWdWc/NOTKjtSYfSqlUxt62gMJYoRY2f69yBlFPOhRcmi3u9el7LNMczGu+KAbr/ZfeV
         5r4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741652502; x=1742257302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6k0Sfy84J8eO6x3Z0kX+45fAR4zU5o2TBXCRbGhdfo=;
        b=wU4TUTIPGqHP6JpBBEnYp/723oC22m6MQ6B4PxJMAXLk/5IR5b0fT4IYN3GMWBvKxV
         Gflvm35u8LozXzLdmVHQRGUu569StWnWLS4LMSqgYtQxqYsPhfT4YuHJR3Cb7dWiTXSs
         HVbukQkIxO5p7+mzzoIv28JP1eZEwBP/oon+0IK2W3EMahvAC+oPACwKlvS8RqQVUA9v
         KyQMeT+Kpu8D8tjPD2XbD03Yo0fwcJktMuCYL/7yR0aGwzK+CzgFxBdEfjch+kLqRGth
         6yNfyTUBrwvbZZkqRaYb3dMKBi6CC3hFOQm4xB06uR6ywoM7RhRfat/u6weusyRuC1GA
         9GqA==
X-Gm-Message-State: AOJu0YwcazjLo8htAZOu0l+KJLlczz8zlehKEWYX3SokH+WGOfSkY1nQ
	5wDOz2zZPzUdB1fQLxdfphplN6kVF6Xrsjl+mSHOa5bFDT5NzsEwONbQdVKRGruoZVmPlUIhXAw
	+1kk=
X-Gm-Gg: ASbGncttu4+uzK8Fh+LuZMDbpUtKl9GmPRVQ+aBVUJ0TCSq558CQ5X8/ZNyxZ334f5K
	JAI3KKf1fKY3blSpmRCVjOTQoZPvPll+YncK9kkt0jXwfiyatxM9HqJw+BlzptMVNag+3lq3Moo
	f6aV1fCtii9Sieq4KjY7ViaZsrnL6xs+OeadodaMc+NC4xiJMVTCxCkT/d+bWqDiJ8R1mhCUqWy
	xVWcekIurAkV6HzexsiDPlsDUFlRy5sWQmqoSGVMefmQwit6WFjuypo/sASps8cuFhx42nT5jyZ
	+1LypVFTDJIrqiWIrBNKixdipTSo3ALFR7B9utBhC/Gq44KDzEq6NZTtVADfswiiOdDQNkEeudD
	bw82TeN2hmHLi7RAQ
X-Google-Smtp-Source: AGHT+IFr6gGBxY6zczqLYngON+C3lloiQM6Mn5PI9+3gJVWRClUTYsOtezD2lfuzKG3ZkQY4YoRsTw==
X-Received: by 2002:a05:690c:6d09:b0:6d4:4a0c:fcf0 with SMTP id 00721157ae682-6febf319c4bmr220237187b3.20.1741652502400;
        Mon, 10 Mar 2025 17:21:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2c4778esm24269547b3.114.2025.03.10.17.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 17:21:42 -0700 (PDT)
Date: Mon, 10 Mar 2025 20:21:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 2/6] t7704-repack-cruft.sh: consolidate `write_blob()`
Message-ID: <e7ebe6c460e2013d565dd87bc4bd584027e97590.1741648467.git.me@ttaylorr.com>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741648467.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1741648467.git.me@ttaylorr.com>

The last commit moved a handful of tests from a different script into
t7704, including one that relies on generating random blobs.

Incidentally, the original home of this test defined its own helper
"write_blob" for doing so, which is identical in function to our
"generate_random_blob" (and is slightly inferior to the latter, which
cleans up after itself).

Rewrite the test that uses "write_blob" to no longer do so and then
remove the function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t7704-repack-cruft.sh | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index aa5d8913ae..5ce2648a29 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -552,11 +552,6 @@ test_expect_success 'cruft repack with no reachable objects' '
 	)
 '
 
-write_blob () {
-	test-tool genrandom "$@" >in &&
-	git hash-object -w -t blob in
-}
-
 find_pack () {
 	for idx in $(ls $packdir/pack-*.idx)
 	do
@@ -575,8 +570,8 @@ test_expect_success 'cruft repack with --max-pack-size' '
 		test_commit base &&
 
 		# two cruft objects which exceed the maximum pack size
-		foo=$(write_blob foo 1048576) &&
-		bar=$(write_blob bar 1048576) &&
+		foo=$(generate_random_blob foo 1048576) &&
+		bar=$(generate_random_blob bar 1048576) &&
 		test-tool chmtime --get -1000 \
 			"$objdir/$(test_oid_to_path $foo)" >foo.mtime &&
 		test-tool chmtime --get -2000 \
-- 
2.49.0.rc2.6.g9a1eecd400

