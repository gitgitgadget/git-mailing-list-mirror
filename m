Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035504;
	b=2hXjuzQS/dus44QzVt3Ita/8ikm3Ql9XrSTeO42gvFbOkYytyYeFDDehQVCizF5bVgjV
	 YPzUZ1oOoKLyhB9Xv3gWEH3eHRU8Wq/4K4YSrrU//CmD0TgdiG/i23fMeq9jXU3albtyY
	 xAQURrhuIZGl6AbEdUB3cidvC6VzTRZ70/9HaBFYZKEByKAkxhH5IPtoJzh35yc69HCeV
	 QC482ZdTxNpCcwcL0mhWnzjtLVyOjxSTqkAdyYm3BSbnBaLe2646CDj0BJJca0zCbaUAU
	 VT+XbiRO5kwJu17I+b4SAsCMFT77C4pZWurBhbMJPisUlbYjetVSGwA02iJRUgLNheg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gLAVZEzPwXCIk19PiL7zrXIeu2YWu3OPObvel+m6kfU=;
	b=sXME2hsAloIPruZIwSBsGDZZEBlnL/dVf79HzlDqt4zVeq1mk/LnenbB/XCL6IKxg5jc
	 ZKtt8+NWjiqc2K7ke2Bfsy7vqop48eYS5BXEz8K5Y301OLUDsAbaadq9UZjTpdGhGURmI
	 VE5mzsMDya8hZSWTeQbivkzAM7fsrBmUJA4Z1e6bYBAzGhE0ZPej/TN2yzcv5A1RCevOA
	 JwyQojRkEpxPoOIlSbOfJUKXum3V7n2QzzHxUklhU4iLNxJbXXB/y4kBKc+MQ/vX+NoZb
	 ippzbvQO8st6lI3QRTjZI0crXsbZuK5T5Vvy4ohsrLWhJwfRFUm9pLJpT2pjJdjrsPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UW71INDN;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B6B60A260C
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 17:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8B6B60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UW71INDN
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so31314965e9.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793035502; x=1793640302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gLAVZEzPwXCIk19PiL7zrXIeu2YWu3OPObvel+m6kfU=;
        b=UW71INDNB+mPcTTYMdKhx1bUMen8MD1hLJFqFzQRxVu8HUNKJvmsV0xFhgB3ZREiww
         zlFXB7ji6XJ62JCOIiK2Ts/3BJ6DWBuBxKAte0lz03fw6yqDkcsl374rYiUBip7TO/iC
         Daufx0gF0o+61t3qIPJIe4RyivHP/ZIuchSV6kyKWIm5nBmpxdEQ9vdQPeTyP/rwi/PH
         CL99lCc+mFy+k0u5EDNn52b/eJwRHa1a6IB06NG63xEndjqdTx2fj8pR0v+X93avrw/s
         5DnkBae4LzfiqFJ5e19VyyoyWcGF2SJSKNKuEpKFsDBr9RKfVu68sDFv7Cs2HsJ8jxOx
         7EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793035502; x=1793640302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gLAVZEzPwXCIk19PiL7zrXIeu2YWu3OPObvel+m6kfU=;
        b=gJ4Al58tz+euOKywOZ5wXGr5Vxx1lRbWqdVJum1lWLaARMUe088G5+aM+hdMAp7CDy
         b9Wd0daOSdPLZ/gOZLNXgvB6UOr1xiWgHVD4LdYcnqQ5fVzZ4GCQFo+9IMi1KrhLVxmJ
         UjbCbCJiTlRQimdgHT2ZjOrrC6qtwCuZ0gz5PI2TwnTjv25sK7bCu5uxmWk2YTGMJ7fy
         AvJ5JeG6yZ3DJZSVOrAXfATGMeFZ7uhkgT6oSBSg8eJoUGua/F9F9qIAWov+Qkvex7qp
         FmB6Tw8WozDRswz22bdy0wRHKtbnyn5HjCYSDdMjele7ylOKlDfUl16cBLjqhIAl1zK0
         2lLQ==
X-Forwarded-Encrypted: i=1; AKwUvByR8BAWFVi/bqVmrAJJJeiNJB1tEVM1bGQJmQCKXHwmsydp60Pbo/Lx8x5C48vTnXgydhQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI32BuwJXU2nZVfOuHLUhqY03W3RZ/W9AOsao9v56S2hQZxPQR1
	+/qWHhJlJKNOtXQfGX34lkKXupPX0KaYK5xv89wTnXnaRex+X3b/i2T+
X-Gm-Gg: AYBFou1Qw0DcEP35QKbITcqbpOy/ov8RCJAlYtgHq73ld9apuyRDzQ0eVp7RqcjU/iT
	o4EszQ8waQTkZSpnxDhusQTRmnTHonUH31KXQRflq2D5ksAwTelHh8XhpEragICqpOsM9GdA7zl
	OzRCotnRmcbiRdtOrGMEat8v8j8oLDgVL7KED4UQdxPZK92i7JRZh5xQetulAFS1PvIMeCo8FKr
	wxiHJVCa7w2nlRCcRQJy7xbcG71V+0Z1uttg0mEwxJPie/pJR13mW0QO8ZottE49LG8xVHN75uX
	XywGTW+JU049eKdJWeM+klLzpVetxLe/pfnIH+PRa1bN333t1GzEYv5NKUojaWBKi960dcNxPxR
	yzSVWhZrUs7Q8c+ZuEUX/USa1J2/JSR11pdT7SEgOoMf4OGGG83rdmr03dOGGh2NgRq9ktKlTce
	Pq8EZBf+3dvy76yYwcPJIcEuQbB7DAWdMZwhQ8mWxXv1YVG5rukZAASFuzpZbbTUyZZx/O3AqVm
	lE47L0GEf5pKaGbjtBlXX4+Mc1+un2Fs+i4CDXTOYvARYXoKatGhPyEpO2+GNbo1/P0EwXLotA8
	i7/M
X-Received: by 2002:a05:600c:4704:b0:4a2:190f:cf6a with SMTP id 5b1f17b1804b1-4a35acc2ea1mr132108245e9.35.1793035501951;
        Mon, 26 Oct 2026 10:25:01 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f248sm17091540f8f.6.2026.10.26.10.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:25:01 -0700 (PDT)
From: kerylefondji7@gmail.com
To: gitster@pobox.com
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH v6 1/1] archive-zip: refactor 'path too long' error message to use Q_()
Date: Mon, 26 Oct 2026 18:24:56 +0100
Message-ID: <20261026172456.561-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqq1p9hhbue.fsf@gitster.g>
References: <xmqq1p9hhbue.fsf@gitster.g>
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

Hi everyone,

Just a gentle follow-up on this v6 patch. I have rebased the commit directly on top of master as suggested by Phillip, ensuring a clean single-commit structure and proper indentation.

Please let me know if this version looks good to you or if any further adjustments are needed.

Thank you for your time and guidance!

Best regards,
Keryle
