Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F537261B78
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 20:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771187815; cv=none; b=RA1Ipgc2Wg/BNR4MgEDHbEAx2CVBQKSuGvwfNMszlbg+98djuuBEkrugRFJ1MipaSjuKP+MHUohIM2WOfMSRIKVse8kI41l+mjWuFoil6Gc6JYG02gffmupKqsS5kk/haT0uQLL9HZrvm/ZPsVXSNelxMfOzyq+dQmYntbX8bx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771187815; c=relaxed/simple;
	bh=PjoPFbA0A6v6fklM3fyXBdHgHCo+CIogRZ6XB61d7o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AP03+ArI1HBtXZVeXCQx+EjBASQvzuEi/MdV+Kfe9m4Vzh/X3HPkkrnjhLh/Efebqyua4dp2FlGU1Basab60psuOlTkV6hu2UkWZiodCHMIPUNDkB/FJ+ICLsi/SypzdI1nn21ljQ3C9I1ueyoLUM9UfYj+Y5WVrEAwqg6CLKB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=FuTg5PGJ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="FuTg5PGJ"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vrirK-008Dh2-Ls; Sun, 15 Feb 2026 21:36:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=0g3aUAqTOk1+0R7odBKfQXceo07+vta1+1kjsbk11I4=; b=FuTg5PGJPcjvwx06jT0jghLxE7
	ARGEAKIKdLsrMS34bqMRf7bycSD8Zw7GaB8stzMyeNtn6Z8yvMV/ISSegoEeJcAhGj3Tw06qqNEXJ
	AQBJPX5nQFmE5n1RGcEjEeizqIIunGTG9z3K9fBMhKbdfoiPN8qsRBAgm7MO9f7Ooz+4wxnkcRXpB
	ABRl451mW+NvA21wmqU44muaino7zjRHJqpYJAXDfdS4J+TmHFl9a4bYTtdJwrP8aC9LP7P6GKPIV
	1DChc4k2f6GIDrZkh1FR4NgF240BDZic5+WouiAS37f6UWReQBchCr3ct7w3IZ3Wld+SGMFEDFB+G
	bNK9DShA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vrirK-000789-Cy; Sun, 15 Feb 2026 21:36:50 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vrirB-00E5fO-Eh; Sun, 15 Feb 2026 21:36:41 +0100
Message-ID: <8d5212b5-3088-4b73-a849-f1c297e06157@howdoi.land>
Date: Sun, 15 Feb 2026 14:36:39 -0600
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] Git subtree regression
To: george@mail.dietrich.pub
Cc: git@vger.kernel.org
References: <5794d99e-a7e6-4258-9a1c-1512c3f577af@howdoi.land>
 <20260110172219.125762-1-george@mail.dietrich.pub>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <20260110172219.125762-1-george@mail.dietrich.pub>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

George,

My original patch for this issue introduced other regressions and needed 
to be reverted. I don't recommend using it.

Instead, can you take a look at:

  
https://lore.kernel.org/git/20260215201748.889866-1-ask+git@howdoi.land/

which removes the "ignore other splits" optimization altogether. After 
some research, I suspect that this optimization may not have enough 
information to work correctly and preserve history in all cases.

I'd also appreciate testing of

  
https://lore.kernel.org/git/20260215201748.889866-1-ask+git@howdoi.land/

which fixes a "recursion depth exceeded" bug on Debian/Ubuntu.

I've CC'd you on both of these patch series.

I have tested both of these on selected subdirectories of your athena 
repository. They seem to work. But I'd appreciate it if you could look 
at all the splits you normally do and see if the patches correctly 
preserve history for you.

Thanks,

Colin

