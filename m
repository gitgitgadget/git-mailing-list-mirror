Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794899524;
	b=bpUaxePD3OvJB1nRip2AZ+gOaqLrkNXxWX2RUC52JgxLrlCK477qM3C3nOMMrC2LZxKg
	 wCiMBkdP7Vsf5z9Ylx6isnZs4NP/9lH0ZR40bFupzH20t6s7IrIfHbvfvXKal+H/rFtbG
	 thfRY0eJCJ2FSf8zNK8cu7s6Tg1KZ//ZrzbmaW0sU3RSMF7Zg4K9aQMK7XqAvJk76Y9uG
	 7W4VmFabg8ODmx/OKvoWeRI1cxW0H6eBS97N+3mHX2Skuxgy+C/jXFA0JLkRICtAvyL/e
	 07ro+wOXuE3oUK+A05qv+jLiF+OPKEMIksBIXE0JFaJhvd3HHn5kzBz1FzycO8HjRNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899524;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=exYzvRR0C2kCYApimvjdf2fa5ZZMJb3Kwip0Oawy2Pg=;
	b=LuU5qmcPr30p5VrCxrSNlys0vjtmWi6JHzTP3lckMrAndPbtdNH2ltEvAtpatVMPWYi1
	 GHvVJ+TG27jtLDFptxipxG7xMTPMlC+a+BodCyUYj4FMhSm37O9LyOSM3eWaFkK6yeRg9
	 Kh20mAZrByseKNVNRZVRPKV7+Z4uf92suBsPgBQ8lOydnf5juLmghUKDdZrsssI2J4EWd
	 tFxLhJD3l8qyaNkzwXOxZhrJ7j9I8JhMJan+TlGrZpgsPZO5uwCqvZ0ainG/kT2NrImuz
	 d2THUdgWfCYGsvhGJKe3KTbxDTFR1Ypt3NoS0FK0Lgqs9IEQDtSk2+Lf3hIHuuNPsqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=COiJ6l00;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126F560A2604
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 07:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 126F560A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=COiJ6l00
ARC-Seal: i=1; a=rsa-sha256; t=1794899513; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lE4AqIq14gy2TN3gTxzVWPKY8KVT7nHJSHV7rRgtEO4+QSIpuw+qJn/QOJgAcqR5C/pfbU083ZSiUvSPULUgV3rf3smx6Xi7r4F7Pp74cthrg2skFQjIdmGYyr7hgnMERaJfU5LK5GntcgBEVh7KswbyBO9oqdeTHpNzGzChFUI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794899513; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=exYzvRR0C2kCYApimvjdf2fa5ZZMJb3Kwip0Oawy2Pg=; 
	b=NWLaBB2ny95xcuzZoCGxKCMCeVev0suO3L9CnFhaUj2bsf9Lk53OL5Y9EhBUMc5/uWe0QR0bRnonVfacAS/wRhr4mRO6Z7XUmO7W2adkHnwRnl7BssATRAkJxSSeC6JNRfefO238+snvF8DWhUaJn3Q1W9kq90rMRczV1fBn94o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: a=rsa-sha256; b=COiJ6l00Rsj+Zd5cAHMrYWrKn2KxF7MKmuFTNBjSTUI82SPG2Dl/1dc76V3K/RNe3zwwsSeN9M7BbK3fCuDzeGv8cx/x6+WWQdpmdQCMoKG96ealm0Cg0CMNLq3HBI5q77F6HIn53ofQ+AIRZTJTD2Q6iak95dj3zApHpRS0yqE=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=exYzvRR0C2kCYApimvjdf2fa5ZZMJb3Kwip0Oawy2Pg=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179489951110742.687498829342076;
	Mon, 16 Nov 2026 23:11:51 -0800 (PST)
Date: Tue, 17 Nov 2026 08:11:46 +0100
From: Miklos Vajna <vmiklos@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: gitster@pobox.com, jltobler@gmail.com, szeder.dev@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH v2] log: make --follow following renames for non-linear
 history optional
Message-ID: <avv-MhYrtlM53GNv@collabora.com>
References: <ava1ax5UFfcvkU_d@pks.im>
 <avqyVuMvKeQshZYS@collabora.com>
 <avq4QewLSGVLkCjv@pks.im>
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
In-Reply-To: <avq4QewLSGVLkCjv@pks.im>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.877.32
X-ZohoMailClient: External

Hi Patrick,

On Mon, Nov 16, 2026 at 09:01:05AM +0100, Patrick Steinhardt <ps@pks.im> wrote:
> One hint: please reply to review feedback on the mail that gave the
> feedback instead of posting it as part of v2. That makes it easier for
> others to see which review feedback was addressed.

Makes sense, I'll stick to that in the future.

Thanks,

Miklos
