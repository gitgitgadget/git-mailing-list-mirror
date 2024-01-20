Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9181094E
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705771187; cv=none; b=OZkKb6Qgkmi0lDDXsowGh8ElsDxZYhm76HPYdhJNFdRxrdkWCAg+UarI0/qImwzH25rKYIKLyK4oFvkAxFsMcyMnjpzxxPPs2QO0Qg3zGiSvzhlW8ezfROvFDWGvTHy48yujTGUKngTl8frvaBgAvf4wtzfvRP9KxYo8S11kX3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705771187; c=relaxed/simple;
	bh=DpBTWDBwanKN6y1iS+pztmzi6kzNVxgFsb9y6rvUQsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YaETLLl/Ofhaqn1qo1Gon7HP247B98tbJyZv3THR4Mj+34yJN5EOb2t8e7xh9EoCE5W+lbkx3+Bb1HTWKy7LdPQLoThpnWxLgwj98qA9fs28NSGcINFJKcTXlZjjacrFnXPEoCHzATzfIZsVxjl074gBI1rRNf/SxUzdFk9JcHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DqvqbTET; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DqvqbTET"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E59502570E;
	Sat, 20 Jan 2024 12:19:44 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DpBTWDBwanKN6y1iS+pztmzi6kzNVxgFsb9y6r
	vUQsM=; b=DqvqbTETwvmDmPCYLYlCM9uRzpbQFKxrk6Zicrp6tZOzynTvUEwsWW
	P+ieAyTplG6S02FCPzDLj2HgPWvD/5eUwtaqnA2G+A9sm1uS5y+casHS97kxhrw3
	wiHY3IY8DokCn4IbVT42GuYUKKQC2DNoDVCnbjIbVxp6jhIFAV+oY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DDDAD2570D;
	Sat, 20 Jan 2024 12:19:44 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7A91A2570C;
	Sat, 20 Jan 2024 12:19:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2024, #06; Fri, 19)
In-Reply-To: <CYJ62QPHPHCA.2WLKYX1AIZ50T@gmail.com> (Ghanshyam Thakkar's
	message of "Sat, 20 Jan 2024 07:40:13 +0530")
References: <xmqqbk9ghio5.fsf@gitster.g>
	<CYJ62QPHPHCA.2WLKYX1AIZ50T@gmail.com>
Date: Sat, 20 Jan 2024 09:19:39 -0800
Message-ID: <xmqq7ck3hqhg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 18EDC416-B7B8-11EE-8694-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Ghanshyam Thakkar" <shyamthakkar001@gmail.com> writes:

> On Sat Jan 20, 2024 at 7:26 AM IST, Junio C Hamano wrote:
>> * gt/t0024-style-fixes (2024-01-18) 2 commits
>>  - t0024: style fix
>>  - t0024: avoid losing exit status to pipes
>>
>>  source: <20240118215407.8609-1-shyamthakkar001@gmail.com>
>
> I have rerolled this series, cause it was breaking CI on alpine due to
> a syntax issue which is described here:
> https://lore.kernel.org/git/CYIDCZPQN2H1.1ET0CTP07NMYR@gmail.com/
>
> Thanks.

Thanks for pinging.  Yeah, there was that buggy implementation of
tar that requires dash in "-C".  Will replace.
