Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0248438839F
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781641140; cv=none; b=aGcCVhPUDhT2934qMeHRYtUhIhbh6xcF1Yv/Jf7Jefle8TrvU8xB62piaVh9GE1CHVCR9HN6yWvChJeFCOGkw7GFB4EdtbjsYBWei7lnz69HBPsnwYIQHaZsidJVWEHom8iwCQVO5PkQh40Dt3ZGwxjrR+XfdkVzy956Vo3fZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781641140; c=relaxed/simple;
	bh=YITgn4rtvkYFWLno9DXQ1ZDeNkaj5Rxt0QpQe4MN5tY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sCye48onuZfnygUGxJyQijNNYcTqG9MH8YWctnogMx+tDC4j9Fz6x8BWYA3RY/a+On7RtPleAtaee26frF1GsNSQVIfryjJz37bt4ZscDIOIkF9nsFhnjkw9KPTqY0i2ebTwOF02HAWvkLg4B6OR78dWLKmHm46sH3CkYuWrFuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=G+68Erg9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OMtu0HB8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="G+68Erg9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OMtu0HB8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E6A2EC01D1;
	Tue, 16 Jun 2026 16:18:58 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 16 Jun 2026 16:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781641138;
	 x=1781727538; bh=BEah8mPpbOyilxI64NfV0LukmLNpmYVMpf4uhYTtZwY=; b=
	G+68Erg9a+2ZWgSfytevuL8zS7vsBO4P2MQjgWIWWrCQJkJFqlZNNgOPZr8NCfXp
	eQ20rwOuoBRPr5HSdFfEf1zC8FzCajlzvMSHaljy3dsANF/Hkocq9BHkCZepKxqP
	N1rapSK0NbD66gr2B87bPjXk2EoRRCb4GGnJEasmTd1E+6kP1UBZyQXlSrURa82E
	EtAGgWo6qk7ibWTtybn3r6uk8dWUy/GpPXDnxaYoa6WxL5U5yRaNLHt32m3wbwu/
	GMYQuidFPzgXi1nno7Q4si0bmhlLUMQPeHjgIYyUVVkrXO2keqVY2kvnr/2g1VUe
	NlmQMBI8H/sLbYyCALV4PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781641138; x=
	1781727538; bh=BEah8mPpbOyilxI64NfV0LukmLNpmYVMpf4uhYTtZwY=; b=O
	Mtu0HB8n5vuRhkx/KajiS32lQyyep/CdyIExHF3l0tlXM8EFs6bZnya7N3dyldb7
	FHiK5kzXNFh1NwTVSuHTQ7hzqwrj1yBqIPo24ifvmhHKyvAp0Ta+T3TupEEX/yJ6
	4ZSiDL1cz0l3jyhrBYpRTOiCmryaRBers9bt/qsd5mTwkh5gm5cAvCnVoC51os1S
	tuMW80BP80SKwQ44XuiT3miVdB7Pt1bitsYh05PbyjWHBZfsl+sxvRVi0xzH03B1
	Zeu9zcHq8soFM+KRVssoEjOQzMAs1HgKDsJKGnSCziGBR24+lB+QTk4ZO8N43EBo
	i6ItbXc7A/k+R6ICJ2LzA==
X-ME-Sender: <xms:sq8xajS_B7keD1U0ATsD_ZJvQEm4Ea-6Wy9Oyf1EUkP4I3PeYg1Xr_o>
    <xme:sq8xavn0k_Uv2c4bEX3L2WtyIE_MyDYAP77CRi0bPUtrHBiQ8WgD6YDA8FAxcGBxy
    Ee5DsVdOJMlI8lzacpydvF50eEFAt6Shk3IlIgimyke1GFpbaGH>
