Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937980;
	b=Dg4agJYcwmVAEUfYKpZDd9bJazUrOQbKnLM4EmtNjR7eGcYU+kLWwLEDMVTkYoacOhfI
	 tYssNLXBOBgd4eUuLMl65L+MDuQO9kZ7xIwlf2kbFitXzNzOlIxpSerJzbBzbkD1i/26/
	 0P8WnsuZ0JBH4aoqKURCR35uxJBTTAFK7M8JUuZtwPRC1XQs1tr+ClD4GDzwNs5ZrmZuk
	 xB+M8pXVUaMydrprd9KBJBwXAt3yAw5oDUJvRPqkRGGY7kB3m+WMBN+fPUG/bTmmsiSL+
	 Tsqw1daaQNvrgXtXa+NEp6zW/fhCr0vXfhno3YQCh+Ljok9frYN7fHCaUT+3G6P7Drg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937980;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=FMBmThXl9fCCEkbh/nBF1nVcZ52Ao2G8gAWyE36dqo4=;
	b=1+ZwI6RRGjBHJY7hJNohwGikFNxziI1vJBf4/I+BcIoD1z1n5eiDxkXy0BfENnlfCpVn
	 2Y/mPabQqWxZ0nlojuTy38yCCtSXiFy06uxo4cbnji4QTDvj5v76sIEjPSUxeGP+v5ys/
	 alcZ4Vevqsbpdh2dR8rL8S4UgvgtjhaNa3Nx28j0ydou7rMwqS74ug4nGIc+46/Uxxu+e
	 5w8ddZkP9BhNjWHUcnFZlly0d26yTJaY+Fczo2XShdugWve/9IRmx7u2mlpSHs+1g2XCA
	 r07k9nN0Q13M0qjJnP+rzxrLTLAScYQLkc2Jlw5EuISUosKDRBSaQU0wZJq4M1hGfhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="a41ya/KL";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SRrSThQG;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD727606A32A
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 17:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD727606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=a41ya/KL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SRrSThQG
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 139BA1D001A1
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 12:52:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 17 Nov 2026 12:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794937978; x=1795024378; bh=FMBmThXl9f
	CCEkbh/nBF1nVcZ52Ao2G8gAWyE36dqo4=; b=a41ya/KL8phQ9vBug4B0AK0Iq8
	Ajz4Mq2U5Sn98PGcm/Cm/OK3lK6rqBv+XGD1M4383KKnL1QLq3JxjJX3/YJpL3/O
	b9aJPiXUQSrzFnP5ZaYH4uuPegmYUocah10UCkJvn73ZYljfWdkAC2ZAU2hlKuFQ
	KXcILWTFmyeTgwSp7eb4XOgC05UyNCgjMn7jrCWl+zeQKyVDltesAzsxCWwGmUVG
	z3hjRXV3/4aRNzKGZ+zNH69ezfLv+BJwQLLiycoPjFlS+/l+N3csJzEPuP30XgsP
	rPm+sGeCL4L0RvbP6CAvkZuT83BWvtF07dfGjMH5L6mDeN3Bs0rkUvjTk0Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794937978; x=1795024378; bh=FMBmThXl9fCCEkbh/nBF1nVcZ52Ao2G8gAW
	yE36dqo4=; b=SRrSThQGlEG4OqSKXL06JaVUqqkgtV4+hZMNzd2oZ8ZDoN3ZsUb
	NVNFex8h7fH83KOAi7XhQfgX8vN1f2hZsU13lDfQQHeREEfRHPGg1iPCZcyRy02Z
	P6XIYoHQoZ8PKvzbzMr2cQkhv33jNaABwgBRSx4x7EDhmI8DRMd3xLSrVKCTHQ/a
	wV+7G1fctem4dtRQaY2v2bJHxF0sx9rgDno/W+oWUf/V5wbjQDyoHtbQR1D57uDy
	weUrtlwmZjia684KpDjvoOLY3rxYmMibYpIdW06b94yZ4fLePxZyd1IOKipCOtPx
	Vwc6AfqNK2vBHFn5h8nIdoIY7JoG7csSEvw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794937978; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KVrfPyQvbQGKZKhoRr78E1Ho30Lx9JO6V28kdxf19lRKKU/
	yt3Mhj1c/R8Y6hkfOhejYE7eji3BIm6ESYScADIThTI7DepbDCbftSHbkXm0gwQZ
	aF9L1dqp8kM8a0ndCgafwR9bpJ1uIGUa2AvOg1eS0YVwRtflaQS+67C/8VJWSMgQ
	v2+08aO7YDFXecaKek7JU3zWNl5lXE8hfBur7uTdN8bHR2BNGYn9V5JUxJYSmMjo
	0LbiZ09SBcrlKt7cU5NUcVLjUKXe8uZoYJo5x/hisviyMMSaiU2guoawY34/Bo/6
	PFtMZDf1BG2fz1wO4WOCkbCBLkVqJKY0MgWdE1Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YKkxOFi/SOxagtuxgkTBN0gmej/nRYQpY868af8P0PM=:3UgIxSXdd1lY+VmZB/3wdaL5FecHr4d6Xle6MLoVDtE=;
X-ME-Sender: <xms:epT8auz8b9EOMywxVDQhnJzmHwSaRYjAJxD2xc2XzJ6oYjm-Qq1j3w>
    <xme:epT8asi8SJqd711yyGPne49jXNdQ40AM7bAGFj7j3V6edS5IlqEbL0mDK490u8eWb
    QmMrDOcdq1uAgGoalMa8wruuMdSBwxQAcFrbioKGP0r_fjuuxtjPg0>
