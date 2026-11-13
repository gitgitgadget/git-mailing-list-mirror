Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583896;
	b=yIeD/0iXj3XFA+BL0/roue4wVgyxJJXFjwoJLsRLMLoVtp+TFo2eaOZkY8pmZXf+t12r
	 ZTmpjmcKgsz8UAtJNm8lRlCW4XhqoDZ4Qds0FIpCOYJOpv/6maiDkS3p2GPZdJCapIa/h
	 Jy/th4slJodoQXTNolyio+k0yL1CZHdmA3GY7odLpaFth37X3ECTKe6K52BzcaQf1lHxu
	 Wa0oMyN/BAdlQ/GcH6gwFBHkS2fdnjSpC8In4RVlqSaDKIK+UVoozUXKbR1anUVez+KoZ
	 +5npSLuTLwqs170jUsS56xwiYf+T/BYhQ7S3rFrQ/U4xHgGAH1eWbNJCw+zOACevY3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583896;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Provags-ID:X-Spam-Flag:UI-OutboundReport:
	 Content-Transfer-Encoding;
	bh=IYmt41duz6E3XD2EWzEAW1oy/+4GChSvYti/AgDweho=;
	b=0Qadgsc0uX2RMcZWCvI+ERQ2MeNpcIiEMz1PRRajQxsN2vrbDQle1vi6T5xCL+jIbrG3
	 J5q9Au+3TGkezHQ9KG01N1wEV3SEKBChzUDUrAjIxwBbCe0VEtCmJ1GVqhUjcZwaZx+B5
	 C0PqH1miBUjj4MHz/8cP3oWGvRA2/IfJxFqgPJGyFI9DdOb8N3fY6+Rpy3kT3t3isEL0A
	 URWaL6m1icaT3zh8gW/2klJxVSs4K0skAGAqx4SSDnOi0tL3RzsJv6SWdvMxssritBkI/
	 /zZ7P3Cym9OHLvdJMakn/576Lw9WHj2ntXq623zJOSUoGitiQv2FbuMHeJy0Ckp7TyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=E4rqNJP0;
	arc=none smtp.remote-ip=212.227.15.18
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B6606A323
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 15:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F2B6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=E4rqNJP0
DKIM2-Signature:  i=1; m=1; t=1794583893;
 mf=PG9zd2FsZC5idWRkZW5oYWdlbkBnbXguZGU+;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:qrXErBShhb2IcBZfJ1R0GSHn3d4D
   qbm6FbtGX7jXWsjSkmYSR7a+rcVM4TZMAYMpOe3f66LMQfawv+F5Vsr+0WH/vm5086bC41t5nmz
   Wf9eyBvE0JwAAIFXVA+u2zTRfqIZgeLfp/aoGXS7bZZAnbQDi1mHBfAKYTjpEGoA4/GInqaDHA4
   87oWLNScrLHy5l7VzRdB0pbLyzDqM47qMebqM7uUDuKDjEMsEDuTulAvvckovP9RtWNGvm1DHpX
   IpbPoY0NRB2XLXFSZxAZ8ZAwQFfhgtUOA0oB5VEWrLWlEzUhuG1dTrh+kMcYq42SKpaTcABrvJk
   7Z/Vl38kRtCyrg==;
Message-Instance:  m=1;
 h=sha256:
   0Tqb09U2klNevFFfNOGBQAbApgwh7sYGgC8RlRzDttk=:
   IYmt41duz6E3XD2EWzEAW1oy/+4GChSvYti/AgDweho=,
  sha512:
   w6zKMr2APP3UmgEwqXPuecc8SxFwnN7EYKJQZf0RsmYbU0dyA6JxYmsMo+LJpRHZu/gdpY9wJNQnJmQA3X7wTg==:
   oEP0OjBKNd6oxhLU5CwoO2+JyZjZv8Caye3sf+d0d83E6HlZltd2Xxk194s+F4QikiJA2/hCs1rVB4g8QaLqlg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794583890; x=1795188690;
	i=oswald.buddenhagen@gmx.de;
	bh=IYmt41duz6E3XD2EWzEAW1oy/+4GChSvYti/AgDweho=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E4rqNJP06DXTMle1ipNlBe/EM1hm0Eyh1ktpTbHIVlXXCm77m1uZuBm/pVkDMb1u
	 7j48wcAar2R96efs739nNJnpjFxydlCctAteEuqtCLALOtfs7y4GZmFJJr+OIkUxs
	 5Lf/wzgU1ufvOJ6F1hAAyQmaAXMosiLOlqxMtyMyYE5kf7KzAD+4vCKDj7e6epp/F
	 a8/aOEQFTidWjyOtm4dCBmi9UvMFEahFF7nrNeEirPC/90uz3qI+AbonceJ9tOdxC
	 EKjUU0az2MxmP0n1fTLLqIEajyRH/qqByxrff7LFZsDF0R1I4w+TX62A3nl3DXq1D
	 NdbPw4rq558cIvcbdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiacH-1wmWHe40Zz-00ciJo; Fri, 13
 Nov 2026 16:31:30 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1xRtFR-oyB-00; Fri, 13 Nov 2026 16:31:29 +0100
Date: Fri, 13 Nov 2026 16:31:29 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] commit: remove padding from struct commit
Message-ID: <avctUapIbXrL8q_e@ugly.lan>
References: <pull.2309.git.1794500044740.gitgitgadget@gmail.com>
 <xmqqpkw9j1ng.fsf@gitster.g>
 <CAL71e4OS8MKZMY88C1SMs7ufSZ98-DNHNBc94cESdKpuXKbs7w@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAL71e4OS8MKZMY88C1SMs7ufSZ98-DNHNBc94cESdKpuXKbs7w@mail.gmail.com>
X-Provags-ID: V03:K1:62mAC5oI9X0Un46QWIEIZz9a59UgJGwrgJ13YjOjOHyWBkP4wok
 n2D8W7xl6pHvETC+7FdWQ3yjmkOZXKdgPrLutrncJeO62zrqH0CKm1FgAvsgdy5YleCAntQ
 2tulF4QehZl4JIFQJ1dlx43ni+zuA7bpmapfqheAJNnyG3Dr6ZsK8h21QG0DSbD2oHr055+
 UgZ5acnYGLDTdxp1F8RUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FAzsNWowCg8=;5k0WiFeLOibGdaPQq5fZ2RVHbf1
 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
 uWnw7g/JpJhw/nj3RTp7ubceXr/e25zs
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 10:35:42PM +0100, Kristofer Karlsson wrote:
>If "struct commit" ever ends up with padding we cannot avoid,

this is a non-concern - one can always introduce (arch-dependent) dummy=20
members to make the compiler happy. not beautiful, but justifiable.

