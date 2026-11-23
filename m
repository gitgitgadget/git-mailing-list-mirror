Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.119
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795450409;
	b=ItgIgnTPrcVoSxHFTWkK3XaQ3MG3wOJ315H0DBYWAbJps0XFSXF2M9492oFDqCTqOhm4
	 A0zHe3c/6/3KXx8au5SSOQ1QmQcJcLYeA2mvDacP5yhvg4Baja0Xi3GrD88yWNLG1eG0e
	 i2I+q6wRgRgOiLN8Svnczu0yZOUyO9hqCcbSSYTe4Cs82cIR8tx1m16VZxj0hmNu9cYdA
	 E3eCLN6W7rXQhk8Pi63577+1YAkO0EhNlTfyBM9TyCEpR6n4QnK4/IBlRQmrRw1bh3n4F
	 /mOQm1KNI6zf2Soh/ILijoYradNsjHqrmfLVF/2f7VPwxSw2x1QCW1Fh9tgp9M0SLIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450409;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=ASc+roQMFxc1sbm5uiO0l1eNsACjD4tnZ2VigpNGckU=;
	b=FDcOlzFTqrx+jroid9u3tcXWQpfSzwi3RGD3kaf5bdZW5XK0fymcEeqYKuVKjEGIVCl5
	 zh9WK0aKmWXXhoL44jNBdDkSsMmPzbLaXN9kl1wTVnWhtlA34y4gY9FuXvECjg5zlY0j6
	 XdTji75CkRej3tPCpGZV1Qy0ixqj6iJVcq+VQLh3fjZfVowZZxY7q28qyyDPtgR1IVDSq
	 XhaXZNssubb/6NhkvG9dcPjqkJGF3+ZgBTBrUKl2969P15316qsM0si7J9by7xGC943aZ
	 hzdPNtz6/KoRcw/aJZoIxoox0yN05s1nReg1O7VuRN63PY1fwtdUeaBeIvXdaL+QZ/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=VmFa9E77;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.119
Received: from sender5-pp-f119.zoho.com (sender5-pp-f119.zoho.com [165.173.182.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F19606A33A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 16:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99F19606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=VmFa9E77
ARC-Seal: i=1; a=rsa-sha256; t=1795450370; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GAeP4OCZ9cSu5M4u5lKrMo1ZJ7Y7X5aQru/0iXGMlOr+Tk5irn1R34wflwShd1vm3NRwqJomxhL//1+LjRe21ThnyPXOrUpFbG9Clp04lg2SWsz4QkAzES2dpz4F01MQfHXt9xaIQQwaYtvezjaEv1wRC3IeIwcPZTrCk7fMetM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795450370; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ASc+roQMFxc1sbm5uiO0l1eNsACjD4tnZ2VigpNGckU=; 
	b=XQMR39m3fBrZCVieFLrX+tNZpxFs/QLjaF/QSB7To93dWtpAwYn/QbESYiAslECSEx27DWOTedR55BncvBRxgcGEw2p1/65b6Z+HlLUToLfT8Zc4dnYERJrxvPk+BWP0XkGx8Bg3NE1n36Sje72cNi1hjtAqYYJ4D5sk2eT2Jn0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=VmFa9E77lgYV0H6wZgzLDPNrKj66h9g4UeEyNWn+oQoTRUi5vSYeJMgjICVhE+DBxDwa4JVAnW19GxYmhCncPxcGrKPAEpwUZTwk/uK4wdEQZcxnfJnk4R4shdHbSWPfpZMQzB1Mtu7t2SfYfk275FLEz4dUkOEue6+86QeW/Yw=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=ASc+roQMFxc1sbm5uiO0l1eNsACjD4tnZ2VigpNGckU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795450367511434.07745898637734;
	Mon, 23 Nov 2026 08:12:47 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, "Eric W .
 Biederman" <ebiederm@xmission.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/3] rev-parse: die when --output-object-format
 cannot map an object
In-Reply-To: <xmqqfqwvnnm5.fsf@gitster.g>
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
 <cover.1794932695.git.adrian.ratiu@collabora.com>
 <5b9137274818319747b3eeafaf800ec6874df1d4.1794932695.git.adrian.ratiu@collabora.com>
 <xmqqfqwvnnm5.fsf@gitster.g>
Date: Mon, 23 Nov 2026 18:12:43 +0200
Message-ID: <87tsl7r0g4.fsf@collabora.com>
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

On Fri, 20 Nov 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> Fix it to die with the same message as pack-objects. The other callers
>> of repo_oid_to_algop() already check its result.
>
> Mimicking precedent is always a good thing to do.
>
>> Note that this only covers the case where the user asks for a single
>> revision, as it is the only case where rev-parse passes the desired
>> output hash explicitly.
>
> I cannot offer a better rephrasing, but the above is slightly
> ambiguous and excludes "git rev-parse --ooformat=sha1 main next"
> (i.e., two single revision requests are made at the same time),
> which may not be your intention.

Correct, that is not what I meant and "main next" is covered.

What is not covered are the arguments rev-parse expands itself like
"A..B" or "A...B" ranges or shorthands like "rev^!" and others.

I'll clarify this in v3, thanks!

>> +test_expect_success RUST 'rev-parse --output-object-format with unmapped object' '
>> +	test_when_finished "rm -rf unmapped" &&
>> +	git init --object-format=sha256 unmapped &&
>> +	# write the object before enabling compat, so it gets no compat mapping
>
> clever and clean ;-)

Credit goes to Patrick. :)
