Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F142031AA93
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765204583; cv=none; b=VcKN0pj+OX0RXPfG7ocCGnjSv1nl6i8KZtG9RxOYWzFrPu3QvE5uQIEgZMYU9Nam4UacCR/k/PEk8DbV/c8kMJT1S8Z7/9fTIbDIeC5yLgs84wleIBcrCpwqhXhapPG0Y7w9D+82i31UPajy9B96ovE5xzdVXf+37z1LQVd/VB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765204583; c=relaxed/simple;
	bh=FppxWHwhjn659F3pNWAH71GGpMeoKxe27FcStheQOuY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Wiz42xrJD0k85BngF8T29stuERKQn7oZvhLhi+Jm0jmJF0Yc+fpTjbvGxZRvsuRjboz0/frkbtuKTaPjOgpzez9DB3BXEbRRXF8+1JtxH4VLo2/Ro5xnHDFkObIZ3jqVrtYuk1Qis8Ri5uN0FSs1bH5SG1EUz/0w26zjwuEu7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=qo2go28c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wJJxSbuO; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="qo2go28c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wJJxSbuO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E95D7A01E5;
	Mon,  8 Dec 2025 09:36:20 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 08 Dec 2025 09:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1765204579; x=1765290979; bh=FppxWHwhjn659F3pNWAH71GGpMeoKxe2
	7FcStheQOuY=; b=qo2go28cd3WR3ntyn9rMIgwSRamXnFROD78D2redYGX3Uifb
	uEmWG/7l6ug9wHZ0eHriqDx7HZvfdMEVG7tajuVJQUaa3vzVp1Cfado2qz98Ocpo
	Da9EkBT6iSnMO2nb3SNd7jQ1gYTLRrkJjjWl9S6IO3U2i7b+zZZcTAgi7OX1DuZE
	IUYFpFGZ5LufaYgQ5d8Oa0YhT8y39z9nAJBEMiSomANCzsDxrRjtzM2eSrqHjEvZ
	5mDr4XDFBuRN167Hu8DUgDm3EIX9aM3ve8Y+FF6iqwKhjYbnU8XT9w/RxzBGo4nK
	EyzOQBWoRoKrWQCfi8XVnNndgHKQNbR5Bu8fyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765204579; x=
	1765290979; bh=FppxWHwhjn659F3pNWAH71GGpMeoKxe27FcStheQOuY=; b=w
	JJxSbuOERA1HvQpgSJIYgkGWmBgu1DmqbEbiykeGYmLm6ykQNOT3cxVgH5rWSDY/
	hdKjI+QbRfdG68ZTLaxoJz+VeFveNjgtYigR4VixNooZpYgBDq7nVee/DJrp+3D4
	tCwOJqjxSTWeiXrbtuj5QRYQRJ4Nwcy1gLJc9rj/wwMFWpM9BSLQKlgTFwxUxoio
	hpiWEuZISrOWq9U9jR3j0ld0QRUVUGt1FKDqx+kEk1Jjik8gRTci2HGRSpFm0Crj
	5JeRgT+qZ4eGPES32XmyjhfMtFwK66j1EzoQZVQyKqcXMXnwLl70/xk2FUNfZGty
	2I8oqwsOVrxERn2gqGzsQ==
X-ME-Sender: <xms:Y-I2aUjKUXgmJSuHAM7BAO9WbxQea5psNqs51OnaQCDh5vDm33YWvM4>
    <xme:Y-I2aX2kfnwgm3IxOJX0Yj-NmxZ9r-cNQn2We427h3Qu51PBulwjRlqO4y65ftlDf
    sBalwYd5-g8DBuU0I8LteFveeE-5B0FbcjgBTkWuPqDdGyy8eQh0kA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeetkeefudehhfelfefgueeivdelledvjeegudej
    gfehjedttdevlefgleekieevveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoheptghh
    rhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgr
    nhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Y-I2aZavQDwzBUjv-4Ej5iE1spHaVVqwrlnPp485NEoymMnqcanSSA>
    <xmx:Y-I2aRH1QkbEXwbbGfdFbFN59qb3uW04puizYMHMGyd8thEHDd6ErQ>
    <xmx:Y-I2aaJyEASvtSIWkRVq-nGJYqjF_2-xStl6TOou0mdGCK69KCDacw>
    <xmx:Y-I2acO6o_04Y-GOSbMjzhNKzuF7yAFRhpoGv3OhPm5VhNKXErehxQ>
    <xmx:Y-I2aUSlpUMKrboKmNXJydaxfxcUCYbbRCjBpOlXKD1HeOW4LJh4zGiI>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B08EE1EA0066; Mon,  8 Dec 2025 09:36:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_-Iu8LU1e_w
Date: Mon, 08 Dec 2025 15:35:59 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Toon Claes" <toon@iotcl.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 "Elijah Newren" <newren@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>
Message-Id: <d848e8fe-7ecc-4197-ac27-d87509f2039c@app.fastmail.com>
In-Reply-To: <877buxvygi.fsf@iotcl.com>
References: <CV_replay_conflict.101@msgid.xyz> <xmqq1pl6lzt6.fsf@gitster.g>
 <d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com>
 <877buxvygi.fsf@iotcl.com>
Subject: Re: [PATCH 0/3] doc: replay: improvements like "mention no output on
 conflicts"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 8, 2025, at 15:29, Toon Claes wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>>>> Explicitly say that conflicts do not give any output. I found this a
>>>> bit confusing with the current doc since I am used to other commands
>>>> complaining loudly.
>
> Yeah I agree it's unusual, and I'm considering to submit patches to
> change that behavior. But for now, thanks for adding these docs changes.

Thanks for reviewing/checking this out!

>> On Sun, Dec 7, 2025, at 22:58, Junio C Hamano wrote:
>>>
>>> All looked sensible.
>>>
>>> The second one looked a bit sketchy, but that was the phrase used by
>>> the log message for c4611130 (replay: add --contained to rebase
>>> contained branches, 2023-11-24).
>>
>> How should `--contained` be documented?
>
> I understand it might sound a bit cryptic, if you don't have any prior
> knowledge about this command. But on the other hand, I don't have any
> good idea how you can document this in more detail. I think it's fine
> like this.

It sounds like it is the same as `git rebase --update-refs`. I guess
that could be mentioned?

>
> Overall, I agree with these changes.
