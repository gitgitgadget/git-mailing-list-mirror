Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042912;
	b=ts8kjGnlDyHjFYCFRlQdDGcelfjR3W+FunseCXX6KZv2sPJnVaEIGAT1c9mPAPpZ1Dge
	 8Sf3tj/I8ddIljdWkDjpViIOxEGy22q/6B3EfXTzNwAOdO89zUSIR3LUIF+vtpfTetWxX
	 UkNAnOZ7i5VPCOa47Kk2TDJ6NHtPPHl8PvoZHeUTwod+I9b0+vOfwiTl7AN4aUIEZn6sp
	 178lahSDHGZw78ExuwlmsO3TvBtq9cBEcKVl+0BlIbqtxOqKWAo/TuhzcbW7LkK23jcj0
	 V1rjsyfWLxQCGHiJWBSRrWmsY5aQgP3ZA1CFb6+goCvsgXUJhamVfZwbQgDML1GMVIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vJtnPA0ktwlXolNKVa82Yg08eibDBlRQRi9mv3IBt3I=;
	b=2/ZnEnIvXnblI+Z8ab2Atcxug/8E6v8crHhWUn5ihyBqgKgQBJoS6ewCg6pPjTAQ9EfV
	 UqXY4IfcP1TTc/KSQIMWyhMFKxomNBY9eLfPEJAu1aZH1cgYgQCX082NAe/gilbyKuC4y
	 5tBMlQ+ZhP85YHiXeWVmjUinIdkiruLsxdhWPKYRSxk/W6Mh6Mn0bD6TQmm5/uLXJ0ui7
	 /Rk4FK/rFBuRmj+7TUYKYpQzhyn1XfAL7VeGc29pxi4W86IA0aELedYG64q0ljTC6WgGQ
	 9gsN7sgRYfEE3gkQuG+Mg4PJsQY82TO3nODUAI6oZSDFHafWwYIZf4/2aJnW6poUYUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NYro4aAt;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA81C606A31E
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 19:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA81C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NYro4aAt
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso2191992f8f.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793042910; x=1793647710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vJtnPA0ktwlXolNKVa82Yg08eibDBlRQRi9mv3IBt3I=;
        b=NYro4aAtrWPLBN8K+CVUJvTmBxtELS93WMr7OMB0VUzwRfTAbs7MDvQIm0kjgaaX3h
         /gwS/9RETQfC9tIol7rla5dKvSLvwoJVeQwYNbQnwR6ZkVstQ3+6jqfibtud1C4dg8JE
         7ikyt4tYF4ui35LlX2zjuOUJsZwdGH5YWNBQJsZMNFZz7HdspWPCA15UODXa3NGVFBd9
         D8RTES6xDUorSW4x685RGhMkY7GtbQCF1gIGvYqtxUdXw9Ft8xY6/Kt1J69FxzsCvTEC
         4wI0YTAthyEBtKNwRLNon0jntM7gxK4U+iqm7y78vywvhb+LdpmHJse97NQI+BuRju4k
         t4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793042910; x=1793647710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vJtnPA0ktwlXolNKVa82Yg08eibDBlRQRi9mv3IBt3I=;
        b=xAYX81/MMLfkqjbLrprATUeSv8AcehlT77ZuYNrz7UA6BV70a/SvGUW7c9M/MW2sYT
         aJhlbj+pB7G55+UM6cOQil3+gk5Qkz+YROrdhEDu238V5Wc20lHECydGGby53tTL5zs5
         6+xAelVj7K/l8kuqluH08P3df+yTG/ZJNbEekap0xEVw6LatICLdJo4eIxN+Z76/j789
         F7GiP0fYgsMBajeM3qQ3R2CPoXhXbEolzb3p+T0yn7tozd+Yc0eWB5/FgmCT0060F3Ri
         brVjo89qFzAb0ORrgfh9EhpCotnVVLe1um1Aln9Kwm1t8kc4vs8bDPwtlqJkye0MPVMx
         06BA==
