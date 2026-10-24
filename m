Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792801926;
	b=fXhC2SUYgpjMrwPrpU/h5r+Ly3lpa5Lekr1GkQG06rmoN2GFRaJ4TgnOOggnmlhMX/Nk
	 BMBKhH5TKNIL+30cwHHY1QXG/JA1s1v58k4q+9HAOwT/lN5PFm7dXbHewc4nD3+YtTdOR
	 MHSk64+wnKvU46R27sYTMfKgwWrCb90/nJ86cHIjT6sNkY/Y6G41Jz5JC90m/9xCZ61eC
	 U+x3AiGFRrhTlnBYSL+pcEqs+L8ulShNFaFN848J9LHt8PmnFHP4O01dMgciC5ZiqyC39
	 GX5QVoTyf4WIJE7fLAHtvoj/43oi9deo5bQw788miRALwYlF9rGj78SgoOx0VL3HzvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792801926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=1v7ZBXWKwiQnN4dtlK46nUzGEXzadqOOry1mIdOU0vk=;
	b=E57vifcH0qwbMr8+lQkibUfxN2LuqwfWi8O9PSY69bE+yHz2upUeYNzD4Z8Qs+RQ2ePX
	 nQUhh1YZ8wPDTFbvvPxDO9Qu4YcuF+l0f841G2vuikiWDFDCOoDMShP8lDBnC+S6cVmF8
	 qlMlJvrHbsqgbeDz0WizPGkkdtkH3kNsDi9pGPcf3kkQbSwlSr0T5gybLRGthQydvhDBJ
	 CDDrzQknLb+rBKfzATid5trb6s+jao47JnSFWLpicWDtH8KMzPQGcvffLDcmN3nFtBir6
	 S8F9aLSdP43tdfGMzcOqICj1/8y2u5T/eCr5jELWh0sxK9oN1q9EID84E7TjmZcu+8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=NbJWtdhx;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FFE606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 00:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67FFE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=NbJWtdhx
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f1ca4132bso118639685a.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1792801925; x=1793406725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1v7ZBXWKwiQnN4dtlK46nUzGEXzadqOOry1mIdOU0vk=;
        b=NbJWtdhxs9JwrvDhPJJGuHoq2uT2XCTcYQfoBVOxjtTnAo80yyxadbwIXrvNERkUfY
         mV5ETY4L0vLLTKmCOpLVB3aBllbr/5KjducDByom7/LQMv1up2EInwjiFbYUE6w3YxHi
         qFVhmfZWmOqDab1g3kKDJNNY8oe8k6byJEr8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792801925; x=1793406725;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1v7ZBXWKwiQnN4dtlK46nUzGEXzadqOOry1mIdOU0vk=;
        b=IpzInJLhWt1Mi6mcuHqqI3AwNHCvTDaWV/qPgE0RMPNNHz8PgU8zZKsW51cbLBgfLb
         S7w8SHSmBBXPTofiSEfPZ8WbFz5zeKrFEtKgJY09t1bUhetf+Ya1sYk9vMS0n7ye/seO
         4aLvqXROxIRwgYOcj7rkcUfRpNgKeokMcXi+GiCx/tpBp4BTbe4NWhytSGGiV9weibdB
         yejseqyV0FK6TFMRo2hbMVLXVlMPV0twT0ljTwxVtUBZEB1ze6gd2FNmotFTLbm/K/ON
         4kYD5Y5gtx77A9uvb+oVCJgT2+qUu9qMSd0cUhQmf5MrYy2PdoOOY0MujCDqf1FD5Crf
         YHIg==
X-Gm-Message-State: AFq9FYKGgZBWUdwHS0fpXN7L5MNSvlgaOAK52ZUlvBzwR7nSIZs8Uwlm
	sNXHzK+x7kmwg3oxwHpAsFafKrD2OtIiiW9aHhqsGx36JKPqI73687eRnvC+pLXyjQcElCF81C0
	YekL09Rk=
