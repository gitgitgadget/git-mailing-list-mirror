Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021877;
	b=TCmcP6401Ou4tBezSNgx9xvjWADRerqqtTym6vOFOXvHb92rZNwMY1qG8rHu+Q8gqKPz
	 y5wfk7rG7rA9hhCvOyvC85HUAS1Tfz95Z0gaLCaWl6Y/wBLn0DhxOZLlxowKaLTS1WK28
	 Es4g45g1mO+YXFNcN83JV1suOX41pAHC/LOlWIYvNAkJrPp8rBTK7q6ufIDp6QqCCDU1w
	 oYJJOHJofHdqUioi2i7Yk1lbWZsqa2gn+EMKFvoq7srrPlZN4iDMqhMM4+wbFwVRrNGwO
	 dD9hQ5Ugc9vOkc7rRUMXpCGHX1bRepeAXKzFSU+fhaMk5AYkdejbR2WTd8bKXnHN3kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021877;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=B1QHe4y/ML79oQHGJHbH/NPtdRha6ZvqSAlbX4MFrXM=;
	b=ugFhNEymos7rUDTFMfK8lZxsHUPAnIo7zGaJmGr3eI4gXXfP5pyaj5lJILA4B1GJQOa5
	 thbBnMxS2fAI7K3aGDhqj8XnQ5h6U3BrgQ4ZM/GhXohDVNliwIPFcMGrSDd2faDsE7ZO2
	 QAD1NJN90N1GuVXL1YcewWOlwj3KXMwPc/XmJO0Xdf5NwIf81ua3FcLxNbpmhjf0ezVm4
	 YcrRcE6BOzPWBA3APeFDydXF2mOOnZ8wEzMRH9MT3hVfj6VTLALrUk3UOT5W8NQuT4TN+
	 eZ/ZmLhlMi1O+QBYBGdpYpXqru34iBxWPxWjKHM/8JkMsTUUv5oQc+SZ6o2ZQRSu9/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VVKEA83r;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D+ry+Rpc;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B13D606A320
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 17:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B13D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=VVKEA83r;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D+ry+Rpc
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BB8BDEC0610
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 12:11:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 18 Nov 2026 12:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795021875; x=1795108275; bh=B1QHe4y/ML
	79oQHGJHbH/NPtdRha6ZvqSAlbX4MFrXM=; b=VVKEA83r1s6wpr9f2+zKuCCEAE
	Z6WY8r2lB7W9iJWmXAOvfMkme3ygYWrVXlbfMw/iT1yrlTAXUWGR/viwYpx+5S1H
	B/wxUD+Zzhh9aTLMXo3f62y7UUX7lEpvSSzKdKuzlUuRkuHqRDxgRJ3yY8/ui2oT
	ORb+o8gDwjoQ8P5T3FnUAPo1RzkqxedpnlZNlW3Q+B5bxtWoXh0yllkVtYxYp8MX
	8voWTZqzeUaRwxg8U/4AVCVlLNHdXY78jRf3BLTTp5bxQzSIXlYME4LXso/3nPOG
	Qf1eUqh4fn4Qb3Pqal5tH6PDbUqNC1a7nXjhrDxBlf3tt7N2OPvRYfHOd7Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795021875; x=1795108275; bh=B1QHe4y/ML79oQHGJHbH/NPtdRha6ZvqSAl
	bX4MFrXM=; b=D+ry+RpcmLoM/YLWG0DJ2Czu/ZNJgC0xfqiJFwyp1MksXum6KE0
	X8ZZZ7R2P3gg6jR3oOpcMWPOvejdMplvLVMf6MdZdcXyMfe6KDtbrVyQnndRGmWj
	vwzBOnnjIzGdSA1zvzbpvtm+/RLvebCkExSWx2tMM8aNeiDO/I6lKz+J70Inx4ab
	XfjJu+8f+HCG7+6tK6RrxSGDfFdqy0Mz9NuNW14KW8hUfALPxJIeklTppUpvp9RY
	etFLnJsH6kC2BmFy4jxaGNcHetMUO4wJx1mzPJEbmSn8AarMSnKGiwPafgpAuSRs
	LEpMY7k6GkmjIhqYysmrKBH8rqRJ8Xrl3Pw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795021875; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:R/lbbE2pdWGLO1sLWPA+aOg/TkZFLsh7iP0WKlFv32y3zKk
	6CBZYwtbm3RuygVepEaVrvtwW3XQFewCpiVIosTuifycGlsu9mofzcRjg/RSs+XH
	C9mJMb/ZjUMw8J7f+F4k46x2KBTSDO4pgfpRoeqylu37pH+xhxfLNMPe7VaQRBXu
	zMJQn7K9U1XEueuitknVMlIinirD5q6MfjZy7fZrcbv6P3eud/m44/CFS5Pe01sV
	VXGHh8lNvrKwowgpf1sjKxAlCYMP+7d6ZP8QlZZipWwdsCq14513M6lkNxYpSdS2
	Tq/PGk0d4l2X70C5OUu2WW3QkhJ7DqOt+xPuHvw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:luEWajfEjGqGTvzTs+zfadWKfgqakbKLTU99w0lOxEo=:za+pPjzy61HWYRcct2ZHP+YBu71FD1FrP67cw+yZG0s=;
