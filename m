Received: from libero.it (smtp-18-vd.italiaonline.it [213.209.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B93214
	for <git@vger.kernel.org>; Sun, 29 Dec 2024 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735466604; cv=none; b=Z19S64EKaY68mg0bWBT5W6yPAG+lpY4LNu4u60o91SVEb9W1M7FgE9RSe51tnK+KiwgEZouRD0UVz6RDSKVJryMHL52ZGiLMDrh4xtQ8BObE0seQpdtyNySAfDnD8O+KrEfjlwkJv2lkjfQ3y8YI9OsgvrZb5RA+1QOWuYZdAdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735466604; c=relaxed/simple;
	bh=ZCV3k62RcTKc5C1J7PiS70EsnT4a9TWqpyzg1/yiUdo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gg3pS8kYs243kCseg7zpdoJyRZsHcXMaxAzBHhS1FFJGA8MUz9kkzgkqA9ovh0I9VedATpD44Xrz3NwDZBqmtkN1V4aLiX4vPH59Sgsr+k5PuwdLZEwQMZEOViwpYcHrKokSqBQZ0rcxrWtz4LrT9q8lRYpbxOrjLmiF5jkqw14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=tWj+Gpua; arc=none smtp.client-ip=213.209.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="tWj+Gpua"
Received: from [192.168.0.129] ([188.27.146.10])
	by smtp-18.iol.local with ESMTPA
	id Rq8ltnpAGgetmRq8ltROTk; Sun, 29 Dec 2024 11:03:20 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1735466600; bh=N2YleGl5Ho3/IoHQejf/5ujUy2pHvXrX/wWgwgw9DR0=;
	h=From;
	b=tWj+Gpuao2qg2mHAwEPysHyM5bMEeRKZniR8xUfDjaoGQk97X+ax5fchvOPXmFxKz
	 1S4wJvaCNd1EEOeT56F+21Ie8RIAEHdich2DYzMnrzPl/HeTLyGMrez3V5kKOtjIDI
	 Q/yNJOx0y9x2Z23tAehqJqrvViYuK4vg0sU/x4eu+xw7ZJc0LcZs1inISKeehBxVWb
	 tBjW7r/FTLN0tFuMwpGGuqyKRAUY2RdE2O9TD4xBRTQ69w85btXFzJFmtlk+vFCf9q
	 RxsvXkh38vjiUBks0LcaAaKELYhKH0PAxuw/Jk9d2++OtvSwwbsRzS0gJ9JAmhwmhn
	 RkrH3UFTBy2GA==
X-CNFS-Analysis: v=2.4 cv=QPmjRRLL c=1 sm=1 tr=0 ts=67711e68 cx=a_exe
 a=nouTapptOgoxzTc4WCMdog==:117 a=nouTapptOgoxzTc4WCMdog==:17
 a=IkcTkHD0fZMA:10 a=f7IdgyKtn90A:10 a=bzQfXJuQWmcOG9-JT7wA:9 a=QEXdDO2ut3YA:10
Subject: Re: connecting the local main branch to the remote origin/main
 without pushing
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: git@vger.kernel.org
References: <a69c4e2e-cbb0-c242-a34a-8997a84fefb7@libero.it>
 <87h66nk9uy.fsf@igel.home>
From: crstml@libero.it
Message-ID: <558a48b6-d818-a5bf-6988-e0a500c6d5fc@libero.it>
Date: Sun, 29 Dec 2024 11:03:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.18.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87h66nk9uy.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNmgdRZlVqjK7Rgn0b6nuAEkX5h1yeiPm7ENXQdvYUom4asQuBkZ7kqPPXUTfomaIS15H0Nk+lRVwKavae6isGHl+VdtHBkK6SS1xxiCyPcgU3DEK9Oo
 gmj2X1YOu9GScqlClph6aypEqWNVIgW42wP0zuc11ww7nDsa/1cPT17TT4emWVk35xeYEYk+nohQ/Cnlugemb5tOFEf+6a5xXQ0REV5l9Qf/HT80Xw7ZqhvF

Andreas Schwab wrote:
> On Dez 28 2024, crstml@libero.it wrote:
> 
>> My question is:
>>       Is it possible when applying the method 2 to have (without pushing)
>>       the local main branch connected to the remote origin/main branch as
>>       in the case of method 1 which by cloning connects these branches.
> 
> You can establish the effect by setting two config entries:
> 
> $ git config branch.main.remote origin
> $ git config branch.main.merge refs/heads/main
> 

Excelent. Thank you for the info.

Cristian
