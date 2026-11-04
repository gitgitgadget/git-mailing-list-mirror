Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752773;
	b=AKTGJiYlOZ7CyaTbWYpl13JGp3DPmKLWtYmZiwFEQpwg/kwr3DFsoPAPWAPxogOs9f90
	 23aEsc1erjV7nrmsfGQuwGxFRlVEcFpQK6B8Xxs3WIriYOWkL6FUTwjZQTGFb1Br2nmtD
	 kOz6A11CkZTfMLuOl5zeGJc3uDQ5qjIFbFhAGqG12xS6ol9NDW0ytKEVCYW0E+9kkCE6f
	 wKo5WxdVbF0IVsoF+TLvvalNJVir9d0MwTZNQ0HWSXIUervlzq15uzaP6mM6GQE0Kif8X
	 FVgEb/PFatmtI6+zLYfqAp0sPEXH5taoQY8y/DB09RZGgZVUKb05rQU+PU6JFIo5EYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:X-PGP-Key;
	bh=rqC1gwrqIWhZ9RcVrl4O4IQhFo/mv+lipU+KUMXYTSg=;
	b=258kzYIwvyTixF6hThLLisynVYzTqXbv/ApOkMKv2Uh3udD42R/2tuZOZDt7pEmVMKDJ
	 yA3b0vKlqhYH1JshKGUYgGa2/dpA0ytmYxyf16SWsENUv/C7Q8To44OrWifV5Rwv6Cugl
	 M0qsQ6pr3TbNwGvhMnSoAAy0qhEFpYdPm4F1UFMW6mgqXn66ubvtHd+Sm2oOI0p5UEw5A
	 lNU6b3KOiSITE7ERCMSDAXaQ7SVtRM9hj1DhMgHBeBu33cd3mGirENhvWcQ5uOfrm79PE
	 dyMOyBRlVVmZyLwDFNlZlWqDcSn3mq+utqVyd6DZjFusnkodxiMrl+rTKM1tX8PA1UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tylercipriani.com;
	spf=none smtp.mailfrom=tylercipriani.com;
	dkim=pass header.d=tylercipriani-com.20260707.gappssmtp.com header.i=@tylercipriani-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Q+eSG56Y;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8FC606A332
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 00:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB8FC606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tylercipriani-com.20260707.gappssmtp.com header.i=@tylercipriani-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Q+eSG56Y
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f84a55e31aso95763a34.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 16:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20260707.gappssmtp.com; s=20260707; t=1793752772; x=1794357572; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rqC1gwrqIWhZ9RcVrl4O4IQhFo/mv+lipU+KUMXYTSg=;
        b=Q+eSG56YH0UDMhskWdAHUIIof6RIXm6L4tNKXBFrp01w2mzkOPEtukDyLgCg4Varxc
         iMV4d6BDo+ZDngul5q6iKuvWcncWeyNz1FAkMdJzIpU3q9390s/gB4BDar/z3ISY+Rmy
         cDNtZNFcDRtk0882lJ5VcRNGOGmHWRYCISzUDdVSXdmr/JmsAxIbTljXCJZ2IVDtr31M
         L/UArdEpItJAatalV1Ro8p6eYlswzrW9EqWfmvgVA8Gt+l0T9Cr/Y8NjfUbzcZnxUFrP
         Xj8VnBulBfWWnclR1CYAPx/hMActygPV4FgnIw0OgE15DUCgs2ROxKPp2600RBRmdkh4
         ngxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752772; x=1794357572;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rqC1gwrqIWhZ9RcVrl4O4IQhFo/mv+lipU+KUMXYTSg=;
        b=VQ3B1j4phaD2JkTNm9j9cFM1/tsS18L2GseFgZVSE40ipqKpIKgdfBu7737zCTjwYM
         F7Wt2ZsRs/6eKJIusxJgl9Ed5N8GGZqmZUTa56ohTU/dFXlFMZu0jV1U5L4TC7E/EnK5
         iKH3D4CrA5qfV/a6JLgMQvJYbR58Na2Tg08SD9JrySjL4co6uibtvRHlO6Mak0kC/MOP
         0VgGTv5vmjdTpijq/F+er1njk1sNxP3x1swM12N0gH/NVQlQh2AAjSQJvF5Mp136bcRl
         c/5o36H/yQ2XVnPSW2FmnymKpRfqFMArL4irGI5qWni6vQTi+y0NjT9jYmGFsYm7nPF5
         M/lg==
