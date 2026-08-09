Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7A12B94
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786265301; cv=none; b=cnKEnGtwwbSHH+O7ke8G7wolRqs60tpi+7Wq8h5LiZNCWvosg7b6xsWOql7+hTMhowauqCbOJJZsHoyxxToTRkMUmRAPwi4qZC2j9rjA53cM2KTCc2hWwBrIukTXPPz9wHWOuCNVzZY1KmXHDsUX77c5Keq3MGFWi418SKfxApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786265301; c=relaxed/simple;
	bh=65RzQDSBQ4gxk33/JPluwceUwpDfeUXQmLdcxymmYcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ec1DJgiXcIGmXovubUoZYPWNI5inMnZPC6seRPJrgUd+dDsRjq25G2kGDpZrBSqCzmtrtGhUQ2HN/tyjkOb4XBe3aJ+t+zf7uXC6wsAQ8IK89Aj2fNOxawpqhp9OMZuRrvsD6r1JcZVXbzjmCL6Vap81mgPA4qlghGkk2qyswCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4hHs3Z5DnDz7QgNF
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 10:48:10 +0200 (CEST)
Received: from [192.168.1.102] (unknown [89.144.223.124])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4hHs3N5N3mzRnCw;
	Sun,  9 Aug 2026 10:48:00 +0200 (CEST)
Message-ID: <ac611c48-4f95-4bf1-addd-bdc4344e80f3@kdbg.org>
Date: Sun, 9 Aug 2026 10:47:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk: add user-defined custom commands
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Tim Wiederhake <twied@gmx.net>,
 Tim Wiederhake via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2371.git.git.1785879839766.gitgitgadget@gmail.com>
 <xmqq7bm1d1au.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqq7bm1d1au.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 08.08.26 um 00:16 schrieb Junio C Hamano:
> With template "echo '%t'" you thought you
> are just printing the title but if the title has "title?'; echo no'" in
> it, wouldn't cmd end up being 
> 
> 	echo 'title?'; echo no''
> 
> and a more creative type can use something other than "echo no", to
> have a process run under your name and do more interesting things,
> right?

A very important observation!

-- Hannes

