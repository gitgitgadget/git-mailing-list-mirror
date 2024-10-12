Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588013B58E
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728772195; cv=none; b=YjJU/YhMGLsz5yJvyNxVdf6/GHhJKAXfb3u9kBp4thJ3EALOwUVmA3k2cX3FuSdNmm9Ph4ncw527eEvZSiRxxsQO3q3QmPOYDuVwAfBvd+U4xzlX79oegggAe9vvJY6uz9fpdiUXFzcAvtd4Uel2ZglkLjGy/nfNt11ZAZW7sOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728772195; c=relaxed/simple;
	bh=qmmIGjp5JvoU3w7xsyeGtMmZCyNvPLVq9IaKIZMlZM8=;
	h=MIME-version:Content-type:Date:Message-id:To:From:Subject:Cc:
	 References:In-reply-to; b=Eocma6X8L151oTW9IpP2Q8aJuBfQIzaly5BIHrvGCbRKFvZhEJa/jQLiYqhRw8AQyWp39IqpZOEsKteC1pEKaFlquh+bFv+KgEE0lbw/O60xAM+D0A+K9KTyeGmj6IUAcPNK+PoiESHzGD5fiBnLo68E8rqEHXXZlsa2drjLoBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=DmtYwFO1; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="DmtYwFO1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=x0KesoxrlPwGfsftaj7KiyP9eltRhhWIjVpW+RI6YvY=;
 b=DmtYwFO10LlACtHOZRYrfCBiQAhpZBX6E/MMw7MnsK1vpIGUIYZ5mn+dpkI3msE955lIXjoBqK/a
   5uf6DJ+svKGs6V2Ro4Gl+gRCU3aWISG+ZFXPuK4dbaBTcY0Npxj9v+epAEf03aaRc8JNdJ1WO9Ch
   CGVbC/+E8ewROVU84FIlyFpEoCaQOEyJby3Azy7UqHlBYHlE6lSsUq/EXMNI5fDVpP/B4TLqkwG1
   LpuD5wvTYev5DHMGQbNS9DXCdJXwmJw3ErCl0jSwOpcj9H89xatn4+xnYtXzyNuY3ZfvCWRI9IDK
   rK0lXJHpBfbbXL2jwbCSiy7sinzwnUVSrZrZ0g==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL90089UL5KXY60@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 12 Oct 2024 22:29:44 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sun, 13 Oct 2024 00:29:21 +0200
Message-id: <D4U6L3C2GHZG.2SN8P0C7ZH33M@ferdinandy.com>
To: "karthik nayak" <karthik.188@gmail.com>, <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [PATCH v6 3/6] set-head: better output for --auto
Cc: <phillip.wood@dunelm.org.uk>, "Taylor Blau" <me@ttaylorr.com>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>
References: <xmqqzfndndfm.fsf@gitster.g>
 <20241010133022.1733542-1-bence@ferdinandy.com>
 <20241010133022.1733542-3-bence@ferdinandy.com>
 <CAOLa=ZSV50OkDC2p5AHHW0u+fAtLMcCX36W1SuT8AnTkX7HNZg@mail.gmail.com>
 <D4SUTJDV0Y04.3Q8YED2MVOKBL@ferdinandy.com>
 <CAOLa=ZQY_a_dEZQ2EcLVfE_5Kjy7b2R3OFbQHQbkzH0o9-q1JA@mail.gmail.com>
In-reply-to:
 <CAOLa=ZQY_a_dEZQ2EcLVfE_5Kjy7b2R3OFbQHQbkzH0o9-q1JA@mail.gmail.com>
Reporting-Meta:
 AAH5WjwJA9YJE1eMNxG4kucu7BjGwMzMiiZCwtQcLQfhQVT3cNAlp8pJlIUdzg4y
 sh3cOykRyQotKGSzVWC2e5Hd3upg32zoUil5+8eDnmhjxP03y6q1upvnLke0bHUZ
 x/dUwBLMRVEAQjkAdYyvz/EWVrmbptweWW+qaD29h0Vqx930jxd3IflYB12T9BzI
 ERWDjwlLOh68HHZkgZVuciwf8pm8rQXch98kG6GKl69YsjXM6ttQx6kLxJDjz2jE
 dZxZq8SrdOjS0PutEtJLnNfvNYa8rcnEVScuVeunr5m8iWfU36t6BwimV3qroAW4
 +Gt/O2BanHMKsZipi2EKGBiXIabAWU1NRXa5nO02sKC51r6k8Jpw2bzL5tScHL9a
 eEoqmBiBtwSx84ev6D14hgqxp4pyDBStWNBy4HqnrvWm2n+rjsb4ggtogGmdgblQ
 QtGh+flM0EZmc3w7P1i0rOHrpMDlxMoii6ly/mRIyD0GFe5qhkgeG2rX


On Fri Oct 11, 2024 at 22:43, karthik nayak <karthik.188@gmail.com> wrote:
> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>
> [snip]
>
>>>
>>> > +		git remote set-head --auto origin >output &&
>>> > +		echo "'\''origin/HEAD'\'' is now created and points to '\''main'\'=
'" >expect &&
>>>
>>> Nit: might be cleaner to use `${SQ}` here and below
>> You mean something like this?
>>
>> 	git remote set-head --auto origin >output &&
>> 	HEAD=3D"'\''origin/HEAD'\''" &&
>> 	echo "${HEAD} is now created and points to '\''main'\''" >expect &&
>>
>> I tried a few variations and this is what I could get working, but I may=
 be
>> simply missing something with the backtick.
>
> I mean simply this
>
>     git remote set-head --auto origin >output &&
>     echo "${SQ}origin/HEAD${SQ} is now created and points to
> ${SQ}main${SQ}" >expect &&

Ah, I see in other tests this is used, but not in this particular test file=
.
It's a bit hard to decide which is more cryptic, but ${SQ} is nicer on the
eyes. On the other hand I would either switch the entire file in a separate
patch or leave in the '\'' here as well. Or I guess one could go through th=
e
entire test base and switch everything to either one or the other for
consistency.
