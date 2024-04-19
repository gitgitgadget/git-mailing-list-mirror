Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A06129E9E
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534215; cv=none; b=S9p73AWuX1OkW5pEKIYhULlUkPcRIHXqVfhgKWpMohSAHPiwIdf1aNRxaAThI8zQch03CDLTz+XY6QAxU0Mdc8twcS8gRHdHRqH40J/BTeWKQIfiRRWneVuwigZ1g5podBhDjXRlHb7cNjGF0HbJRzhp+7/An8T4RDa/JSMvK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534215; c=relaxed/simple;
	bh=9fwoz+pHtDEO6QROhRjPZYF008tejGoxhOuOkU4TkLs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=qSXod4PudXj2x4Mob2rhJRhIUj8ztpN+FQFzP+I34PBF2VPuYs1ndaWyDmn8zNSuGGzpPWw4CleEfC1rW9yZK9D7kjzC4HsIqbxklHlL3AmRBkZPFk1mTKjGW9aGNvuui47ubgnsTW9RGONYvPX41yUMObWs3BeG/tGEM32K1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=RoiTd7fr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ka2h494W; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="RoiTd7fr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ka2h494W"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8084A13800B1;
	Fri, 19 Apr 2024 09:43:31 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 19 Apr 2024 09:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1713534211; x=
	1713620611; bh=9fwoz+pHtDEO6QROhRjPZYF008tejGoxhOuOkU4TkLs=; b=R
	oiTd7frB0YzlXBKzItZxxNEXfT+we6pQooVQINbRP+sVZUyfT6nnPy2efEsXj89T
	fbkqS/DRm6TBLOD2XpUoU1L1Z6r+OuuGMKcg5Ea6sdccpKdHwVWu3rovtgQuHNdt
	td/WSajN7e989iHDWBgs4rdsEts2HHWBlK+63LHyPik0j3oe44eUwJy3h7A/yRO8
	dgUy50rdcMpCuuYqAEgsOkcRhlZsSd10DrIVV01xxmI6LmsbX02Nk4TuUI2mAOYZ
	95lazldN9+Xmvx14g9tbGKB0MqMzEAN7i1fpR66Spt8A4z4CgTCOXAuypnWjTuNL
	4GS6xGFk2Gh0jqbqr7JEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713534211; x=1713620611; bh=9fwoz+pHtDEO6QROhRjPZYF008te
	jGoxhOuOkU4TkLs=; b=ka2h494W2gbwnQJFm3EnwMVgA/ETkceYUzXQcuVh3mhx
	wTsLLsEHgzahy6KuOG0cQCBtEU2Kq1a1Qvq48aR4PS5AzWgck4Iu77FPXjfc4Rir
	eZNA3QI/TcH6VjTwwrCYUIYbyflMpmQyEqx4R5A4NVoq/mLjqBLdK58Z1kePpMf9
	KOsguxNe/KunpNgsncT/w8ugOkY+RuwGO1yfZW0mR/021RxKPfIvhUar56rySWXs
	rARuUfFl6NvPqz24SncTf2zfHX8D0QswtJAMT6AlgE/MqlF0tJ7Gz+YfE0h6hIyG
	UkNrCvlXAV6lN3N/cPHlmw65oUwJwvbkz+9+2XA5Fw==
X-ME-Sender: <xms:A3UiZuwIGmGyVbWuxLZLuhOrqXxC5nikYKJtaUZhG7AGUOZQqbjhIiU>
    <xme:A3UiZqTwn-U9TBHjYLpL42MmL1Y1fSrD4-LFdKxMh0poDD808YuDQjVtw5KNk-Qsn
    QtuVgnwng74Mjm2eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:A3UiZgUm3X0UuAJtgx34SWOeXYuzz-b4-0UpxDfL-Dv6OnhYMTNTfQ>
    <xmx:A3UiZkga0e6xSQ2IOc9CzPWayCYeiDQGenIkBLvVY5OEBRpCU5Uv4w>
    <xmx:A3UiZgClSHOumPnD2C0nmeyie90z1cL3UIJyGJ-E86WF3WcUyJVH6g>
    <xmx:A3UiZlLdEvdPIyUUVzu6Cx0ZcygYlbL1OBSZFgKfNyT3ZUUqgfYJNQ>
    <xmx:A3UiZi2BCxKmXsKLtbTxGnHx9LiHeXy0uwL5x9DWLsBQjkpvZVp5y-pZ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EC40515A0092; Fri, 19 Apr 2024 09:43:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0d584b86-0b48-4e7f-b81c-fdb672dac98b@app.fastmail.com>
In-Reply-To: 
 <71d195c248879e7c46fac0e84c6b0a8aa90bd2c2.1713488563.git.dsimic@manjaro.org>
References: 
 <71d195c248879e7c46fac0e84c6b0a8aa90bd2c2.1713488563.git.dsimic@manjaro.org>
Date: Fri, 19 Apr 2024 15:43:10 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Dragan Simic" <dsimic@manjaro.org>
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>, "Patrick Steinhardt" <ps@pks.im>,
 git@vger.kernel.org, "Drew DeVault" <sir@cmpwn.com>
Subject: Re: [PATCH] format-patch: ensure that --rfc and -k are mutually exclusive
Content-Type: text/plain

On Fri, Apr 19, 2024, at 03:05, Dragan Simic wrote:
> Fix a bug that allows the "--rfc" and "-k" options to be specified together
> when "git format-patch" is executed, which was introduced in the commit
> e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix sets").
>
> Add a couple of additional tests to t4014, to cover additional cases of
> the mutual exclusivity between different "git format-patch" options.
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Looks good to me FWIW. Also very good description of the changes from
the previous version to this one.
