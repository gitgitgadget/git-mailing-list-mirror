Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795850015;
	b=3LmSPrpGIcL2PUV5l1vPBwEAPHbQe2eSZDT6SdsNmGe99gw/rQPATS1KxD+93ArBVCJk
	 EBi59PUnolbX0S3hciiycQtwyaraK1XBSOQmaxpnyB3IC37eSVq7FBsNOQ657+iqEBEH8
	 /Jjr4rymP8x1A0mr7ggXqNjbl9NAf2DJ2s992mbr+2ZMb6ykdr0ffCrLeS/bqsYoaqKce
	 A1/Vq8+gXPnK9FMC1eFuDpWkvRQLbfzPRt50cawn5hHHTN6hh863rtUITtKrcvA35smet
	 sMUanr7g6M6uAjnRiK2ufIxLe4XN0MYj/+f8Sss0uIVsJG7r/2tVorNocjl9CaFUt0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795850015;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To;
	bh=PbAicl0DG5qHnBrjYiNVd2LYZ726+6he0IcXzp8ePBY=;
	b=FJUBJQ7AD4PcZ2RYnOYXtRDXB0jO04GZ82X47fikVR5G7G6istNEJWVQqaFLcb+BGlJ2
	 8+uy8+9KeHLXxdzetJyVNsA5UXQDEJTQIaA8hXluHAuGlGNVBwaXbGvAvIVvkvzr08qua
	 y6JY4wwWjVGiSVeGFi67K3fP+3og3zeWNxBfK8nCh5TcDctMxqvMbb2jBPoqNIng4BbxO
	 c705qKsFwW1hsGjdW7mJyIq40Ra627oeEYdv1+lrSX00j+mWYXFx/gThjZaOfGMDPw/GI
	 GSC2iO4rGNlptS8HxXgTZCbQIgCtnst+2J2nxN4gFziI4xWP83rofA96pVJZSd3jc1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=RWosgHoE;
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102CC606A31C
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 07:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 102CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=RWosgHoE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1795850013; bh=JjG4d6CTPcqTgm/mO3p/36lOZdVmwQg4sPkRdrJcsLk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=RWosgHoETdr5E0mzO6BmLngDDTqwyCfbBITOwEnFBnBKvi9Tml2rLkluDc70G67p3
	 2E7lqK/7ozmgSkKqzmpE6wABpkLW7dPs8R9QAZKFmeczM/j+zDkXd45KqJ0xIgAtPO
	 iLB7cJVLltkJmiK7Z6ATPYn8A6zfy0F5kz/tENpc=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 74DBF63F91;
	Sat, 28 Nov 2026 07:13:33 +0000 (UTC)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 02:13:06 -0500
Message-Id: <DN6NOUP5N3QB.1F84PP4O8PYYW@lfurio.us>
Subject: Re: [PATCH v2] gitignore: rewrite wildcard description
Cc: "Windl, Ulrich" <u.windl@ukr.de>
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <07b3498d83424cac87221724b371839a@ukr.de>
 <xmqq5wyjxgyn.fsf@gitster.g> <xmqqh5hx4jz3.fsf_-_@gitster.g>
In-Reply-To: <xmqqh5hx4jz3.fsf_-_@gitster.g>

On Tue Nov 3, 2026 at 5:40 PM EST, Junio C Hamano wrote:
> The documentation for '.gitignore' makes reference to fnmatch(3) and
> FNM_PATHNAME to describe how an asterisk "*" and a question mark "?"
> behave.  Even though it spells out that these wildcard characters
> do not match a slash, it does not say if an asterisk matches an
> empty string (it does).
>
> Rewrite the section so that the readers would get a more complete
> picture without requiring them to know what fnmatch(3) and glob(7)
> says.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

I see this patch has been stalled for going on a month with no feedback.

However the rewritten section, with its new explicit wording, looks good
and clear to me.
