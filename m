Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDAA370AC7
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054095; cv=none; b=GhGhQ84TaEs9nTsQMRBK48FBjVlq/Wy2yF9vkvxmAYYX6pqKzIzQrX+JVpFWnrKOD8BIs4yI0GgJWbG3jdQe9QSTgDUp1QPvVvdoMtO77iLlr5+2MD87WO7v0GOTFOb7oaDM1fp24J2cnjWrQd5AZroEXic6vmVX7LIJxVTMn/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054095; c=relaxed/simple;
	bh=aNuXgKYrNNb7xVa0Y2YSngBX5pShcdZevKPglQtH7VE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sIbi9N8YmKIPGo3jb+hktp/QGX24VQt4R1n9UAHnPAoanGIbCk7dzdn6MIGOLCMC2lo6QGubvY50SFVxHrn6VNms+XSEMDLv7dCjZzTLL9U7/V3Cc0uglrcDo+jw7gShH8bGzmhFfNpDDOx6S6DcUlqeUgxgT0nIvSUvryQEE5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=euULa8rt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uqJtHcMC; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="euULa8rt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uqJtHcMC"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23A8714000AD;
	Thu, 10 Sep 2026 11:28:12 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 10 Sep 2026 11:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789054091;
	 x=1789140491; bh=aNuXgKYrNNb7xVa0Y2YSngBX5pShcdZevKPglQtH7VE=; b=
	euULa8rthgKXo9hR/lNpuIyri1/qbDf2I3E5gA/pwDHmcZhyvQKfg/e3ctfwNBP9
	C3HaY3S0r2SEK5SP1epYohhmevZCXdGaqooCWYk+/qI9F3pKVVQf+UuyQk0GEmvC
	RiuB2xqSvAvC2LJvzu+uxFpbPBy8V+guvo0jJ9UcUIPWPUXmXOChICOxoqtAh9hp
	7PZhVpI2mZF7lS4M4y/Wzg9WdTSh1RKltt6z7xQUPREwMbN3uEcFTacWHP6RcwGS
	hvJ9OU3ZM2qjqJqc3TWUrDYGX6CotVtEfEvYrDoHZogLZ0jJ08w0lN/jio27hHoo
	dp+Mp0EFP65pyFkSn1kuPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789054091; x=
	1789140491; bh=aNuXgKYrNNb7xVa0Y2YSngBX5pShcdZevKPglQtH7VE=; b=u
	qJtHcMCZthu9sRbQ/U9bMeTgJsKOqwHNjt8A1XaXvcC5cXaJbOwANdo0R5hje3h9
	iaRxgaZM5W1IVz6KHFNx1hyvfh8FYVTFwOTHAbAvlKPCdfdR7ZUlDUrL5FD2a7Jz
	VNa28YgS9jWhrRomv7Bu9YI6eALQkt2ZyFfyt5/IaRA2q55ONeH9whidPveZ8NBj
	pMfSEYkYuuaD8RPC+A6naDgaeizPMDF7ONkD49tEwvuUgX7C8gmldkR6j5FUygoA
	y8HE+Wo7qndD2RfLjgo21ElBUfdTDdXqNoqR+Jmg9dSwJ0zFjqbBVbK7POwRYT+o
	3EclGlrvwNW4MfGyAZC5g==
X-ME-Sender: <xms:icyiap4iKZmTZPQHTxojPFXEcp1VCQTnj2tQfP7RI-c9wsO0cFELRv0>
    <xme:icyiahuF1PRVracEkkrnH6lSqatM3EVRIT_LwdPhbKoZTsdWFY9loOXUq7F7WUj3y
    a84OxOPj2zR4P4jrN2m3WBnJm8Ki3nc7jAthmQLWZyBvEKxByMVow>
