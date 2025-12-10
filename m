Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F471397
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765368308; cv=none; b=dcoijvoGy78ohweLXhGrnfZT+N0mShpGoRir44RdYioSkxcZrfJ48klwNX0D79ShA+z0KVsQ9gZeJ0wLivm+XLyFvXqMKc73RC/v+P5CS4jiY8gPwdE4TjUqFINmvxXADSSEdR7/frfrc7F/qd9qc+WxS7UWravxWwLK454s3nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765368308; c=relaxed/simple;
	bh=M+H9IHNCiwQXXtwrmPYSOFAJUWgdaEMRs3QWs43HKEs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WiJz018T5GhV/WvTPcJP6ji1wGpkZnTWKvXqXMydKr0bM256ciNqfhqXzEYMyWnTe/vqaDz+emRazjNxY8R2MCenfMs91fX7lfHYNg5EcetN2/e6ChqguSOVNk9255QOfKq2t6lOO0xTGK1nyUA8fbmb2S6G+PWWApET5RKVqf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=eoLsGsMa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v8RVBS9b; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="eoLsGsMa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v8RVBS9b"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AA95DEC055A;
	Wed, 10 Dec 2025 07:05:05 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 10 Dec 2025 07:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1765368305; x=1765454705; bh=dv75EfHOruhFenJVYrNSn+j1Ik1l5/jw
	Kz6pDshEBy4=; b=eoLsGsMa3TTvvmpiWWG+z1F2IrBfq+1tsAejZLccZ6U5AIf+
	b28zrBilWruMAVQKhK1goZGa+6h1LU+EPOMnbcyaClCc/QaKIapt1g4SaPe8vvbp
	+fXD5XVf16isLysbG4VKBqvlVwDu7IPwKjrH/X6uByPgi0PdXbWIs/13Oe4cOStq
	ZPDrcrYPsevP+FcImmzolGVdOaWrdOoRZVlCnxYaxSA8ZwfbTqscTlC17swHMlP+
	cOj2pzBhzqiM/sNX8Jd/ubvFEMnucRlM7NSbDJZuYb+IbCuowAPgbPCoDlGoCF7j
	dRfl4b2FU2hDH8nJpBHOkmYqN8F/9sMu/LTfUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765368305; x=
	1765454705; bh=dv75EfHOruhFenJVYrNSn+j1Ik1l5/jwKz6pDshEBy4=; b=v
	8RVBS9b7Louy1Bd4M2MgfTzlajlH7cxQ6kzNe7X+zO0s5YgkiNjPq9flfpRUr7Zp
	OuIegc8WvCI0ct2WsFDWM1+eM75aN6k/C2tfIaNnyQBwts/67Mny1389rQSIL664
	mKaWCNBJ+7s6eWxf9T3NWtJavN9Irp8xjuRxT1D9Uy/yJA2xVG4r0W30bwNq8aie
	5TvMQs3M68LvfNcG93DjEYYqymbQ2rdgGa7/0eKegatfMOEZ3cqmbZ41FNkZIf9A
	IjV8hg2EeTzM/awPBBoEV0zC8mjUBHkt88e/YGopPguAEYLDA5obsD/OJcTfyYsl
	WnGPZ/aHHugZQXJPjgM3A==
X-ME-Sender: <xms:8WE5ae_j4OtfcDxg2kFFpwXsGvukV7GcNCV1VIdXFFgmiAbm1O6Ycic>
    <xme:8WE5aZiabLleifIChQGNoSvTP1d_KZXvds5yEkwmcsRwNCuOP4bXxMhfD5Ur4u5Iv
    l5ireZYN9TPl9hV5uD43v62jm0dAKlghma1Y_J6sJC0pDqUc1Yo7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeetkeefudehhfelfefgueeivdelledvjeegudej
    gfehjedttdevlefgleekieevveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrh
    hishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgef
    udesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8WE5aRMRO3aoeBe8C84hYvXeaI2pmy06JkgrkVh-FgtBGxkuDRLf_Q>
    <xmx:8WE5aUYNo7FlE6-biPsnEROH_TkaN6sAjngzJg9kxCUO3fq-H4dM0g>
    <xmx:8WE5aQ-H6NlROb4UxuvdG0lg0blUWafiJ0_gjHs3xBEMbTvP4-xwkQ>
    <xmx:8WE5aVTi-Kyhp5nJp0t8SBYslyNdm2edHQRv9KzvXH0eHY5MSwaZlg>
    <xmx:8WE5aXQFAt3TELwGYT8OShpoLE9R15yEVB6q6W3fo_DAIjlU5jgJ2aeW>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 678901EA0066; Wed, 10 Dec 2025 07:05:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_-Iu8LU1e_w
Date: Wed, 10 Dec 2025 13:04:45 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 "Elijah Newren" <newren@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>,
 "Toon Claes" <toon@iotcl.com>
Message-Id: <85ce46a9-a097-462a-aa1b-904eeb7b89ad@app.fastmail.com>
In-Reply-To: <xmqq1pl2im8x.fsf@gitster.g>
References: <CV_replay_conflict.101@msgid.xyz> <xmqq1pl6lzt6.fsf@gitster.g>
 <d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com>
 <7d0201aa-905c-4da2-932d-47666c923875@gmail.com>
 <202f7015-1e7f-493e-bd82-474e5cefdf01@app.fastmail.com>
 <xmqqzf7ri7q7.fsf@gitster.g> <74a705b5-bafe-4304-86ea-fd3873ae4fb4@gmail.com>
 <xmqq1pl2im8x.fsf@gitster.g>
Subject: Re: [PATCH 0/3] doc: replay: improvements like "mention no output on
 conflicts"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Dec 10, 2025, at 12:56, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> We do talk about "branch heads" in our documentation and they point 
>> commits. We also use "tip" when talking about the commit the branch 
>> points to so maybe something like
>>
>>      Update all branches whose tip is replayed
>>
>> though I think it would be clearer if we could say "commit" somewhere as 
>> that's what we're replaying. I find the concept of "contained branches" 
>> rather obscure.
>
> Thanks, I do agree that "branch head", "tip of the branch", etc. can
> be used pretty much interchangeably, and using "commit" somwhere
> would make it clear.
>
> 	Update all branches that point at commits in the replayed
> 	<revision-range>.
>
> perhaps?  I dunno.

I like this. Or just

    Update all branches that point at commits in <revision-range>.
