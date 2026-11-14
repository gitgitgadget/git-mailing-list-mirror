Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794632061;
	b=w3FIfzdUupN8HlRgnuudTPWR3dv9KMFp+mtBRKSND7xt5eDPUR9IAzNIRxqL5nAkSSuE
	 k8OC/DQWIVjcBJ3cbsKkzJnrof7St2DrgxAtyhmjZQ822dUoGsiWuw71ZvYHJ1I52ZjbM
	 CuBF7ju7yv9e3ddOrxyuXAvFEol2D2M8J+UlaviiLW5Ff6/vyEhqYxR+ugdd4NAHCgFU4
	 UW1otqPlNyWC6cOOXmNhX5bQd2faGyVpMONyfBdKwx/Ilh5I1H/N9WdmeCsSYL+i0Srnd
	 EBWodPy78rFj5USvPkLssRpRX0a1hZf2j5vrxeD0ACe0+9hmiZzTru3IoLEY9A0RDXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794632061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BsT8BpwrlXkD1e+6KjJ/ouE6uAxyQYbPSMv+jf5xk6c=;
	b=1jM189BiH+1w5X2JeNOZp+Pa1Z15PAslJvthDwy8gbDICCdkssTHqiUR0BYtNIujx5XI
	 Mt7I5r5PNOI0+NDdVnnv7E6tCGgJ3fn7eZQa2V2PKSYvmtDP+Dm55hCWziA/3R6x59VJp
	 4lf3fNM838o6OPULZXc3zSlbrvVq6rfgKvVOPL9REAqpm6XLP/i5mXatTu4FCru8rUxrN
	 b9MiqknPAnMfIW8cpYbttz95FLqW9YU6selEh0Rs2LA8Suou05T1mmGIc1N0B/0pcELuR
	 lRYq83kHdolfErlp8h38lSjGCZ7E4klxGI+VEfOWkOrVqZz9UvTMz1mVT1yXWUIL1cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IO0Xvz97;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D601606A32E
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 04:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D601606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IO0Xvz97
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a8cc11ac42so1582844c88.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 20:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794632060; x=1795236860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BsT8BpwrlXkD1e+6KjJ/ouE6uAxyQYbPSMv+jf5xk6c=;
        b=IO0Xvz974T4gTbyQDl1hTTz0cvScdKj4vk0gifM0xRWne4edXOfLnKYQB7/QEUbrfJ
         ikUF5lPlkrNkRZAgdn+/WBXGWo+OexQfcsDrc+AoSLGHKjgygd2pJwcn9wXYtbLpEXTW
         mRawFQxsUVDMdhRV0aoTCl8d2yc/y1oWeQZOQ7nkcJ5q445jIGsI1lwbDbRYanDVCEGv
         rIucl8BpZH06dq9oTWqy+/3BvRFcPZzMbdIatGms6lMjxZ1jl7T//8DBfDHEhHHtNX6F
         wMWpJ03mRZUph++h2sx52AsJ3+9gJLnecz5yvbK28y1ouOhxdgL1kefwVaCtjLz5Iqxw
         aLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794632060; x=1795236860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BsT8BpwrlXkD1e+6KjJ/ouE6uAxyQYbPSMv+jf5xk6c=;
        b=1Jj1bwCoOhnSmW2/E1oUDGKpTyzW966O4+3DnQwNeYEMJvM9FR7jfyd3N15gqgg1Gg
         0b8kQPnXYE6dF4O15aZUnc2iI1Sf+3rLKSC/YaGgL0F1AEpUHXqc42whNs9mi7XeL/a2
         affQxgVQ8Cj39MceuYYYy6W8JIDYFuoVkLRo9Mh4vorCLIM5s5X7JCQK1QL58MxpFMVh
         cK7ziJ1XYs5pmp66QKXN1aXL8Nn5WubIj6C1OfP0VBz9yzHNmwgw/JSRfX7AW3qjsKX/
         QDIs9aYY4FhKXWOq9AstXa2DvRv83kYWv+7D2Js5Id8x+0yXgByNa7JP/9+sg6Uuw79K
         aAbw==
X-Gm-Message-State: APuU4Z8Ce8bfibbBjiI3bM5K2spTnKSN7f47P5GBSLlmF1+hpb78nA5P
	09B9st4XuewghJRAnrIPB18X8BK6jHYPsrIAD35ILUl2KBytJDsvB4fF
X-Gm-Gg: AYBFou3GWD6GRitiq/ePD8vEL7DT1nkHUFP8YbboUx30vSlPsrjs8pPok4hmH1H4S8q
	1OBz2N2y3ueJ7OAc9GVtBSHF2twLO2/1i/Hehzyk+OK5t/4o+iGd62AxORn/B/Amlz3C1nBbE3O
	CyhU+RyyQdOSTrXnBjpdDZqo6l8wxMl46DFpgYf2ao0O5Y1JDPczxhKXk+AjcYD0rS6yYOxM1r7
	qZfGwJp94TJxmMyHBeVwdAoK27CnCBXkQ8iBQB9gQEexf8oeHJid8gB9bDsfnKBharvkHVDY5e7
	N9TZ1gSwsLPdRfCq4PAMdln9RAxxcbU0MbxNtzkcCI2yNpe9kgQkvj/pDgqtCHE0mCrcl/VgExq
	2Ra7sXXPlboq0G3L5UXS3H9fvVxFvI9WQss9i8adxKV3n8UYeQnCV2GmPhBhXtSPvrMLdI4MTBQ
	c4lsFiweV/lYozZ5nUxzB/tWjEMShpH75tMnbnNApyOhIToUrmEZSN2a27g7uPR2WHtKVRGPR8S
	zmzfDkKYmQBcDQVWWpxGfoLPjGQp4yRCfXsD0kSndMqPP/IzhurzuMlo1ET/q8bRx35O5PoTUyF
	NJNScKxDh3dV65/HimeHHvjXxxPv1imZYlvHeEPDfyAbWPotHjGz
X-Received: by 2002:a05:7022:b053:20b0:1a3:dfb6:e593 with SMTP id a92af1059eb24-1b5031167e0mr4443696c88.27.1794632060081;
        Fri, 13 Nov 2026 20:54:20 -0800 (PST)
Received: from aeron-host ([2401:4900:883d:dce5:aeb5:d73b:40b4:bbdc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319d40asm11455023c88.11.2026.11.13.20.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 20:54:19 -0800 (PST)
From: Abhishek Agarwal <agab0323@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Victoria Dye <vdye@github.com>,
	Meet Soni <meetsoni3017@gmail.com>
Subject: Re: [PATCH] for-each-ref: avoid segfault on --no-format
Date: Sat, 14 Nov 2026 10:23:58 +0530
Message-ID: <20261114045358.26780-1-agab0323@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xmqqse148gyf.fsf@gitster.g>
References: <xmqqse148gyf.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> The implementation of "git branch" side is quite clean; if
> format.format has a value, use it, or fill it with default.  Perhaps
> mimicking it would give us the right behaviour?  I didn't check.

Yes, the patch does the same thing.  After parse_options() it has

	if (!format.format)
		format.format = "%(objectname) %(objecttype)\t%(refname)";

so "--no-format" gives the default output, like it does for "git
branch" and "git tag".  The new test checks that "--format=<fmt>
--no-format" prints the same as giving no option at all.

I will send a v2 with the name in the sign-off fixed.  I do not plan
any code change, unless u see something else.

Thanks.
