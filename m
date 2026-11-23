Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795450642;
	b=WD5YT+DSwboagbaMCNT83chYId5KQ78yriRNwE9tY658eg2Hm7DPLoJA2/ym68UWpOpy
	 b11MQHy7pErJjdniwrEpR9rcMwCVYTMj1xYwqWrt60vlmCk234zoYfWouyfBgJ399lrXc
	 Jl01gT9GCPHHWKjBy5MBCSozQNZdxwiDdPq8v1XSZyUNuNyuRErGcOM7zkM9LQ6NQZmGa
	 5cI8LnAB6OELjIWZ58OzIFT14aUVdZTCUEaXv4YEUR1ob/Xvk7kBe8a3AdqqEXT69oF4N
	 LKk3lLjexDM1PwGT+MEhM8+BBJOcMj62X18pmaDEWBZuPO28wzFRSFpswqRpRKRcbYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450642;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=6+MJWb3sdZ5XSOwrbD+z2rMoSPFYP+OQj+KPog6a180=;
	b=tgJBMy5YPB1FGjEDhdxBdnxiFNXVO7j+GziS9stid08opmicJDQK+WCmssalwN69Y2Gm
	 6Kc+gu87O8l/GZQe6merXNoJMzovI7IQCqUZ9OuHeI242QBz4MAW1Vwsjt684cjVyqUAj
	 34tkkQrxjvh1jEf78PceW/0hmYJt4zl1QE9IAZOUypITNB2xZTFrk5QyrqNi/tTkHesQO
	 pLM8kutY74sLvPsvFIPyqkxIkkdYxKE+VED3yJ1MeEb7HQ/l28bP3T7bQ/0tpuCiifpCv
	 WVqpkOEg4lSee4JRfZyW54tNZNqzndgYnBVmlw+pk2I6EQKMrVrepa8xqfYkOYurU8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=CMyk9Wbu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.12
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED46606A68D
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 16:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ED46606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=CMyk9Wbu
ARC-Seal: i=1; a=rsa-sha256; t=1795450603; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j4ib6i8U3wxWpOoH+tPSM39fbDOQ+/mflJBZ3Smoha4gIfeooym8WzmiwdsfiYcLDgh1eig9WjYl+is3lSPRgbCcbKMaSyST4Pimj/svuu7b2nZT4cvlJpAJWFubRcuGwmSAoQax7ADbOQ5sCUMkgo7kBozwu2KL8Ye34v6I6u4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795450603; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6+MJWb3sdZ5XSOwrbD+z2rMoSPFYP+OQj+KPog6a180=; 
	b=X4ryb8/IkxjV9jk7JsqYUaTBCb4OerBTttpn8aGmuAtdCG8tOOpIuCJ36D9dHJ+dmibqdaToRU0nSl/2CRai5mmYhb8GEbFNppp15MWG+XOQiN7susLq2kkbacnRgDs2ZT+qY5Cd70X9Sd0I2JGQ/d3x8hqhZKf54+hh6GdrIug=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=CMyk9WbuGy27amKhUj46gvqkN0T95K/FM/BEKoq5J9avEnZX3Z57dyfG59dOCStm8dVQKNJbhHjYOTZuHmsVDPjZWnpMrZ/11skSuKieTfpFVj9v+Q7U+aPbjN1RtxCcQmEThZx6/6oc+DLBsVPf52pIbVSSFeDbFprpxL1O+Ow=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=6+MJWb3sdZ5XSOwrbD+z2rMoSPFYP+OQj+KPog6a180=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795450601534661.8451238201905;
	Mon, 23 Nov 2026 08:16:41 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, "Eric W .
 Biederman" <ebiederm@xmission.com>, "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 3/3] object-file-convert: copy unknown commit headers
 unchanged
In-Reply-To: <xmqq8q2mm28o.fsf@gitster.g>
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
 <cover.1794932695.git.adrian.ratiu@collabora.com>
 <26080a7a386bdd0ae14725d2e731d1be81774d49.1794932695.git.adrian.ratiu@collabora.com>
 <xmqqld6nm3fg.fsf@gitster.g> <xmqq8q2mm28o.fsf@gitster.g>
Date: Mon, 23 Nov 2026 18:16:37 +0200
Message-ID: <87qzgbr09m.fsf@collabora.com>
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

On Sat, 21 Nov 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>> ...
>>> +			sed -n "/^committer /q;p" ../${hash}_commit2 &&
>>> +			grep "^committer " ../${hash}_commit2 &&
>>
>> This "grep" used for validation will be flagged by test-chainlint.
>> Use test_grep just like the previous test perhaps?
>
> Sorry, I misread what this block is doing.  Your "grep" is not an
> assertion.  It is filtering the data.
>
> Your first "sed" stops before showing the first line that begins
> with "committer ", but otherwise prints all the lines it sees (in
> other words, it shows all lines before the first "committer " line).
> And then you append to the output all the lines that begin with
> "committer ".  Which I suspect is slightly looser for general case,
> but presumably it is a good enough assumption that the input file
> contains such a line only once?
>
> If so, wouldn't this be equivalent to these two lines?
>
> 	sed -e "/^committer /q" ../${hash}_commit2 &&

Yes and it's simpler. I'll use this in v3, thanks!
