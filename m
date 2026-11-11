Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405550;
	b=PEoiasviNmno3DRyecfxP0I5Pk0d9ROSP7ZsErAkYGVKrXSGw4DcbfSC1TLVstYb76H/
	 40D+f5eZxiOg6/dbqwUXepj8pOvMAHXZ3POV2JtQEqZ+4/+/AisqRbb/UVBb15YPBf69h
	 aCB9vaPjt31PxDqDheEHuKb0fajklga+c5EA7eOA97ep5u1NeJje9EhXIk6HU9RRj0C+x
	 ywDYbUPpOijPMHd1JGGd9MW9j6J+32fGiYJPODe16qIgOPE7gtU8VpSTPrLrZp1Zvn4ol
	 ZtFK4F/9hYlkyFNpeGAUF09X0vwndsGLO4Hj7jfGUPo+Mw84PFGrJdTttxgdf05Axiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405550;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7PP+n83NNa9H+xO7Xq9ednnYCkdijzHbKfhOCVizGLY=;
	b=l2HU6tYL72ch7O78ev8tNvvQl44ke9C6kLo7EH1iZyNwZc0z6glqK9moP5v/vFMbcJRf
	 +dOdRpKnROwIxvKRF0728kAZ4d19ZPSUIGPdScmxY9YcFmHnVoosX8ubeBlM/tJ/y6z65
	 x4vBQ7I3NemIK4X8CnP+6oSM0HsaqQQqkhaQ84XzHro8eKLsPfyQ+KBWgQNQCaDbQzq/e
	 HrxDLjOoa9N85kCVzfUIaKMROPuTKEFnPnM+xLQw0JfQHL026ABPB7n6ngPVFjrWIqcaV
	 WB4ayBkWQvxJ8uZPImdhAE2CR575YnpnbyKINmkn7+5IGK7cbnOBzNuYtu0JDSWMeVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=w9uvCy1M;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=j49u35V2;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13253606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 13:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13253606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=w9uvCy1M;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=j49u35V2
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4D3B7A02A4
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 08:59:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 11 Nov 2026 08:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794405548; x=1794491948; bh=7PP+n83NNa
	9H+xO7Xq9ednnYCkdijzHbKfhOCVizGLY=; b=w9uvCy1MYPi4xm7nOPkJtKYJYL
	up85h7Jg5+J7FhxAZ/DjNS54zfnI36yQBIjXw0Mz7z+rxgw4JvdLhI81ArZym8mz
	r8lnlUobE51KfVOyZmIPiMaWYgWMvlF2+rnfCeCjYoEODW3Hb4kXYESyBdoU0VZx
	qghjWVfczar8pyw+3aogg8OKvPdqQhKLjQQAQYRTYeN3L1lMHzFaACh683Dam9bG
	A6slxy4ilWa9wtFbD9fFzQ7x/X/O5oRlIPcpFHhBHWNpJHlhkkWMTy7EUnXpCnJc
	zEeuVQqR2ZsUh4pRdEM1B5FpoQVDUiXu8X7VkjpnNOTzkiAGvjzcAcsVzb5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794405548; x=1794491948; bh=7PP+n83NNa9H+xO7Xq9ednnYCkdijzHbKfh
	OCVizGLY=; b=j49u35V2flsKUq70Hxn4a/DSoWPzzjeqTaxK856Vnme7u/O4haA
	xF5DYZPnCV5qhvq/IZaOmwT95potXo/NHn8Fa1lcRLQDVf8Fh5UL1XZJkpSyf2lj
	wLkbJQt+d7CG1Gjq2C3duY1054ivF8JeaBzOZsVm/ugnfbDunfpMHCpbVk7CZHy9
	u6Ogii8uNf6YPC2aRFPk8KcC/LfEVjFoTryEeBzIoIsfEKHdo2bCA8TqN3SfOjve
	VT5ZrsZWt18Xw6L3Hm9oFitazKSTKw/gD1OjPRAClZEeJgbYv2ynFgpfVSQocg1L
	b8AjlKmWkeV5ABA8654LAI2+OixW5d+p0zQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794405548; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:i2C2uQSz7I1D06/YWjFChrwPr4wnNe9xCA4ussO/avfivEJ
	tJGLll7BtGfP+sqI5U60GvJW5M++boSQgozPtWBrmyDSxMqDeXb898PICbggJQmY
	39//gHhwv+PukubH95Z+9NlGZg5hmQzDRkh+uh9u6E9FeaJM/8BO7ILF3aJe7i+9
	Vc8Cm40oF5W3ZzLMdaFC5FrY275uQA+T7k+N8I6t1H0VIUG2LqGdOGCIEXHsOib1
	U7+m/sHBnShfdWTHLae0Ro8cbUwph7zl3UZ2ct0Byer7zOF8lzhd+Fuy1CDR9Fvm
	km94mtxMxf/FbNZfizta8Vx2yxnTNyFOGt4IO2Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:YkZwu0iMTjZ8KeCKz1Du7b7Kii+4M5yI78tFxzbsqAA=:rt9YectLTucXjvZDXDNfwLepf8sHTDYQacHV1QswZMc=;