X-ME-Received: <xmr:epT8aintN24PrS3LXCifH4TPK-4uc9NeRoF_oOtx-MBe9-0FVJu-k2gnd6MZlF0hEbBjYLwWYdLVE98OalGR4PAD0NyJrNp8x_fj>
X-ME-Proxy-Cause: dmFkZTEbGjlDAlwqZJ9BUNBh/a9ENpUV2Uq748My/Ce2BEcVkdXhBgnfXCwjQialLXppjL
    MQeLyWvsToz3zFS4CFeoRO9bliLg9yzYp7jzHJIh+qe+cKCnxeroqUy/zddV32vWuSEp40
    DM6siQnnc5jAkO+ZzfVyCEPZKzEfK5PuZ8At3jyp+0JdVoGtgFxbkXD6Z64KUxMP+A8GV2
    THKy23qxjpNsmoTOvReZMoHBxo/XS6YRM5CiYHHGJCLwLi08gdis62eUOMq6Msr9A6pK6W
    0VMcN0Wb/aZ+JfC1mRDytcIcbyw+CUC/hw4OJZqusQHUXhSeL3JhGCgt2/1A66wa2csBfi
    4603HXSYit/PKLfR746ByCF0+HYqVYor5JP0bHw97PYar3JC/VIrUkfUacqsxNyx/SALcZ
    4pGZ9hsrkbRKdPQ2TCPt+gbDe2CiSaIVkeB/3+pMeuwFRnw1Y4BNGi7PoaN5ZcSdg6DJ0g
    +RigpYmcYJSscn5y072cqn+Ax85JVeKaVADTo1UMuy7KrnkFuoFME63UdhsknzQD8htM8M
    NmZ5kFunYa1bB2b7Oy8+DkP+5/3BhIKW+WQMFedpv2aFtagdWJA25/7b5S4ngsHj0ss3za
    qpN87qA0Z+q7gEUidkujwD1oimHyiWd5EeO4pxcVGTnyW1HLjTxG6YhhfPsA
X-ME-Proxy: <xmx:epT8aqg-XutBndksNDjxABsNCmH_WYIxDcE-N8szFV8TN6YLM8aE8g>
    <xmx:epT8au1xAJ4pgh360X9FCE2nDT2zv7mkXIA-zoSz3DbyxB8uRRs1UA>
    <xmx:epT8arLPVItpnTjTjvFbTFu8tPbWm-Z2L9ME6H1UXDJ0e7gvxmzrzQ>
    <xmx:epT8amy2qM2yuuV1SRBLNfdAey19t3ZUhTADFKVlEIsyPgzD_x9tiA>
    <xmx:epT8atanQblhVSoAec4ZW9cWyMDO2ZsnMe5pApJ2E4rQElHtwOGjaEPY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 12:52:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  "brian m. carlson" <sandals@crustytoothpaste.net>,  Neeraj Singh
 <neerajsi@microsoft.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 1/4] csum-file: use size_t for the count passed to
 hashwrite()
In-Reply-To: <07baad46b153b255b6e70f2597f1bf41b9c48dfd.1794909894.git.gitter.spiros@gmail.com>
	(Elia Pinto's message of "Tue, 17 Nov 2026 11:37:53 +0100")
References: <cover.1793546752.git.gitter.spiros@gmail.com>
	<cover.1794909894.git.gitter.spiros@gmail.com>
	<07baad46b153b255b6e70f2597f1bf41b9c48dfd.1794909894.git.gitter.spiros@gmail.com>
Date: Tue, 17 Nov 2026 09:52:57 -0800
Message-ID: <xmqqeccjfipy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Elia Pinto <gitter.spiros@gmail.com> writes:

> hashwrite() takes the byte count as "uint32_t" on all platforms. When
> pack-objects writes the entire compressed buffer of an object in a
> single call, which can exceed 4GiB if the object is in memory, poorly
> compressible and core.bigFileThreshold is raised accordingly, it writes
> only "count mod 2^32" bytes, corrupting the pack.
> ...
> diff --git a/csum-file.h b/csum-file.h
> index 6ed74d1637..f1c8a9df13 100644
> --- a/csum-file.h
> +++ b/csum-file.h
> @@ -75,7 +75,7 @@ void free_hashfile(struct hashfile *f);
>   * Finalize the hashfile by flushing data to disk and free'ing it.
>   */
>  int finalize_hashfile(struct hashfile *, unsigned char *, enum fsync_component, unsigned int);
> -void hashwrite(struct hashfile *, const void *, uint32_t);
> +void hashwrite(struct hashfile *, const void *, size_t);
>  void hashflush(struct hashfile *f);
>  void crc32_begin(struct hashfile *);
>  uint32_t crc32_end(struct hashfile *);

src/csum_file.rs still thinks that hashwrite() takes u32, though.

If a caller of hashwrite() has a contiguous region of memory that
exceeds 4GiB in length, shouldn't it be looping to call hashwrite()
in 4GiB (or less) chunks, without changing the API contract, I would
have to wonder.

pub mod c {
    use std::os::raw::{c_char, c_int, c_void};

    extern "C" {
        pub fn hashfd(algop: *const c_void, fd: i32, name: *const c_char) -> *mut c_void;
        pub fn hashwrite(f: *mut c_void, data: *const c_void, len: u32);
        pub fn hashflush(f: *mut c_void);
        pub fn finalize_hashfile(
            f: *mut c_void,
            data: *mut u8,
            component: u32,
            flags: u32,
        ) -> c_int;
    }
}
