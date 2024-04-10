Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8565330673
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789436; cv=none; b=jyGEBxwooS4Zy0gl5x2pUm0+//f4gDFbGF6RZL6Z9092vRharSK59EmyPoapFfKoE5CainDgn9OcskxGN5dS/2gNpMThoNHUXRl+bt3d9u8aE0VxOvjitLg8uj+GevP7ablOfqPw0PZDc4BUl6n+YrShYPL1BGMVZ+FjpDPpzH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789436; c=relaxed/simple;
	bh=Zg5pNRCB2SwGParAfq90o4AcOq5b0glZuQIMfolwy94=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTNPXpAVig55QGRWqVM0/PRiRfc8/sJQ1Mmai64c3RDUjHsfgZVoWdfrMjbPO86qD2BjwpCjqih06q2q9rWODchrSdjvqPNizbjRPNsj1WPRIV4RaAELnejpcyONL2lQ+2R2ZLuqRyuLDPJI2qHPyfacdCkmeTRCOgVDz5h/COw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=uD8DSdX0; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="uD8DSdX0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712789429; x=1713048629;
	bh=vYm0cMVkjw4EdV8u1J6icG/UBNIRMg7Sm01TCrPNx3U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=uD8DSdX09Mzly134tXpu5wnwbfg3zuUoF2rwl6tmx2pF67ft/RNnzNOM4j6LRrnK7
	 re0yx+oEJW83FXh/fOhVD+Z14Za+URI0JVP17RnA/V4itAggHYrW1d+e41lKh+ulWS
	 v24kEjJH1vekruDFDUHgC9tw0h44clPNUb8OHUV7HQfxQRrq/oCv9GUICyokSr7b1n
	 WNHQYKOq4zcQ0yStCQ54zwnb6lAJD/ChsfJPGGU5mhM0lt0FW38nevx3pnLsEXHl1h
	 BJPvNYogASgjwXGgY/GkwWe0pQGMYmJDAdTVmiCBOXBcjCX+vPl2+SfFGDyt+0VOh5
	 Xo4v55LwTENZQ==
Date: Wed, 10 Apr 2024 22:50:21 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 6/8] fast-import: document C-style escapes for paths
Message-ID: <FEF264E3-B671-4F0C-AE41-FC8EE44DBE28@archibald.dev>
In-Reply-To: <xmqqjzl5t6mn.fsf@gitster.g>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <cover.1712741870.git.thalia@archibald.dev> <1b07ddffe000ed2ab34bd41f4f0558ae8b2dd663.1712741871.git.thalia@archibald.dev> <xmqqjzl5t6mn.fsf@gitster.g>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Apr 10, 2024, at 11:28, Junio C Hamano <gitster@pobox.com> wrote:
> Thalia Archibald <thalia@archibald.dev> writes:
>>=20
>> -test_path_eol_success 'quoted spaces'   '" hello world.c "' ' hello wor=
ld.c '
>> -test_path_eol_success 'unquoted spaces' ' hello world.c '   ' hello wor=
ld.c '
>> +test_path_eol_success 'quoted spaces'   '" hello world.c "'  ' hello wo=
rld.c '
>> +test_path_eol_success 'unquoted spaces' ' hello world.c '    ' hello wo=
rld.c '
>> +test_path_eol_success 'octal escapes'   '"\150\151\056\143"' 'hi.c'
>=20
> It is annoying to see these changes (and the same for the next
> hunk).  Would it make a lot of damage to existing lines in this file
> if we just say "do not align with extra spaces in between strings"?
> If so, that is a good reason to keep doing things this way, but if I
> recall correctly, these test_path_eol/space_success are what this
> series added to the file, so if we stop such alignment from the get-go,
> it may be alright.
>=20
>> -test_path_space_success 'quoted spaces'      '" hello world.c "' ' hell=
o world.c '
>> -test_path_space_success 'no unquoted spaces' 'hello_world.c'     'hello=
_world.c'
>> +test_path_space_success 'quoted spaces'      '" hello world.c "'  ' hel=
lo world.c '
>> +test_path_space_success 'no unquoted spaces' 'hello_world.c'      'hell=
o_world.c'
>> +test_path_space_success 'octal escapes'      '"\150\151\056\143"' =
=E2=80=98hi.c'

Is it a style problem, that you prefer parameters to not be aligned? I
think it reads nicer this way, especially because there are quotes
within quotes and spaces at the starts and ends of strings, which can
lead to reinterpreting the boundaries of the strings on a less-careful
read through. They=E2=80=99re like a table of tests. But ultimately, it sho=
uld
be the Git style that prevails not mine, so if that=E2=80=99s it, I=
=E2=80=99ll change
it.

Or I could preemptively align them according to the final alignment in
this series. I expect there wouldn't be many changes to these tests
later, so it should be stable.

I expected more pushback with 3/8, where 9 tests were indented to place
them inside loops in order to test them with multiple values for root,
so it seems not to be purely about whitespace changes in diffs.

In any case, it=E2=80=99s not a big deal and I=E2=80=99m happy to go with y=
our
direction.

Thalia
