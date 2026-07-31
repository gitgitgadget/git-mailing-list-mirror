Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E263403E1
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527401; cv=none; b=CcAjp18OeuTU8vMbnORbW9XHC3sU3JWnku4K1rE/S682xGH52a/UsaeCvI3vPR2fZjW/RCH0XqK8u6jbp9pRonl4PxmTU0GmosHgVgrseglvmqIeFkxZrH0MypI2M6fXyTVA9KQKZMl5NwU2CQK8I8VYY21YTrwOFjYONyAYsu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527401; c=relaxed/simple;
	bh=Fn85wLwBsaZ+rv1pvBzTNVmAPxMPMBJ1lk85WglkUOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sHUOs5watpOuzDzksWOrlg0pyiNm57IHjZjKgy0sOJmqO/6IYo13iKt9RYe4ZnlDuZ4k/sNoUjzYFqCi0gZetSMK/bG7Cbp5c/t9goINKM3q98z8aeGdoTSKjZU5NGH9kEKvTNUyYiEZrmbe+HSkbBieMAJokHdH7URHhBqTbB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAV7geSN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAV7geSN"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so1795395f8f.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785527398; x=1786132198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F/Nstck1LOLiL39xqf5bbL3YvKb8rZnnK09V2ITF9Wg=;
        b=iAV7geSNsemQTpLjNcYRMmI06UGVH8lsWNS96Xl3bcZ4r7QiaeTFA0t3Kah+f2NbqO
         EgREhpk54bMw4S0Vd2DvMuTYceROslNQAU5320tAhiC9LzoYiHYcfE4/PGllskFILtGz
         mz4gpX/Rq1vs1TD7s+q4nkkIaK8uZvzZ/Own4OoMsXRUXjlVFI+jr9e1oEDyiVuy2ffb
         Hr1YvML3AsFBf2IObnardqE09UyDyODLBMHLHHRv/1mAq40Dp92vx5S1R5DBFfnZ2I8b
         98lN1FLyL+8WJ2byDx2ONXuewX9gjuGEWRyQ4GOOPRhofQtlmorrm0o3wZNedq6bCExf
         etrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527398; x=1786132198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F/Nstck1LOLiL39xqf5bbL3YvKb8rZnnK09V2ITF9Wg=;
        b=o6+Y2ou42x6mHYbdrpifvRIA4SlldLXWT1pllZTCt1EqDg8tdnkemRn+gSCd6eLGZ9
         NkUWj5bY41TR9+z10Y8YTGFMDVefuWW3swJL0a7DNq2xIssG3DvRlyUzE+N39++iRyCY
         blLx7G2Q7T+xhqjQWVf4s3bo8iTihA+Mp5fQXHJbXfNCC4vJChytpmr5JBYHh/WyOwDF
         3IV5kBWgo+fEaLr1i2NXB3zOAQkhq13s25+EtcdN/zDVznuCAWND/+Wf6BzepVbKjdK6
         J+pe4nQsXyiCw6MKclN7WVXZB2E5rnII1VLtzHSGq6u8YP/jifQZX9aAZHeqJA0KcDSD
         +Nug==
X-Gm-Message-State: AOJu0Yzj640qfI4qYQL8E8ZdZ+bzyJCtvnlhr7r2G9skXhHf2Rn7w1e2
	ri7InECahZW4hSe4ZolFeTqv/efvGNr2nPiktt2CBdRMxTE6NNc+5xg/
X-Gm-Gg: AR+sD11PfbKd8KDNeFwV5CmpRSKpJwWfqhRW7lCXBFqLI60+mF3+Delgow7XL7lJIUe
	Uz+6EbzcNj0XMR2K0JF9DkooKTVRuvE17fqpRhkJN8s4KS5qbxI0Pt92TiovZ615HbrLeJ11eUe
	xLC5/Xs8NJEB6+jPCs1RIRXstAusVzI90kA5v2FQt6xDkyTtsPR6Z5N55Jf4ikUoF/SZ0KZ8MyZ
	fT+zhv24ZTdRUbbrqynMsoGixSFPMQBwZALrPKk/bEbIQYK7NWtX2+yN8hEM37rof8WM/Dyci4x
	rPR5QOI7sKR9utrTs6nt+2HSRyo2DmiJrnhQ83CuzUryVYQSAirPsaDmVUyI1+dZkcHxlOpno2F
	c3rtsJvRI1D9aKo4NCYtehbJ7r/lYx6QQ0iw02+DI16DEoVdKStYNM4fXKTtm3cTRXvP2kL5xEp
	mnDSCDDcGkU4XfLJSAL1/ps6zftDiuirhQOsLGVV2iHZ2eQGUD62vKA6bdpixXJZMOsBkWfWQfV
	dq3ULityS9Q4KAjmCC5x+4nGHBOKFTtBM9EVApp1ir9b/Ap5hVSSS1+vNv8dOjFgcd5FJIWZEov
	5PIjf5DogYKW3vb6XRN0D7N7i4z3mGmG+WA5RGc9K1/ptr6CV8XRSZZRQjUaE4T/FK4p6+TbLqa
	Q5UZMYZzbVmzh1H68vRbkwqnNh3dmWLp2DoFn4gMuEdBv0btP6x/y5zAHkfEXL7lPWziEmm+Wsa
	b0UXP5mMfQStQzGzSM6A==
X-Received: by 2002:a05:6000:491d:b0:47f:93fc:2d27 with SMTP id ffacd0b85a97d-47fd72f08f6mr1750220f8f.30.1785527398162;
        Fri, 31 Jul 2026 12:49:58 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2cf1sm8248568f8f.10.2026.07.31.12.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:49:57 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Fri, 31 Jul 2026 21:49:35 +0200
Subject: [PATCH GSoC v2 2/6] t5701: use the test_file_size() helper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-objecttype-support-v2-2-af577461ed57@gmail.com>
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
In-Reply-To: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

An object-info test uses 'wc -c <two.t | xargs' to get the file size.
Update it to use the test_file_size() helper instead.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/t5701-git-serve.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 9a575aa098..b4d6beef11 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -356,8 +356,8 @@ test_expect_success 'basics of object-info' '
 
 	cat >expect <<-EOF &&
 	size
-	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
-	$(git rev-parse two:two.t) $(wc -c <two.t | xargs)
+	$(git rev-parse two:two.t) $(test_file_size two.t)
+	$(git rev-parse two:two.t) $(test_file_size two.t)
 	0000
 	EOF
 

-- 
2.54.0

