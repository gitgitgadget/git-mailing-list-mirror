Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27591DD525
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734620; cv=none; b=U6vgYw9SpwGpu7lkGkHunFGCfvNVXbQ9oE7ILa1j82kB5l3luA+Kz7pa1ttiwcwsNq+zFoC979mMORehQOomRO1EqobCQ5S+bYBC/+Hitl/dIsE7AU6Y2s3OHw8PfNqInmCJz3hNSUMrOwMBVuyV3CaX0QncIiKPn4yvvZAEWV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734620; c=relaxed/simple;
	bh=FV14QLMEBg653mFrZm1N2YzHknz/YKWWPNI84qE2+eo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QTEXoWVzwsnuVI/aD26d0OQyp7mjZ6Lfmnrx2IR1FmRcON6SlLtix48q8ItFoz23YFchJ4enfQgKwTOLrrJaniG4+Z0bGsyL2k8+2L+ek/kdVhQ3xFbo1TD6BtZubaErGDTjLLt/G/FDp43AVXdEJX+CIhr9vg2B8yr51CFmMF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oxg8+O2O; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oxg8+O2O"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-327b657924dso3748351a91.0
        for <git@vger.kernel.org>; Mon, 01 Sep 2025 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756734617; x=1757339417; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwTBr9eo35lcuKBLgW1ezCEAlzs+A7m7RFXzKgsNORg=;
        b=Oxg8+O2Oo88hgvzHilTI82MY+uLsnU9iTF2BboVIxv3xw06hAR36Jq+FBqPpPx1JhC
         xtK++g+WaAZLBQUqqa3e6Jn/bY+jxH4iKKYSxQTgejs+DXpR+IQA3nKuFl9z3iXge1ro
         a5AEJDLZK3RjRVwK/P8TsvO5SCOsbkpimqnfMl+qD4unoLmABAdHV6bLPbkhweyiT3or
         bjC4AJL2LVkmWiw03qQVUVNpRBfLE1jYby1FoRygk5/S5vxOJW29NpbsMHvZizba0Y1s
         EVHr7wZiJxWDDFtOgXJ8ZDrQ1lXpr8W6bZjBOG0vx+kggNVLJFjl+GWspyS5ejSgMkzc
         npSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756734617; x=1757339417;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwTBr9eo35lcuKBLgW1ezCEAlzs+A7m7RFXzKgsNORg=;
        b=Lr3yq+wVt/+FvlD7nDN4jmw/RN5dvSh25EAu3ihEOxxHAu7l5LoAus8kEwGjbMAkMh
         IPTBN9fe3wZo3f6BHc9mq5NiVQ7FdglDuZnZTFiTx/JQhsjpJauiTT/yvDP8O/v/SAj0
         G8Ckqq7feTf/3UsIjygqkkggbBnSES4EmOnSiK+YcgHnJT7HusHpDAqMbz3F0fiPB+aa
         hNZQzkL4wKdDEE0SYC2Kx8Kn+rJYgzUYP+sFbPxuFGvXDkVN9/4N2hH7oseIyiay5q2P
         AcUJ3UqJFrBKercnIBTA1PW1GT19yerPQRqUkvjIneELdGXCMFrjpmRw+7SZRFoJQt1f
         R5JA==
X-Gm-Message-State: AOJu0Yx83fbALuxq6Nu9/FNnWhpNcn4qy2bnO6DPIyyep8/uQ14WzOrN
	yTUDeoOP6f9+OYzqn9Xj6i1c0r2X0R8gh3myb7A6OccuW+H+/ueFp1y3
X-Gm-Gg: ASbGncuhW1D+SQf+ovuY68blXWcaTz15b4y3FxJeL/Ss4lb1+4CyAUiDYpSMnePg0Pt
	BA/c3K3PHw4exfaFjhjwTox+VfiLTW540z5HfPJEL+sA9yIxBKyMY8GYbKbdDLJhCO0ElD6rHFe
	0/TQkc3NtmAxnVhNd9WopPGecBjocs4kJD80KC204xijkn7l8YFFo5KG+8JKZr+CyZMGpgAMbi4
	bRyOLYgdmynmBLuzqwXm1wWitYZ8ydqQ+uVywXLapPyeQvKoAct8PL2p5uslI2GNg3kUOZZ7IH7
	/ikLis+gafwNdhhzuDOcSHEi8pUNX+6+XeAegvMiLZwlNhK8rqlS2qIAEU+g5QeEBDigOV772Pc
	uTeZ6/xKGdfQWWWehrsRpDGZcHX4MFZzOpWpEXluGDbekUJXs1JMUTI29
X-Google-Smtp-Source: AGHT+IHfR5/jHZffQ5LZURyIG2cYOGlo58aLJR2h5oryZJspSDi2W8CWE8U+F7V/ClR1hwqBbMQnRA==
X-Received: by 2002:a17:90b:4a01:b0:327:e6b0:c519 with SMTP id 98e67ed59e1d1-328156cd048mr10690095a91.27.1756734617064;
        Mon, 01 Sep 2025 06:50:17 -0700 (PDT)
Received: from smtpclient.apple ([2804:7f0:b77d:8aa:9182:5541:e684:72e2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329d4bf27b0sm152572a91.4.2025.09.01.06.50.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:50:16 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [GSoC PATCH v2 1/2] repo: add the flag -z as an alias for
 --format=nul
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqcy8frqn2.fsf@gitster.g>
Date: Mon, 1 Sep 2025 10:50:03 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 karthik.188@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <FBD7B727-BE36-45FF-BD19-8086701C9753@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <20250826183205.19566-1-lucasseikioshiro@gmail.com>
 <20250826183205.19566-2-lucasseikioshiro@gmail.com>
 <xmqqcy8frqn2.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)


> Putting the devil's advocate hat on, "--format=<plain,nul>" was an
> attempt to avoid needless proliferation of options (e.g. presense of
> "-z" would tempt people into add "--json" when they introduce
> "--format=json"), so it may not be unconditionally a good idea to
> mimic these older commands where there are only two output formats.

Yeah, I understand...

> You'd probably need to define a parseopt callback function for
> "format" and "-z", and remember the one that you saw the last.  So
> giving "-z --format=nul --format=text" would first set an internal
> "format" to FORMAT_NUL_TERMINATED (due to "-z"), and then to the
> same FORMAT_NUL_TERMINATED again (due to "--format=nul"), and then
> finally to FORMAT_TEXT (due to "--format=text"), or something like
> that, which would give the familiar "the last one wins" semantics.

Ok, accepted! I'll also replace the tests and the documentation in
order to match this behavior. Thanks!

