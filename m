Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792530008;
	b=dt4fBdAwmGOXB8Z+7GzwZoxbXNUyiRnO2z3aVJThc31+jxIN2t6uhxdXWTmdZyqvaxUc
	 3RpXwv5E/xlpSDi6ml+tqND82dyUT4nH2XFY0ZGtsEkpxqIkQmwipfxF2fCY0g/BTOTwk
	 H4Hr1vUOy7KTby0Ers+fTyTN6RVgdn/ihj9GdgFAA7lED/RG7lJsV8f5Bi9mUdfyxpBS0
	 H/mbwbd24nXkF/2Ent6CMnc+vbP5kIZuGUsP7X7qMSWe672IuABjwWbkWI/RhHgQeEC57
	 Z+kFe2h/c06jof47KcXh+zEN2/UTvTemL65j7CF/2mfol0+0VfBtV/gyi6oiVFOvpGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792530008;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:In-Reply-To:
	 References:CC:Date:Message-ID:MIME-Version:Content-Type;
	bh=F16z5Qq4Cset2RZwqYpU9lMDUyz8XQv+aIojfZqb9bU=;
	b=OKZIXmk+byLq4dlHQfW0BJ7hDe5u5pyXyxPEFiCIAoEuzyxWKEGPjhyu2ocoI20ysf8U
	 Hrk+mjpZ0ZT96Bx169XoJs7JxvWfulGz44LU6X2gNI5KtfWJQuJU6FyaiGn6cJPXtPaR9
	 gfeimvH5kwp6ZpTVO4SlqhtZDhmoCXDxfO1KHzGDOUPAoSyrRxtChzFzdCl2WOR8I3DhE
	 AVx9mvVDTUN8PvmNTRklw0keA8O3fugJAAPZ/I5SJ+yUorLtEHfR/FNZW9rYZHy1MM6wY
	 O1inrTRwQSS0CqVZb2QfLtSflS2UOYcoW4SHS+OVQHVz5ebdmwoN4q2KmQgUQitk6hg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=adrian.ratiu@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=HoTqILfe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DE2606A31D
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 21:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1DE2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=HoTqILfe
ARC-Seal: i=1; a=rsa-sha256; t=1792529995; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z+Jyk1dPjL5o22aQjkXoD3TgAOZp0hihR7nTFousa93oQa3x8eER7mV/hYnEgHlgUm6lOMym6o2w5ReFTHImt6t+haZMkZ+eBvPB83glL9p177DP8WoeraSJdIHipjRx1zCZUdbzeu4ttUE77QVjT1sFr2n7n6CeqEtOFdu63ck=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792529995; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=F16z5Qq4Cset2RZwqYpU9lMDUyz8XQv+aIojfZqb9bU=; 
	b=iA347zadZXzuL7azvXqvRoUmbBosH54PnS4xXs1Mx7ugj125EpMoller2+s4UHvwU+oOwvOmjZPed+10WHoRsZlSWYHmv90NV0s81+T4b1VwvHKGoWPJMwlf9zyuk2xoNCWEWOlyyUGYRkCTPA3T936uyt3iraGHMdbQZreQthI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792529995;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Subject:Subject:In-Reply-To:CC:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To:Cc;
	bh=F16z5Qq4Cset2RZwqYpU9lMDUyz8XQv+aIojfZqb9bU=;
	b=HoTqILfexV9LwQQwjKZppevKAEYcCFeLKm4WsulfumII0ShoqKx4ZuJkF2dMCCnv
	XKcMICll1FsbIsO1a+azTipmke0aqCqH5iLeyRqF+bHoYDF1xt2LmTIKYuFf2kI1ov/
	Wh+NEALEjDTyIIirVykldQitHGGu4kuTIewnXcO0=
Received: by smtp.zohomail.com with SMTPS id 1792529992739761.876849534691;
	Tue, 20 Oct 2026 13:59:52 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>,
 Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH 1/2] hook: honor hook.<event>.enabled for the hookdir hook
In-Reply-To: <xmqqzew8us4s.fsf@gitster.g>
References: <pull.2272.git.1792520353.gitgitgadget@gmail.com>
 <1a7d060fae0decbe7dda63ec4ab57e32e0205df0.1792520353.git.gitgitgadget@gmail.com>
 <xmqqzew8us4s.fsf@gitster.g>
CC: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Emily Shaffer <nasamuffin@google.com>, Thomas Bachem <mail@thomasbachem.com>
Date: Tue, 20 Oct 2026 23:59:46 +0300
Message-ID: <877bjc2im5.fsf@collabora.com>
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


On October 20, 2026 6:46:43 PM UTC, Junio C Hamano <gitster@pobox.com> wrote:
>"Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Thomas Bachem <mail@thomasbachem.com>
>>
>> The documentation added by dcfb5af67e (hook: add hook.<event>.enabled
>> switch, 2026-04-10) says that with hook.<event>.enabled set to false
>> "no hooks fire for that event", but only hooks defined in the
>> configuration are skipped.
>
>It is good to see that the original author and those who helped
>were CC'ed.
>
>I have a suspicion that the current behavior may be very much
>deliberate, and the documentation was written too loosely.  In
>other words, the author may have been so excited about their shiny
>new toy, the configuration-defined hook mechanism, that they wrote
>as if that were the only kind of hook that existed in the world,
>even though that is not true.

The suspicion is correct: I did not intend to disable the hookdir hooks
via configs when I wrote that initially.

My reasoning was something like "configs affect just the config-defined
hooks, the traditional hookdir hooks behave the same as before". 

So currently the doc is indeed just too loose.

However, having said that, I don't have a strong opinion and am ok
either way, so if others think it's a good idea, we could accept this
patch instead of fixing the doc. :)
