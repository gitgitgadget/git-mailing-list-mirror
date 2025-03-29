Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3261F372
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743270189; cv=none; b=sAw7Ut9XuPsyTXEXRXMjjWN/nUHqefTs3WpX2QdydoisKtb2fOxg0BLZUBMtkkAnnaRhhHRw1UVruvqOBCcX1eXQ0V+Nd91oEsXIMFlCHuR29HJ5DKBoro1DR9Vf97V8Lv3++tAH6hW1ViEcFtdlTtcZBB3vE4ezgMvg4BcpsX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743270189; c=relaxed/simple;
	bh=4xlkltp6vhpsMv/Br5LeLjpKXkfUO8QJ9q+YJSrFnbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dd/2J6ac13TcAeI/32XXQpUWDz9K0F3Sez5bq8AiWkJ3Ur6Fd+INtztnIep6lrDi6pB0xEqyQoXaAg0f8DozSo8ucd0QdTztfOOHPugrWX6liyiThQVx2bhxnugmExtHFN9w2aaZwXu4oqjJroQvf4MqMTgMae/sK/7JZ/HSUJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mA0W4Prb; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mA0W4Prb"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c592764e24so345701085a.0
        for <git@vger.kernel.org>; Sat, 29 Mar 2025 10:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743270187; x=1743874987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4xlkltp6vhpsMv/Br5LeLjpKXkfUO8QJ9q+YJSrFnbM=;
        b=mA0W4Prbt04V0YHbr9ayepQ1MGKLHjsJX6lqfUdXp3QWbrD1MQ6unoLTFmBHwkGx/+
         oze3PrwK7aMuiqXrUi6d6N0qqGEfQR1bNkDKF8jselaC9TwnjUT5uGctAqVXBMox2Az0
         YwxxraXejNIdNivnMolr9gO+QrJUxT1nA6ujFZsSN5Q8iUHlP6s5p+C2sOG5GPO9h+vw
         DmaWqx4ZSbqsB8KqhAu215ydVr/1h0CIXyHZSA3iMmevkykeGbpAQQ7W3jw3Tu9wkWn2
         qkdnOj741hC/c7WSHNLThgidZDhU5PSZ35hs8YRFIx04iogbf//iEiC+z+7Ps5zeiOBM
         oqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743270187; x=1743874987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xlkltp6vhpsMv/Br5LeLjpKXkfUO8QJ9q+YJSrFnbM=;
        b=RlErHHP8bA+HOhVIA+3qx+Ten8VgLy511CkD4LDm3va7q6sKDtCTknHWSknggOm+uV
         zvsgPZ/irlJCSsOW+C1lVAgUP+RSvIXcqHv+eymwAEPowFnaD9ZZ+l1sLyF71ft1Marm
         QjTSawerKmvmn9MeGC11K5oeBDyWpapfpe6u9nClVscX3scE4yOV7MoXDqbF2g5cWKHI
         B1P/9seo6EkVrGYcz6CguNdTzDgOW2YcmT4yrw695YOCDQ/wvidZr/bHx4TC/Qx2z5tK
         3YD877eA3uWupfbXBk+Lv0ZUyS+jPzUASoJS7ydBO7MtcARMy19hdUwG5/k6Iu0bAqff
         HtDw==
X-Gm-Message-State: AOJu0Yyjn3c3hwyMxT+3E2rW+5Zy97u/h2XB7NgSkVS2xVBJeOWQ3uZ7
	IAcSNRGLtkdH1KlWloTkqFanne0F+PseU1DYAKLYDwEUQCVHU34h6C/p2k9ivdBNL4gF6HMi3aG
	OCeuOIidFdd2yylYRJlsVYj4TWRoJUw==
X-Gm-Gg: ASbGnctfmS0lHR/UAR2dtjp2DbhZ2GpvskhYUaH7QRJWCErk3Qf530Z9jopRBKDWEfx
	rmU+nnTS344FHbXHuTk4ZTdVmVWjf9Kp2oXF2+rrPtenZ12FehE3LmU9PkXLFdbnS2AOl/QB3Jo
	GXNukJIQFdrnozi6deMcTSUu2WDj/MClMfee+evbblBLliY+rMdku5W6V5kF0=
X-Google-Smtp-Source: AGHT+IFd35VFaaBoArHewpBDUIZY4bUIf7vAS9uAMRVIGkR5byGzwkPWYjxsChY+abMUopzjAF4Zhe9wXb6G34tLuu8=
X-Received: by 2002:a05:620a:3725:b0:7bc:de68:e932 with SMTP id
 af79cd13be357-7c5f9bf914cmr963168285a.23.1743270187049; Sat, 29 Mar 2025
 10:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqa59evffd.fsf@gitster.g> <20250321143022.5406-1-jayatheerthkulkarni2005@gmail.com>
 <20250321143022.5406-3-jayatheerthkulkarni2005@gmail.com> <xmqqiknzqu2h.fsf@gitster.g>
 <CA+rGoLfALoTvQuAzQPx7rqd-Zy+wMiyEbF5Y8_-2Yi-yE-2qpA@mail.gmail.com>
 <xmqq34f3qbna.fsf@gitster.g> <CA+rGoLf7R5BmpN1E+AXYhEKz=Th2TcpfDr0NxNma54GR_X_K-Q@mail.gmail.com>
 <xmqqiknwldob.fsf@gitster.g> <CA+rGoLdJucLSe0fMeOEd6aTJP4p7JD7xyrPmWUetNWbQ0CoeyA@mail.gmail.com>
In-Reply-To: <CA+rGoLdJucLSe0fMeOEd6aTJP4p7JD7xyrPmWUetNWbQ0CoeyA@mail.gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sat, 29 Mar 2025 23:12:53 +0530
X-Gm-Features: AQ5f1JrYjRwQTYz2h_2OtxvZtbwx6PHd5H-5stmztLGd9mtu-Pst7Rwu4wOQGQw
Message-ID: <CA+rGoLe2bn=NXYChq=v54QzPCaVMNVO-7du7o--iMawcD0jCcg@mail.gmail.com>
Subject: Re: [[GSOC][PATCH v3] 3/3] docs: replace git_config with repo_config
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hey Junio,

I think this email has missed your attention.
Apologies for persisting,
but I think it would be helpful to know how to proceed with this.

Thank You,
Jay
