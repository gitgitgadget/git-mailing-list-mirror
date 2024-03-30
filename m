Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158A1D6AA
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711842857; cv=none; b=VXmDL2gnZWQb4Fd7/KN14d1f30NxgsRLQpHe7Ro1jaZESxDVbm2PV3dvaVutvkCWE0egDEhBXIZUFxCW6IQ+0UKyLw5Y3wjMJOlukPN2XDYVVOwtyDsDOULzmE0V2D56eVUbf46KvGcGko9/Bm5eDY+CshA8AP0orQcx6cnRb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711842857; c=relaxed/simple;
	bh=wlMHaGlauf6OU8259JDUl2vgOgwWhPbGIdnS+BVFyE4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DOJOocjZ7LazTUG7FMxLxV/iHpuGFOfLUgjEG7x0AzncjciIaS6CMzDoxO4fci0HZSYkQDPVp+E2BwCpS5ey9JIgDpIf1N1QsEfUIZPV/LauN+JvuaG1HUs9esscK2D9TpLe4UC/WB5bmC3mzyMoGTZ36A69sChLLQEYjJgWR1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=Vjq2tn1Y; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=PMpGekbE; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="Vjq2tn1Y";
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="PMpGekbE"
Received: from localhost (7of9.are-b.org [127.0.0.1])
	by 7of9.schinagl.nl (Postfix) with ESMTP id 666B01A0BE63;
	Sun, 31 Mar 2024 00:54:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711842851; bh=wlMHaGlauf6OU8259JDUl2vgOgwWhPbGIdnS+BVFyE4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=Vjq2tn1YcwNLUve9pITgdTS3M6Hg+n/8QTgO3aLyoHwbtNGcvpwEs17n27NGUENIU
	 9fQWJ6CAvArv0XywbKkTG2WGbVJy0A6G0n2BywV9pbOKTIrYY8QQSsVG0YNkSRRjah
	 qkz5qOWeTe0q9fvb+iwzE8ACQg4Mj+M78FIQhURk=
