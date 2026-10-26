Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020230;
	b=RQDcdF9E7LNK1xyXXyl9TAJJOSWkLIZDOMlZ8TNJUDdYQVciZNXRmhqgKVhHOeRNWf54
	 mA1HaZbmopy1xhL2F/lzNa7sxugHnhUmznty281CnNUh9HitUmHfQyxHuf4axJeNGgQAx
	 zb5hiX7e2/w/lLokfC5zDaYqtcPmfsZ/HHCtpoHGKUKhcISKenX0qitKzCHuXl5pvY3q6
	 oT5YTaI0eYU/HF4NbTWzrY9ps+Vit/ET4uuaTgAXQOhOv1L33xDgIEPiXBXXlKqSyUou9
	 jHEJR8w5zFi9PkYsAGxVk6VievxN+Ue1p95jWqKA0H+cW9WprMZ0gfpmuZWMG500bcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dIqx/SnBDCPeKh5w4leY8BXaAJZIKFQmDXdTT59P/rg=;
	b=vlJP+S+TiApLzooJvyZdjDlUNaWrs+wFGAX+aA9+0JLSoftDt85heT3s+gjOISs0OsJ0
	 ZwKXMx2rlMU4J7dn7higztlBSDqIQfr/cGM7rlZZ9MpRDFOyV1Z8nH4VS8uUIboxeL1Nm
	 tfL5IUDIkyUopx7daPXUze+p9ZqzALcSttZEKMiG7njTo8ZGUwdpH/AYlM9doJymJ2nMv
	 uC65Qo7UXaKvxf+3EyFlsA1DMPqFTR3QlYBf4U6oJT6GbbqLGU8kRvNP7sgev3xw9DNQE
	 IHDugWK/e5gVEiEdcI1q+EzM87LJhax2zNIBKvG9GHLPzz8/JmHgwZWYZPKRU2QIMug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p2nRu2T+;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A04606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6A04606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p2nRu2T+
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so1549041a91.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793020229; x=1793625029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dIqx/SnBDCPeKh5w4leY8BXaAJZIKFQmDXdTT59P/rg=;
        b=p2nRu2T+0IOgTW/BJoA3zZzizoI5dsm70oN0GK7YYnnbdQIctZd7gbxxfpHzMMiVjW
         fjyErxY8BwdMp+VNcMBsSe57loZuXOSK3BlHyUru5AGoIlFswBj1GVuSUpcTS/Ju4pH2
         cgCKYhf4baPKVuQJuFuFmxNc+A1pCYONaVNb/+VXv3LIKrB2WLOM98JFtKjzNiK9UzCe
         JtO7I6jf1uPop10yl5LPZTuIOkRmN5ZPNsKB/10DPLdNUQJ0/x0OdbxZ3d6fKvfOVeY6
         U/Fwyh8UwWyAJwiYWFyl1xFN+mBtXoT9TWvqRvO4RzsrRc1Ep+9N755mxhiIWYDe75iS
         9ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793020229; x=1793625029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dIqx/SnBDCPeKh5w4leY8BXaAJZIKFQmDXdTT59P/rg=;
        b=knA2l398m3MWstHmF1cvQa0fHVINStrBzQrt7fSTVqRMYaqazbirqyrBdLahCfpaif
         WuH2mk1/vgmFq7X7rxizng/qyduW+Eo12cS27pHNKw/jay7TmsNSetjJfKY6aJdLlCvN
         sPiXwQ40i/SLow2uiOWE7bxlueUIlLBm6SAy9p9ZQgp0IoM7Xm2YMRNHjuKtabxTJVpu
         6lVkvJ3lneWk0kvSsea64eBpN8gGtIpRCYJZuw89Ps957veOe9/QuZE1F3thtRi7VGib
         MLVnwmo9l5pSdjKsf7CDYgLE9IUZsXKPrO843xtMzQ3Bo7DWETryTwzzCAg7trNV6M8+
         T1pg==
X-Gm-Message-State: AFq9FYLN/UDCrzaWSUbdigvLD7/ZNyg5aYdFPoYmjsatDXeEwG3NqU13
	EYILo+jhk3qHMIPtVaRoQNqFnd8XjzMJ3K16SXp0728wBD4d38hjBJUj
X-Gm-Gg: AYBFou0qaCgu9w4cFlussE1ImI0+l4/Aybld7zlKOPwfk747XHLyWP/eIvd7KgiYG/Y
	Co/Y9ISGxU0l45XJBT3eBOSbMEww2v3Gi81UmAez4CIGyP+8XvpvxfKf7YoO7y5xQQErTeT1x/v
	cPgS4dOYLW0oNsVJ2Mb+ZyQ5yD2VTu7dJ3F7jwxXU09IrPzDbIWB/cP2q56O4Ts8z4XIkWGhFlR
	OdWTED/UMFJxTgdOfjCoTiYscRc7eMTM3DjmJbDCuQBSJO+xO6C/ZWmgPNrft+VqrEah1WKFFTq
	s9p4F726hMshn6rd5LrYi8GZwHm3kvGKOEVj0b7CO3GnTwTZebRx0gw4Jr+jUpSsyzVc2wj7SbN
	a39cumFgRDcfaWM2JfKlT+ZkD8qbhwgBZJZy2t54WuVWhvnGyzylJY8L2i3S+Y7Gq/n/TlKqHnG
	u+YTQiHLl9Bt1BKgBbkbxo91I/ABTG5cQ0JIIVdb8+XvKkgFMJUAilTpJ28j6CcloKrmSuxBg/Y
	yCJJkIrxv6zso0MtYc5yCqE8RXJmzAiAbr+Vnp66YH4421trsGqTQkkh/uj2v6rKkFPbtonn3Hr
	RP26Ofd9laseJT9fTHOQjj8=
X-Received: by 2002:a17:90b:35c5:b0:3a4:b3ac:904c with SMTP id 98e67ed59e1d1-3adeae6d8bemr5228525a91.51.1793020229058;
        Mon, 26 Oct 2026 06:10:29 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK ([223.190.84.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba32e38sm8982404a91.2.2026.10.26.06.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:10:28 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: ps@pks.im
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	christian.couder@gmail.com,
	cat@malon.dev,
	belkid98@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH 0/4] environment: move line ending config variables into repo_config_values
Date: Mon, 26 Oct 2026 13:10:23 +0000
Message-ID: <20261026131023.408-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.240.gf97865f162
In-Reply-To: <at9HOXZhVcl53CGX@pks.im>
References: <at9HOXZhVcl53CGX@pks.im>
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

Thanks for the explanation. I was not aware of this and will hold off.
Is there any thread or branch about decoupling that I could read? I
would love to contribute to it if I can.
