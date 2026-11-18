Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795046059;
	b=prMSbr45lhj643ePPOL4Msd03U/zByBy1fb6NGlNjf0Ba7iVUAZzWXXvm145CzJKTP2D
	 jgZzG1UeqZOhRfLBKqBYntKRapDkWi7XXx0dic5ZMkDDVaEiObBPmksxR3XL0obMNUr7d
	 /cFXN+J7qG+foaFrNBw0fEODBMiSDmO9TwxOpN5Hdi1OoOU/UdaQfu54XMQSdI8gT2yMp
	 pz1BCXhzkV3f9WKsUd9XOjylhHAFtQZMmMFgx7/mdoytZ4gJQqLdIRsIGAbBCy/wxSUGG
	 +i8ETMcTjDIqD4d3lHmvDo9hMWT3qcfmrasGgOW+3jcU0Lj78wGSDM5GG7EKE8mDrEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=8hiqtWx7LclBvhlgmIac8c9KwMyqPRLtXmLZo1jzcYQ=;
	b=5qla1iVNhNOGANxHJ6eU/MVHpjBCPAZLb5F7ro7edi5zytyELWNSlMM9vYa1NK8E1+Xm
	 KFsynbtdqUgXZTMqfiBbOIMbqibkcyKJ9qPb4NO2PCb/eDqGkHxhbMppvmdjYd1QUjgYz
	 I8CvGpqeULpY1lzEm6CmiUVdAVNNMJqN4i32ra0GKbo5LRGKEYqVdGnl42cfy0qlw6rPx
	 2lNnibGwSFvvpoPdoPBrQSP4SKC/QOO9dFAZKu4M5XQS/fTohTHkUIw2jMFJoivjZH6gc
	 uPl2CL1/Z7MGlgXNIM72dhjssFnx9PHpaH1UdY9z6k8viD5+y1hv02NhSwpEl6htfsA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jF6P5So5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D0F606A332
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 23:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0D0F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jF6P5So5
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67db89857abso2012243d50.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 15:54:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795046058; cv=none;
        d=google.com; s=arc-20260327;
        b=K2T4YJTar8G/Vp7e1m1X8sZ1lhuRQuIsvB6xazx/vDhodtZjvXpt4pv5eOc6+pOtEw
         tnXXMhj/TLfnCbFmlcIMoiPgEmF5yoQc4akQY390KrYu/l3glVBunzbZSEYn0f+/t0v/
         8HsIBN9geKOsPG3l7PzqArcvNs47kPqVkqA69zxrZoQTEOeSnOAP8eMw1LuUgawEN1p3
         LztgU5iYB9AQqYkNDW3wSWjTjoNhO8j9IOw6LmemLAuAYY1klaHMwR8Kc4bXMXycgvv6
         A2qKWNSxKTpe8hwK8sgJz1U7AOkyMT4uTZ2hvfLd867zJzymjD5D8ED6+nvZ0pJhzjHG
         Nj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8hiqtWx7LclBvhlgmIac8c9KwMyqPRLtXmLZo1jzcYQ=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=L3GJVkmtb+WBKZOhnP00ydmnmOMutIOrMKi0SSNJ+hM0RRo0rYrBRhgoAFF9BTLDNF
         CcOOvRM0HTITc5+Mom3tM1663xQnxe9VjIBDpJENhT0Aun/ofYp72GPDV9btTH0zFJEa
         pUvt/VWi0EckWafTug5bPkbslLIj/gBr+yui0l0Ry/YSXbe9hI+2VDPwseO4I8Mmnn5s
         MVp/LyB5JIUTzLJyaq8FFEexMpvFJ8CP5or4qSHU1S/SWbxWqvlYASovJ226ckJi+r84
         SBIq4oX/2gcy6hDXIcM8/aQvuuRVaDoxoWSoqmxhYBrdCnAhUgoRfxeu5/CRCyUhbKaY
         5Xbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795046058; x=1795650858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8hiqtWx7LclBvhlgmIac8c9KwMyqPRLtXmLZo1jzcYQ=;
        b=jF6P5So5RhOlAtEUE0oybF7+byWPuH0L4no0+ppAPG6XPtFPCtC0uCLyaThO/XTAh5
         rX/+ibFXJ2ihgjBRjEr+mFksIYSnq7yJSvWZBrReqJauQuQMCIMLToGsKGKA+7uBTsYE
         h2IRmvld8jjLvM4lUpc57lIMLNVY3L7ATx4CNMbbnEwuQlxJ1zCXqeeXok59T9pdaDRE
         7wwN64exPJqxPZOUEeaNmg0ccnCtC8SGF0BDYgaG9TYItYQ6yGZ7mfoH+6bOl7Q9wmh7
         bdksKt6BKSBqS8YNWrpWSOSyzr4QxhjcFmr/kHk8WXUB8t92By6Y9BIHW125jclGZD1R
         12oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795046058; x=1795650858;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8hiqtWx7LclBvhlgmIac8c9KwMyqPRLtXmLZo1jzcYQ=;
        b=ltkGx439beLmgWQJiZ5Lqwqu3VEsiJQr+u350yBpqXt2S5bCE+IrrkrQRoV5mjuFql
         o4NMZg7uS6RdUH0/LoDnil0kjgq4EXyr1EpiGAFekKYacWKiRJliB8KABVsIv1cfABHQ
         JZg4fmFPGYdhv9BH4IJS2ih0i2e/7X6YyfyYwVqzqakNgi/iprYMaH3bsw9C78wASBjP
         mfWWhLWhHPCRhNFVyhtLpZHlOsJb5R5pIxUr+6C86grDBIPm8hZyGkBjJ0b47Sq/Lip4
         3sPoOuq2oM8xlR6tWDndHO3UxPD+NSnvpdR8pFjRAOljFzKvy2SO6+ftc7e/QIaQf3WX
         htnQ==