X-Virus-Scanned: amavisd-new at schinagl.nl
Received: from 7of9.schinagl.nl ([127.0.0.1])
	by localhost (7of9.schinagl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id VA-P4SOWPgML; Sun, 31 Mar 2024 00:54:10 +0100 (CET)
Received: from [127.0.0.1] (unknown [10.2.12.100])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id 36AD11A0BE5E;
	Sun, 31 Mar 2024 00:54:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711842850; bh=wlMHaGlauf6OU8259JDUl2vgOgwWhPbGIdnS+BVFyE4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References;
	b=PMpGekbEBWXz56x3RoeGEwyh7Aer6LfrQAnnJQSMhnp+qQlz28+ZSRv0dPpTgHTk7
	 GhKFXLjKnzX3S7SYebmG4qk2XLYX+mXKsrbLc5YbaXD7qk5F+XoFtzgny5PcqzGZUW
	 ua7qGYFOjN6MJLWWmF/odPzFD5JR5oGKcee2siC8=
Date: Sun, 31 Mar 2024 00:54:12 +0100
From: Olliver Schinagl <oliver@schinagl.nl>
To: Patrick Steinhardt <ps@pks.im>
CC: Christian Couder <christian.couder@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
 psteinhardt@gitlab.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Git mirror at gitlab
User-Agent: K-9 Mail for Android
In-Reply-To: <ZghUu7Ae5PYga-Ji@ncase>
References: <xmqqy1aba6i6.fsf@gitster.g> <E5C00398-536B-4CE5-AB25-FE7FCD55CCD8@schinagl.nl> <ZfzUb9HkZLq1UIed@tanuki> <CAP8UFD2LmapWutRpfveL6ChSg8xrCkQXyQaJwHyEp8JA0p_Osw@mail.gmail.com> <Zf2B5oksaJRDH5WT@tanuki> <1d6a282e-afe6-4d43-a61c-d0259131b11c@schinagl.nl> <ZgfK3DoeidDcIaFj@framework> <f283d6ed-54b6-4bbd-8b14-67c9c8d50a2a@schinagl.nl> <ZgfWH_smdZ1jXkLO@ncase> <68563c5e-af74-4300-84c4-a0d75434167f@schinagl.nl> <ZghUu7Ae5PYga-Ji@ncase>
Message-ID: <4A3E0E2D-2922-4C90-A306-30A685D11C4D@schinagl.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 30, 2024 7:06:51=E2=80=AFp=2Em=2E GMT+01:00, Patrick Steinhardt <=
ps@pks=2Eim> wrote:
>On Sat, Mar 30, 2024 at 11:59:51AM +0100, Olliver Schinagl wrote:
>> On 30-03-2024 10:06, Patrick Steinhardt wrote:
>> > On Sat, Mar 30, 2024 at 09:20:22AM +0100, Olliver Schinagl wrote:
>> > > On 30-03-2024 09:18, Patrick Steinhardt wrote:
>> > > > On Sat, Mar 30, 2024 at 09:14:47AM +0100, Olliver Schinagl wrote:
>> > > > > On 22-03-2024 14:04, Patrick Steinhardt wrote:
>> > > > > > On Fri, Mar 22, 2024 at 11:08:34AM +0100, Christian Couder wr=
ote:
>> > > > > > > (Sorry for initially sending this privately to Patrick=2E)
>> > > > > > >=20
>> > > > > > > On Fri, Mar 22, 2024 at 10:41=E2=80=AFAM Patrick Steinhardt=
 <ps@pks=2Eim> wrote:
>> > > > > > [snip]
>> > > > > > > > I'd personally rather go with the latter, mostly because =
it matches our
>> > > > > > > > git-scm=2Ecom domain=2E I also like it better than the cu=
rrent git-vcs/git
>> > > > > > > > because of that=2E
>> > > > > > > >=20
>> > > > > > > > So Chris, would you mind adding me (@pks-t, my non-GitLab=
 handle) as an
>> > > > > > > > additional owner of that group?
>> > > > >=20
>> > > > > I'll empty out my gitscm group, make it private so that it won'=
t be
>> > > > > accidentally used and transfer ownership to pks-t=2E You can th=
en 'do what is
>> > > > > needed' with the group=2E Since gitlab doesn't support aliases =
(yet? :p) best
>> > > > > to park the namespace=2E
>> > > > >=20
>> > > > > Olliver
>> > > >=20
>> > > > By the way, thanks a ton for being this open and helpful during t=
he
>> > > > whole process=2E This is greatly appreciated!
>> > >=20
>> > > Hey, no problem=2E I initiated this discussion because I wanted to =
get to this
>> > > solution=2E Just because my mirror is not used doesn't mean I don't=
 agree :)
>> > >=20
>> > > Btw, I can't transfer the group, it's empty, but if I delete it _ri=
ght now_,
>> > > you'll have to re-create it, _right_now_ (well within the next 5 mi=
nutes?)=2E
>> >=20
>> > Shouldn't it be possible to add me as a secondary owner of the group =
in
>> > [1]? From thereon I could "transfer" the group by removing you from i=
t=2E
>>=20
>> Done and done=2E
>>=20
>> I'll remove myself, or you can kick me :( one I know you have successfu=
lly
>> received ownership=2E I tried to invite the group git-scm but that coul=
dn't be
>> found, probably you can do that (and then remove yourself :p)
>>=20
>> Would have been useful to transfer ownership of a group, iirc you do th=
at
>> with repo's as well? Under the hood it could use the invite + remove me=
mbers
>> thing=2E Though this works=2E
>
>Thanks! I've added Christian to this group such that it has a higher bus
>factor=2E I guess it should probably have the same owners as the "git-scm=
"
>one just in case we ever want to do anything with it=2E I've also removed

Could you not just invite the git-scm group and have no members at all?


>you from this group now=2E
>
>Patrick
