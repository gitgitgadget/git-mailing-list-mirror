Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EDD2907
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 23:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003748; cv=none; b=GYCZyI6BknIMcBqjrZ5q1VpRxyx6vzhZD2SZDb+c7ArkMXJ1lVaoAftC7pM30XojZTHrIE8Y/rueHJB4rhUdhvU01frrf1MJa3T1GwFEhl5BFpYPH2eR3kZncnfqKBhjCexDm7gyjTbg11OX4h5vh5VJ5eVJ1Z2lkyE3uoU1iRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003748; c=relaxed/simple;
	bh=KaQqwV4MYMRVjuUtoSNQVCZtkzqCqZx3/pjzmNwQSiY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Q7IOqHq+upnwp70REsjcFcQB8FP98/tUJMt3L+kShUKJyU13B2wUEj5uarzz3Xp1M20y7qQW/SF3oZb2cLJc9LIj2Ko3/aZ93kyJYzP/NOPfEyek0PM1gZHEjd9Xiq0S9bmeTyZCknAf2lVbvyUho8rGUCHpsmDeqJ2+AQLmnDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBxsQsjB; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBxsQsjB"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b34a78bb6e7so846894a12.3
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 16:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754003746; x=1754608546; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaQqwV4MYMRVjuUtoSNQVCZtkzqCqZx3/pjzmNwQSiY=;
        b=eBxsQsjBKeX72ghwkOzMJB7HxADc02VWyTIE4S1JRxzbXU6aNGKxCjA4iLyxVp1lrc
         +x3cwnT7fn4H4yA5GwBh8cdUOL1Ef2F8ENi+it8W2GQEeQsvtOD3p3Jk4AGEtPHK6Kx9
         /1IfQg5N7h2DNJu3Aa4ThjmMV64/aQs72t6ESNke9TRy3Tz8UMkBDKYHkGqDXdDbJKrq
         ibGyY8WzRFWYAdJX6NfPlpOmO/x2PuHqTlP9MUWWGPAD6Zw2eY6/g4hSaTWGC0CMraPQ
         SszfWsUKywbeMdYB+b5WA8dBJDji+VC8NO2kKYnBkhJnduh/bl4aHrWNBlPynoZopdj5
         t6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754003746; x=1754608546;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaQqwV4MYMRVjuUtoSNQVCZtkzqCqZx3/pjzmNwQSiY=;
        b=vJjgnwHGwwwj+vS3d3GQDYrq4krSOE5jlgkPkdgZDfFXVp5pgeo/BOU3hWe9TqCW8H
         wp1rvnvsBZHiBd/NIfHVH5gNhL3z6wbhJ60rFIS8E4DUsMd0siUj0REuxZ3j4S14sjK2
         47TOGIuDwZ44LIq3CWjrSpzq7A/r4H0mijtMGUiFM+OhoR2g/jeZaGq4Bz3oNpQTAfAp
         3VElr0vR2jnuOz/VhFeRstHHlF68uKHQpxNfDT3ifHwIEY+1dJGgAemMZrArkBunfyXi
         849A0SWJHh1KXWN20pUUM2nReRXWEkvSz1mi68tRpneIa5WSegMi9dLiIB4fgjkyEqll
         GzbQ==
X-Gm-Message-State: AOJu0YzFpUVnycnTc6OTVMqf3J+8TeTc0C4g7CZgUTdB/+kwQJXjJ30G
	Be4jbT8mnfB5f1Gxch4pcU7pFT5Dwz69+qWlxwc8UkyxCxkjji3Y26i7qsLiFw==
X-Gm-Gg: ASbGnctyjQGboRW6hG9HuEChH/23z/Rs4Hk1aTyiVAMFUFgjRSKgw2Xz+5qYHBC8AHQ
	k3+PtFdHjzRHtxHlkvcxpQT4qtoLNshYJAGhtijQhNj3j4FuK//6myHwXLA6lJIYyDblGEAEZCA
	SiDkVP/lay7d9b2J9ZY2OMLwMjV/TkFqtUHdNeeKAWV/oLRkqBfWnUg1eFMs/MYsJrMRORKbb81
	yJwWFj2lZRYsGNfmvWwLKHSiQP2t01opQs1wrb3n+iwXQgriCmY7U2qK0eGCnSrx+yGiXX0c1VJ
	rji4BxAf63B2/HhJn259FRqAeNIvaDAzaEPpHVe+STD3/cpgbviEIrg2PjwoEOCCE5PPtrhCc+c
	PKnjrkJcVyVWUzmpZ3uPMdtYEtOV4E3Wg1lUxZ3lYllVhfWjQ2p7AAq4=
X-Google-Smtp-Source: AGHT+IFZJBNc1S859iMBxBQ72PkKw4/D2mAL/iTNGB79zRejHagvSQEqNsemj4yK2PYLeTy/OKv3/A==
X-Received: by 2002:a17:903:2305:b0:240:86b2:aeb6 with SMTP id d9443c01a7336-2422a699bebmr6216155ad.26.1754003746569;
        Thu, 31 Jul 2025 16:15:46 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8c1d:9856:3844:bdd1:13d4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a11sm27712135ad.86.2025.07.31.16.15.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jul 2025 16:15:46 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC PATCH v5 5/5] repo: add the --format flag
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20250727175110.84770-6-lucasseikioshiro@gmail.com>
Date: Thu, 31 Jul 2025 20:15:31 -0300
Cc: oswald.buddenhagen@gmx.de,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 jltobler@gmail.com,
 jn.avila@free.fr
Content-Transfer-Encoding: 7bit
Message-Id: <D915C846-5DF8-4C1B-AD37-D825A1AA26A6@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-1-lucasseikioshiro@gmail.com>
 <20250727175110.84770-6-lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> + const char *const repo_info_usage[] = {
> + "git repo info [<key>...]",

Reviewing myself: I missed the `--format` flag here.
