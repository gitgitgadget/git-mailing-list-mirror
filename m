Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01B71822D7
	for <git@vger.kernel.org>; Sun, 23 Jun 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719157854; cv=none; b=p7E3y80jT65vak+/2eI9WRueMY4QegekL8MhvddwJjN0coAoJbooW3iZHFfkpwaSSFU6TglTo/c76MbzGoboa6PIQgK+aK7o/FtSUHDSxQad6SXJm9uVHXSkpvjG9a1R9JVgv0GQBn9rEbNuvR6v2Qm4LzmVNNgEc4L5/A4u1f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719157854; c=relaxed/simple;
	bh=Mz8Z9WpoMdHX8gp2m+7Q149A2Y0sXIvbap4YrXzfVyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyIWZ/IyKhpyUWr264hzvrcJdiSnQJ9QDI+kMiodu7N9rYedeDybIAV77caJLjb8Oj7V7nX9nKC4mKXmZe3cBj4OU0LoTyOOAw1QzN9ZmODNxYP1hY8thageLkmDx8z6M/FQRUQz9JQHIiU4YJS1mR3va+EK+fQqALgXq2Yh39o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.105] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4W6bCn0lsYzRnmG;
	Sun, 23 Jun 2024 17:50:45 +0200 (CEST)
Message-ID: <ade809ad-3748-4124-97c2-9d6c606c0585@kdbg.org>
Date: Sun, 23 Jun 2024 17:50:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix default font scaling
Content-Language: en-US
To: serg.partizan@gmail.com
Cc: git@vger.kernel.org
References: <20240615085345.47278-1-serg.partizan@gmail.com>
 <5dd4de8a-255a-4f03-b4d8-fc160b3178e1@kdbg.org>
 <Q1B6FS.FVKOG950Y3UN@gmail.com>
 <abee589d-5bad-4376-ba91-3bd611936983@kdbg.org>
 <N75EFS.1X38FZPYSV94@gmail.com>
 <0c845460-c211-48e6-af93-a0b483817420@kdbg.org>
 <3M5FFS.HXL15VW2HPOG1@gmail.com>
 <506e1f16-ac02-496c-a9dc-414726c1c37f@kdbg.org>
 <YY2JFS.UYR26AJBROJJ3@gmail.com> <3LDJFS.N7X2NCO8QRE9@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <3LDJFS.N7X2NCO8QRE9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 23.06.24 um 16:00 schrieb serg.partizan@gmail.com:
> This is x11-only bug, which existed for a long time and i'm suprized
> we're seeing it only in 8.6.14, because .13 and .12 are using the same
> negative sizes.
> 
> It is also fixed for a long time in the 8.7 branch and not backported
> into 8.6.
> 
> https://github.com/tcltk/tk/blob/7c3e2ff815e23cc6ac1ce9891ca659e709776ea4/library/ttk/fonts.tcl
> 
> Also, you may be not seeing this, because your distro may have applied
> this patch:
> https://sources.debian.org/patches/tk8.6/8.6.9-2/font-sizes.diff/
> 
> With this information, i'm more inclined to making a patch for ArchLinux
> package. So, it will fix every tk app, and not only git-gui.
> 
> What do you think?

I think that would make sense. It would relieve me from taking
responsibility for a patch whose effects I do not understand well.

Thanks,
-- Hannes