X-Gm-Message-State: APuU4Z90gqAMqw4acyh2ansMRRHBgLXUxqIrTL3kr+Ab1hSu+4F1y0tZ
	Ekp9OXCtYuUQslQQ81qjHZN0OfVukZNOJ1ByQRllU1a9bngOKK27CiVM3n8YkHtlfrxrx8vAoLO
	NvaXb0PkYO4cd6EPStMVduwfnyC7dvEsxEAgUZWkNRA==
X-Gm-Gg: AZFdTZfyuEUlpGhWTyVDKeLWX5vqcEypvwlTWiAzyvmhTHPZWH87VOz1Ud5wOAZWhaz
	ve05Ckkcl3te89VIJRjxJg/xvsU5xVkactWyiIxX+3I2MlgsRYelW9G6iu+vHr8K8fvDtPz4YCZ
	QuK0jlGKSKcGMfjCo0bC6NSwxq8zJpeOQrS/JWd6o0RJfx7kAH9HswRs4qFFN1Ub+0nr3F3hhFm
	xZO7dtD7pCndHW0XVQBdey3MXR0WFU5wfq9HcA6UqfJ7Lxpe1dHMGNcVm292HLq2si4Q8D4HcmX
	mrbjdLE+/XGDvbHJ0lTH8b8xVuulXyvAvUSMkpLfuHYXvg3CPd8aU2wirauhTaz6ayCir2RgOJF
	usGinp1hCTOyoJeyJIjPkCPjYxRKZvo5UNQmmJdnAC03y98aUZZDN7WoW4X4LTYcfMetS11WfSm
	y2/Ibie1cDxPwUIPCWx554T4GHZjVC5/+Sj3UPVy25RD/9HLSUf261vLXbZQI1oMxmOpk2NRYvn
	9+4qDYTZb5lcEoL2XXKIF3RqJQg44q82aeGqg==
X-Received: by 2002:a05:690e:440e:b0:67c:332f:3fdc with SMTP id
 956f58d0204a3-67dd3fb245bmr1129534d50.82.1795046057839; Wed, 18 Nov 2026
 15:54:17 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118105227.50447-1-okhuomonajayi54@gmail.com> <xmqqy0aq56oj.fsf@gitster.g>
In-Reply-To: <xmqqy0aq56oj.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Thu, 19 Nov 2026 00:54:06 +0100
X-Gm-Features: AclHuK8TJujNmKOvpXF0zMay4O_E_vbHtVoPlwUArw0ZVqf4ms4bpZV6UxaCULo
Message-ID: <CAFpMFfDOGZUFPRfPkCXZyO5hJ1O7gfjzTnv6Djs=EMPd0VmfuQ@mail.gmail.com>
Subject: Re: [PATCH] MyFirstContribution: leave a blank line between
 mailing-list paragraphs
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 7:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> Sounds like a good way to help readability.  I didn't expect this
> patch to extend MyFirstContribution, as the first chance for anybody
> has to deal with "quoted text" is when writing a response to other's
> patch during a review, not when responding to a review, but it seems
> that CodingGuidelines, Submittingpatches, and ReviewingGuidelines do
> not even talk about line length limit for e-mailed communications
> (which is a bit surprising).
>
> Will queue.  Thanks.

Thanks Junio.

I am working on a separate patch for the line-length limit. It
states the limit in CodingGuidelines, SubmittingPatches, and
ReviewingGuidelines.

Okhuomon
