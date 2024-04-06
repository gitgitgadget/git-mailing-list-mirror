Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB0446A0
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712431183; cv=none; b=clWlwkRB0Yxxk7FN5T2DH9/C+invcI00OGmGRftRCGGuCzBK7WVwwn+HrP3mNcRUG1jurujBlsxKFQJqkp6BBSmeokhR4miYMWo+uH095ZGpf7yWIYTNXapeGJleMWpO+5a+c4kUeXtH4Y6gST4JsPgbd0cNldC45LhClMbXZ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712431183; c=relaxed/simple;
	bh=8DdM/pufJERwtGtMqUzferK0OXgDD9hkFGpt8iAK0eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ho1ZnGrXzsAULkp1huBM7AtXGzhVsuXLfFqXZphYUYsGlZvdfpulZDZBExxOioUC6PWaHCBXxI34n8WYSj94CsV5iDG4uUSQANct7s1LWODffSdPIlsWjjDedeARdrcgJNx1IxUQaPcWjftzj1T6SrTLytUDemOf8ot0vIz8Niw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=ELF6lcfw; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="ELF6lcfw"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id E3A2B1A181AD;
	Sat,  6 Apr 2024 21:19:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1712431179; bh=8DdM/pufJERwtGtMqUzferK0OXgDD9hkFGpt8iAK0eM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ELF6lcfwZJ0Kv/TwHQz80K3mzgmqMDLozcO0ojjQ+0+tEUEazYuCFhflo+7EY2U/3
	 RG6KIOfOCVCMK+gKImlwW8FvUS3Rhpl7idVoXPKPM1f45+oEZ4LBxY5JD5+jePBud1
	 2aHzhGcCwcbpNl/6KX2DZXm84w3czUp6pURual8M=
Message-ID: <a861341d-4550-4729-8f86-c3378b1c3c6e@schinagl.nl>
Date: Sat, 6 Apr 2024 21:19:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>
References: <20240330081026.362962-2-oliver@schinagl.nl>
 <864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
 <xmqqcyr3s3gj.fsf@gitster.g>
 <b194ba7c-454b-494f-bef2-e9eac7ca87f1@schinagl.nl>
 <xmqq1q7il8re.fsf@gitster.g>
Content-Language: nl, en-US
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <xmqq1q7il8re.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Junio,

On 06-04-2024 19:07, Junio C Hamano wrote:
> Olliver Schinagl <oliver@schinagl.nl> writes:
> 
>> But seeing that these are your main concerns, I'm more confident I'm
>> not completly on the wrong path here.
> 
> Mind you that they are not "MAIN" concerns.  They were the ones that
> jumped out at me from your sketch.  After seeing the real thing, I
> may find completely different issues that I could have spotted in
> this version as well---it is natural that people notice things they
> did not initially notice with a richer context.

I completely understand and agree. Just as I changed my design 3 times 
now already after learning new/more things.

Thank you for your time, patience and feedback however, it is much 
appreciated!

Olliver
