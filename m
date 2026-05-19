Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908FF2F7EF5
	for <git@vger.kernel.org>; Tue, 19 May 2026 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234650; cv=none; b=LBpsEWTPD7gDbfzv5+qqhj5G9w0rkRBNv+q5ff5kK69jo9SDEB7FY3ojAQfl1agv14sr2YLUajZSoR0LFgMRqZkva92q81XICbhGEEsGZUlN7OkBvkSlw4oLF06X4imnwHirYu2Bgd7XaTQDVHboxZkzypFTy7B7lHHmKw8p5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234650; c=relaxed/simple;
	bh=GbCg2Rr+KuDDIa5VHbbB+/Jv3G1QvjEan97iImyAX08=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=j8EU0iEB0S0Vm5z5HfAZJbiVytMXTH8UwzZHNOjrU2sduO44a50eTh0WTGq7qUTE+mITCcq0ajQ/t0by/520XBcvImmhMJ+uxam4/j81bYBaslLuL+JHCS2tZB5vWc12WM/NP92KcnazFD9sx2FbjwqMBvXVBPNmjLUI6vH0MoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yFFlZh9/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uQ8TetDP; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yFFlZh9/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uQ8TetDP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 18F547A0166;
	Tue, 19 May 2026 19:50:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 19 May 2026 19:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779234647; x=1779321047; bh=7dzu+XSxk3
	lYqMeb/z747anAJSHSk14e4xnOIaFDJ0M=; b=yFFlZh9/F0tKlQKOW1HuewdivW
	pFaJkgDJBWNSaFj5BoByKIOnROLsuBIDaPVRyhn+tu9Ipa0+Uuv1QRvMaHiWIPu2
	Qc+MmTEP4DePlAIta9xp8o7E2Zhgd5m4UtBFpLMhVsxE/3FqQHgexDcxyc8YqhoY
	xvMutjSVSQxLtvVfeiw/4cTVLKR2yLMh2Uo40uUPUv3zoBE1EEhDor7P0lkCLmCj
	oUWHENeyncsDDz4JDyC+Qdexl0wEbg2ePdtn1DGVIpXvS3kbyYSqSBOuQF6Bki/O
	xSlBJN3bGKfHCn/mhWYJUXJ8UIure6UdQq7KB60reVlzVtImw7U+C8ix1Yag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779234647; x=1779321047; bh=7dzu+XSxk3lYqMeb/z747anAJSHSk14e4xn
	OIaFDJ0M=; b=uQ8TetDPfWTtavHOjXiVDrntLpAWYqlqWNHFgfMI8qadrRzfqoy
	VRZ0dH64rWPc4/wpxi4rgXaM08yoMgw8wxKYZn3/2Y2l/r+KmyGwZjXGcx3oI8dQ
	6cP1xKPG95ARy9chayJIIXMYPFvL9BsW+LD+jBam1KVFAFPpD/AKnIn0ra2uD2Di
	TR75U+alXAowwHsbGWAORb+w2/dOR4uwkPEgOOMb49b2ta+3O9rBa8zJLPmigj8f
	7m6jdJuNFqZgRnUbJjoNHIY6patWHMSYOqaLaDxP0KyyV2AaavUmoZteDP2ugxOa
	UuFrY2DeWRWDmQGfcc0Y5+Qlq0hS0ZIfQ2A==
X-ME-Sender: <xms:V_cMasyzYFIRHciOToZggHftDBQH4nak4ZAJ3Gcd1BKBT9ELOq11KQ>
    <xme:V_cMaijak5saaqVisJmIxA7W41DOjG-V4OxyCYlrE6_0lTX6rZtPCpz-z9b58oFAg
    Nd7ab7PfRIv1zMfjUClqbxq-fIa0kMPDflm0xmbJr5nSNRas3T8rw>