X-ME-Sender: <xms:rHT0au3g7UWVr69gDRwbP8CCNgM6pPnk6Ed9n1N4zGRPJhMlsR3_Ng>
    <xme:rHT0anFSbTfYEPeH2Nd_8VvEPgM23JCuIWecGYmnW_e_K-RS1Ymu_6JE3HIpcWmH9
    f6CNruIN-HftJ5qvgwJP7wHPPMCbkB5e6lmQE2ZHpLInkmY842GPFU>
X-ME-Received: <xmr:rHT0akiWEgTbn4rwA7mX7CUScjPgy6hxWNior6CMwtqbNhfLi4NaynEtGqgWmE8VbUKkqA>
X-ME-Proxy-Cause: dmFkZTE2ueYsa5XYVz6Vl+DzaoPJwnVjFzzFttGS4T0a7NbV0GAgtxIzHWU4IRUQvMCeBw
    6yGAY/Mt66RZGi+eFUQP9Oy4QTs4nPYHSWZRwW7IqUvlnZQ4OPxcyxqclHZIxd8y+PdaHh
    a6XbUy/FAMBmALJGinYVJnidJw4pldG/F8XqURk/dUw8jDIbqpiLIuDpwHtYfguys7+B3P
    fP5gwlA32WFVMNUQuo+ECVRqtsebxKRhRLUI1eyIv5tr/CJP0CWszFCwnZ5/czmgQQOPqQ
    rS1JvFBI7+kXTM3LpMSQOudS+SA2xcjRIHq9fA3jD5NOrcMPUhCL7goyCGHy7y+bwIvHkG
    gLNPavvYcetNJYdbVYAMni3cb2U+8Xui68prZBX6cfnHeLqw0JrA6IkFoXTVq/Y8On0CLW
    z/+w/n52tifWaQRS/ugf4PddfkTMVT5rMlpI+hhOR9KapGGCT/f0QAuPLUfaWtBHbvYeJ+
    f/xrA4FjOc9rgzVv3UM9cd05Za1CngxRxgCAHjJo0Wh5elryHXy2pkrElbMkjbq45QTptE
    wHiUjp4svk+2Ni2XAnHNJEQ/Hg0JRC1rpJ9Z4sTvqNJu/WPnCqPj5ckBY+KMmzyqp1/xi/
    JaC3Cj01ZBBBGVMF42qMyLYaD88dYxxK+Bf6OXAZXj9ll+hJ58q8YlMkSLwg
X-ME-Proxy: <xmx:rHT0aq_1KJGvDeUfO4MKD1O94Ea46qn4Y39SlvQabqterFkLXAN4Xw>
    <xmx:rHT0ajpTRsQsmZwakdDsr67bJkPLqf-aXh3H1Xz64847DBH2BskB6Q>
    <xmx:rHT0ah93x2PkWNUah1WGRHykB7_kROHLOZulUXQdyiyMdPFbgTsBNw>
    <xmx:rHT0avVEHD-b3NpMJv_wXE28QxlKL7PLuOM4q0JcxL8sSB06IgoE7A>
    <xmx:rHT0arijsgdQbTNA062z0mOvCotyaoLU9xT5o04C5iiuzqruUeGyR4Ge>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 08:59:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 65828b59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 13:59:06 +0000 (UTC)
Date: Wed, 11 Nov 2026 14:59:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Sven Strickroth <email@cs-ware.de>
Cc: git <git@vger.kernel.org>
Subject: Re: zlib 1.4 compatible?
Message-ID: <avR0pxqREJGwDS86@pks.im>
References: <9c54aa5a-f359-4db8-a9fd-d86c48b73ff0@cs-ware.de>
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
In-Reply-To: <9c54aa5a-f359-4db8-a9fd-d86c48b73ff0@cs-ware.de>

On Mon, Nov 09, 2026 at 03:14:27PM +0100, Sven Strickroth wrote:
> Hi,
> 
> zlib 1.4 was released recently to fix security issues, however, at the same
> time it introduces potentially breaking changes (cf.
> <https://github.com/madler/zlib/releases/tag/v1.4>) such as:
> 
> > Raw deflate that completes exactly at the end of the output buffer now
> returns Z_STREAM_END instead of Z_OK, as documented.
> 
> Does this affect glib?

You probably mean Git, not glib.

So this breaking change is only contained to raw deflate, and we only
use that in "archive-zip.c". And as `Z_STREAM_END` can only trigger with
`Z_FINISH` there's only two loops here that we need to vet:

	buffer = xmalloc(maxsize);
        ...

	do {
		result = git_deflate(&stream, Z_FINISH);
	} while (result == Z_OK);

This one shoulud be fine, as we estimate the maximum bounds and then
decompress everything into that buffer. So even when we see Z_STREAM_END
we'd write the results into that buffer as expected.

And the second one:

	if (result != Z_STREAM_END) {
		free(buffer);
		return NULL;
	}

	do {
		result = git_deflate(&zstream, Z_FINISH);
		if (result != Z_OK && result != Z_STREAM_END)
			die("deflate error (%d)", result);

		out_len = zstream.next_out - compressed;
		if (out_len > 0) {
			write_or_die(1, compressed, out_len);
			compressed_size += out_len;
			zstream.next_out = compressed;
			zstream.avail_out = sizeof(compressed);
		}
	} while (result != Z_STREAM_END);

This one looks fine to me, as we process the result just fine on
Z_STREAM_END.

So I don't think that zlib 1.4 causes any issues for us.

Patrick
