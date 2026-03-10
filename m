Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4237C0F5
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168528; cv=pass; b=HPmWbCTZnlxEsrhSapw/f5mtS0QJnlV/q1k+GGSRIBtYyWROFEk8NJddmEu3sJtB427ZHigsMytbTGXcBaxgGmFpTpLCMeBP7ZMClaMDP8gjzsHVdteC0XqRUNZ0NZKIAVW7UofxjJUWrZVjKKip0cZqj/BCoEgd6lIUqOj7eho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168528; c=relaxed/simple;
	bh=43Q69o5iIPXEEXBjpbC8LL+7gIBENBlUrU/9wXehk8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=suX8WOzXmJTT3p3/I8QxqN/fw/2gOqpd2yUIYzhLBPnfi2BzSoMPCVBj1jKhB/sZwF1K3M+9CsmRrFWtTKj86BmViWP8X2w4m0Ux5LqkAlZshk8emVUL0XPM3xahdD5t07Uw9F2uSITz8BS6KYhIhlGQaNuMlCBBlYnEmSi5yIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VF1lm0+J; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF1lm0+J"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-798578e2918so122283797b3.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773168526; cv=none;
        d=google.com; s=arc-20240605;
        b=H7vrYq0u+2+fq39ef+J1uK8yxIMK/xEDibjtsSV/UeWCWZ8s6e0/eJEGBuiELfGTYE
         GtHUNmxM9/53vkI/P1VryAmuMnnFeDD1r2q5S0NaDB2ZeqCqRYk72J7AS87DbVjuFlqE
         yaih7CY+dxtVAu37kyUaZHGigX2GFSejarG3OYpK0wnpcdMxZ9rWdqHuMlgVFS1Lam6I
         OKSTsb5Pe0tv1qlrAht8Z3+UVfHB3USBIn5uDAK3Etu88H8e/efJpZj4SDV6/9IPAuHf
         oAhskTdoVbC3nDdp8ZPhD0rHbY26b0Us75jyy3Q7EuZMciLpS6KlZI9xLVdj5v4SshdS
         N/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=43Q69o5iIPXEEXBjpbC8LL+7gIBENBlUrU/9wXehk8s=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=HlOnMhT8V7yae9p8YaWmWyZRO0qLqWvlFsWYZpxmcPDrIBRZ8OWks0R0UemKBCki1i
         9oVZu4h852z6rB2/THZ55BBmzd0ngBn5zCHpjm96xT2zpxWmFTExcgdpabk2TLnLCe5y
         0S76AUlAA/E0o+QI55ooneX0qGFSJQwoI0h0PSm268P4T4xI1fOU1Jp7SPiR5kt7pz4b
         jSR3Y9qAMP/1rm4O6kKiq3w7NQOvkc6HNWB7nuKM/jZWnpgzVnn2T7U9VnvRZoTAq5/a
         OBj1TVmIkjGuhl6OF0VtuuxHwaxfH1aJdKQW10ffjnIfCYbdjkWEEfBViGml2YYDkOY7
         acLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773168526; x=1773773326; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43Q69o5iIPXEEXBjpbC8LL+7gIBENBlUrU/9wXehk8s=;
        b=VF1lm0+Jv3OBvFiyOSsyMHntqDQJw4b1tQAUxoT2DPyvLFFlb4C46s9j2VP8API1Ls
         iRhxCwLHhZLLqrKknZAKZvi/zA/bjvGhLNwKEJvhr2NwVIoth5K/gegRtqcQx9pfn8Bm
         R6MKUKzK63NbZd8Za1kwnjQZNV5t3RoqM02Mf2sBkY0pXSeF3AVBEQ4puSDLAGQAFF4Z
         +RnLs0/+Tv5m6vt+x4TVVY2zpPFTrSaLPFqd6zrMokQXHYe7XvnisQ/WwCj1B6LbIkN7
         G0wC4dA9ah/SpY3N9dLqD6M65Lg5Cde3KJ9HLajeKZDrWZyOpu1Kik/xzY1FyhC6kDLv
         yl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773168526; x=1773773326;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43Q69o5iIPXEEXBjpbC8LL+7gIBENBlUrU/9wXehk8s=;
        b=BIWTLlLWv0QJPZZLtqkZl55Y4dNOvfLe3JlPA8MmL2z5o+QWSMezlOJsc+DNjxYI9v
         wVhoWgYCxmfI60E8t6tv9x0b5f7xDyuWTF6pgY0Qs//Na47kuWtUAJ2+nPOQ0xS+krUJ
         xGJ5sxT1vqYXfgsbItVJTvc5WCl0P27rTB4/PEiLV3tARgFfhmQlXFZx0cw3H/xoavwX
         rgLGK2XIJ4INpqf67LYih5vqWNO267SvwVuTj40ViwHf1LHC4yBu0y5h+t/A3FUAcRBY
         6HxhfOHjWyjXWz+O5O+bxV9wa6QGwSYSYJkDOdYKAam5DxPkQB5zSc8Agp2Z4K/S8r/D
         EAIw==
