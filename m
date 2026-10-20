Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498466;
	b=oe4cylz1XaDWwbVSjPwNaZ0v2rpfz4legg8KDnQMT7wpjVUaW0u1Xe4SjpxiXSBzZUTy
	 lPoO+oi+dslLO/BCocNH42tX2sNuW4e5DQspe3iinrAawMxGqeHzc7OTzryJV+u7ZQ0I/
	 b/I1HRTWV7eMHLLfszMPtWMf2dnsh93iGruVsRPmqanNizQro7BKorFfVXxSe+oLs2emm
	 CEdrC+22bI79I/6qwiLMeQYZ9vfbdFsu6NaKBXBtF7VQg8UZ+IM4GqKkot3tEqgQBrVET
	 d8pz8/MOsQrrgZFpDNhljdOo6Ec2VB1luZFEyOGDoqB9i2zpDAVGF58GPSC6yAMBKoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498466;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=E/JIEH0PWppCtoaHfKVvbDDXa6uEcfJdIG8rbSU2zm8=;
	b=4QKRTfzyJBTvOSNTjv9iR2HeccC1Ww3o2mEPOsEI3TMIkiu3D1BoiefTA1bNQZYayuC1
	 ZKybiH+5+nB56oVgvk/tf5dQmEqhbSVLuDnrRa5hxgOUCDDLqT3H4a5gvWpuXSV20QU2O
	 N939Dph0yUEjgrWtyIiTeMQzn2WVdP9y2KefQe6UrEUwBxDwaMJ1XzQNQ9Bsl3lpvOM/m
	 YxbSIL+JH4B7Hc8FphqfQpe2KLBE/79HFw89hex49Ck4cqwIBsfwvnWb9GR4QdekDI4Yu
	 BzLV+Uli88XMBHrzDOinbU8FyT/SjmZFFlj6yD5pL+2qHzDR1VZMZOpE8vuaRyhxSnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=IDKFvuC9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DqXD9W1w;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9478606A31C
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 12:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9478606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=IDKFvuC9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DqXD9W1w
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0023E1D00126
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:14:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 20 Oct 2026 08:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792498458; x=1792584858; bh=E/JIEH0PWp
	pCtoaHfKVvbDDXa6uEcfJdIG8rbSU2zm8=; b=IDKFvuC9MhmwmCqADPhoxQHIOG
	fK/Rj+a7dBqlRPWDdkGtokeLjasSzcZAmdUHBQMkBjFKInplGTq7oudYZ0EAaq+T
	xeDSSoGOh5oQGfhIA1813KzxabKjfQmoOFj4FCA4p/1S4VICje0oeJW4AFvFDTzi
	f2AiD7KIhgHkIDZCHE/HVsSucwy7VKSmwJYfkwUd2dbTfJZsfhJK2jr1tixbY3nl
	g+jVPJTWBfCjv1XqPvwJVCqhF4VgB9m5pRlE3gezg6ZvfriMIxRfE1bpt2ZDEBjb
	YZc9JmfEML9hO7vEFTv1nMoNgJmuZIimLM1gVZmyfs6vVbjnmmpHxVwGlmdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792498458; x=1792584858; bh=E/JIEH0PWppCtoaHfKVvbDDXa6uEcfJdIG8
	rbSU2zm8=; b=DqXD9W1wwg9qE8w0FWmve+vWXkmr5M94QZPxRt+rP+yLzNk7tVO
	fvMNGz/YIppjbjt0nVg8T0JO4ZCbWUNmErUtSYDC9g/JhV3OF79GQ2ApRpHYgmA/
	5A+0KOP37RHVuSzdbFz+kxsIoI0EL9VksTMW2bEOEca2U65MHDJh58E6A7ueIaFl
	je6Ix9RyTL8hwjf4QWbCM7gEMAkD0zZ8kV9AGYgqfcJ5UKGLp3mjYkdtjI6GCyaI
	7LsrjKpS47zlBV29yIaq0RZdEcQbumeV5XOQX0nDtzSJk/QH3s3qQJ5EWRIEsZ7r
	bu5GIktzH6bi99NPeALvhLIw5Dm8AVO3z/Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792498458; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:eZ9QzFm5HKEOJpxld4mQ/Dn6a07dkmwzY/vHWECIknceQSu
	W5DPf9bo++62QR4XssEltFVgeFefYJkyuPkjoLJoKJUH9pBkmSiL3k4/DBVkUnL2
	blxaOUdaahVAtwYmvPFljlzwHyNRVoi2ENIfqHIM4QnCFU7W1v2xqDjP+++WbDxB
	r83Co/RUllEf5yt6R+KGvj6Ovmgbv6AH4QBbOUZFyHodZ2HDeKyzzkWhYagzE7K+
	iDHJ2HiI8kC1x6b8t+J5VAl+h/CJE1BQ8H4cv07yzK/0dZk1lO9esQUfVcsmFpHM
	BSuO3MjQEaUE7G61mfFeT10Cv9oLWOeo0gVFauw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xBIWF+IiljU4n/Oe3DIL2TeIoRtCLPNqWYCMOzUaHKw=:ihBJq2LG9C2nQhDZxptXaeYj2cGw/JfhrCozPA66ZpQ=;
