Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305914;
	b=ydUZLvbLrutdRpKCNKuNjFyW2LJ93pYRFNr54AU1Djl3DVb9Gstk0aVGbMVuc/jS0LYq
	 d1Cqcf6/m9vS9cjYpyy1/dBJfHOCZNwblPg0MIYcw4leY/6xxH87oCmF5WP9UrBU4lm+g
	 mhlu8NK+f0UjTPR93JPj3Ny6U4TLpLkv5Gh3W6fkIZ4XlXCZjlylq+VUJnhF3vQ4UTr/Z
	 T2Gh1EZWLAQv0ioS7JY2tcKipSiCDJHKWK7a1vsTXlTy5XM14LyC+QUZazQet/gSBro1X
	 pptvFnkqYOYYd08JlZOhKRbQNjKpYLVylZ3VzkjKzo6NEYw4Mu633RUbUZ8yz2ZBRIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rozNt1Pvxgwo+7+V6qPgeeU7KHOUlWIFLURsJCEH85s=;
	b=fuuHsRo4N4vNPZIj4PbckcIN3tD0xFgOwhRAThatgMTzXXednhiyhRaRUkLFzgGe9zix
	 +THikfTqAP+G6wn5pEtDrzeO1x7aDB03KtjJwJgFGK0GXqJXN+4vhVowm0P62frCqjtDO
	 ggS3nStZ8feCvSL0uCjYURmBMrlRRiOwvQV489hX65soKxh5A2UxA0g7YjIqGWNvUIrnT
	 +RRO6Be33kY+kWWlrZosRRBYtLqjFdlIRsSFlXcp5eL8KwgVhn41xM0+fS283+B68Soia
	 9De40cdU3nR/RlPzvLos0Joe4R1/VJ5v7E0PL+lDDIoa2N4wmGzJORiV4haIotkPy7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=AlcCmdfy;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD6D606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 20:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD6D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=AlcCmdfy
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e63ee7b4cso267484485a.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 13:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793305913; x=1793910713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rozNt1Pvxgwo+7+V6qPgeeU7KHOUlWIFLURsJCEH85s=;
        b=AlcCmdfyT62Y4gLWPbNzCoDXkisCfqzc2bvkHWX+lKviNGxOSHqduJBT2/1ie2bHb6
         tdg2oQq5Y0LGt5gmRvLy4cjiBRh7OYkrlFDfuqJMVyiHCUalln3geOcMgQYQqF9saq3p
         Auz1UFLXCR4rjtMRLTtwY1UfHneYaim9JbjJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793305913; x=1793910713;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rozNt1Pvxgwo+7+V6qPgeeU7KHOUlWIFLURsJCEH85s=;
        b=zs6F+hPcl7wnIMG3JHnplYMiLD1yToUHuKbMj50kZoqOWO7mqAN5kXiIaBp9NUxd/C
         ECWG+7jIPYSaqUQcpT0GkZPgWSQRCuRaZqtzf8kZt3EISFDFvFqS6mwXHprlmnZzaDq8
         IyPvWvvp3re8ZltspbOIH8+cIVgx1yMNJ5jN+uHA8LTkkst9WzlC4jITjwS65Iy1Sh2d
         KUnixaMSNf4T0bYXcuCeq7qf7KWKgRwPa/9ocS+laMgull86frnQR7ZdkEiL+jReSS2A
         Le/grtwP9KYMgG1fqZn8onnvypBxUd1QHnlqTnJVwwcUOR8vYp/LIZVKbc8BxO4xjayu
         N3vA==
X-Gm-Message-State: AFq9FYKdysguioRzOCRnmwYLB+HIHHuioiPWt6HgYoiuiJBAdwl/UF0i
	j5h4iOjaaHsKe14/f+gaMCdZEO5tPpio5CStYOD9qTXFJ3S8j2ecF+3fLmZ95crZVdGYS/bKVob
	mx6qUPsM=
X-Gm-Gg: AYBFou3JxUY/j7l3HWZuE+mWRfWP99gFPmd9Y7GK1A2gN+aXCP3VPQFXaWnlelxZLbt
	6KalpVzBgZzlmyJDCPMbU/paS7HBqvAMaA0e9+5f1IBV87kUCknia5TT6AQOOugEvhlxwBZApdm
	a5phTulwSRf2odNit0ZBtDixEvwwUqnXDSX/PL+i5ky12BjKn6s9Lia9FqhdKPljdKoof/CeZWe
	acuoLD8GTXTrNE7kef+zF87cozx0/l1FLgHoC+4izhC2ogp3HMjOgRpfWtCZ30DI0qAtFyyzqCe
	4uAlcjnTt4QRifMAImvM2t4ACaFPmHu1XEwibP/Pq4k8HdoZ06hn0UUkFqKoOAoq4nKfDLrvpy5
	yBU7iRvxoyAozWvPO/VRLVeqIhdSCfwePV4RNthE+nIwSl71AdJdHVdEh01vlvsFWKmOO7a2tHt
	rPmBofsyUSGJ9R3LMcueAxtr8Qk1hNqiETCc7UNuEPXgFAkob2VoDFxTmDAis1oT4G7b31CXoOE
	NYJCrEGEJgpbW67XWIdPOaOSfQMdVyozTgNEVI4j4Tn578hIhuZiFOZv4Qv9m0CuzXUXls9vmXn
	zznXnGa07YLR7e2P5ewFRAv/dBCbbOuifxmWqdXht5JG9nteiDFEC+OcmTiqvsZsi9kZ39ry2xG
	Jkr/vDpHZi7DgsGawFkbpMeu5lBagV9USDJrb4OwWpQ==
X-Received: by 2002:a05:620a:26a9:b0:93f:1cd7:734b with SMTP id af79cd13be357-9442174f216mr52977285a.34.1793305913516;
        Thu, 29 Oct 2026 13:31:53 -0700 (PDT)
Received: from com-79390 (vpn-eastus-02.tradc-corp.com. [20.102.114.220])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944210e4449sm36228485a.5.2026.10.29.13.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 13:31:53 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:31:44 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Pia Park <pia@pierre.co>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] midx-write: skip writes with no object entries
Message-ID: <auOtMGiGOvWVtkl7@com-79390>
References: <eef33827000cf106544174ed000129c2989af1cd.1788851232.git.pia@pierre.co>
 <97eca05600afc5828e3f27c6fcfd3f7872ca326b.1793260625.git.pia@pierre.co>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97eca05600afc5828e3f27c6fcfd3f7872ca326b.1793260625.git.pia@pierre.co>

On Thu, Oct 29, 2026 at 01:26:17AM -0700, Pia Park wrote:
>  midx-write.c                            |  5 +--
>  t/t5319-multi-pack-index.sh             | 15 +++++++
>  t/t5326-multi-pack-bitmaps.sh           |  9 ++---
>  t/t5334-incremental-multi-pack-index.sh | 52 +++++++++++++++++++++++++
>  4 files changed, 72 insertions(+), 9 deletions(-)

Thanks, this version looks good to me. I agree that the remaining set of
questions can be dealt with outside of this series. Thanks for working
on this, Pia!

Thanks,
Taylor
