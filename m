Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236966;
	b=UMRAcIMj74MHVRBHuN8k9vIwQk+3yfnilRrqkUDy9vOcA15vs4SeCsJkw9fZnkjnhejE
	 750jgcz8dbSYwHXCj7x0jlb1O1U8q9fIJNUGkbjWR0WKDmPl3V+DVxrs2EJp9zPevXGmn
	 M5bneu7/Fn+q7Hr9gL6aNQXuaD08JL36+CNZTULFde7TMu0xSQXrV7QU/Z08VK1dkRCGP
	 OyX3bxYpgGK0mkULDw28JL+flN1WYJaMcvmA69Y4OnMji4womYLeCn07qi/ifhMhKw+Jg
	 CEVB6T6FVqduc/oNvn10T36hfTVHy04GRb530Mx+mzxRcmAXNg9YAkKZKPK6VJgNRGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uBz5EFwQxKG+InHFaaQz6WfdZG/47QI+ggzv+DVjsq0=;
	b=emislcBt82C3M0nzS5p/Qra8xQz13FDibBpQAO/EBmGXNhGbiYIvWpHUC7Y4K9RgDwUa
	 +0ZlCNkO9pWSdJuVNs3DkU7X7mbYjgY+ILLqB1VQurNQzIbjoQu94ZvectHFlSm0drLRQ
	 9P2i70ByvXOK2416999GvOrKdnq342FLXmyx71YsM1x5Hd0UMAGCRhsoKu4P3YZ1v7Yqx
	 ZXLzu6JLrxcmrvlWAtysTWGcZf+biJ4Zd7obNi+MokgT4ugNdVcqxreLHKSkEkHZmwxV1
	 RdESv+B4zp0g3ZIJyXiGjYWKdK3999j9NZ80PcDQlSiZS19f4+ow2pLXfQZAKTKQm6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dPIKp4GQ;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE5606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32CE5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dPIKp4GQ
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48b001cd92bso466321f8f.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 07:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794236964; x=1794841764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBz5EFwQxKG+InHFaaQz6WfdZG/47QI+ggzv+DVjsq0=;
        b=dPIKp4GQpsE++Un362SWWuDmum01Q1QSjOvu9FsLkNTnMRzaOhpRUAnoyCdZPPITlv
         Qimy1iYV+ExkfPB2s4A+v9dvxIXAqW5KqhPP1yJDArUmAVwzsav5Gy8zayaaEhi4CKCb
         Pp0DFoy3JwgtGfBo1u3tj0ezvKFMs+flg+3XnSlxPx7y3f45Fqa/goukMZqZa41jIdAk
         9o3lYUKm0hKzMUT4GszdqwYEHq8HAWJsSjYHRj5JH+uZbV/XNjYMuv0f9Zpeu/xOMG68
         XvoaWul8Rb+OJcWVyAxTW0VRG8Bsqc44/DWJIyoW5JeKSG4OULyT0cMGsGlV2KPoH6hF
         JY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236964; x=1794841764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uBz5EFwQxKG+InHFaaQz6WfdZG/47QI+ggzv+DVjsq0=;
        b=OmDp2RxOXNE4c/3y3bDms/QLkOaeag/PBKHloe+DUcCR0hSGGFVvfoswN3VjKcn39v
         2tG3XbX6ll+965zJ9UmrK/XaIZtLxmSJ3XMGwbk4J6leQhVbKQbSe0RZ1gaReMYSDfVn
         iEa6y3jbgN+9lQUfTcFxhzygdahqESEalPbYoYf/hOGKoNZNbaU00iWW6qu7cAeELud1
         pm+gQdeXnpDsURxBovGi6uzoeY08bRJD6Od/ZXeZIV0cx3qPZ6+1TC4ZHFGq7dk7ilgO
         7u1b+JWXVDvwl7/EiL3WS2yIZo5mRYFnHyxyMxN1B9xvzA+T/capdVv/9/Z4VO8DOpYO
         EUJw==
