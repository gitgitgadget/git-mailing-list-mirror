Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8BD1F873A
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074022; cv=none; b=PgmWuu2+UFlk7ZfjJLZuVDZLTI0Kuw7OCcwgUC5kRmOJWsbsMuWb9/3c3loPQVfKVMO0ALGzAnYT4SaW6i3//3YnxDRZIc6p5nj6Gn6KPcKVxthUGyHVx+pXvCmKF62xMl/f5SVe1jOTADdWryvszypWoDTjcCcWcg3jIEIZqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074022; c=relaxed/simple;
	bh=/71lS8cJNGok4pLNbLq6LkXWAkl8a4Nl2kFL5IdjW4c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=laWQ2aFmrbIgAy6eNv/byHDYmWmaQTxduywtFHYTQSTKboOwFD71bHQdvo9BGluybwJ7FAlZAz03R9juJDTmfZCGRItYkqj9bUVmU2z4lRZ6ZkxqaeIuso6HIlSsGnz7kvz5/9F6puxASGwHdhaw220y+L4MWMMRqO7HQun/d5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=qGvJR3El; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="qGvJR3El"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741074014; x=1741678814;
	i=johannes.schindelin@gmx.de;
	bh=JLaP9fzFeutOjggia1UT88iTIryOuvFhvwHfcuEjkmg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qGvJR3Ely9se6mZkpHUJMpaSn8qZhSDPdwCyWJXHSSgTg+LclIRRnBGsmKBiYUwG
	 aLAM/tNKBSRZIux3/zAhtTcEWjC4sEf6btuWazlg4CtshNN9OF93VqpWI/OiDyGzm
	 ZGyiQuTU9UuEyGFg2nzyWM78b871L6Lu4l4/rSzzuUr61zGjn9yFRF745za+au8oO
	 SossPZvVDWjGiXM9O5IHdFcK4GrTLfsrLnh+2BL4SNCoqiOB+qRmCLEVfaIMZmbAP
	 UPQSPHh6VhAvRM4PtEw0b6kNF2+QyVM2PgOQ3JdoDv8lpG04650nOWJk5iG9icKOF
	 F86AwrzE0TvKjMwXjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.101]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1tHOdv0Bcj-00bHp0; Tue, 04
 Mar 2025 08:40:14 +0100
