Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299013;
	b=yTroPI8S+nZfgrSIH4pxNhNaDKv7l7dAgxkDGyFi9p/1xBDdM5MxQzBqlbBjfTCCXtKW
	 HBy7VB+uzviSH2A+mjQB+nKrHqEUD+jPjZn06jTiwu8Xtc37Cmtp2FUcjgjgBdgdqseuJ
	 z4BwcAdl8sCcdP7ujvDma9dKIPyTmUA8UcuN87XY6cDow57Kz3E550Ojd1+bLsCImHdK5
	 XXBHBCXvk4AmtbTn1SL7thGK9A6Das6efr5TJAlpkNwy0V+/oKd6vuXiXOvsSvTnrcRGv
	 u5LN3hEA5OuQmQPjtB51PoIUVSh4YmxRTRopYk4AKbltRdKIPJ7UtG8EsmVXnu0bKKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299013;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Fvuh9yZ7rt9ULpAgV6G/UKvCLVFxk4DzZyr6D75u96Y=;
	b=KKEa30Aj+RpbMyp1GXZuqr/JO7DyLwG7hwsbCOEfSrpBpW/iIvi4VnWlHV1Ir0F2Jg12
	 Qob/Zs8hQxaQm+fOKgXAQqLSGyM8MPIhtB4rGvbP4GEXWLwBsokJCowHTPSeIMPlqqyoq
	 a79210LCocfz3WMBwU84KbHgRtdjKGXP9FEubeIXuTXzlqlravMCzj/yj++OZqEIQsmB3
	 s+7fgH+PwXT1H1gvSZ9nTzn5pIxWioWOoWgGZi9JKkZUsOnEBn4e5ziwi+uz5ApzgcKJ+
	 8sC/run/VWz8OALHMRvPNCwh2QZWYwqqiDjPScH8S7QMLqaRdKYwbv72VUTGdgz88nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=nwhMWfyZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HGs4EiC6;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5ED606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 18:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF5ED606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=nwhMWfyZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HGs4EiC6
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B1241D00145
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:36:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 14:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793299011; x=1793385411; bh=Fvuh9yZ7rt
	9ULpAgV6G/UKvCLVFxk4DzZyr6D75u96Y=; b=nwhMWfyZYiUOM98BKnvjAmn3fM
	+xV4Xyhv67nxmLZhlzSjptrKTyu8/pPeMHy8e2+1qYvUfvkwMyNwGt3raMsx9bof
	LQyWH08DWnZgFKUpq3Z1MZNAFSM+zi8pOB61W9mQZZr/GYjDGn+aH2pNk8EN6wK3
	S9CXZtHaRFTEwy42489T2vRYe9uPNAdzz1J6IJfS0/UqN0SlfBmsEh5F+wXX4h/2
	n6M7OaEVd0W1ivG6e05REiRPUxL+qkKecHtUnIcj50yQn+urIOSNIdiw8Md8QH68
	0+tlyLRiGvG6rvnR9zrOwaMy+mSP4OY2BwtFck4QlnrarVa9uAeAZ48hjFHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793299011; x=1793385411; bh=Fvuh9yZ7rt9ULpAgV6G/UKvCLVFxk4DzZyr
	6D75u96Y=; b=HGs4EiC6vRWHVLZVqG0cak1YgkF09UrDJHn5tvNHGO3V17KTrBe
	QeLj1nfvpbpdEIce/Uu2KVPp+qCkSl3B43VRopZdOiUVjdirMJVE2ohXtRAjnFCG
	u/p90MYVgEdeMgpiDmrts4MPEaBKump7xr7FEESoeQOxWPFm76oX6+hSKB/y+OZi
	Dd9THAzQfWuy0ovfxEKIJKnMGda4mcg8CP/PiehvyHbXtEj7xJ06rsy2fPrRtErY
	W5TZ7aD6+63ohZGQPHh0NsM3hXZjTbNi0ECQrA8/Y+VKn0ZgHDiaa7yKPgKfvZZM
	1tVSYn2teHQMMlvVFmxtw3k0m1tw4ZZAh3A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793299011; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:M6HlF8bQ9BKz/7EkQhGPsDHsZczmGhLO0Z5aKOuoKVCx5ok
	LtO1ZSHixrPAUE+oqTl42p/KY/7pMDCU8e3EYPsT22WkQ/ELYMSC7UzkInxmCQro
	y+KK4YID9V0GKB/lBO4d10FmLhxpN2hROQ3mrKE+mS/QlTLZ/L6l9e3by4P9B0Kg
	jN8+MLj2xZbcGa3Aw9grV6nC3sw4fL9IGlCuT9mwicaQaSYb3+Sno0jgUbz2W37J
	+/av460w5zmzdNuDJYDCPrcmNGvfuNLxaxqPcpKv3ErflFlN+qEjCrhPGdHy1/L8
	sHMdlCrk5eq5u9F8+sfAd3oEkFNglyfU321d51A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:85H8oahPnaB2kb+tRwt7Lsx4hiA4aWYdO3ZJ67xr0D8=:Gt0ZJO7WmD4uXwGxwoyhNb6j2lueO0ZN4W//saoaPo8=;
