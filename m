Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369F2580D7
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 03:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773458291; cv=none; b=av0YDN3foqTRYz4VBn9CrzZMERR9n3F1NPcq7flahDoMb59BsiMtpxS3azd4/NAI7Q9bddwWlZ8NFOJYjK+kUSxMvV4+6hE9+TM81IZ+KV6j3CRQaAJiYFf4zB1mZ3MUk20tyZM1ImxepoNnEL5pwptz1Vte5KP0Jva/OiKoeDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773458291; c=relaxed/simple;
	bh=dl1m4aKniwRL6CGoSAWXN1iexH5BXQ4lQHvqSq6jBR0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nHI/GwxuY+zfHCXDJ29DUreiWepKcoa+lTGuuokD6IWUJHrtm91ZKWTAYb54EQzPcMsg8xYVlsAmz/XVk/VS3sMeqzVO2aa4d0gcHqgkXaytJxnO72bIH/dn5NKzfabSQekaRnOI5ZmjwS+kA/nysuQeBX8X1AFIk7TYU8w2wRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=a53luipz; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=2J/ZtJMr; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="a53luipz";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="2J/ZtJMr"
DKIM-Signature: a=rsa-sha256; b=a53luipz2scXQPtdXsXvUOqbDrXGtOaOUjCwfp8K9b1R4dK7c2Pc2P7fvYyoBVR7k3O0aSMDUUf13CT3uElKKYe+qFqAnpKSIh/FMCp+9Xc1HeB3XaiAWk0uEqttMpFQEAaArY2X1Yr+hhI+51wYfxE83QjRt4S3qxR7xxDPqZxbRSAbGfetgPKgMhQlUVJWxkoi1LtDwsmCAieP1JmfKn7+OyVhC84fdIszhnjInlPqJBfvPs/bS8p9Y3HwSD6Q7w9J7uDzuNyz0j4f86K1bTkM+Ak6SotrtmfjM9zx2/Au+RrUKIY2MN0Rv6MqXfMz7P0Wn3icvj7Tl+14OtSA4A==; s=purelymail2; d=malon.dev; v=1; bh=dl1m4aKniwRL6CGoSAWXN1iexH5BXQ4lQHvqSq6jBR0=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=2J/ZtJMrRWo89lUvsaUPITJRa65TdlNjXs43aSqV8kjaVzIbGsfyLJqgAbShkqPcb4RR4Iqicv0oxGPX15IyKZUEDWnnD9WCdsng7wQC8dngbH07gM6HVRjaCdZ2H2KmXmf5UflUQAF0CbuONN7N4+Sd6wd4nvnYBglq7lP/yxo/+yc81ApCucBMcAJ4GVb+OajDa8i37q7e/RdDxEeJbibtiHa9rt2QaHG4wIH6fykzK4VJCs6gsRfl6lawc4oxTRgrK3P/F1kOwuVG8DAOYCkxhak2EIGX3ANBjgMpx4M41t8J6CiOZzKOiTI4FbPM/W6xQcdC7xH2Jo1TGdI73g==; s=purelymail2; d=purelymail.com; v=1; bh=dl1m4aKniwRL6CGoSAWXN1iexH5BXQ4lQHvqSq6jBR0=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPA id -1203069208;
          Sat, 14 Mar 2026 03:17:58 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 14 Mar 2026 11:17:58 +0800
From: Tian Yuchen <cat@malon.dev>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 karthik.188@gmail.com, phillip.wood@dunelm.org.uk, jltobler@gmail.com
Subject: Re: [PATCH v1] builtin/mktree: remove USE_THE_REPOSITORY_VARIABLE
In-Reply-To: <xmqqh5qj4h1z.fsf@gitster.g>
References: <20260311181704.958509-1-cat@malon.dev>
 <abJjYNq_sxeH8yLQ@pks.im> <af2c4ae3-c273-40ba-bbca-cbbf687b1b91@malon.dev>
 <xmqqpl577m3y.fsf@gitster.g>
 <4fb9c915-7246-4c55-b7c6-b4ef7ca91230@malon.dev>
 <xmqqzf4b4ntq.fsf@gitster.g>
 <e448f98d-58be-409d-9ff2-ae45442dbded@malon.dev>
 <xmqqh5qj4h1z.fsf@gitster.g>
User-Agent: Purely Mail via Roundcube/1.6.11
Message-ID: <77a9fc5cb543579ab925eca9fc9c2b1b@purelymail.com>
X-Sender: cat@malon.dev
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Junio,

> Tian Yuchen <cat@malon.dev> writes:
>=20
>> On 3/14/26 01:54, Junio C Hamano wrote:
>>=20
>>> I strongly disagree your idea that 'z' is more business logic than
>>> 'h' is.  Both are equally relevant.
>>=20
>> Perhaps I didn't explain myself clearly :(
>>=20
>> I do understand that *currently* both are part of the business logic.
>> However, what puzzles me is: why is it written this way? Why isn't -h
>> intercepted at the outer global level, but instead handed off to a
>> function like parse_options() for interception?
>>=20
>> Is this due to historical reasons?
>>=20
>> Please forgive my slowness. I would appreciate it if you could offer
>> some guidance!
>=20
> It is perfectly OK to be slow.  Spend enough time to study the code
> so that you do not have to ask for forgiveness ;-)
>=20
> In order to make a useful response to "-h", that business logic
> needs to know what options are available and what argument they take
> etc., which is already given to parse_options API.  What makes it
> make any sense to split it to separate codepath?

I see.

I=E2=80=99ve been thinking about it, and moving it to an external file seem=
s
to break encapsulation also. If 'option[]' is no longer static, then the=20
code
that originally handled this logic would have to be moved to a file like
'git.c', and the codebase would increase significantly. That=E2=80=99s prob=
ably
not what we want, right?

This is not only semantically confusing, but it also doesn't work any
better in practice.

I kept thinking about maintaining a separate framework to intercept
all of this =E2=80=94 I guess I=E2=80=99ve fallen into a certain mindset wh=
en it comes=20
to
modern CLIs. These changes, which do not offer any significant=20
advantages,
seem to actually undermine performance and local clarity. It really=20
isn=E2=80=99t
worth the effort.

I hadn't actually planned to migrate anything. I was just a bit confused=20
as
to why it was written this way.

Thank you,

Yuchen
