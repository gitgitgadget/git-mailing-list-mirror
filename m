Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065131;
	b=ytK6kDgYs/8AtWCxm//0Y4cAqxnJtgY6olFH5XAtj02EtX49d+FP9siWNaVm5uF16eus
	 NAJwLHk7d5M7bif5/BG5+gmpXr+TYvXuVFD6UyXs8mqPgte68ms2j1Mybsic296V8HpuM
	 fRNgG4JguZa/k+OJjToj1wFUPwp1Rallao4dLOwnHmuRxLTuc6YZzPIiefqIpCogbqlMJ
	 z4XHpFTzklohNp5EfI61atxm1C0UXoxDcS28iw9HSyB5578wnZzjhQuxdxKj8/pijtul+
	 kewhfRV88/SG693F5P/uhak3U7KM6CboPTnm3W6ujQc7o3ktER3xMWWRoE/DxlKyniQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:MIME-Version:X-Received:Reply-To:Message-ID:Date:
	 Subject:From:To:Content-Type;
	bh=S3gttaxALnZBd6UjNTczAjuXFNuJlb8JRYSrRl5fycA=;
	b=gdsbUPd8nUBPv0SewTgJknalU6Hh8p4CI03kqeBaO/KLinSY7Rnn14KFa08HH4t/KW5+
	 QTHTWMMHGlcbfi1yLLpCwg1JGxxiNBH1pcGw3YACuI7xiBShCaLWX8nryDllZLrajyzJA
	 saALcC5zCx858ae0ViQCZtPuUZA/rUkgj1oNH/sRAdp7afx+86+F7Ul8mgKwGuRtPJSny
	 IjMauVOQGVd3rvwWEPE4XHcrNNhxcTEGGEqSbyLNsbfE6zbhoMNO3jEJfTx0PUg73rc4/
	 PBypX609vOcqyu7N8N5bz6LQ+wm4/h+6Runuuy/KsyBB995fNoLS33PZYWU37VeTcHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EGNRJExC;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8D606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 05:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92A8D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EGNRJExC
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2efdc279d95so5839235ad.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795065131; x=1795669931; darn=vger.kernel.org;
        h=content-type:to:from:subject:date:message-id:reply-to:mime-version
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S3gttaxALnZBd6UjNTczAjuXFNuJlb8JRYSrRl5fycA=;
        b=EGNRJExCyFUWrTAc03M/BJrDR6uqsmAGDFWKGbvSj4liBqt0PP2bcTTvMZ/KxaVatT
         9aHm8+FhCfy1a0ET5ELVpq7UEiEH6/gh+0pWo+CKULsvEVdjPjZeyBm3QWo7AI4OcMpE
         uSjQD5QmB3ggspEOvjE/vcvBeSsfxo4i+iiH5fT4hYwFkhDkz5rGiobvJadF1/ERphph
         bM+y85x3S7iFPuBRoU0WFfjzhqw/I+Dq/TJwhHhV4540MidkoI9q39dB3hqu5wqpln/F
         FB2p68s5kMWwkd1VVobT6E+pUT/+t2O221s7nR6QV41aDyq3Ve9xl3yK1oJU2ZnE68D4
         LX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795065131; x=1795669931;
        h=content-type:to:from:subject:date:message-id:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S3gttaxALnZBd6UjNTczAjuXFNuJlb8JRYSrRl5fycA=;
        b=f6m3xtsOoXDvVA9DXPL4W+JkaoE/9xzSDJ0NbMFxXWMTZolVzJO3EbD6lHYHWXDtvr
         zS/IRurWQai0Zi2jVYv9J6Um0c4+xsx4uBtiPY0iKBWj+81+AVAdU372LCXIk00LAiIs
         MI+2Qi7BjwZr/yyptgR1vm1uo7UbC3+D0Q1BJRt0uByMfl0+000lY3ZqAHb5C27/X+i5
         XjqPGt+qsZ9Jo9kYc7hPAR//wpLgswUn6+IGwUljYksFHUbnGeZ0EEzW9EjEtXTz5fVj
         qmLze/cLFO0v0edWMLjvn/vwgl76PqRDv+tNFm5C9QZIxDCuWBlVAHAV5OSVvXYrpRfr
         f8pA==
X-Gm-Message-State: APuU4Z8avcGCPXzVwebf6OuD2PPNIrIw/k29dS3LGC+ENyJ2wedJ7OyM
	Ya9WYmZSVidl/k4axluMAPkH6Teo9l0Z2zVrUqwRcK5Sn5SZsuLma6GcNfrXgMB5S550ZNcjspU
	VyHo=
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a17:902:f545:b0:2e9:6645:e9a9 with SMTP id
 d9443c01a7336-2f031cffc9bmr218095ad.32.1795065131088; Wed, 18 Nov 2026
 21:12:11 -0800 (PST)
Reply-To: editorgkxjournal@gmail.com
Message-ID: <autogen-java-ac7f1428-2d28-4c96-b430-06cf23a0ce5d@google.com>
Date: Thu, 19 Nov 2026 05:12:11 +0000
Subject: Multidisciplinary journal details
From: prakashrao1346@gmail.com
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Dear Researcher,

Gongcheng Kexue Xuebao welcomes submissions across multidisciplinary  
subject areas.

The journal is Scopus indexed and accepts multidisciplinary scope in all  
subject areas. Research funding support may be available for eligible  
authors.

Please visit:
https://kexuexuebao.org/

Would a brief overview be helpful?

Best regards,
Journal Team
