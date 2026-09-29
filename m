Received: from mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957AD51B181
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684091; cv=none; b=Oakz/oVls68ZR1cPsYZI2f5VkKGFMjF/V5KqyI1/NCMj5bns24HA9cA7yH9ixTfNhyPeVLs8cfoN/SDscDztlVcwkoMxxHfOibECX245SrLBJsnrzm2MiTPZZgNkH9xZUkKRu9DjrJUJSsGyLomcgVz1KKpQrFqc5pdZOT6bsLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684091; c=relaxed/simple;
	bh=XUk0Os0iXyOqi35kdryBV+4EicWCwtli6iTrFTN6Dco=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=qMgo+/rgoVzjAxXyliq169JJwCTqnN/BB6ogD/+bKTbGAAQ/hzRtvLS4/1ZLaN2Z2CM2bcWuoh/ArQPvulunu64jRZXZ2InUerxiLeJmcdunaDLlosjQ1wI3qUvuppcUNFINpl5VlIeb5kpqo0k0czBLJCDkd6Hu4MqlpuBRs9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=HV3lFbFu; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="HV3lFbFu"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XUk0Os0iXyOqi35kdryBV+4EicWCwtli6iTrFTN6Dco=;
 c=simple/simple; d=iencinas.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790684086; v=1; x=1791288886;
 b=HV3lFbFuUYBA6Z8gwzbYCyHjk/Yfn25O9V/NibQwCl00rx//gUGONM7bfU2/HHG/mDTV8fbA
 qo1AtWUXXhC2aCFbnZfgDC0ymKoYbIBzns5bamLuIhrwcfp9FqFfQmZj3P3Jdb5QOB65f4/GkX9
 2Hc5MbBpisVChBwMBiWG/UfiUs4Y6S4YNqt8QW1WsztOACAsJUC990vqeKMBAY9qkRQaq7cr/0n
 UCGX5OzBftw4C6dNXf4ucWZcFnkF6FCDuR6u4iPySMbmR3vMyhdZJArs1YRPQgVtQxPe1nQQjZu
 T25T1KrYD4FMMx+x2dv2up6EL3UtzLpMlLVMoPZNJJM1Q==
X-Envelope-To: git@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a7bb9edbf723ad21;
	Tue, 29 Sep 2026 12:14:36 +0000
X-Mizu-Trace-ID: a7bb9edbf723ad21
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 13:14:34 +0100
Message-Id: <DLRSIZ3JV2DF.10GG1YB2D8DHW@iencinas.com>
Subject: =?utf-8?q?Re:_hostname:_includeIf_condition_=E2=80=94_anyone_already_work?= =?utf-8?q?ing_on_this=3F?=
Cc: "Ignacio Encinas" <ignacio@iencinas.com>, <git@vger.kernel.org>
From: "Ignacio Encinas" <ignacio@iencinas.com>
To: "Jeff King" <peff@peff.net>, "Isabella Caselli"
 <bellacaselli20@gmail.com>
X-Mailer: aerc 0.22.0
References: <CAK4AdTRdNEU8cLFQ_7A=CUUL6u6dc327rn_H-SeBBD_dD-K7PA@mail.gmail.com> <20260929014415.GB1089022@coredump.intra.peff.net>
In-Reply-To: <20260929014415.GB1089022@coredump.intra.peff.net>

Hello,

On Tue Sep 29, 2026 at 2:44 AM IST, Jeff King wrote:
> On Mon, Sep 28, 2026 at 08:43:49PM -0300, Isabella Caselli wrote:
>
>> - Any objection to the approach itself? The same machine can report
>> its hostname differently depending on how it's set up =E2=80=94 sometime=
s just
>> the short name, sometimes with the full network address attached to it
>> =E2=80=94 so it isn't obvious whether the condition should compare that =
value
>> exactly as the system reports it, or normalize it somehow before
>> comparing.
>
> Yes, that is the tricky part. :) There were some patches in 2024:
>
>   https://lore.kernel.org/git/20240307205006.467443-1-ignacio@iencinas.co=
m/
>
> where the issue came up. Based on my recollection and a quick skim of
> the thread, I think the consensus was that it's OK to document that it
> is system-dependent whether we'll match against a short of fully
> qualified hostname. But exposing our view of the hostname via git-var
> (e.g., "git var GIT_HOSTNAME") might be a helpful debugging aid.
>
> It looks like after review on v3 of the series we never saw more. I'd
> guess the author (cc'd) just never got around to pushing it forward.

That's what happened. Similar to Isabella, I was looking for a small
contribution but it ended up being more complicated than expected. I got
a bit overwhelmed and decided to drop it.

I kept wondering if I should have communicated that, so apologies if
that was the case.

I hope the discussion from 2024 is at least helpful now if this ends up
being implemented by Isabella.

Best regards,
Ignacio