X-Gm-Message-State: AOJu0YzINn84kN/cHlrrVfTpdpH16qoaY2p/XPWFW7OQ7pIQ4LKwFmCi
	G7Z1MkuKltCj+1brW5HKCuUUQ5lRMDy4yuarokuzFt3bx0YMatHi3g9RH01eGcyJtoYxbh9ymc4
	BM1ttnpzLxeaxn6P6f5zbE/IzgKMOqCGNdAMwFU4=
X-Gm-Gg: ATEYQzxm39k6RmL8voIvINYe/ukczH2ibD9XN01CP2KAx/1J+sGOywgesUR+qBEdo8M
	ZVV+Wz2AImDJniGQwrjqnkqY8dobVEdYk80S3PjVyRCyAkOfBVJ+nnI+UXyPU/4xxVTB54LJIMu
	pcdwbZ6A3MPr9/tW3lLcsdrZicIMPWEaiWOnU1Eo7cDQA0r8nSZ/1x+9KWlZ9jgOOJLeTek6Mrp
	O0+bYGozeoGO9FsT13PhM8pd0hKNgM4drcwY1u3BqUIG4Czj09qpZMm3yt0VHY1408jYHGU1QfJ
	KMJfR5iikXxnyB/7iNaPf0XqhgnyAQUsQQtQsK5HvA2uiObci3G2i1usuHGiQtWopytFeW/ne9p
	nu6OY9ORK32PjENzC9YgGEoGxCjPxzbVddg==
X-Received: by 2002:a05:690c:6c93:b0:795:f0c:3d12 with SMTP id
 00721157ae682-798dd7e0dccmr141492827b3.65.1773168526147; Tue, 10 Mar 2026
 11:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310183513.1077875-1-pabloosabaterr@gmail.com>
In-Reply-To: <20260310183513.1077875-1-pabloosabaterr@gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Tue, 10 Mar 2026 19:48:31 +0100
X-Gm-Features: AaiRm50HQ33TKJCih7jaK_dm9hyF9TRVLRBMo6hjDFDGF7Ox9ffTBLTmzXGbs_I
Message-ID: <CAN5EUNRZSBwnAzacA-w7S-vF6-66SH1LdOpZXtG_So45Xk1ViA@mail.gmail.com>
Subject: Re: [GSoC PATCH] test-lib: print escape sequence names
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm sorry, just rereading, on the expected output,
I just saw that when updating lines because of
the new tests added, it got changed:

 # check "'\\\\' == '\\''" failed at t/helper/test-example-tap.c:65
to:
 # check "'\\\\' == '\''" failed at t/helper/test-example-tap.c:65

and one more identical check some lines below

It should work the same way but it isn't directly related with what I did.
I can undo this change on a v2 if necessary
