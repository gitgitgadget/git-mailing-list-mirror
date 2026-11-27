Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796463;
	b=bXDU3JdojeSltOzKAN+YRGGGNm67y53sTGOvQQFgD3ICpkIC8YPMFL77ttnR1VbtEsyp
	 wZsG2BwshJjUjP07NFoHjeP+FfH+ak69r7zLvC1CtFHFGW/Hr6HPTa1epoF9ZCMaL2g02
	 ulPmhKK65RQ5J33X9RbjU29U/NtcEygI9wP9qfKe5ihbbpbUgqECgFIdOR6TUqC0+/S00
	 IytmO9Hx2V1rq9CWWuITPCCFMk3WzBpEgIu/hBtmLA5OHc03FPyGv3eat/NR0Oc//TWi4
	 xidyIbdeAkjcgLT1te157pTAno94d+sYjMkuKJNdF3dEeKfghqty3UMrJBULyWAD9Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tM7vXIKb6CAzATP0hladIYqViMDMHO9t+7lCKl7qeIs=;
	b=P5QApfH7Ar5MBsyKAIyzMCldeJVu4i45ClKK40cAVwh/Ar2cGJ/se6a0lx78EbSJpEAt
	 cxTJ9wmhLM4PO2iz5vHiKBFWGBz9lSXdk99sHQO6oKzhOqDDaPI2VoGF8Qhxv6l0SZ0h6
	 UpNMOdAdp9rFZUSl+14b69sDSy4aov8VS5kuoTrKklcguHbYAdaNZBDho1migyATrY6iM
	 u2isiLsyRKORIKk6xOUylg5MwHv5eE0MRuJRaUirmaz37Yu/A3M6Xz5XzJ3I/jGxQTYGu
	 8VsjzrW5LoL5MBmTintGmkY8v9X9swRjInOhwgkc8UMsY2knO+08clwL/0Uwl3Wgjig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PK+3ETVC;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DDC606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 16:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24DDC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PK+3ETVC
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1aefd1bf74aso4648580c88.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 08:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795796462; x=1796401262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tM7vXIKb6CAzATP0hladIYqViMDMHO9t+7lCKl7qeIs=;
        b=PK+3ETVCTMjhzfgIjp8sAZXVBtPnBC16SqyWm5BWSx+/1+bnSAHCt7Jdjl75eKVlQ0
         5HKw9qaEO5Er6R4loK507DdbjPLQ/Cle68JXqlkqKDw+YZEUz3YttXo2XtLit8UVKPPb
         cGSlw1KeRzwrXTuL5t93ptXMZnl2CsayRJMX8IYlNdN+cl7hc31D1VEWo38S91cXukK5
         JKyhoQNFejBssnBY9SVk8xb8Ci+PhPIR1c4wZYFCktEGHjGrabErj5u81qS7ru0h6vqG
         qtAjfzlwS8KkAoiXODZ1raFQ/GYEu+Wz1zeU73xLLjfvLUTYV/4f5WSEG4SdVH/o4e0/
         nz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795796462; x=1796401262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tM7vXIKb6CAzATP0hladIYqViMDMHO9t+7lCKl7qeIs=;
        b=0aKNgOHiJsKeL1CPO+gDgnDpwPrql+llHZ1URme8DSl//zPrARxiingQQTFMJCRNlB
         G2nCfEAcQWyLNAVr3eYKYyBbjq1oeGjdrw2MlGqGer6IR6GKXO/7/bJZOWg4Qcq1ozRI
         jeK7t6hwG4gxPBvURi3Bt8qC1uIvIb/UlTPQoFPKzeGB/ctHlAy6W2Oaz011yO2ZQVFa
         oIlFqg9NRWhkrKqjIljKGwCFDR25z05JhKrcgIbqE+XaagPk7KRT0ONKOcTM0oAd42PA
         18wwAmQyKOp/2Zdv6ai6jhuNEN6+8eUO0Eceop/NhB4EaHHpMTrf6tsZuem4ika2Xvut
         RgXA==
X-Gm-Message-State: APuU4Z+ni6Awxwyg25QjUVq93gvP/wnKw4zPwdAgnk9qpbW96Tdv0gxT
	fBhsmpnpkWxPB8M4aSIp6GAB2PJ+9V3NWBmi73FiKO4Jb0J1m/jXrQvo0I/nPooA
X-Gm-Gg: AZFdTZc7gS1i6HH05mZPg5297cFzHpxwSUbHpoXnECX2aXQEMKZRG59PXnOPXA7kpUi
	dVId6q5ifhM4ztBTyy0LU1n7DH8atCnOoUfyuz+h3qMbLfs4B5RFsenN671vF0cbioriEiMrqeo
	pwRc/6pAAnJBeAW1d6r+cemEn/A14ce+lZI2tryrp1NUDQQ2YdnpLusCNwAZvIxHOiE+QNlyth8
	hpTNTPM2Tj0Z0ZSoJiWqU+mSxoX0TumTxEN9DROD8R94z+yja3mKOTxQHZnkOBtmN8cVPQep0yi
	cZFi0xsUm04ejHqHhny0bnVj638IFtQmU57w49j1wJPFYvlR0g/qN4eKTESYnh9pBLBLaspr3el
	FRJs+CVxFyYzFRqz/3CPeinNzySxfMzEIHa2YmwS8uw3A4LyGUy8igxytE07QodTpr9dW4oBub0
	w0ee5IcaoJliXpj+cJsGYFf8LlmCAtk0yFUEa8Iu5LYzKVLRpaD/oopBAvXlFUq9KanXncrhteG
	VBxJPrCH3pwKBjZz9lJkPNfTQLNO0Bj+41q/BHX0/aoP7toRSdOUdmUoPXgysyb6Eq3Ve7aF0Go
	wTgmrINGqkSoyMalYxC2Z5B15bNCWua8tRUXvw4WsGPunV22gDEfiGtbwMRgXC02bW2W3Q2LNVL
	0d/fTZ2IMhLrUKL03
X-Received: by 2002:a05:7022:e80a:b0:1b3:a8ee:a0e5 with SMTP id a92af1059eb24-1b5567e6419mr25498044c88.2.1795796462066;
        Fri, 27 Nov 2026 08:21:02 -0800 (PST)
Received: from localhost.localdomain ([223.190.84.94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm54315196c88.0.2026.11.27.08.20.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 08:21:01 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Coy Geek <coygeek@gmail.com>
Subject: Re: [PATCH] merge: honor --no-overwrite-ignore for real merges
Date: Fri, 27 Nov 2026 21:50:56 +0530
Message-ID: <20261127162056.92737-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107044419.209119-1-aniketgupta3001@gmail.com>
References: <CACgTecNrMKHGexWTkm1bqpVzL7SVWD5Hwo17wVokVGe3_Rnx0A@mail.gmail.com> <20261107044419.209119-1-aniketgupta3001@gmail.com>
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

Hi Patrick,

Adding you here since you reviewed the stash --no-overwrite-ignore
patch in February. This one does the same for merge. Would you be able
to take a look?

Thanks
