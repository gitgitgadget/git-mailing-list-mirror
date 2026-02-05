Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321DC30C372
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 06:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770271577; cv=none; b=Wo/jqi7DUADjmnUwxW3oI0JyXbMbui0cwG/Wz10bzIHhlfTEhji24EXVCBOzsMadosCZsVexANr2bqXfu6mekwstM+o1IXS/zd98HRnrMbzzt1hQrP6zQhFdSXz4A0q/+gi4RAVqeYoyV9Y0Ib/U7Kda21f6tKAVCRaFaQk15Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770271577; c=relaxed/simple;
	bh=WwKb9M/5HqtcjnH/FS9RVu4cx1wLdaqbsUAbTu+UtAk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=K7hy8qLzpvd+TE6jKUlhKLQFYezo+mMjE5f6vx8OGc14+bwQMiIn0t3yyKVDV7exYOeWSdy7sgjZyHhzCruAMA5M34zJmZoNgZ4nGoYsyFRUqbmYkn0zx2beTlQMFcqoOjB1kcBx3pdt9M6ZvjQH2T1OOniF+Z8K7JyfzHtCM80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=In2zIWuk; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="In2zIWuk"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vnsVI-003zRD-8c; Thu, 05 Feb 2026 07:06:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	References:Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=4P6DhQfnttO3v4sOhIaZSWh70THqamNOTPtBNObtiCU=; b=In2zIWukOvSBu8/zpfIE8DSQ8I
	NRaI326DPkPAghDEjvK/N8WNNA2mip23H88fx80BWfnfjfpM9QK0FqNPOIZoU+VlP1Swua9gkWH2A
	iFQwNpyOCFuHTbwM7e0lTK8gaenMIiaQMt7O6H6XL3hSR3sxjNLWK17T21r69FuCZHn4Pc4cQltUi
	HD252oV1gxRsTQxMC4hDIOIG4ki4zY2M0+KkuMwjjmwJnilK7kbW4uqLTi/4BUTRQuMNhPIVTurai
	VAdFFrYvlla1bsrK3Gq91SeD5fhrucTKzABBqGOOLuHBIdXBHsOdfl5GrUXuKSO4xUBfQuEzL9HbP
	WQehdIRg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vnsVH-0006Rw-4l; Thu, 05 Feb 2026 07:06:11 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vnsV8-003zR8-Td; Thu, 05 Feb 2026 07:06:03 +0100
Message-ID: <ef128e1d-dd3e-4573-bfcd-6a98a0a1f394@howdoi.land>
Date: Thu, 5 Feb 2026 00:05:59 -0600
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Colin Stagner <ask+git@howdoi.land>
Subject: Re: Re* [RFH] adding test coverage for contrib/ in CI jobs
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Patrik Weiskircher <patrik@pspdfkit.com>,
 Adam Dinwoodie <adam@dinwoodie.org>
References: <xmqqh5smdejc.fsf@gitster.g>
 <20260115175403.3971-3-pushkarkumarsingh1970@gmail.com>
 <7k7ewvrb5hj3jyesiigy6dvo5w5pl67rk7ihztsuxbtqpymafv@ey64nvhzhacg>
 <xmqqjywuyhu9.fsf@gitster.g> <xmqqsebhu9nn.fsf_-_@gitster.g>
 <xmqqjywtu58j.fsf_-_@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqjywtu58j.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Junio C Hamano <gitster@pobox.com> writes:

> Unfortunately, this seems to reveal existing other problems with
> subtree tests (t7900), in addition to diff-highlight tests (t9400)
> in various configurations.
> 
> https://github.com/git/git/actions/runs/21617099884
> 
> This Ci run is near the tip of 'seen', so there may be breakages
> attributable to new topics in flight

At least some of the subtree failures on linux-reftable, such as

<https://github.com/git/git/actions/runs/21617099884/job/62298228602#step:10:421>

are actually due to a bug in ubuntu:rolling's "dirname" implementation. 
This was fixed upstream in late January [1].

bug behavior demo:

     podman run --rm -it -q docker.io/library/ubuntu:questing-20251217 \
       dirname whatever/.

outputs "whatever"

     podman run --rm -it -q docker.io/library/ubuntu:25.10 \
       dirname whatever/.

outputs "."


subtree has an up-front call to

     dir="$(dirname "$arg_prefix/.")"

which encounters the defect. It then attempts to do things like

     git read-tree --prefix=. $someref

that error out with messages like "error: invalid path './sub1'"


[1]: https://github.com/uutils/coreutils/issues/10508

