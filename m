Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B37E0F4
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755698; cv=none; b=hJLDsYqdow/8LRsSo/KJn5vgFRcFt2GkC7cT8YOQTBp/6X6nMLEjkgGd//jiUuRTNGj3fsyXzUwQ64POWYgr4/ihoLBp3jFP8GPZNY2WYOLxSCU+cTlPN6t0dIdr7HCfj9IH+lgUlY/DjGbJdqN+vqPjZsHkS/0jZy7qCNzUq6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755698; c=relaxed/simple;
	bh=P4nLtaax4xZUgAoO01Y3Be2O/COrRVLoiZ/UDwWNLeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1s59n4XCBOhP6NdJbJfJ/tZgWP4xJNlTUP/byRH68lgkiWMGwttWa0kVWgK2dbn2n/gyY5EiP8hoA5HnW3WZGSiHon53yenVFhhhrLoD8aX4ARX/F2PkdZUQetNKnPu3Ck1zqdwrqMr1879gAyHA5Z070wOVrn1l2IdeuIEyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=zrxefS7L; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="zrxefS7L"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e0ea24477f0so1444380276.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723755695; x=1724360495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vnXoms/JZKpsIummwddL7fQgERMHOCeXotpuHp5HbFU=;
        b=zrxefS7L016YaWGgkvw0KSChGyGTjd2GT9agr/xv3A+ryikgYFSkukLRO68fP3DKBa
         H5uDWS03cp3c9wo4pYUIZI0FBiPfH/P4AGQwAWVjGtkhxh82wpwKQftWqABj2BJYsxEb
         lkXNyPax7Gbrew/HK/D2GhPOO9OIodg7Zszb8x4UrZw+dRcH6KVPOYaY/Thc0qsta5mH
         6G/+x4ZYUF6BLdrpct2+bYVHXIAp1S084B500xast2yKvPDvkbAsSspDenDgS78VWvQ6
         o2rg01lKeX5Qrq80OrZFvnsmqtZQGUbEZRleFMekJ2IbzgmLzdC3lwGIYyIWUDzUB+Hc
         +Vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755695; x=1724360495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnXoms/JZKpsIummwddL7fQgERMHOCeXotpuHp5HbFU=;
        b=aYAKfflak+1paPKG1dnUEnfcLdEpXUY+FkFLDOv7mYgUI3O0saJoALOmTY7yTwGsP8
         1iyh1x6xEj1LJ0SVVG9VqSe13HA4isy46d2hHXZMq1RIZlzZbBxkyqry3J9C+c1205Is
         y5XgTMNk9cFc0GlBxLCFRnqjJ6iq74zDjCKLNMAfP5fRLGfLNJK4lIE4cvKX0ZEx3dZ/
         yVJ8WliiHte6J3CMW9EXfjt8m97U+AmdPLBIMb3C6cLFjh7uh0wniUcgORnSPv+BxE7C
         N0hYk9Uk4OEmjyj6Ynl1WCBO7KK64w1MUXzjaLHm+IU51e8GvgKTkBmiP4xkU9Fj1r+d
         NjLQ==
X-Gm-Message-State: AOJu0YyhjeSN5AoPBpjDXhgi89NxFjLLOkr+ZKjyjDA4nvCf2pBUdwyR
	q35HB1p6a3KGX4yxtTnVuyl8kjzURQMcFbOejbcDRWGk8KdR/PjvmMORQbjfKjhXos7zf+tlWE9
	1
X-Google-Smtp-Source: AGHT+IHhiLOep9HKr6QApb5ZkWdF+pH2BWzflfokhHVcoOzgRoaw9drv4AdDqTubEYaT3m4/TWH8Xg==
X-Received: by 2002:a25:8204:0:b0:e11:7ecc:3b0b with SMTP id 3f1490d57ef6-e1180f45d93mr1121089276.14.1723755695560;
        Thu, 15 Aug 2024 14:01:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1171e3ff58sm451727276.18.2024.08.15.14.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:01:35 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:01:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/13] pack-bitmap.c: teach `show_objects_for_type()` about
 incremental MIDXs
Message-ID: <b7eae5dc616f8aa93a304b6fdbfe20b8fa576d48.1723755667.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723755667.git.me@ttaylorr.com>

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 88623d9e06..f91ab1b572 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1631,7 +1631,7 @@ static void show_objects_for_type(
 				nth_midxed_object_oid(&oid, m, index_pos);
 
 				pack_id = nth_midxed_pack_int_id(m, index_pos);
-				pack = bitmap_git->midx->packs[pack_id];
+				pack = nth_midxed_pack(bitmap_git->midx, pack_id);
 			} else {
 				index_pos = pack_pos_to_index(bitmap_git->pack, pos + offset);
 				ofs = pack_pos_to_offset(bitmap_git->pack, pos + offset);
-- 
2.46.0.86.ge766d390f0.dirty