X-Gm-Gg: AYBFou0SYxOcYbdJkaXilJrsoQH8Qyp3qYThp3jF9j2QWFCjrwrwD+dipGN9DYt1A5S
	2SsIsNsXi3LU9XW4EQ0xMKwFMIS4I4wSO0Sjip65/LP+w62IaUDSBOQFsDRn5IZv5yq0xYDQjB0
	AP/R7Pk+FXNIZR3r1zKN8sJohjzSRb9r9tRRN3jMKAnFKuP5HWWA6b7UWmvFneUW+5WInNHoZQy
	rvy9j1zUuAOWWap8qwM89lYPqG6owHXm4GIplWQMIrNXcc/8K3lS3nBjnc7ucBu/PBkZO/flb72
	piGaVYNApKk9VCvDaO7+hXH896/GcXPM0/bZ0UmhO9PnHDQz8yMc7qFnXccvmfEeemI5w7G8IEs
	/5RgWiRqJf340Y84MCTq15Jkx4pAoZabwYpfQUhlYI8taSxRRCrhgh5cVQSoR7FVqotBDK3PXK+
	EaFPyb1++npkhA78FhJ4XpsmVZS5YaU8zyNjj9Vne5cfK5HVCQTt2Q67J0BMtr7exMws7HFf1aN
	didh7vqPM18OJOP1XjeEyL1GEHzxA61OqgFK14CfqJ60bOi7J2ALWGuU0aOsVxarM00tRhxTVPk
	Sm2igxinDTHLptlpJ1r2e+YrLzhFZZqg3G8+3ggtovH4Hx0CjbKpGWvK9q4hNAzs/diJ
X-Received: by 2002:a05:620a:31a1:b0:93f:1e3c:4a3d with SMTP id af79cd13be357-940ef956c10mr108901685a.46.1792801925326;
        Fri, 23 Oct 2026 17:32:05 -0700 (PDT)
Received: from com-79390 (vpn-eastus-02.tradc-corp.com. [20.102.114.220])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a771c9sm47152885a.34.2026.10.23.17.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:32:05 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:32:02 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] ci: pin actions in the main workflow to full commit IDs
Message-ID: <atv8gYf8Le1WHTA0@com-79390>
References: <a178dde02a80324d4cb52781d542ee575cbb68a1.1792773333.git.ttaylorr@openai.com>
 <xmqqbj8k3xcy.fsf@gitster.g>
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
In-Reply-To: <xmqqbj8k3xcy.fsf@gitster.g>

On Fri, Oct 23, 2026 at 02:45:01PM -0700, Junio C Hamano wrote:
> Taylor Blau <ttaylorr@openai.com> writes:
>
> > Some forks are hosted by organizations that restrict which GitHub
> > Actions may run, including requiring actions to be pinned to full
> > commit IDs. Our main CI workflow refers to actions by version tags or
> > branches, which prevents it from running under such a policy.
>
> I do not see why the limitations of other organizations should
> affect our workflow here.  What if another organization prefers
> readable and concise tag names?  Would they send a patch to revert
> this change, leading to a "last one wins" situation?

I see what you're saying, but I think in this particular case there *is*
a good reason to do this in your tree.

These actions are executable dependencies of our CI, so if a malicious
actor points, say, checkout@v6 at something which modifies code in the
tree, we are relying entirely on the permissions of CI's configured
$GITHUB_TOKEN to save us from code injection.

There is maintenance involved, including deliberately picking up bug
and security fixes within a major version. But using a tag does not
eliminate the decision about which code to execute; it delegates that
decision to whoever can update the tag. I think making those updates
explicit in our repository is worth the maintenance.

Keeping a downstream patch is certainly possible. But having each fork
repeat the same translation leaves the upstream workflow without that
protection and duplicates the work. That is why I think this belongs
upstream.

I think that we could reword the commit message to explain that benefit
more clearly, but I do think this is the right policy.

> Would it be too much trouble for organizations with this specific
> requirement to maintain such changes in their own forks?

Just as a concrete example, before submitting patches out of openai/git,
I apply this patch on top of my branch, then run CI, and then remove the
extraneous commit before sending. This happens on every topic, and
AFAICT this is not an uncommon restriction among other corporate
organization accounts on GitHub.

Thanks,
Taylor
