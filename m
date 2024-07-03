Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D00A61FFB
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719987880; cv=none; b=Kk9p1J0UgfdAtIMDpeh0WRw0jYSObaowbAUV5rpOusjW/kU/S6gYwBx8OwomWi6rQrOr3+nFROF7NL11DGUbM/0L2Kx8RgvrCNTqd+3Yc37Uo0fUIwzPXkr9t44gKaP3pCqBuTyYf9+fTYU78mO75mnW1J3WXZdd/D1Jhd+WyDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719987880; c=relaxed/simple;
	bh=eV1QrURpD9ai78SvOT/fW0brHNgDmj/tHKYOLPl7a80=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JZnIawt1eXHwgQZi7sfBx3mBBHDaSNKXOt/xcrek7XgcqrI0X5jxQPXAWbZeL8oqcoCW2VNIDjind0HV3Pmcm8suS7clhno2YGPH8AxiRHUd1A62T/WSuB1aGAVEVeU5J+GW+PcrEtQoJMzxoE49bKjQHHHjN/926wFlYQplWYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=sckWWcOa; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="sckWWcOa"
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D14F9A079B;
	Wed,  3 Jul 2024 08:24:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=46Mzbt+d+1ayx/I/Hbgl
	fhUNucILctVWEhowAyyhv3w=; b=sckWWcOatqZ37nxw3WxF64hLTTSj3o/QsOtF
	d4LX7cCIcXhSuvLzbNg3HZbYcw3d/WD2ZvEx0/7b5y9Cq8rxpb5Dd6SisRyBsje3
	y6yqbxlm0ff8mJ8DY0mtJLAcq/uyG4icd7j5sr9DArdvzO4KztlIaBV3x16r8i94
	np0/OgAf7DlVH86tMZkuTjv90R8595/INUHfS1n4UZFRWrvT0sRIkRjGAXHv26sL
	QY7SvEVETtCMWEYyCo/Lj/w0AdBjxCnWPff3jfb9mRmPNoHjzW9M6VXRFll9jB/Y
	zZBN/V2zwav8ebht8jtotJpXv4M1yhf+nkgSdtJPMx53rKXgAmc8ocPV7I7G0WT2
	B0ooQKNT5qJ+scngj7QrP2x2XuQepoG24AWc4otM7zhzgIDDXQyaqnooCtnm2rqc
	zjWfkuWLNPREF7XKHwQMhsUaIHyCstZDbM2FuC2EHjxI75rFxIBuG5OYZSBSqX2j
	m490Llg/r9reiqIPfE84oB7qKcUUMM3oQR4B7NLZzy5ucdkA8hDqC/t1/B/QJf5N
	95omr+4qwW2g2j6K1chh5hORY4eMFajKRGz4XWbSuUjFblB7KaS0Nw5Ntpkldem5
	TYZKVcAmO9lIT14Nn00KhmTZMgt9+pNH5ttUvOAKU2yfi/nTdL5Ng4wuc/XAuRat
	BrYPiSY=
Message-ID: <dbdaf27a-4b11-44eb-ada7-9991628a47ce@prolan.hu>
Date: Wed, 3 Jul 2024 08:24:27 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] git-send-email: Use sanitized address when reading
 mbox body
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>
References: <20240701090115.56957-1-csokas.bence@prolan.hu>
 <xmqqy16lvtix.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <xmqqy16lvtix.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94854657661

On 7/1/24 20:47, Junio C Hamano wrote:
> Let's mark it for 'next' soonish, with proposed log message
> rewritten somewhat.
> 
> Thanks.
> 
> ----- >8 -----

Alright. Should I re-send it with this message then, or will you amend it?

Bence