X-Gm-Message-State: APuU4Z/nFBqMpdnsg5loiPnI2LDyJk3myw+rAhamir3jpXHpBpSPa8dy
	aeq770w4DlxbuIUL5UZFRLG9lKtNiD/aiWlMTBIlEIV9Q7HwrTBw0PrOGLRdRjKnMCA=
X-Gm-Gg: AYBFou3FvWi6HL/2SyjqwbotokvDbeaPJ4wy+SdSaWWSyfCmU4yYcn1lIRQzd5+0XyO
	cvYJDEpbUGZv/gWhIKdt4JZSqPWrZQZYFMSUhG+8P3aGuKoF+pgl6WI3vPeUjjWYI9ShA/STPTr
	PkFusfUuu18ICsrjB4ibTKR8G4Vc21EpBsyuxUmDXuskjACzlvqecXIXnJ2aoLV64jbZJuTVHbB
	cEp6pjB4bWevTNavtAJMMHRLH3N3hji6fdisKrOPRV+gW0T+qJmB4F/JsTfBX2Qffg7nNC8odrr
	OQfyi0kEb50BKjiP3D17BUZw47VUsD6gjEcYHlq4apZLliI4hLKWCGyL9k22zerizLu7nx1mM5u
	3ByjTeLT8M9u9W2GSaDexeYYHZ3u7XwMNUi5r84n5gKEozBykFh9Wo+KWI7BCtB/1enHZQKxgZg
	AnSPJrNTIdlMlYXXQpsUKlZH0wcitLHxXj3HrZ+oRKsnwHHyf1VF+ndC5iMRG9O0WyaMN72lDBI
	ftsQH9u/RpV2c1O0w75uMCcXk9rOCNgJpoawNxXyxD/helB31PxPYzFxCCh3urqv5GAgIojyTFC
	jDamYKfZ0l2WxftBXieDi1Dx6ojVxw==
X-Received: by 2002:a05:6830:25d1:b0:803:c56c:2b1a with SMTP id 46e09a7af769-85d3661f69fmr10413488a34.26.1793752771809;
        Tue, 03 Nov 2026 16:39:31 -0800 (PST)
Received: from localhost ([161.97.204.248])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-85ef3e74f50sm638532a34.21.2026.11.03.16.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:39:31 -0800 (PST)
Date: Tue, 3 Nov 2026 17:39:29 -0700
From: Tyler Cipriani <tyler@tylercipriani.com>
To: Patrick =?utf-8?Q?Pero=C5=A1a?= <pa3ck.perosa@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] push: bare --force-with-lease ignored on remote groups
Message-ID: <aup-warMD9DDAgBs@localhost.localdomain>
References: <CAByu3etmpxF+zNqDQ0VJ5DZs_qxdnvQxxmeaMcGRGf36+8Oqww@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAByu3etmpxF+zNqDQ0VJ5DZs_qxdnvQxxmeaMcGRGf36+8Oqww@mail.gmail.com>
X-PGP-Key: https://tylercipriani.com/018FAC02.asc

On 26-11-03 15:56:29, Patrick Peroša wrote:

>Both pushes are rejected as non-fast-forward and the command exits 1:
<snip>

I just pushed a fix for this one as a separate thread[0].

Sorry, meant to push it as a reply in this thread :(

[0]: <https://lore.kernel.org/git/20261104002721.304153-1-tyler@tylercipriani.com/>
