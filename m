Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38813469E0
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 23:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783641018; cv=pass; b=dZi4u6SxqfKzqCuw1u0e7Ea3r2nFIwj+YP881M0eztYQ8V2x4ahIWcV4sLRxi+WDqvt1RsbIGgJzm7sT3cYuYyRjKfUDh9MR4+d8pI4Vc5xicymDVdAv88eCerEcyp0AGCOqmOTLWEnQFSL3mcTJjY959lB1CfQhVhaXaOvkjp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783641018; c=relaxed/simple;
	bh=HqTeKGrdatTFu5fxB09DUHhoqsyIAGSfR4W3M0fVp2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1o5eAt+My/JeAVkOPrpxINOiWQ/Se8GKy3g1tQZikqBy3Scl/bfOExspNcbAZKh6QY89LUt6u75AUaPKpgrd4XCjLX4a0Fy68paIVhhtOIrvIYrbJMX74zkeA2cfngWsp6vBJc9gCHoTfGeLjLLzys/ipRJBIlUR2If1o271xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObN+C90Q; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObN+C90Q"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so63592866b.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 16:50:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783641015; cv=none;
        d=google.com; s=arc-20260327;
        b=n1E2M2txGqPOlb7VzLftM4eIEu5OXx/9TZok2pTAisrGAq8m11YhdtjhsqQEyYHl4g
         7MTd1qAjyRRCX6DkFvLgfqO5XyjVPdqn+kjRyCp3fn5zGTV2LYZCoy5/rAQiR2kFYcsy
         a3Th/qoKoxRpGjfZ0esjNrZOV7Db6bFriHBeXjaqkWzy/THk9XNWkwZxlQW+uS6xhaSF
         pWgoT/0UiTO6Z3YnYSg3RcwCLa49SzK+uSFp2coAWxCOWrUws3+YTVQV56Q8dDI9wOXt
         qkYYfy1dLF2Ew7scJ8FfOyGy9RaNVfnq7aumKCkqWXI54L34WGNP65A/Soa1mJOgJWGg
         Y/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HqTeKGrdatTFu5fxB09DUHhoqsyIAGSfR4W3M0fVp2c=;
        fh=yV/jxDZzpIy5agIW46vnDN8kRFrxwmFVXBiYUaq6iFE=;
        b=go1YW7lodYnIsrGDj2mz4RftVBcM104+ZDfzQQVfgJoIntemjfl2gKPtuwLkl3rpmi
         uOUvTBDNzWoXdHt9UDmpRriiwE7n06e+89dffU9HJQBi8/HzXCRhGR5CJcaSMQs1pa8Z
         GN3L6PS7WPa4CHB+kSgW+pjCFFAV4I1FIO/42d3xKS7cgAQXEB/ZLvhEll65Ys5ybWlK
         wJXJjIsQosywCAc5uc9eJb4T4T1EPmPNS0ABvD7KGVq+2fcB4HvldgfYXwISiMPaCiCv
         PuO7rLwGQSHYgX3OVma4VjfbrCtbbRMJMN4qA86qJzxbE6JCywD91oAu5wW78DLxdbMW
         9gQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783641015; x=1784245815; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqTeKGrdatTFu5fxB09DUHhoqsyIAGSfR4W3M0fVp2c=;
        b=ObN+C90QwVcL6HBTNaZ3gP55tPKmRQLvsh8VZHTZElP5H1Ybs5jbreucyQrJAx5Mhl
         BiZI8UgD65wMzrz2fu4IFgWmVPyn2E2q1FBEfjIogGTKYqmt3msyZl7NYJx7HXw6sGEL
         gA/BYWWy6do1wFQ5tt0T/SsMe8VZAlASZQf3KiHb9fNDvvNW9XxXVehITIwzz4R1ASwr
         Jt8gVwv/X23yzsjSDuWc0Ixq4zeSgxDowDyfnfpyk6wqDuZQzKCpY8LERBi7Izd2i9/0
         YYhM8AvApYccGjztQIISpfpQ0Mz/mJTP3UcIfoPIT1OOlrcHZyvg0dlE59dHbgmXWUex
         t5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783641015; x=1784245815;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HqTeKGrdatTFu5fxB09DUHhoqsyIAGSfR4W3M0fVp2c=;
        b=nFu2/uLktNnQ+/CsvS+/YAbOmTsL90f6lfvXl4KDYC2IMCKdGmImg/TNsAfEIgjxjX
         x1g7Wsumixxhe6nSy+IB+ezymf+fzn1oZR+41qifCzVbPC7PJGG2JSU1eiA6nO7wpSwV
         VotB8NBXZYkGANpywnwJpFTpMZvHtVmrQFZ6E+klBGnU1cbzPEgZ0zoFmw1xDPlrPonF
         p7N7ox9DpmPIo+uy74BlG9xWl1fte0+upBbPmi5sl5n75OD2PpOjkXmODJ4lyAWAafc2
         WuDqBQf2h84EQninbBFeje1vfH28Fxc/4xIvRi/ovjXLaQz2Yg4FhxTwkGw7ieFOj6kO
         fS8g==
X-Gm-Message-State: AOJu0Yxvg2pyNGR9hUN1vCttP+0d0b4L5ZvjTKqB72LRia1uVx+pczmC
	qXRQayNQihDklu/PAE8APwGYVOQ5JqC/DK/TMLupg/fAXFUpOvFSuj1hnWp9aN0CrwGs2UatyC5
	M8pQaoMKilaYYnM+leTrbr2/gw96WYO1uMks8FKU=
X-Gm-Gg: AfdE7cn3kx7CtqMRrkx3vWly3nG/C9fm3owB/zM7g02TJE+a76iQBR3smCkahIg6D7r
	bGD6hKRSSzw8SEPVnyuEwvPhvYF669fCQhebHKqy9asZUYbYEtCaqqPq9YnAW9eciVjkmHgQ3O1
	AGj4PQyHU+g6hlp6lH/Iu7bZjFsB15t7OzHUJvQp8ZVBSw+28Rk5GqQiplrfbnMVVCIwaIvp7k3
	6SSDnMQrYVMPQc+Iyt+An6a2nsEwW0FVTPlEHYl18cPpzRjFZnUf8sar1rewwQd1bzRQlRgey7i
	DNzATPQfxZgRpalXj/LeJBCU8fuv
X-Received: by 2002:a17:907:934b:b0:c12:1c9a:48a3 with SMTP id
 a640c23a62f3a-c15cdecf452mr379952266b.22.1783641015056; Thu, 09 Jul 2026
 16:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625194330.3711-1-graysontinker@gmail.com>
In-Reply-To: <20260625194330.3711-1-graysontinker@gmail.com>
From: Grayson Tinker <graysontinker@gmail.com>
Date: Thu, 9 Jul 2026 16:50:04 -0700
X-Gm-Features: AVVi8CfyMrz_VqZfZwiEft6FOCwpJVvs3DT-lsIXUTeyLbeuPH_HEwVRSRbV7-I
Message-ID: <CAAr3fC2BRQ-pesXuQbNz6avBBbBOUSTtBQ8uRFX6AELszzH=Ug@mail.gmail.com>
Subject: Re: [PATCH] gpg-interface: still print ssh signatures when allowed
 signers file is not set
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Fabian Stelzer <fs@gigacodes.de>, Jeff King <peff@peff.net>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"

Friendly ping on this :)