X-ME-Sender: <xms:M9z9amNppQ2HU3yQ3igCXWzvcjbwTzZs57tCxIzTHjeMnP-41m3fJw>
    <xme:M9z9asbIMh-7KVOiNkL1Xk415jdQRycCl80qP1vwqPfRDc-4bMDGenhdN-Y9JWp3y
    TVqiWzTLz5xOgCpdGHKClqNLrP2a9dnHLxXEDsSv0EuV5jKqdlkVeY>
X-ME-Received: <xmr:M9z9aqpoB-hEnp9OZFetY6D8Jr52j094CiyEANY8dP81gnKDQLU9ASz0G8QRsyGfk9xgKiYomN-dgP9NK-W5a-MyHgRTNOCx19K8>
X-ME-Proxy-Cause: dmFkZTFI2n60dE99qF7rXExEZekMuAp0v5L8LWgNma2QBZKZetbxvj6TRjpikJukL+v0Nk
    w0TDYe1GWOnhFsdR5HFv7hkMxot0nrvt0bkO8ZRvLj7uvU4TY4KB5s3E3WduB4W66+HrTi
    wpDFHywGs5elgla1EIDun+BgZFhW478z611HwMoswJ0X6dlprBZxyRozf3xUNwc97pIx4g
    7ZBKJJhzaQTcXs615ipQJp437sqsq4LjslgVIuPRaDjN5s+65scXLK7WUKNxjjs7oAVu3G
    9yrtYB6JGdYFsSkGgBFFIEPVpE+O3HJMnf87vHSsJN/4Q+345UGaN4lkUr/UpqmKw6zoBs
    rQjTgFwbGb+nygdF6SaXbEBRXsoWz3VQoXBXZ8AWRhY+YLpKXa0EuW62JGu5ibjYMyMZab
    qnYptJ3jvakk+mMGetgFnUr45mfGD6Wno/Ob3W0RkNbrio48vMNT+7KmeSfIArknrk5tF+
    ngMHoVWS1f98r/zKAMfpRtJmMXm8aV7OSdYfS/HIlYKz5/k9hjndY2QgQiy1r/QbVku+Ft
    SzDYOiuna+iyU3ROegZ7GCFRqDgu+PyLdj3+IIgtSk8Esjx0JZGgtWddwxVZZCKDKPcL4w
    iH5zG9CaRCRV5b4suxM025kFj0D0CzzkcPzeW6Eh4nl/qwuVASDUdtLipjZQ
X-ME-Proxy: <xmx:M9z9agbQskRSEyJg9m2mP0c9UQFgF-VfG69kMKSJvTJPFrhUlnUozg>
    <xmx:M9z9aiRy8UpqcCVLn9f37vGlWDP39ZQI3G1yZf7qDIJ1oMASsZAqbg>
    <xmx:M9z9an5yG1FlA4jx4kkIRHnJnaqlK8PG7hGA8qixm7DJw-b3pSAU0w>
    <xmx:M9z9anz9h2-ijF92-0tT01hO6aM5AUC_wEsVv9Pv3jpLv3jaLL2SuQ>
    <xmx:M9z9au9I0uNXg6P1f-j6583C8xSYN4N7SXlnx-cU9B66I-nC5ObSIdwc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 12:11:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jakub Kulik <jakub.kulik@oracle.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] version: accept positive uname(2) return values
In-Reply-To: <20261118160146.60429-2-jakub.kulik@oracle.com> (Jakub Kulik's
	message of "Wed, 18 Nov 2026 17:01:47 +0100")
References: <xmqqcxs9j1bp.fsf@gitster.g>
	<20261118160146.60429-2-jakub.kulik@oracle.com>
Date: Wed, 18 Nov 2026 09:11:14 -0800
Message-ID: <xmqqjyma6p59.fsf@gitster.g>
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

Jakub Kulik <jakub.kulik@oracle.com> writes:

> POSIX specifies that uname(2) can return any non-negative value on
> success. Update the get_uname_info() check to follow this.
>
> Signed-off-by: Jakub Kulik <jakub.kulik@oracle.com>
> ---
> Thank you. Hope this is how it should look.

Perfect.  Thanks.

>
>  version.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/version.c b/version.c
> index 21ec7c0fbe..ca3be6d610 100644
> --- a/version.c
> +++ b/version.c
> @@ -83,7 +83,7 @@ int get_uname_info(struct strbuf *buf, unsigned int full)
>  {
>  	struct utsname uname_info;
>  
> -	if (uname(&uname_info)) {
> +	if (uname(&uname_info) < 0) {
>  		strbuf_addf(buf, _("uname() failed with error '%s' (%d)\n"),
>  			    strerror(errno),
>  			    errno);