X-ME-Received: <xmr:V_cMagmvF8zhTW3pi0tyJp0e8WQ1qs7oFy_ZcX9IvTa_v4yrV4yxm3zyEn7RLvrCwyPSXKwuIK8aFzd1lE6SSfSvlIXCm_9vq1jbif0ujGKH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteevteehgfevhfdthfduhfetgeefjeekhfelleetueevuedttddthfdvieej
    teelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhiugguhhdrrhgrmhgrnhdrphgrnhhtsehorhgrtg
    hlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:V_cMaggLU-bgwXXzr-QEMpdoldt12R56cGkmxNFsFjWGuO7i4jws6Q>
    <xmx:V_cMas22WRD3R4IlUmlOslknKFzbW6aPVuivdIdemtQyyk7jY3Gh3Q>
    <xmx:V_cMahJjuC3tSwfS-J7l4jcLgZLimTOoKwx-l959l_AMAEAeiqdyoQ>
    <xmx:V_cMaky29oS62lga9uZhgPzWHkEWCF__RYb_JzuK_nhVWNeUi7y35w>
    <xmx:V_cMaqxGr_T_YTKJ_cs_uYbWsdK0pCHEEzVt-l71zK8cSVh6ACIxyhB0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 19:50:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>,  Patrick
 Steinhardt <ps@pks.im>,  Elijah Newren <newren@gmail.com>,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 3/9] wrapper: add sleep_nanosec
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
	<6a8c2093643a385641ef0b2cde33839dc98d8678.1779207350.git.siddh.raman.pant@oracle.com>
Date: Wed, 20 May 2026 08:50:44 +0900
In-Reply-To: <6a8c2093643a385641ef0b2cde33839dc98d8678.1779207350.git.siddh.raman.pant@oracle.com>
	(Siddh Raman Pant's message of "Tue, 19 May 2026 22:00:32 +0530")
Message-ID: <87qzn7q7qj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddh Raman Pant <siddh.raman.pant@oracle.com> writes:

> Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
> ---

The space above the signed-off-by line should be utilized to explain
why we want this change.  For the purpose of this series, why do we
want to sleep at nanosecond precision?

>  wrapper.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  wrapper.h |  1 +
>  2 files changed, 50 insertions(+)
>
> diff --git a/wrapper.c b/wrapper.c
> index 16f5a63fbb61..1349255f1eb4 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -10,6 +10,7 @@
>  #include "gettext.h"
>  #include "strbuf.h"
>  #include "trace2.h"
> +#include <time.h>
>  
>  #ifdef HAVE_RTLGENRANDOM
>  /* This is required to get access to RtlGenRandom. */
> @@ -708,6 +709,54 @@ void sleep_millisec(int millisec)
>  	poll(NULL, 0, millisec);
>  }
>  
> +#ifdef GIT_WINDOWS_NATIVE
> +/* No nanosleep() on Windows, so fall-back to using sleep_millisec(). */
> +int sleep_nanosec(uint64_t nanosec)
> +{
> +	uint64_t ns_in_1ms = 1000000ULL;	/* 1 ms = 10^6 ns */
> +
> +	uint64_t millisec = nanosec / ns_in_1ms;
> +	if (nanosec % ns_in_1ms)
> +		millisec++;
> +
> +	/* Chunked sleep if we can't represent in integer. */
> +	while (millisec > INT_MAX) {
> +		sleep_millisec(INT_MAX);
> +		millisec -= INT_MAX;
> +	}
> +
> +	sleep_millisec((int)millisec);
> +
> +	return 0;
> +}
> +#else
> +/* Not Windows, so use the more exact nanosleep(). */
> +int sleep_nanosec(uint64_t nanosec)
> +{
> +	int ret;
> +	struct timespec duration, remaining;
> +
> +	/* Construct the duration by dividing the given total (1s = 10^9ns). */
> +	duration.tv_sec = nanosec / 1000000000ULL;
> +	duration.tv_nsec = nanosec % 1000000000ULL;
> +
> +	while(1) {
> +		ret = nanosleep(&duration, &remaining);
> +
> +		/* Continue sleeping if interrupted. */
> +		if (ret == -1 && errno == EINTR) {
> +			duration = remaining;
> +			continue;
> +		}
> +
> +		/* Either success or an error. */
> +		break;
> +	}
> +
> +	return ret;
> +}
> +#endif  /* GIT_WINDOWS_NATIVE */
> +
>  int xgethostname(char *buf, size_t len)
>  {
>  	/*
> diff --git a/wrapper.h b/wrapper.h
> index 15ac3bab6e97..c39992893a81 100644
> --- a/wrapper.h
> +++ b/wrapper.h
> @@ -130,6 +130,7 @@ int warn_on_fopen_errors(const char *path);
>  int open_nofollow(const char *path, int flags);
>  
>  void sleep_millisec(int millisec);
> +int sleep_nanosec(uint64_t nanosec);
>  
>  enum {
>  	/*
