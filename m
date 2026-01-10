Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091E721FF4A
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 01:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768008392; cv=none; b=E9ZmNFIBpWNu/12D3PzEeFG4Kb3FmtiPRfa5JxaP6k/MdscP8fEoQgGPx13BOvJMmrUqfsKxJh+m5+Uc2W0pw9nyp8JEuOUNOk4AyRm8GovpXINzlpPSgt5XaVxt6vyb94kdI0GD+CTSKH5DyfF1qHYwLCvpAg6il26o8bIJsdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768008392; c=relaxed/simple;
	bh=YLYJxkgYCs+9ltIsQzIWvSEI0XnSKRxKsIArnsHtuPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJEieKYW5vaPMD2hRu+neBH3f4ggwYyHxbx3p/o8hfkb5JhxiZUUGiJ7xsk+WrEYxOPXgUcARyI9Tlnj5iIrUY6/GIEDe9sPL93IjdensLoZPe7QL48rMK/cCQ3SFPTj0eiSjseSU63jyrUjsGB8JaaOQAm2LMoWVKg5tni6HlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=J4kqETd3; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="J4kqETd3"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1veNk6-005UfR-L1; Sat, 10 Jan 2026 02:26:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=ctKoFKWkVu0vj8WWnPp2rNPse/MnMQ7oSWTS7Aqup5M=; b=J4kqETd3kkzjPJVS90LANBwP6q
	iBTS9to0UBBcumX6Buo0yfrLthu3ern7HF8lfL3qsb8J/MLomwlXkdFo0aYcSt2U811Djy++Uze2y
	O60JX//MNPLa3PtqiFiM67XcSo4DjaSCNgBee7xkgvftCTP3HlTxxpmt9N3lTxdgBVv7dEkltgjCB
	UZBeXY46nnWI5b4Dz+NU5oCZOIJsrKt5sXkeHCO2VS/yBrnQBPQJbJ4GNYnFvkbkGsNirhsb0bmc7
	RehwKhzivnAlwPHH40ylhl/No5j6c2LwHrVoB7PVfZd3kFNuTfvy5wOBs1CSIaL7WLV2AQpiuOlml
	ugBkec9w==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1veNk6-0002Pm-D8; Sat, 10 Jan 2026 02:26:14 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1veNjr-004Q1d-EG; Sat, 10 Jan 2026 02:25:59 +0100
Message-ID: <5794d99e-a7e6-4258-9a1c-1512c3f577af@howdoi.land>
Date: Fri, 9 Jan 2026 19:25:57 -0600
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
References: <4a9c1a5f-336a-472c-af1d-7011fad776a6@howdoi.land>
 <20260106045528.2628818-1-george@mail.dietrich.pub>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <20260106045528.2628818-1-george@mail.dietrich.pub>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

George,

Can you have a look at the patch in 
<20260110011811.788219-1-ask+git@howdoi.land> and see if it solves this 
issue?

Colin


