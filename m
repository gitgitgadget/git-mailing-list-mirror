Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06941879
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053709; cv=none; b=HZGjGO3+CYDHo3+YMQG5TwUw97tovlAYo0pNkKrKysP69Ly4WUqqbSDYKDyct6ySP7vl/SSeGF+93ttVV1zCFfwTeZM7D0ukw8wGze6UTwwgMrtaZhyGhyVsEYU+OA2ZLou9XCYmE5GwQZDjF4PAlmaClfGjBP6OP1j+70JHLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053709; c=relaxed/simple;
	bh=x/J32n7+phVh9N7TA0Fx/NS4aDJbvzweOBZlwcgwG5o=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tvo+uTmqzuSgzQAvZc4vVlOwNMfFCIPGtvtbO8w8uSXaguDhzMZKzOB+mQ/pSbgt92+J8bGzaOIS0+pvuWu7/DRB0taQnQMP7reIr8DnFe73zWaWUDKgYQxTaUf0o4EtjgwfUUvW1LbKPzppp4Ifyr/uVRyH0RyOr6aWA3Kro8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xRzpEeG2; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xRzpEeG2"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1718053704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ohdt9VwxVTWm0cnisU1+QOO5YylOmiquqWidx/E7Lm4=;
	b=xRzpEeG2413CAPPoDApQHA8L1JdBONdBTBHyd3cCf1UHHLfIPKHJfgehULCnaLVxFPq1OL
	C1LCief+ZqlUqFSBFwhUBgsS3GKTIrp+m6qzUuWk3JWn1W1IQm7Dlbv4m4DCxhXv1Z3irE
	sXB4atAsLTYSMIN87mejvKtWJ8TmsuVRAGkwoA3jHOzTb7LxM4kdfc1+A7DvymKUuJ76Wo
	SfrjrFF76FVBMS0sxOl20Ugaen1otlBOdiTDysFu3C0kcLjLukNs20HEw2iqcEloMgpNrQ
	RpIDtICqSucS+TVAHJX/P2LE+PCeBDphEa+TjeZDdvpDEcb5ib5N2J/3jQTlKw==
Date: Mon, 10 Jun 2024 23:08:23 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk, Jeff King <peff@peff.net>, Junio C Hamano
 <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <1f7b27b1-9bb2-49af-854a-762d0e75d508@gmail.com>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <20240604101700.GA1781455@coredump.intra.peff.net>
 <xmqqikyo207f.fsf@gitster.g>
 <20240605090935.GF2345232@coredump.intra.peff.net>
 <6056d585-6380-43e7-adf1-9f9aadd2a7db@gmail.com>
 <a8d3415e3913e3a0798a748ed7f7a093@manjaro.org>
 <219a195c-74d0-4c21-bf54-0752bb5b01df@gmail.com>
 <9f1884ae-0f9f-4d9f-a262-b6929b81d7d8@gmail.com>
 <1f7b27b1-9bb2-49af-854a-762d0e75d508@gmail.com>
Message-ID: <6c40aa4d829cc80114062984f9d148cf@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-06-10 21:14, Rubén Justo wrote:
> On Mon, Jun 10, 2024 at 03:09:48PM +0100, Phillip Wood wrote:
> 
>> I'm still not really convinced that the escape sequences are a 
>> problem.
> 
> A concern about the escape sequences was mentioned in this message:
> https://lore.kernel.org/git/b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com/
> 
> It arose when exploring the possibility of using the new command "|"
> with tools that do not support escape sequences, e.g.: "| vim -", or
> "| clip.exe" to send the hunk to the clipboard, on Windows.

Hmm, I asked [1] why do we need "|xyz" and escape-sequence-free hunks,
and the answer is above.  Another example would be "|xclip" on Linux.

With that in mind, let's have "P" and "Pxyz" that both honor 
"color.diff",
as already proposed, [1] and "|xyz" that strips the coloring escape
sequences.

[1] 
https://lore.kernel.org/git/3268c498c9ee60803384db6db2d0e94b@manjaro.org/
