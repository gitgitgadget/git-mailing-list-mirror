Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE63E171A5
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721244045; cv=none; b=sdDalPm+xu66lvvfmUNWNIiNTf9Zt2mbeCxmNCHZMaLXWxYr1lCJuWrRDRmkFAu6+kY1WZ5cbbsluSVg1gVOj9IzG3LuJ+bI1M+z3P5wZEoU2dPDDZ8MdGBcjt6/oSoXjjmCUWpkLn61b7y3lpPs31XVqEYIRALY5g2C0hiyLc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721244045; c=relaxed/simple;
	bh=j1OXJR7ItFtFOpc84AJuOpw8yQlHPNZQNGsn/qophoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pdpa/4AAYUBHfKGTuFzvg2M/yWhh3c8K1g/W6SvtXb4IiyDyG20vSH2ezf/lyelLdQaYngOsrZK6It21FOQFoep/pfjOkanIt63Ko8q+5fzozFzharBDQ8suLxGlkWz6SpLoz6GrJg1o+Tqf3AENXKsbELMUSe0bS7pbc9xqP/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=cL1WFfX2; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="cL1WFfX2"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id UACcs8FamH4nFUACdsEzdS; Wed, 17 Jul 2024 20:20:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1721244039; bh=TI1Wsz9cyIOACTsMpu2daYIwlH81j/yzCY1sp0pB+lU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cL1WFfX2q9f4yeeZJdC+UmM7vtOVVxX/TKGsNow5rp9GSi8Lu+YfM/YOP5KZyryOO
	 N66K3Uh9QR1kspALcNxBVAGfx8NUQhD4Y3D1zy6kUy/hzvq2fu+LbqZ7gE21uyNclD
	 hQA7h84CyfMPMH0A37ytLnY0zTq1x+U/ejE2mZ1yoGWi7x03Pw4/mZfdEVTl0fUkhv
	 L99qQv+VlLAGbZM67nvqLnQciry1ycxpGHQOE/mrMfzySIFRIRYGwHeA/Wxv/mjceP
	 KpNoCVoktHAfu0vwujunjduWlts5/6RpsgU0MfTNp7wyei4wetBu9TLtM9uNJOg97Q
	 pOfNnecB5nfdQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=f5frB/yM c=1 sm=1 tr=0 ts=66981987
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=FDPtLpea-vbzknoVQxQA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <8dd1a2c7-5b9f-4e2f-9c5a-d5d5758714e2@ramsayjones.plus.com>
Date: Wed, 17 Jul 2024 20:20:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparse: ignore warning from new glibc headers
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
 git@vger.kernel.org
References: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
 <xmqqikx42c42.fsf@gitster.g>
 <9bdac465-5f43-42de-9cad-e6c43a5a53cc@ramsayjones.plus.com>
 <xmqqr0br26ok.fsf@gitster.g>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqr0br26ok.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKvTZWWyLC7dlI0U4fuxJqnuWhQP8zpZOCVH5yrTMFtuGuG2wzLtQqYzYfytL3VxJwK0Q1d0oFRzlVMwcPHH7pFO03wEcdUjnla0chIs1kkzPCKrmjs0
 w8McsOT5k/padMuAMMCQswifal3CgWLsxDckZYJYZBClw2vAK8dS4hxJ/nt/PCBrgEXT0Gc+TT51076httI4putXxgSoiHDyo2M=



On 17/07/2024 19:51, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
[snip]
>> I mentioned this problem to Luc on the sparse mailing list[1] and
>> he produced a patch which 'fixed' the problem in one way, but
>> caused a different problem[2]. Namely, because git passes -Wvla
>> to gcc, it now issues the 'used vla' warnings, which gcc does
>> not because of some '# pragma GCC diagnostic ignored "-Wvla"' which
>> sparse does not honor! :(
> 
> Sorry, but I do not follow.  Isn't -Wno-vla an instruction to sparse
> to tell it *not* to complain about use of vla?

It's a warning flag for both sparse and gcc. At the time, I was trying
to find a solution which didn't disable the warning for gcc at the same
time (iff you used sparse as a front-end to gcc, which people on git
tend not to do; ie _don't_ use 'cgcc -no-compile' ;) ).

Also, I wanted a solution that didn't require setting SPARSE_FLAGS
(SP_EXTRA_FLAGS didn't exist then) in the Makefile (only some people
were affected).

> We do not pass -Wvla or -Wno-vla to sparse ourselves.  Because the
> tool comes from the Linux land where VLA is not welcome, we'd by
> default get the "hey, you used vla here---did you mean it?" error.
> 
> And the patch by Luc Van Oostenryck in the thread you raised at
> around the end of 2023 does apply to the tip and with
> 
> 	SP_EXTRA_FLAGS += -Wno-vla
> 
> in Makefile, sparse seems to be happy when I do "make sparse".

Yes, that works because 'make sparse' does not use cgcc as a front
end to gcc, and the command line has -Wvla followed by -Wno-vla, so
last one wins (the sparse specific flags come after the gcc flags).

ATB,
Ramsay Jones


