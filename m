Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A55256C84
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048057; cv=none; b=qopxFy+qnVTGuOxuonEdz1L10DmbzZXJ7wfe8h13T/A7thf+h6JAp2oPGj5a5jWRvq+tkiarUKhLwp9Lj+PgE3I/3l4LVldfkA01PB9RMVRwOtZsPKYZGXXk1MY5vpKu5ieHrqb7XYK2ZnZGUUyfTEB7ya51WFn5Y4JafR2x/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048057; c=relaxed/simple;
	bh=uyd65+0be2O+2LYoU/56KCR0XLpkTT2IZC1gvlRAaMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VV7hDm9dsyHBA9YC9dkO80U2P/Sswk3/FptIsP89/NstHANk1pnSqGWJIBKOvlANSPlme6Z2cat9okvOmogSn6aLPSyojdkbMuslgP9I1x/Y0rG54EnHK42Xx0BWnrv8BDSbVH79SdRqyia29hjhXOZ9/8AVofM7X6zWRoRJFPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx11RSMb; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx11RSMb"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38a3225d59fso39321831fa.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 02:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773048054; x=1773652854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyd65+0be2O+2LYoU/56KCR0XLpkTT2IZC1gvlRAaMA=;
        b=Fx11RSMbt2l+lJRWDtkx4X5xUNRPlP/MZWqQxDNmHkznJZeX3bsIape96m4AA8Hp+f
         x4nvKvOPAtryPxpLi9U6STFsq2PSNcE3GNKyp2nMf2HeSiYAN8NyJyCnDtVgdlspgIdZ
         +BqW2aunYIo8wRVb9MS7Oeob5E4f08BKV8CQ4waO7LwpA2MW2W6s4OK9Eh32mwLxJjdw
         weDTNfhI8RVNWVk96TsvsYHKEUjOEU+Qx49np+i7OsXH3lS67O2gm1Yse9Vow3V2AkZQ
         LLeNN4Spb56AYYvFPcyDidj1xujJhIQ285p33A2UOyJJjGrDNws6bqwXrhwtc4/RGkmr
         zwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773048054; x=1773652854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uyd65+0be2O+2LYoU/56KCR0XLpkTT2IZC1gvlRAaMA=;
        b=vgudGqiWzJy1aKpQRzlIhiURtDhiz7D1ocQeyRZ+UO23j+uDG16ZErElWxhCEstH/v
         ZbtDTecWSAHDwbqMrBGCUiv8vam7Aud+HR59gERFNHE5lRumK3aoS4lSxyHtMNCK4Gx8
         o44MTLofS+nWfxf8BOo534gQfaubqQ/xX+FY80198ECdcrW+hJbLrlwch26I3Q611Rrd
         ATsGBtWPtJFYA2ApzRzQ4oVFZeE4ItiJn9KvlBZ2ZnGjt0mQxBPNHjB9XHSjlo7CWrbL
         p07oANHan9ct7AWj9eVGH9eKkFkZJoO893AkghZxDZ1IgrZUKsxM+p1wYCcEj9g9s7CF
         4nyw==
X-Gm-Message-State: AOJu0YyafRJQhQaFwn6I0iytUxnuP2v50F+lxSyGxHYlVghLRxNHRQac
	gnacTIz2is1dqvrGnqqQJT/jMBZVQD2VQffKpGx86qG4BbnecRjIKOAq
X-Gm-Gg: ATEYQzy3mqnI7eWNJ6BZsukpZRntYzPFHVRLKmWhuYd4i2aCcLnpT/cYwC3/CJ9EeCU
	eQNVB88Us/Wg4YAdV9ojQ9pEQVoN4Krz0rfKwMtskK7qljPCDCVlNmjP/kUAezpbU98/cpQrQHG
	3qEJtzwVuZ1OeM2128pGvKTgQG2uVe9dGfjuA0NxwwXs7Htk9b0lDt9oAeRJrMwM3q9v0Yg3wrH
	rhG85mOafUWtiMSI8iQFkFyiIBajDzu3dVzvajh71SNvawDw3mCxqdTNxeR2Hz76UnpzcOZfqrX
	qf19FqcTjtBNhz4QZFzoX+zP4O0Xe9jCAbRGUsshHqvUoX8hkJFpM/B1OteHuzSfMvP7IGPIfAX
	EHnBFkHEIPC8RUDXwUTGoBQyWH2HfE0VfVTZXg9jitz36oabaBnzcHmWfv6zLn8fYHs3yMOX1K6
	TiMkTLdzcBwHqvnat5guJZTM6TUJQ0HrGj3YUGdYHrLlA4CyztB2z3KpRDQ1afL3HflnRp17/SK
	t1SX6BbMn/WPQ==
X-Received: by 2002:a05:651c:211e:b0:383:5c1b:4968 with SMTP id 38308e7fff4ca-38a40a1c8b7mr39071841fa.3.1773048053762;
        Mon, 09 Mar 2026 02:20:53 -0700 (PDT)
Received: from Mac.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a420305ccsm14707921fa.31.2026.03.09.02.20.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Mar 2026 02:20:53 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v31 0/2] status: add status.compareBranches config for multiple branch comparisons
Date: Mon,  9 Mar 2026 10:20:52 +0100
Message-ID: <20260309092052.79051-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq5x7ba5jf.fsf@gitster.g>
References: <xmqq5x7ba5jf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for all your help here! Is there anything you need from me now?


Harald
