Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191153;
	b=JckkDpxt4g2bf1yf/T68E8z38t+eHXpsAAEQNkPpHnAl48kZdFpE0HrtZM4MUFJWdZ1q
	 yGfPFSrfFewBjBL09SlbGfr9WzCvs+92viRsY7LkUPL2gq32oZMAA6NxtM8MpbSIpOQnB
	 Hb5jyhu9FnojNqUQ1PgUwawmV3Qi2FFNTJHd5iAtEhe7nDHdc6RtUf2HNwRurgHmvNXG2
	 Tgd8Qg2SCiz6MJ1sIx72qRtaXtBEto9l4slwnk/7qZvWYosaK3yYJ6eqCpObfKcFhZAK/
	 j5oClNKmfeM/dMfkvNnkgHPJrv/GSlJ737dQhy2lidLXc9F1h7MyDoj91/EGAThpOKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rD/XNSmRVvHa73iEerkLW1s3YrtSlV2IPjXdgBIe6YU=;
	b=g9lyWw+yWyAuTAxNQhf4LG5ba9odixlWxTO+WXINAkJGyZVBCfWhZ23mRV8XidcIe31a
	 2wLX4iZPgynen0kPTtWPLLcn5/09/JoJmecexGahjnsMX6Xxow+vBW7K2n0WmgACi0tP1
	 NVy889+lmC/Lp2mdNhvV4BMktpRyAhCgwOi3iJ6ZoWLbhgYUJnz50I6BrVeROoVDLFVjd
	 qRFmuuDKlOyYXIL7lXDaEwGS3mbPLVdp+E08N52FU9rJOLMYBjoX49MYWmrgDYRb8uvcc
	 +uVmkGRIrpHNLxdvnxrJ2+7/a0hdVB7mszIWotT/q+OIZI1wnyzlR5zXIK1E4gQcrVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qZYOEV0L;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8640606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 16:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8640606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qZYOEV0L
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f04bea9a93so6277255ad.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 08:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795191152; x=1795795952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rD/XNSmRVvHa73iEerkLW1s3YrtSlV2IPjXdgBIe6YU=;
        b=qZYOEV0Lb9D8hIfOub3XfNGoRhlZgOWeERKgtUKnJLf2eJQVshZQDHdWv2nuy4qeDp
         SunWteSpRcJ0HG+zFQhEcBLv80Q0qauy0a7k1g+pcofWOLVCRPH7iyWyf+m+OCm/c4UK
         Qv+orEc1no8fZRzR6c2qKv6mCQNpzXa+l0sQxi4g0cb2s+jiJ2jJC6iwTNKJbalRF/0Q
         1bdlatfBFJfHaCL1UUIHOaemRto3VG7cTFDO9oWJrDqhzkgM8ULJmGOevgGRlf6lLZzl
         GTQsK/OuEnTBj3juGJDbGhaJQwXDV5+CbKwzPWRYXkf0ybt0LIw9q9lSfOKEyE0TEJDd
         bagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795191152; x=1795795952;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rD/XNSmRVvHa73iEerkLW1s3YrtSlV2IPjXdgBIe6YU=;
        b=EGttnm+7FyzATG54K0dVlXYDolXg0uVkdDLJA32Y8FlJQTodac16AiEJW3nGkLE7Pv
         jmRjTxk1w9OQfQiF5G4gAs3ymcLyKbCgc+zu1sQkc3qw3CmlU0RDUG0YaK9iAKhnWGrX
         Z/jUhmwS4dG2TvvxS++lijfluQf1OsVopWkpg2+zGHa+Q/EXAshLbzj3qlUem0YC+WUt
         RsGiMgdLt4s97EbGMDh0wUJKDN0PVjZnvfJlx+MTldkdFEahz5Nl7TCeQsONC0pRd9bY
         EhEjrsuKkiz6B+LGtn/oFXdu5S9cwhC+SXSu2Rtmm02T8ktDSau2nTC1IpKCLFH5AmOo
         Trsg==
X-Forwarded-Encrypted: i=1; AL+hErGga1OKlsGjoQ7GXQMnjdczOezuTJp4rIZifMs0Yf+nMomFuk2/Zv1Sk9+z8rlIdEa/UJk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lGEJLX9qIsoWy5M8oOhPAi3Xv1cRvnBM0y4EjwMbBXMGsuj2s
	N99BgZ31GtRjyNgQo21oT9Dnx9coKoSEOKICXZ9qy/k9aprGVcO7YA3c
X-Gm-Gg: AZFdTZeup2e2B1Ao37dUgnKeYdKUnZjx0GP/vtguVPygOgvGb4Y773m0mskFdFK3gfu
	4lkv9n+Ed0y6KF45cnZUJc6PCTRvcTKhqYgzh/w1gXVq6GffR7QHlv87FKrcE/wKb3gifbXqEs+
	prvJwSHDF1RlCMT2KMUwFyBOTO98ox7QEKtnAF9SD0BiGfEmSiuM8GgJgQf/l/6GQc3/c219aOL
	uFPgG/zx5KSyfwPdwFi6DeFDKyvm8xEZNtR/8E82bvkeT77kGySyPCUu9WKPwIFhRqCd+VmCKh/
	ptb6KJE63Fb435wUis8fcQuy5FJWH9HT4KJgFYVkovTTWoIomnWtda1CQSpJ8mvJ7ZYIwH+Oe29
	jpw1llU/qI5Tg0a5CaTjnLUuRSkQ2AI5K+IrHyM7O95VjMlqPkBaZ7lyXPxT5NsK8ifhwaL49as
	iQv1EC5ZXw2Jy9VW7AvuL9BMWZ9FeuwX/b96pJU3AQL+Q0vTiID4IUbDr4oFBxA/4JKn4NHMQw2
	St326dlh/aMF5W0LnVzLXkgmPENTT3N7HZ76/gabBSKftEHscmGoA39GWNSNVaL+nvCTTxbyzio
	JD+21efx/DYfgTUhmpU4klTwJodq0EFfSHAw6fQV6wjJKlodHhIJsqRfL53zXIaomXtE27tKPaP
	t/U1TcJUI91/WKP/hItMY
X-Received: by 2002:a17:902:e551:b0:2ef:ee74:792 with SMTP id d9443c01a7336-2f03f232b03mr42053195ad.41.1795191152088;
        Fri, 20 Nov 2026 08:12:32 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0fdb1fsm16263025ad.42.2026.11.20.08.12.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 08:12:31 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: l.s.r@web.de
Cc: m@sph3r3.com,
	git@vger.kernel.org
Subject: Re: [BUG] ZIP timestamp conversion and strict fast-import date validation
Date: Fri, 20 Nov 2026 21:42:27 +0530
Message-ID: <20261120161227.58989-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <f8dc40a4-920d-4dc5-9f71-7686bfc6255b@web.de>
References: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com> <f8dc40a4-920d-4dc5-9f71-7686bfc6255b@web.de>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi René,

> The latter function contains two NEEDSWORK
> comments about perhaps adding more checks, though.

It seems nobody is onto this and I would like to take this part. I will send a patch so that plain "raw" rejects dates that fsck rejects and leave "raw-permissive" alone.

Thanks,
Aniket