X-ME-Proxy-Cause: dmFkZTFeDeot+ytVXCHqf7PGzvnH9/SgBVTDXvcfQ1mwRBh+gdARET/SoPfz51aUSDZ0kb
    xiOEKDu1HvrvEviLpNhd3TGWYU3AYmpl3XraIzYLnnt5tcj7unh41L0/31HwvNokhnH8+U
    grkc97vLD5S9VSHka0uWGPQxEPm2rB7i9S7pxYvr8wcscnYRYoLQQNs/2gh7vmvfRt2ZbF
    GVadMSRLHYlOYH/1zZPSHPv/cnCJIVaxB7PJR6zAT9+dUtJff33xsWq3TtOfcHjGeuvmgH
    jUg9NxhBfhySfFlz5/ErvmMDLI5T03dhABQyom560dIpprohWqMAK8JcWsjW/YuPatCnMZ
    3Zyw2jZIpLByhN++/kHEkVDO21lQeTJVcgTkW0hxnL8Z/RcHbfoJ5saIlXiQRiVq05gJgt
    FOj+uEv8y9jsjzHne3AEdNNweEHKQWa9x3RYjkT4X7oNvSVYTBZZWF+GvzXe2YghMjwnKx
    C8YvPdReCaQ19uiH+0rnlQP9al6csOHxLIJlTo+4qUxilRgSzEgBQheLuqlYsiL60awGYF
    tyI6T9FTigdLMk09f/A1ak3McYeb+wFcSmqAF/p5tQqZrT97aM+jphXCP4Ofag4GdQgFlD
    DdwmMBhONbcy8EIkKI8t4ikX+OslRBHXnXqUC5dElTbQwH0TVE2/cFAyrtxg
X-ME-Proxy: <xmx:sq8xal9bUCng40NhUcYxi3pxjux0Xu0X5vJSmooebIhuLbE_q2-sbg>
    <xmx:sq8xanqKvI4hzcoYfQAaZdlDMBFY7kNlascjZqHBIKSCwqX7qsKCxA>
    <xmx:sq8xaqkP74j_ttg7Lmz2QRXKnYqvkZ6YTPW7z_7UVrxV8vwkBrAuyg>
    <xmx:sq8xamJsP7FPstK2qYZrCMeCtYiDJLAF0fxfokPmMO158eYmWrmqjA>
    <xmx:sq8xaqL4e-x7y1SfIFH5yv5HJ7N03ZpSPrnUUitacHLeZmU1MJ6qpwXe>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CD8443021A94; Tue, 16 Jun 2026 16:18:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AbKqEtIpQel3
Date: Tue, 16 Jun 2026 22:18:37 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <89776d4e-bc61-475f-a12d-167047ddf23e@app.fastmail.com>
In-Reply-To: <xmqq8q8mt4eo.fsf@gitster.g>
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
 <trailer_order_matters.8f9@msgid.xyz> <xmqq8q8mt4eo.fsf@gitster.g>
Subject: Re: [PATCH 6/6] SubmittingPatches: note that trailer order matters
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026, at 00:30, Junio C Hamano wrote:
>>[snip]
>>  Only capitalize the very first letter of the trailer, i.e. favor
>>  `Signed-off-by:` over `Signed-Off-By:` and `Acked-by:` over `Acked-B=
y:`.
>>
>> +Note that these trailers should come before your `Signed-off-by:`
>> +trailer. You are signing off to the patch as well as the message. Th=
is
>> +also makes it clear who added trailers when multiple people have sig=
ned
>> +off on a patch.
>
> Perhaps first mention the underlying rule that they are added in the
> order that helps us to understand the chronological order of events.
> That would avoid giving a wrong impression that the nature of each
> trailer keys determine the order of these lines.

You=E2=80=99re right. It=E2=80=99s best to lead with the time-based orde=
r. That
naturally leads into the implication that we can easily read what
trailers that any given person added.

I=E2=80=99ve seen discussions in the past about whether trailers ought t=
o be
sorted by *kind*, and maybe if first e.g. you should first have
Tested-by, then Reviewed-by, then Signed-off-by... best to not give such
an impression by accident.

Thanks.
