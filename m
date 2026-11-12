Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794468574;
	b=SrVBCMJm5V/iYoY80U7zRNWR4oby0PKFSK67zDcYMXMwoI8pnj/FoKpjVPmCTC6rODEC
	 JHzHLcPuyvZwZYaRt9M4B+nQqVq38lyLWHMvMFsPSlghagBX6tuZDzCkhZ3XneAQN3cAE
	 1G/eEms8zk8RuO6AZurwak3r/RVieccsN5jtXsVL8qsHGEnWS6QLjaRoLClft2PhdZgZ4
	 cjAoLhxeX6m+gvYbVt9XWV5cQQxZHfNdUvAjB1OTV2z8sPaskO53W/62PkEy5F2ctmK+S
	 BdjOEUNsPojIHya5kS3s87wXiggzha5SxTTFnjuWLSK/oCpeicQe86XdcK/WbYgTcbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rJl9QVExJntYCb/dbxze42QXj4SXIf2EBIDTPdk6Wd0=;
	b=18vklBsWGkpmXxsAfQKPyFFik4EvixDn1atiUco/8oaBt7Jih/XSL1+YQRM0U64nZLhv
	 zmOvNh6ePgdF5gdBkkdIL4HiYdD0b2cVjX6n74mFYYhdBEVkUpH+kcFbAEhTNI8dPGPl+
	 EzLaHeTwUP1FD/27xI52l3BePmISydT3CvO9+GaMa6LpkKpmDK5hrUVXCMEdie2YsxuNY
	 hJfPqWEeqexH7uKlmsItVZLbcOyYrNNB+Y8+GwHWnO6SdrgxjZCFd5bKe6GbqgxbsSDC7
	 sY2leGyzDQ1JW+67qAn0UXi/FW6r8PQNFEke+Eo7uCEIj7csZiDHUi+Fg/tedep5WVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iuf8RNIi;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69453606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 07:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69453606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iuf8RNIi
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so7233948eec.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 23:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794468573; x=1795073373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rJl9QVExJntYCb/dbxze42QXj4SXIf2EBIDTPdk6Wd0=;
        b=iuf8RNIiMe1fc6Cgbc0b8O4nWyjqwBvNdPzzaRE2h2i9CPV0cu7VgZEhCq/4tT2AJS
         5qaEAaf5QuF9i8pCoyPAYGRP8aVbLKKBZfnIi5htn3VsVDK7mWSnhnfH+DRRgasVFWge
         IK5IhnEAjUjEKPUZY4MPfy38LekmnQmegsdg89wEUl5tYr3Mqu3Q91E9RXR1cttyyqm4
         9/zim73JJ0BL+tbQRp287yfYlCGsGUqkz9JhY94ns3qQ8sZXDij0Ne0GeMYb3UM8RR73
         IWs2yag5fBVSerk6DA/V6b53PBHAAJqR2p8RsU1SEiLcTTZQbE6GYkJ+ny1xpc3S4uor
         wOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794468573; x=1795073373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rJl9QVExJntYCb/dbxze42QXj4SXIf2EBIDTPdk6Wd0=;
        b=AmOMgMw/hsN0kA6/eg3pj0cUQQI4lIEsQd0lNWcyIVju81RqOOx3a/j4QUnwOBabSz
         Onqb84VjIcsaqBFHUaxrwzF9KRjulDu5tqrd/N7VqzCBzmQ3CeHwfgrMHPRq319p8exU
         b25cjdeZ35qMkK6lEEitB+YxyPgxYG23IvIo4dAoo5XBp8RSabfzWmyL512ojhYKdly/
         T2gXbUNLbERt1MnOLszkezpj/etejSjpL5jG6Ca4x63niZLgEg/Hkn9Sp/96QSLi1qGg
         H8guzhXQkWgWe5+dLLIPWY5HwjQ2gBM8AAXqSo+eFmGkGwU8sKBEmpps0VK36tNkHKcX
         agLw==
X-Gm-Message-State: APuU4Z9E9FRZWJIp3sbGdBIXAn1xsjyc2jQYaDnMGutj2wRx91QtqSiN
	0GjfLAY2xk5bFG29MLs6uULrJFlxWC2LiWvtp2YY1NtK4pxFix3Gt095
