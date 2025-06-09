Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27AB7FD
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749503435; cv=none; b=RioJlr/TmLWGsB7nKOt3Rk3spE5osfEQcZkWJraeDFHWtNgDMDA5xTcL4YG2NPoQUH1I5J7ZdegnMrxPzHzVLtRIKSDfJ6P2hKlwrvQK3H8nNi+YNvUy+hZIJhdXZxVyzssFMSYfFdzlX4uKENCifZJ+6iHDcKI44ovvGKKrJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749503435; c=relaxed/simple;
	bh=A79BvTJzEVpfPGnobcq5f52BM3UxZ4FYXF8JphwipR8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MvCvGEaauoIXs1AkE8I9v7wGbsIeHo5HHc1C0u2NfDpYOaAehSuWSlyFaHj3XJ1xS9FqbqER0mJYnBwKMNRJ3YxLD+ASHOxW2WkLhgvUhAccrS0g7LGe3mpEYu7zpWN5ZsFOcwuJul22JxrwQVdzQyok86HeK/dQwY26xess+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=LPkraRJ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=muDgTjE1; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="LPkraRJ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="muDgTjE1"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E295E25402C8;
	Mon,  9 Jun 2025 17:10:32 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 09 Jun 2025 17:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1749503432; x=1749589832; bh=9uD5bv0ZhRzfmpoQSSXIlJ7xT9UP75lO
	3kDOqxeVVn8=; b=LPkraRJ9pXUkT/RODbBo+Qj2bMVQmqrZzyQcMiuNQJmI6EOq
	YE2O7dHB2pD9IceNUut5ZTqMYm+xXsOmo238QQ4g5VQ5zuDqC23Hl0lWEyqzzLko
	UGCP89UvWtX4KQBa/78xQyH9UYbC8FcdzXoD3bZu13UIAo2VOy7Mbf/6WBSk19tK
	R0d0eZYk3zfakhBttDu+J2yMxIVSs8hAMMjlsSTZtjd911vUfuqEMA8urXrWvbYi
	d1htprcpRm1jwNVjP86tibfbyk5GuL8iOze6P6XwpNqoY6jLDT72BVxo9sxyv7zx
	VOCgO7v2ZhlfVNz8N3OOZI64uRynIP3eyV9vFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749503432; x=
	1749589832; bh=9uD5bv0ZhRzfmpoQSSXIlJ7xT9UP75lO3kDOqxeVVn8=; b=m
	uDgTjE12EKNNtQgM2EK/cZKObolnURCwceDUOrcYROpxZFp6hmI5nr2tGs/Kh3Ui
	RpC1FD2t0IWHTItDztYW/n9L3XqjL7KEdCFIHz5BV1XkGjlfihTMwPMxFHXFBzNP
	HzMcmXVYi7e9UaUrEi3h/dOLQGipjSvsT/jrEay+lSWr9BTJ27oZFWNhMa39zwcC
	3zyZBh270Z2XLeVCReYU5kI/vlmHKo8BwqNQfUIvSqYJ/sL1iN9lqIZIFg0wfz1m
	NFD9Swy6ERyiCbjpaMoPo0j8X1Ke+0gQOm38ZEvQHKu6lx3Deu9oyCDqrL/zX7Vb
	VNThqTxi8V957fHI8aNyA==
X-ME-Sender: <xms:yE1HaCa1e5Zc9pVOBSKHegbfa39sQ6vTeSxsmIy_NRO_mc2WLfOLHec>
    <xme:yE1HaFZhanLtPTu-0X9ZwOceOqg_lIKW-sF3ZmZi4Rt6LIh6TIW-1oS4qKaYOxAYB
    G3-0vmqqV-RgXzW4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvg
    eskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepgffgueetkeej
    udetffeftdfgteevleeltdehfffhgeeuudeiuefhkeehffeufefhnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghrtghpth
    htohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghr
    hhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    uddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yE1HaM8NZ5EHevQbOtmzVIh9iGeTfCrhoYuOifr46N7Je7JyJn-Ftg>
    <xmx:yE1HaEpHAAExaJykNNMDAZ335G6s3Nng35R9KfykBArs5FDVuWfkKQ>
    <xmx:yE1HaNqaps3cj58PNvz0W18X4g_QfFtkZrhPkvi2OnsCErcgWlVMag>
    <xmx:yE1HaCRn7oxnepDO5FZT8o0yotgCrMz0rbdCzDiMaXYijzpaYsPadQ>
    <xmx:yE1HaDSewJfrX9ETpAwQiXNOB_5bo3XhQNO70LaIM61biW6eWn-2nw1s>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 57C4C1EA0060; Mon,  9 Jun 2025 17:10:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Taf9fec3ba48f0e1f
Date: Mon, 09 Jun 2025 23:10:11 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Eric Sunshine" <sunshine@sunshineco.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Message-Id: <955b6f38-0a98-419b-abac-899beaab277d@app.fastmail.com>
In-Reply-To: 
 <CAPig+cRTeZosWC=b=9MOjKaUwPodp7P=X2pwuXVgiRorx_+jmg@mail.gmail.com>
References: 
 <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
 <66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com> <xmqq5xhmvuol.fsf@gitster.g>
 <CALnO6CDgcQCuhxcJLH-XwxB85mxqokxsf04CU4yseTy-=XUWLQ@mail.gmail.com>
 <CAPig+cRTeZosWC=b=9MOjKaUwPodp7P=X2pwuXVgiRorx_+jmg@mail.gmail.com>
Subject: Re: [PATCH] notes: remove trailing whitespace from editor template
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025, at 22:46, Eric Sunshine wrote:
>> I think this suggestion would also help folks who "git commit -v,"
>> which IIRC is also indented in the template.
>
> For what it's worth, there was a previous attempt at something along
> these lines after which a discussion ensued.
>
> https://lore.kernel.org/git/20210830072118.91921-4-sunshine@sunshineco=
.com/T/

That=E2=80=99s very relevant, thanks.  It=E2=80=99s not something that I=
 would have
noticed since I am too afraid of editing any file with patch contents in
them.  In part that=E2=80=99s why I find it so convenient that you can s=
end
notes along with patches.

--=20
Kristoffer