X-ME-Proxy-Cause: dmFkZTGMjOFaxwBtxN27EabKo9xkPfiDelMZ8ueLdtwDucpdzF0lmsu5VA+ek5yVlBK5GZ
    kNdkp41VhDNmSo4qJThwDH0M4wbSguYEH94TEg+NPX+/3/HBwItgVUXVjGBGy6i8x6W15e
    90f63G3vOncneWBzX58Jv2qXOoWntO3BwrLzjQBqV2Tf/p3F8EeA+6zR4EZHNXP74FhIaV
    RuxrBMMJhn4kSZ/iEW/eXy5SvNccdWZlq0jb5cbAX9XXs5AjY/nyEoqX3fma7dhWSP8yrp
    ADuLXo7htBtBMHT4CwjgGNyjYb/84p+6T/u+7xKXLwbprsvUb0R08PMtEAxKKomgFiqWZa
    6bzIRJeVaDpQayoL6Suz9DazCkSBeUFXPyWKOO85XcUJji1U4Mtx5BbaHUNWsw7WOEjnhq
    mSR6krCWH5d0NmFO8dqx5WSYXVRHm3VzGM8lFBdce4abmpxE8qCQvWMeOIjoEQtpF+tEnp
    cTpzDOeUTB2JiGrsAILdGoYLokJvMAdzAQDIr7H+gppHM0fOCqIzJ+13zalxAmMqGRyWE6
    cU0shj0pyreQUeIRS6NS2mD/RLgnfBpfUc7xKcJ4zhQMgQJ8p7NDrgrPAMbKkZ7cvcOCSr
    WFx0f25jxtQxwhZfzH3UQowxg8Lynu3Pv5s+MpJa19HfcLGjZh0MTY9LNRJA
X-ME-Proxy: <xmx:isyiaoXyzBAtI7P1PMpFOSwrUWZ1G02S9JbGPRjW31h2xVHwI2Kv9g>
    <xmx:isyiakVEjRoYthtfdDP8JPRoDb0SDHUkpPivPX7VGbqlREt40BXxgw>
    <xmx:isyiaveKeWn3hnwwQWbGOS1mKBAbhrimJRVYyh41WU7pEf63bgPz_g>
    <xmx:isyialWW33O4r7Z9XIKhHu5VbROdjoB3NuQ3XWLsl-qecNF1d3rC9A>
    <xmx:i8yiarzSOkA-YRxTcqbDsEAuduyTW3jMD3lO6Yn-LewouYygoSZ4sjqw>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 9DDA822C007F; Thu, 10 Sep 2026 11:28:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARdisE03Sr4w
Date: Thu, 10 Sep 2026 17:27:48 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>,
 "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <2589b284-28ea-4724-8aaf-5ca438957755@app.fastmail.com>
In-Reply-To: <ap6qQPL7dPjZy1lO@pks.im>
References: <04faa984-5b56-406b-baa9-dbb4b5eab259@app.fastmail.com>
 <ap6cU2elXvmlLgb8@pks.im> <c12fe123-bf10-46f1-b369-b582a623ce19@gmail.com>
 <ap6qQPL7dPjZy1lO@pks.im>
Subject: Re: history: 'reword HEAD' surfaces a memory leak
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 7, 2026, at 14:12, Patrick Steinhardt wrote:
> On Mon, Sep 07, 2026 at 05:16:44PM +0530, Kaartic Sivaraam wrote:
>> On 9/7/26 16:43, Patrick Steinhardt wrote:
>> >
>> > This feels familiar, even though it doesn't reproduce on my machine. Do
>> > you have "i18n.commitencoding" set? In any case, I think the following
>> > patch should fix it:
>> >
>> >[snip]
>> >
>>
>> My bad, I suppose. There was a suggestion by Peff that the commit message
>> was misleading. Per [2], the leak only happens when we get a commit that
>> isn't cached in the commit slab. I was trying to identify the specific case
>> in which we get a commit that's not cached in the slab but eventually got
>> busy with other work. I will get around to it soon and send a long pending
>> re-roll.
>>
>> [[ References ]]
>>
>> [2]:
>> https://lore.kernel.org/git/94b0bed5-c86a-4291-b958-52f09faebd29@gmail.com/
>
> Awesome, thanks!

Thanks, everyone. It makes sense that the commit graph was the
triggering factor.
