Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D75A1B3925
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768182457; cv=none; b=n9ggJRhoosUSjUDHmIsjiDWwU9FaCTeWoiSftUiExCsZ8vzmyZyDQgiwFg8ahhAmMAAA+Kl0n3UcF886Y/AJk8ntZo4KVNDvkq81zmnKNWXlTIbFB0V0VzcY0TjGqPLpZigdpnSmX72wcNFlpwOUNj0P4J5stru8TUhFLBTgEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768182457; c=relaxed/simple;
	bh=La9ID/d3L904bT9dFRKeO33r/iOBzrWwA0xmaAaexnk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QeUtNhNgAil55R/nX2w0oHZxQhUKi+MsoVAHYP/54eJVb9p9Rg/9RdluurY/JbGgWwFi1pHLJi8pq5klNvpCj9kYeiohc/sZNDao/slPcBCJl4zIsLqYweJz/V2trBPCY3dD9M8NtLcQ5j5KMtraVtQKov1kvtuT0y+Jcd/Xg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kjtsanaktsidis.id.au; spf=pass smtp.mailfrom=kjtsanaktsidis.id.au; dkim=pass (2048-bit key) header.d=kjtsanaktsidis.id.au header.i=@kjtsanaktsidis.id.au header.b=nICZnCEf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oX48UJ/5; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kjtsanaktsidis.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kjtsanaktsidis.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kjtsanaktsidis.id.au header.i=@kjtsanaktsidis.id.au header.b="nICZnCEf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oX48UJ/5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 17B03EC00BE;
	Sun, 11 Jan 2026 20:47:34 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-04.internal (MEProxy); Sun, 11 Jan 2026 20:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	kjtsanaktsidis.id.au; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768182454; x=1768268854; bh=FNuAX+r/DK
	BRcruYk4XP7HYxRLcRu9HZ1atG080hHUA=; b=nICZnCEfNKb0iY/fdcea945HR6
	eZm2CrGq98SOb7i8YYixE+70SMQgP+Y/YrVpsxNa1l9kazRf9nFqc/rvOv3JNbcN
	UZA6sAx3MT/VItyzXMMHMFsMArCDbqv4uIRQdz13FNv7jAsAx8ok80BUBs5xEHLZ
	4hqrIKM2oFxar5PWyQ9LACTzEZBkF3PyO58eD10GlkqT5psPBx4VLZypTnrlgnFo
	8H0cbtSW2q3SRadGfNKR4nFA/a3D1/s2AZF6lovfUK6teHzSr4iGAjjxvFcOVYhX
	bOD065bUMqB8Mv1PZSZq+44ZTN776qxSyqeuesHVmlqM/6P6Dx+ph295Bdrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768182454; x=
	1768268854; bh=FNuAX+r/DKBRcruYk4XP7HYxRLcRu9HZ1atG080hHUA=; b=o
	X48UJ/5zP7lkK+UL2p0wgwFeoTlYdi0+toa0tUAOLu+HGb6u4QOsglrvUhwDWdXP
	YKI0WdqZZDKVuhInRMAc5Hm16gXqAtzFThr1N1jQ+58LmqKL+IvniFYFNkvJS6QE
	5Dc0TjOkBP3htOTgSl1tm7Q3xLhD4ZCBXQnbGBNtB/A6kZPP8QQ8ADZdBOMgeHad
	N3l4tvtUzkKS4ek4LJCwerYplAKdndme8j5XinRC29j1cJ61+iyXdCBy6/0N9lf2
	jDIh+h4ThZ4bFN8+USKuUOEW9c7WHpQ+mR+Gm1tkDz/tj+5Zg1TkojeH0neJztZc
	ngfCXjan4d06I6kg9I2Lw==
X-ME-Sender: <xms:tVJkaedNneMvnhhrr7ShcLhgQyZqq7feLesiGZezrdaxx8-MMsO2fg>
    <xme:tVJkaTCJejzfmIUk3JL21gHtZTNKsNEa9MHb5mAi44y3clD_apIeBYuS7QoO1djWO
    hl9cI0WWqCnvAckimGWm0G6ScO1YX3Nf0YIkCfU1FPJJJI1VeH5zw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeiudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfmlfcuvfhsrghnrghkthhsihguihhsfdcuoehkjheskhhj
    thhsrghnrghkthhsihguihhsrdhiugdrrghuqeenucggtffrrghtthgvrhhnpeeiiedtje
    etfeejffegvdekteetueeugffgffffleevvdeileejlefggeeitdetjeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkjheskhhjthhsrghnrg
    hkthhsihguihhsrdhiugdrrghupdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehkjhhtshgrnhgrkhhtshhiughishesghhrohhqrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:tVJkacbtrBnOG6Tsga56CFQgsL6Wv7laZQsbwaDSB_6RMN801ljPgA>
    <xmx:tVJkafKkkxvnRERQmy2w7ySo6Ni4He-KgweXICYDBE2rMlY3q4-zBw>
    <xmx:tVJkaaAiiLk1up_1fnBeiOTEz5VeEhHufktTOtmIozMSpBnwCK3SBA>
    <xmx:tVJkaUr_IwRIMhTYS-KGDlzJavJeqeTD9kb53Oz7U5ohLAZLb0UnQA>
    <xmx:tlJkaRWr2Ly1-9cx96ArVaObEnpx5leCvdWf6J77lTUmcXIP7OA-cQ4h>
Feedback-ID: ibd1946f8:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 908DF1EA0066; Sun, 11 Jan 2026 20:47:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2Xbupy-4AlR
Date: Mon, 12 Jan 2026 12:47:12 +1100
From: "KJ Tsanaktsidis" <kj@kjtsanaktsidis.id.au>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "KJ Tsanaktsidis" <kjtsanaktsidis@groq.com>
Message-Id: <e9c21aba-fa06-4e4f-baf5-f11f13d9ac72@app.fastmail.com>
In-Reply-To: <xmqqpl7govl8.fsf@gitster.g>
References: <20260108225926.3587282-1-kj@kjtsanaktsidis.id.au>
 <xmqqpl7govl8.fsf@gitster.g>
Subject: Re: [PATCH] http-backend: write newlines to stderr when responding with errors
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jan 12, 2026, at 5:25 AM, Junio C Hamano wrote:
> Now another question is which between the callers and these two
> helper functions is responsible to ensure that the message
> terminates with LF.  As these functions can be called only once, I
> think letting them add LF makes sense (if they can be called twice
> or more, we can imagine that a caller may find it useful to make two
> calls to produce a single log entry by ending only the later call
> with LF, but such a use-case clearly cannot be supported with these
> NORETURN functions).  So I think this design makes sense.

Agreed, the code clearly can't log more messages at this point!

> Somehow it feels overly heavyweight to call fprintf() just to send a
> single literal byte to the standard error stream.  putc('\n', stderr)
> perhaps?  The same comment forr the other hunk.

I sent a v2 to fix this (hopefully correctly, I haven't had a whole lot
of experience sending patches to mailing lists with git-send-email :/)