X-ME-Sender: <xms:Q5Ljann2DrLJ_zhP2jPwVtas1es8nkCU_2IQkRNml8vx_IpqLjgk8A>
    <xme:Q5LjaujozF7u8rgmDIhtc6QuBd8RisN65fJkx_zIKzwjB_wxmxjkpM8aNNZVp6y0y
    tyvfCqlLrhJUAqicEMFAH8xX9kIxfT_Bcz1Si0A6Op7oYJVgKQ4uVE>
X-ME-Received: <xmr:Q5Ljanf1IqWpIuzfaRTKU94ERgg0yxQ6a3G_gmlzVoxGDyeNOjKtjyvAYyDz6MtSdD7CuD-8lHjsJuqxDMEXRDiJlfpg2f_2Tx1U>
X-ME-Proxy-Cause: dmFkZTGRgtzTrmdB5yPE5eAsHyxIjgJH4CwYrJ2ZAyt1UCPomA001VgGTs+un/XtVdw0tP
    ukna44+OuIR7Wyb0inwr2CQweSLfcC//p0rBqrv2CvMzkk41ik8F6EkZUpGGs5+Kvw4E6/
    kLxo3A42Csexj1asgZxwTnKTogV9tOjvmOGGpamCvqWFyG5oLQSXILHeZYHrXaYH3h+JDj
    Bm6aPzhiZUroUUBregPak2NVsjLUrGsL4S0An41tMED9LeZzTurAJEALmHgs8iLxK9lgti
    vaCRI4OxHFlqzr2gvecLnJm9eoU52DDNYlpo0n65pi4jEqEJLD+4wK59/J3rV+8JdUWqlE
    osiI2dMO7FhsFdq74fOnLwMVopqsXigzzez4CHb6J3EW87ZA3wZFSvWjo2OaMjHutH7JiV
    pACTnj2Voao1OzAuqxgsP2DNOIb6s/eYLqhVPxWz//TCsh+UkTyJfWQJCQtPbnO5/zr4GY
    Tk/SFMd2PbaPhPP8QgzRANFkfIO2raHiIlGETrIBXJyyLtwfl+bkqSY3f1FdYFr+8ccrtq
    S+rFsyeIk48eYnn+LM7YScpMkhqtr6yQRbXXlVXSI9uvOQ4WomKoCOBl96lrLp4SPXA9xt
    hkBoo8ZN05I7yD682dJEmIwn1QXM2Fz8zIZ82mADZMx9HaUyGqNDkDYPmwMw
X-ME-Proxy: <xmx:Q5LjamjdDBgXUqBshjissiUAuJun8j0WwJXeAvHXtavbe-EoHBTV1g>
    <xmx:Q5LjanyEu371JfJ2rgmSLfU_NLgy8YLMo4nzn2OrXqqlAWwZujJdFg>
    <xmx:Q5LjaqPvXqjaCnJ-Bi8c6-CQ_X4pUmhdMeFhWA_MqC5hAEwKeMl7fA>
    <xmx:Q5LjagXxBE4rjdP2B0-DmKT_vkJAbxOQwqmOOhj5XdhngmkbHyR3CQ>
    <xmx:Q5LjaqIbbdUcoVh9Mue2wfOqjHgwFnfODw8rbQJUP24WqACThMt6dGha>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 14:36:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Siddharth Asthana <siddharthasthana31@gmail.com>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v3] t5300: modernize test path checks in t5300
In-Reply-To: <20261029120210.3722-1-ogundipesolataiwo12@gmail.com> (Ogundipe
	Sola Taiwo's message of "Thu, 29 Oct 2026 08:02:06 -0400")
References: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com>
	<20261029120210.3722-1-ogundipesolataiwo12@gmail.com>
Date: Thu, 29 Oct 2026 11:36:50 -0700
Message-ID: <xmqq33to2w1p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com> writes:

> Replace `test -f` commands with `test_path_is_file`, because
> it makes debugging a failing test easier by reporting what
> expectation was not met.
>
> Signed-off-by: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
> ---
> Changes in v3:
> - Rephrase patch summary to state how the use of `test_path_is_file`
> 	improves the debugging of failing tests.
>
>  t/t5300-pack-object.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Will queue.  Thanks.
