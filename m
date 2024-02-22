Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FFA383BD
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596128; cv=none; b=keXIsYWvS1wg3dHKx3DEYJVf/1vbK0CpdhZgB/CnfNGofiYQe+KdT0PqbIVMT4DYfs5Mn5SJz/zWuvnkdnHVAoZCOEfxfq9Mu80/ygNxOnJbm79qArFs8i8hmflcuS4T6ln7c8ogcdhFzvqQ++s5TD0IBscOSzQ7jdltRC7GAs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596128; c=relaxed/simple;
	bh=82yy//8HUHa0Bbdz7zmWCvJVin+rLzDnxubGJqoWGI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/FSlMxd6AgSV/rdSt6wfxi4G1acXkPjca3jAC0Psxi3XyYhIGFeA+YUJSBVzNa0BzxeFZ9nldrgxCLJ8qM5KxWXQC9dbU87Ekl8wGGaqKWCD6WoXiIDTmpXBhm3dPdH+Rl4EJvYDtuDn2oadb1JAw9U7OZtF8kmEbVGp+0GmAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=nMQk5YZ3; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="nMQk5YZ3"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:efe2:1aa5:9f41:6f3a])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 0D102780316;
	Thu, 22 Feb 2024 11:01:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1708596124;
	bh=82yy//8HUHa0Bbdz7zmWCvJVin+rLzDnxubGJqoWGI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nMQk5YZ3pYjn4XoBPeXUui2MzpweTnGROyFw/Ur1vU3JmS7T/JjrvtdHjoMeI4BNM
	 nPxIjePNvw2Q7fK6SYBpmmQ2OPrBzxS5UUIWs0IJ3rp4k7oBiwbJ3jj/h58Wmlyv9T
	 uP2l43MkerJNQlSpOPm/UzKDLPM8uQHvtufIrIzuSxOMbbU8BcEA0wqS4gUxXf1vSv
	 0YZurTd0VIM2Br64RU1M85H68gfXZvQwPJCjDlEKNT6rjiJqQOvRpByGSaW1kFLXyv
	 t47mu7c5JaGtn1oNq7/GupMMq/BuZJPpOEKzxyyJrlNs93HLNzRLql8Hw2oXhlOg/A
	 no3Pv/O4ORQsA==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>
Cc: Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
 Harmen Stoppels via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Harmen Stoppels <me@harmenstoppels.nl>
Subject: Re: [PATCH] rebase: make warning less passive aggressive
Date: Thu, 22 Feb 2024 11:01:59 +0100
Message-ID: <7633780.EvYhyI6sBW@cayenne>
In-Reply-To: <xmqq4je1mo5p.fsf@gitster.g>
References:
 <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
 <2324063.ElGaqSPkdT@cayenne> <xmqq4je1mo5p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday, 21 February 2024 23:46:10 CET Junio C Hamano wrote:
> Jean-No=EBl AVILA <jn.avila@free.fr> writes:
>=20
> > As a translator, I'm less bothered by editing a sentence to remove a=20
question=20
> > mark (maybe enforcing a language style and reformulating the sentence b=
y=20
the=20
> > way), than by translating again and again similar sentences.
>=20
> Sure, but if the original in C locale used to be "FOO BAR?" and you
> translated it to "foo bar?" in your language, and then a patch
> updates the string in the source to "FOO BAR", doesn't msgmerge
> notice that the original as a "fuzzy" matching and offer you
> something like
>=20
>     # fuzzy
>     msgid "FOO BAR"
>     msgstr "foo bar?"
>=20

> so that all you have to do is to remove '?' anyway?

Yes, it works as expected.

> So I do not
> think you'd need to translate the "FOO BAR" part again and again.

Sorry for not being clear: I don't consider changing a question to an=20
assertion is translating "again and again". This change is completely entit=
led=20
to end up on translators desk, because it involves possibly changing the wh=
ole=20
structure of the sentence.

About "again and again", I was more refering to strings such as "could not=
=20
stat '%s'" and then "could not stat file '%s'".

>=20
> But the above assumes that for your language, the ONLY thing to turn
> such a rhetorical "passive aggressive" question into grammatically
> correct statement of a fact is to remove the question mark.  It may
> not be universally true for all languages, and for some language,
> even after msgmerge did its job correctly, you may need to do more
> than just removing the question mark to adjust the remaining "foo
> bar" part.
>=20

I perfectly agree with you.

Thanks