X-Forwarded-Encrypted: i=1; AKwUvBwXvbyl91qf/MMap2cdpu0/iG5IBQxP+jOsb0O9/7BdPvw7/6S0x2DPM4EoRtYtp3RyECo=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+TUgHqsW277p1mId0p1eFvXZh+C6C7wU4m47cDMUZ7pDl6405
	D1QjMmy56ztP3Ga1xV4v60K4iUK3ghxdynaF/9yHMNv3aZ/w9/RoyX+x
X-Gm-Gg: AYBFou3ekOth7V+iH77B9FRdxeL5t5Mh5Na1QHV+cXcIubP5p9XuIeiwIaSyXHqkyzd
	b+Ho8dEk1z8eSfH2cKFlSfYK2MTArZELkiEVEivABhBNvZVqwisBoRUMDJsBZTyF/HIaLzGtsyr
	27+td6JnTtrUcYIjEXR+TsuppTjzxTIqU8ZVXc/8eWXytaSrXOD4CQsGq4hFXuh+dtOm/vhsefS
	rEtDu3L2WbCxhiJEuee///6h7EiraZhYlXkFKF3DnDlrw0gKZAELaH/tRbgxr1VcLiMbvS6M5+B
	CF3yjJZy3qyWfB5Lmt8NvvVm8cdMDR4xyNBuu8piwZufyo3LFD2PFj2TNwCA710awZZzlHEiyvp
	My25O+c9Y1QYRddt1D804bZc35jvK+fIs54wJPj4R6QBsd5O4xCh0w/rSHpT25LCak+iMXSGcD4
	UzF8/P083uOHfPUwaj/zBivfwj75xjnj6bgAS6PoZZQwk7n0USdCTwhEULI67ucj34gDCRaxRxw
	OfbsQtPih2BNcN7IABGV6cTmyfZk8333kgjA4qmvHbTFaU8xG8VB84iVX++/H/ks1Ol1wGf21cW
	khXT
X-Received: by 2002:a05:6000:29c6:b0:48d:f541:a6e7 with SMTP id ffacd0b85a97d-48e3eb9943amr10384137f8f.40.1793042909929;
        Mon, 26 Oct 2026 12:28:29 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3c32sm18519047f8f.47.2026.10.26.12.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:28:28 -0700 (PDT)
From: kerylefondji7@gmail.com
To: gitster@pobox.com
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	git@vger.kernel.org,
	Keryle Fondji <kerylefondji7@gmail.com>
Subject: [PATCH v7 1/1] archive-zip: refactor 'path too long' error message to use Q_()
Date: Mon, 26 Oct 2026 20:28:03 +0100
Message-ID: <20261026192803.1985-2-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026192803.1985-1-kerylefondji7@gmail.com>
References: <xmqotsm8qsdl.fsf@gitster.g>
 <20261026192803.1985-1-kerylefondji7@gmail.com>
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

From: Keryle Fondji <kerylefondji7@gmail.com>

Replace _() with Q_() in the 'path too long' error message. Although
pathlen is always greater than 0xffff when this error is hit, Q_() is
required to support correct translation for languages that require
different plural forms depending on the count.

Signed-off-by: Keryle Fondji <kerylefondji7@gmail.com>
---
 archive-zip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 6f73ca6d58..160efd878f 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -328,8 +328,10 @@ static int write_zip_entry(struct archiver_args *args,
 	}
 
 	if (pathlen > 0xffff) {
-		return error(_("path too long (%d chars, SHA1: %s): %s"),
-				(int)pathlen, oid_to_hex(oid), path);
+		return error(Q_("path too long (%d char, SHA1: %s): %s",
+				"path too long (%d chars, SHA1: %s): %s",
+				pathlen),
+			     (int)pathlen, oid_to_hex(oid), path);
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
-- 
2.53.0