X-ME-Sender: <xms:GlvXasF-ofHRwx7UWdqDq9sHGnBxlMgoisGuvcRA3wAsrlR1m3Va9A>
    <xme:GlvXarX9Iwonkw6l9iqfUNy-zhA6Ui3jD0xcrMKtGX7ci7ZYCtAylaP5d8tszjaHA
    AmCqL2pRAQKc2vepiS3tAu-Vg82vtkir20HS8TQL-6xHzcwxfN7ndc9>
X-ME-Received: <xmr:GlvXajyaaLTtZrzBSfuJwIw_AJjHrStmYRK6i9jI_m4t21L8cFf0Yl6p8obSSJ7eSdKWxw>
X-ME-Proxy-Cause: dmFkZTFgkzPBMoQdUmHjCn9KpIK00rkSm7jJY4EL1drc/4G6CjUMNV11ZJKtegibkp/fKt
    kARvNm3RlYhWG/sw3U+k15IDFpWyNnE+KNdQgReS1peSx3TRXIiN71RKKwyY6FGEgO9bd/
    HOwH0YQ91IDcsagJf3WwChRm7ACwKaOelnil4D7HIn8qCWRZ/YbvHLRXZP6p55C0U+kost
    AEN3K8MzqN+8YwLKHYPE8upWo5IH4KJ8vAaLgrFY7tHaVIo8z7f3rJcc85wiyGafPj79f5
    yTw1HSvipyNP0vDMk7IG5sJuPcyUXR8HvW12theKtR10d8CpWJb7LGI0r/njoxG0pln4o7
    0zNZuFFQhN09Z1flKqysI3kUrJeOoa9TZp1R5c7t7Ung/CadYXIJiG80SyrdlXWgjkLK8W
    9VyZ7ONfwMiqBbFuAQ97VZvT/SxeDDNTs6K7hQMhZYp4qtip8QWHccsYOu+buphfA5v0qq
    qJvNNUi833XLIM0RNDDhKtoTSIFlUiiqX7NVuTK/+PznLH2GOrQ4v1tf3IXWXtxzTp7m/Q
    BVroyOeXpo9IyMPm39lCnoIfBYXHXHC0IrBd5NzFM63Ca5SRYFQnLA+mF1a2+94Hv4TCww
    Git406g7Y18su4k4VxSYkEC1rba+hnNeybaRHtUH6rtZX7Vd7aLNHHuZGI9g
X-ME-Proxy: <xmx:GlvXapPcRSrFKUQ6lWawDCrpiquSAZYhZWw2HgxFwdyghSaO-KcEMQ>
    <xmx:GlvXak56NX-KvvwOMbR_WnRjDoqvbrddm1_-qxUtqA3WbB6ycMdxow>
    <xmx:GlvXaqMSJzfABsaLi9U6A_JBbMQolzOlrY-OUQBfFZ5er6KTBXrabg>
    <xmx:GlvXaikUOvpLfcM_TYDG3zp5IKwqAhFrHNEwP-6mf4dRgkw6ryEUVw>
    <xmx:GlvXaiw38mupim3QMpr8o3IN6gtPct6hnFMqA_sx-1njqd2ugxNjOupm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 08:14:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id defa3a67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 12:14:15 +0000 (UTC)
Date: Tue, 20 Oct 2026 14:14:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Matt Hunter <m@lfurio.us>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] init: show absolute path of (re)initialized repository
Message-ID: <atdbFLArbbRRNXNB@pks.im>
References: <20261020053932.1274210-1-m@lfurio.us>
 <atcQb_V69vvKnxoF@pks.im>
 <DM9JTHREBQOW.3IOHX6OZK3BGQ@lfurio.us>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM9JTHREBQOW.3IOHX6OZK3BGQ@lfurio.us>

On Tue, Oct 20, 2026 at 05:13:07AM -0400, Matt Hunter wrote:
> On Tue Oct 20, 2026 at 2:55 AM EDT, Patrick Steinhardt wrote:
> > On Tue, Oct 20, 2026 at 01:38:47AM -0400, Matt Hunter wrote:
> >> 
> >> None of the discussion [1] around the original patch indicates that this
> >> change was intentional, so address the regression by similarly using
> >> repo_get_git_dir in this code's new location.
> >
> > This indeed wasn't an intentional change. I also confirmed that with
> > v2.55 we print the full path.
> 
> And with 2.56 :-)  Output changed right at the beginning of this release
> cycle.

Oh, that's something I missed. Even better then to fix this before it's
part of any public release :)

Patrick