Date: Tue, 4 Mar 2025 08:40:13 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: ps/reftable-sans-compat-util, was Re: What's cooking in git.git
 (Feb 2025, #09; Fri, 28)
In-Reply-To: <0c808b85-d97c-ecd3-0b1d-fba546a1124b@gmx.de>
Message-ID: <9cc294f6-03de-d88f-9734-510a23fc8991@gmx.de>
References: <xmqq7c591sus.fsf@gitster.g> <Z8aeLc-xelujEjTE@pks.im> <0c808b85-d97c-ecd3-0b1d-fba546a1124b@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Fc1nI90G+3fUWrHcrxukd6tdIEIn94JTJKzwcTIyzmeF5WnQzZh
 dlOZl95Chyu5ZpcIfATP2rv3WAHUyO4nuumNg1PTyr4/f44t/jRANrr7Y7HQQ6qBM9nZw4O
 FKeZ2MabBE8o+98U8KaTTq06EwwPmU0jrBl4glpRlwYct0UTxrIOzrtncwJYpJh0U7SNljs
 1mNCGv/Ke4pPKC2ZzaITQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wqwvu5ta6oA=;xz1Tbb+5iHUqdWJY4VgkWSUlnhN
 RA9Wmnpvo52HU+v5Oyj5LDyDKAiYI0ETe3Ul9uLjpGqQVP9h7aXh+MfhsX4TryZi2iQp1Q8BZ
 z2PZidVeqXgLIerlXjq4zOdSCl2XzeTtbKjVKExoAmPchONxEWKeBoyn0E5dPsGvI7esnPq62
 OqE7aVPl7cTWGKRcWcCwonHgbUWgzkvYkZhAETdWRqlWF7qjOEKtnv5STsmC9ReO6C9LMpznC
 pqROkKt9H2W41pQ0OeHcDcWjjJrFcCQd9O1sGBXJ6ry0jUmbmQkcYn//eIFuk3aEOPQjlqfpH
 Gg3m/rUd2DcaTiIzQFQf1XLMi5IgQGj3aEClla0QuTIg3z3cg6bcboOtt6ywCDxhXpvvTIWNU
 nYud7+sO/b/VIqW3iEKVBsxmiI8KgRJWa1F6aB0AQqVMs5Y7f8Ufy2aDrCzJTzkLuUokL0Tpm
 Ki1RD42ZKr+GFX0jOsQvYu5hRRHfF8WIgd8ZhBLIM+T1pDhlZMWHzAxeIO1yONCk/3xRzSF/X
 KELM4E4h804DgjM17BHBGHVDz8cbARVNMAFhVA/rTi4K5f1J6e9BuwOeWybIoNq4Jw8cCSM7S
 bHYeVL3teiG5XJ3LWzLUtBlHaWZe518imYE15F7xfZkFKfTVs8lrRNsqExmKm42s4YbmQLiji
 QZWIw+pif8FASmKyYChmzu3E1NxIZWbV176bL8YpGbmpK/bKV236bOU6rKYvZqM9dct6z7pTt
 VYF6X38D0gYC+NSISckERZ2Y1/B+8r8eaLEKjjBK9HJajkqyuVJLKrVjbL8IGL5fAnKIqsjvV
 Mvk3vy26+sBoL08cnCVknpx4XZNNU/7U2aHFEaFu/9l7aZkkqWHAaHyoy2SjNP7z5EOQ93wv5
 2ZVjlz/BYdYHIlq0hTakU/WZQm02Jk6/GXozJX+vrVRSPulEfeqXegezQu0Nz8pwLcg3KvFez
 ZRiZkTgBHkHRl1uvCV6Z+AC4uYRwh7sD5lW+J1HjwPZ4EERkl63BU+YSKwf9WywQH3TmJfw2j
 V4Tm06y/Fi/jl9XU0OMhltswR+gigqN7+RRGAkzpO8ve3/gyIqqL1QCKACJO9wFxJRv+7nilM
 Zyt5kBP86KToT7/pd+KXDfcz9VX9TwdYKOCcM0yTwWSvW0Hs0ZDBMOF+w16IJJbvNIq4ScNpO
 /0Jmk4E21m/vxvdn4IQLvNvrO1H4JkYJXHkztraW44IMYly6WlqrHMqGQF7kj5kz+TDM54Ge5
 MqF/oZjzFu+QZ+Cflk6BUx97vKktQrlxbWu8nCZFF/m0EVYqtLGvZ7AcDiDtNl0thCCOyGyhM
 wO5I+0KaeejhjJgs8e8RGtIeSHc4zV1nVC0/PjrD1OAvV03OD9S3x6KJfIifU1K6Zobej95FK
 I2YWCcVyOImHsvgiTUG3PHFL3HnHSHF1VkuLuNE8Gp9jkt8zyNKtQx9uzbYLsoDAniDM9nT9g
 hcaaW6FpLltstnaXcd9R7RNQHOKpfDtq/8KNjeWxgdzPuWhYh
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Tue, 4 Mar 2025, Johannes Schindelin wrote:

> On Tue, 4 Mar 2025, Patrick Steinhardt wrote:
>
> > On Fri, Feb 28, 2025 at 04:45:31PM -0800, Junio C Hamano wrote:
> > > * ps/reftable-sans-compat-util (2025-02-18) 18 commits
> > >  - Makefile: skip reftable library for Coccinelle
> > >  - reftable: decouple from Git codebase by pulling in "compat/posix.=
h"
> > >  - git-compat-util.h: split out POSIX-emulating bits
> > >  - compat/mingw: split out POSIX-related bits
> > >  - reftable/basics: introduce `REFTABLE_UNUSED` annotation
> > >  - reftable/basics: stop using `SWAP()` macro
> > >  - reftable/stack: stop using `sleep_millisec()`
> > >  - reftable/system: introduce `reftable_rand()`
> > >  - reftable/reader: stop using `ARRAY_SIZE()` macro
> > >  - reftable/basics: provide wrappers for big endian conversion
> > >  - reftable/basics: stop using `st_mult()` in array allocators
> > >  - reftable: stop using `BUG()` in trivial cases
> > >  - reftable/record: don't `BUG()` in `reftable_record_cmp()`
> > >  - reftable/record: stop using `BUG()` in `reftable_record_init()`
> > >  - reftable/record: stop using `COPY_ARRAY()`
> > >  - reftable/blocksource: stop using `xmmap()`
> > >  - reftable/stack: stop using `write_in_full()`
> > >  - reftable/stack: stop using `read_in_full()`
> > >  (this branch is used by ps/reftable-windows-unlink-fix.)
> > >
> > >  Make the code in reftable library less reliant on the service
> > >  routines it used to borrow from Git proper, to make it easier to
> > >  use by external users of the library.
> > >
> > >  Waiting for Acks, especially for Windows bits?
> > >  source: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c=
02@pks.im>
> >
> > Johannes, did the new version of this patch series make your life any
> > easier? As far as I can see the conflicts in your "shears/seen" branch
> > seem to have been fixed, and the failing pipeline seems to be due to
> > other issues. If so, we would be able to move ahead with this patch
> > series and the dependent fix for Windows below.
>
> Honestly, I cannot say whether it made my life any easier. As you can se=
e
> from
> https://github.com/git-for-windows/git/actions/workflows/main.yml?query=
=3Dbranch%3Ashears%2Fseen,
> the `shears/seen` branch failed to update automatically since I updated =
it
> manually last Thursday. According to
> https://github.com/git/git/activity?ref=3Dseen, there have been 5 update=
s
> that were hence missed.
>
> I'll try to update the `shears/seen` branch now, but I'll time-box it to
> half an hour because I really planned on taking care of other issues.

It seems that there are the usual CMake-related breakages (not related to
ps/reftable-sans-compat-util, but to the introduction of the
`CLAR_TEST_OBJS` or at least the `lib-oid` addition to that). I hope that
the tip commit of `shears/seen` that I just pushed addresses that, but I
ran out of time to monitor this.

And there are some pretty bad `exit code 127` problems in the unit tests
on Windows, see e.g.
https://github.com/git-for-windows/git/actions/runs/13648196783/job/381513=
12208#step:5:213
(but again, I ran out of the allotted time).

Ciao,
Johannes