X-Gm-Gg: AYBFou2q76ha+YQdbPE71JNCqE0QpIrVwnlask4zV7q9GbvZSS2g/lJPvVSCUUcm6Wm
	e7XbxwogbFTC2vJBHbD6HoZdzWu/JBirhLelRFp44n/5xJmcBTCV0E+S1TBZc2KecXWThL1x0dA
	OiZNgGE0qNJODvqZzNcvm7ThXU+fKDHSoaaVUgpAEVa9KvS+aTMKONuqvZK5mjTcr+Ca0rJmKCH
	DdF3jKfDdXwLVRJxcFhy2kI/AmGnXQmohvT6VcCjJUONkatyQxfgj22m2Z2N53+TD21kSs7IZUH
	HlYjv0hW/Ry8VwL3INdg2F95Kv4yKsuzYFPKFmmp4R00L7uc11osjVIeS250sNJxsSQIG2yL6Vv
	6zKsU27aocJ8sSQBHZ/j+3nh1ZkvzNwFRuG/mXKCPit2zrSNiBipdP/Bmpx4IJGUuGUvfqecQiG
	CSdTwxjipWiLWAnlRaW6/p90g9YCVvIQYLGBbh3DKDiLNO+kRmx0WZmiG3OVA+HH6H/kBAy02RU
	tn/QqTcApYhLTMs9HQwsno2sGmZVgqhIGzoEU++EmzmqxqPVZGK9u/d5IJl7XAICUJ8cYkUrRyC
	LtDORrXbtcCslJAn2JoECU9DIs8vP12KLfAwOsfCgESiJ4r6/b+BXFUNjgwXwnViW+zPIcOg5FI
	nm+sC6IBZINvRUhe10fhgRcDmGSulevL62g2SyyhKs4loO+mnJOQE+fIzdc9qsETbVeza3psm51
	JqzFhzHfc=
X-Received: by 2002:a05:7300:e915:b0:369:fb01:2eb7 with SMTP id 5a478bee46e88-37685a88c50mr4866590eec.13.1794468573335;
        Wed, 11 Nov 2026 23:29:33 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:88fa:bbbf:d8e4:1ec8:23ae:2224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe3261csm20609659eec.4.2026.11.11.23.29.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 23:29:32 -0800 (PST)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: kongfankaikai <kongfankaikai@foxmail.com>
Cc: git@vger.kernel.org,
	Samuel Bronson <naesten@gmail.com>,
	Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Subject: Re: [BUG] repack --drop-filtered aborts when a filtered blob is referenced by the index
Date: Thu, 12 Nov 2026 12:59:21 +0530
Message-ID: <20261112072921.19170-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <tencent_AC7FF23968DCD0078A6B863A42BCB5ED4E05@qq.com>
References: <tencent_AC7FF23968DCD0078A6B863A42BCB5ED4E05@qq.com>
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

Hi,

On Thu, Nov 12, 2026 at 12:51:07AM +0800, kongfankaikai wrote:
> When a blob selected by the filter for dropping is referenced by the
> current index, Git aborts the entire repack with:
>
> `fatal: cannot drop 'path/to/large-file.bin' (object-id): it is
> referenced by the current index`
>
> This stops other eligible blobs from being dropped, even though those
> blobs are not referenced by the index.

Thanks for the report. This is a known limitation and a fix is already
planned.

Samuel Bronson ran into exactly the same thing on a real llvm-project
clone and sent an RFC patch for it in September:

  https://lore.kernel.org/git/s0vqzjavw8p.fsf@gmail.com/

and I agreed with the direction there:

  https://lore.kernel.org/git/CAGWgyh9B=re06aofii9VFB1xOwEeTtxYE=7T14m9WFAx1ORpMg@mail.gmail.com/

> Is there a specific reason this condition is treated as fatal rather
> than skipping the affected objects?
>
> This behavior would be especially helpful for partial clones with
> large working trees.

No correctness reason. The guard only avoids dropping a blob that the
next command would lazy-fetch right back, so such a blob is never at
risk. Aborting was simply a conservative version of the guard, and as
you and Samuel point out it is a poor trade-off.

The fix is to replace the die() with a warning and drop the remaining
eligible blobs. I am working on this and will post it to the list.

Thanks,
Siddharth 