X-Forwarded-Encrypted: i=1; AL+hErEnUGpTFC1uHYe87iAOa2MMlJvESZ3S4l3OQnNn9FV9pHsO5jTluXQW7AewuR8ON/WNJgc=@vger.kernel.org
X-Gm-Message-State: APuU4Z80Ld8Klt+n0399p9c9oRfiSVP4R78FaBQcdcYs16gmIBvrVzD7
	ikyeWrRnOUQiCobkpxV1nwToFVoVFrvWV/7K2zy8K2kPqn9i3glcYHsr
X-Gm-Gg: AYBFou3/scPqWt7DecHGbxQkrnGhfqoYFMffs5VgymDM1Ze4j/gkk6+sp8jklTe4TlK
	UZlCOepQ27Zt0C8Zzv4gYkTMWulq484/OIREobBynlnbRbj3pBhkiM5ntT0g8+hSnvGyFOIoP2O
	O4VmhnqVzcNXj1MZPTw693YESQ2FZOA3sQLeQQsGN4HAHKMI/4Kfq57eN2iz0t6DHNfUebj0v8C
	dXnrujGapd2fZAkVdz775M0/DClvCSt31rCR9Q4wDjikpZt98C5v1c8cVMTrE/BIJiVLwJNDVUP
	9qwIxKgv/FdbAjmdTex4lCFPkqQJ+J4phP0vh9EerOHFjT6dsYLcnur+T9nMN7QY8DgZyQ5eLiy
	B1g8DNumi5oP64FyDpfU8SKSfYGcKmOhoZmwnbyP0BmnmzRK8fFdVPOmOJtgliKIPXVnV1hDA6D
	2cP4zR0V415NT9NP+4AjpgoI5Weq2NoYOmCpfeT0jAn3D1SkvIJY3VCj+QSGNgWcRtv+uWxcn47
	GwI+zcSlxjErdpEdpluIKFoNl6URq9SmXQDwY34iz3ZWhufWfIVMit2KucdrPaWBvbx9Bxqc4WK
	HExryswFBOyaen9f0utF6kptoKc/TkEtS+L7Hlu1AJaJN8afbZoAytseKjqBfiJzFuPlcWrs
X-Received: by 2002:a05:6000:1842:b0:490:50c1:f352 with SMTP id ffacd0b85a97d-4958b90ec17mr8102372f8f.39.1794236963294;
        Mon, 09 Nov 2026 07:09:23 -0800 (PST)
Received: from GODS-GIFT.localdomain ([197.211.57.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597e00d75sm10279043f8f.58.2026.11.09.07.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:09:22 -0800 (PST)
From: Cynthia Uche <herroyalpriestess@gmail.com>
To: gitgitgadget@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	herroyalpriestess@gmail.com,
	kaartic.sivaraam@gmail.com,
	shashu8660@gmail.com,
	siddharthasthana31@gmail.com,
	usmanakinyemi202@gmail.com
Subject: Re: [PATCH v3] test-chmtime: use parse_options() to parse command-line flags
Date: Mon,  9 Nov 2026 16:07:40 +0100
Message-ID: <20261109150740.3003-1-herroyalpriestess@gmail.com>
X-Mailer: git-send-email 2.56.GIT
In-Reply-To: <pull.2280.v3.git.1793639275978.gitgitgadget@gmail.com>
References: <pull.2280.v3.git.1793639275978.gitgitgadget@gmail.com>
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

Hi Shashank,

I applied v3 on master (fb255012ac). t0082 passes 4 of 4, and the
negative-offset test fails if I set the PARSE_OPT_KEEP_UNKNOWN_OPT
argument to 0, so it guards that flag. The behaviour changes listed in
the commit message match what I see against a build of master.

Looks good. Thanks for adding the test and the commit message text.

-- 
Cynthia
