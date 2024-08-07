Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB5415B10D
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722994509; cv=none; b=l0ei4LF3Fl5EEZOKxAz65Zlph2acercOEKDiu30fxcWoXvwkqk7ysE+2A9e3GWaYdD0f1mvzHxVZNRKZb76h0wSpKgqA981yOYxTuS0PcWt6PNtV35/bbFlSSQY+YdISBxZxC/hQl3FTcsqBMSx5Djhm/0wn+XKi3z4Mmb3fFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722994509; c=relaxed/simple;
	bh=eTQjJUwad2H4rSRLHtIdTO9VXgHmqrwVfZ+5w/wTE9w=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=aFY0ddrJicZs0lurV/v7Cv5PNA0jgiqbD8G/aUcBUwx8uST6eZWLIG/xG7ROo3E3uybgaY1KicPO2qIoki7gHO3kIDFLp/h0ttOCq+pd+4bMP1apVVENJhZqESiDjQJwTPHckqZyyyqE/ZpQ+l5XLdsSO7M/JHYEzRO+9lsAFNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=V0lfvbbv; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="V0lfvbbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722994500; x=1723253700;
	bh=kkT+Fe5jSLzHjO7bczqklUqcBB08BJWkLhYVLTyZ/bE=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=V0lfvbbvFhezvm6BJZcCrTTnpGvyN1Gsu4TCKcUygdZ9zoMRjG5eKjoWFwkyvZZok
	 C3Jv4K2jVIoKR+SGwGYR53KHoZnPeKtAtJCLl54UyZr3nPwpBj1VVU4lG+ziQLf7Ft
	 U8aJl5mvK6h/IO7JRjBHUBmnQnIc7jOQ03mLVyHcZJB8qp6EkPxbeurhstw4e2EXg4
	 KBuvT3wsoGyXH5it3fsOPs942E0yg2RYd48HgRaK5/V+Hq54Viq1LLsehSIkvRLYMr
	 7mZKLh6dnKG2fBGuyb64jC613NZ3OT+whReb9AKll+KdrXRIaX2fG9UUiu/xrtYRiU
	 M9qYjPE0z2qNQ==
Date: Wed, 07 Aug 2024 01:34:56 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Avid Seeker <avidseeker7@protonmail.com>
Subject: [Question] git-commit: --template from cmd output
Message-ID: <exd_wMoR3eM-2oo-XbhCudo6nHa1cgm9cBIpSNvj5EFHBPeqveBW-44rILPLINIB5fxxrBLCpApjFYI55ckzEYNZr9qibkFcHnMI8FLQOj8=@protonmail.com>
Feedback-ID: 42841990:user:proton
X-Pm-Message-ID: b233239a4f220372d47cd80b71cabeb3e8f8d656
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------f61888d073fc25c43f260f50b35dfab37670d2c0d7df4b6ecb14f2c13642502e"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------f61888d073fc25c43f260f50b35dfab37670d2c0d7df4b6ecb14f2c13642502e
Content-Type: multipart/mixed;boundary=---------------------ef789f235e5489f3c98e496f664b9d8a

-----------------------ef789f235e5489f3c98e496f664b9d8a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

I'm trying to customize the commit message instructions showing up in text
editor after `git commit`. Checking the docs, I found these flags of inter=
est:

- commit.verbose: useful flag to see the diff of changes done.
- commit.status: for toggling whether to show status or not.
- commit.template: this is what I was looking for, but when I checked the =
doc,
  it turned out to be a useless.

IMO, all of these flags are redundant and should be combined in one flag d=
one in
the Unix way of doing one thing and doing it well, which is displaying com=
mit
message comments within the editor.

The way to do it is by having commit.template as a script:

commit.template =3D "echo $COMMENTED_INSTRUCTIONS; git diff" # commit --ve=
rbose
commit.template =3D "echo $COMMENTED_INSTRUCTIONS; git status" # commit --=
status
commit.template =3D "" # commit --no-status
commit.template =3D "cat path/to/commit-msg-template" # original commit --=
template

Where COMMENTED_INSTRUCTIONS are the lorem ipsum printed every time git co=
mmit is issued:
# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.

Of course, to maintain compatibility, these options would stay, but my
suggestion is to have a way for commit.template to read from command outpu=
t
instead of a file.

-- Avid Seeker
-----------------------ef789f235e5489f3c98e496f664b9d8a
Content-Type: application/pgp-keys; filename="publickey - avidseeker7@protonmail.com - 0x7EECE85C.asc"; name="publickey - avidseeker7@protonmail.com - 0x7EECE85C.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - avidseeker7@protonmail.com - 0x7EECE85C.asc"; name="publickey - avidseeker7@protonmail.com - 0x7EECE85C.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWWUrZFFCWUpLd1lCQkFI
YVJ3OEJBUWRBNG83QVlXUVFHdzRTeFM3dVFJRzJhN0dBU1RjN0dLdlkKKzdEWmZ5UCtINDdOTjJG
MmFXUnpaV1ZyWlhJM1FIQnliM1J2Ym0xaGFXd3VZMjl0SUR4aGRtbGtjMlZsCmEyVnlOMEJ3Y205
MGIyNXRZV2xzTG1OdmJUN0Nqd1FRRmdvQUlBVUNZZStkUUFZTENRY0lBd0lFRlFnSwpBZ1FXQWdF
QUFoa0JBaHNEQWg0QkFDRUpFRVRXMk4zc0VEWnhGaUVFZnV6b1hKVEdSQU1ob2NKalJOYlkKM2V3
UU5uR3JaUUQvUXdXWVJMU1pPY0piS0JkWFhMNUdjZkRqS0pZRGcxRkUxVExhcFJIZk1rTUEvMis5
ClVOQ1hQTlNxWjl4dFBKK0RvaERFNnNZVlV3RnJOMjZSTmhqazRZOE56amdFWWUrZFFCSUtLd1lC
QkFHWApWUUVGQVFFSFFQbXV3Z0FDVit1UWwrT3pob2xiRDc5L1ZpUWNUTzVYeGtxbFo5UW0zVVV2
QXdFSUI4SjQKQkJnV0NBQUpCUUpoNzUxQUFoc01BQ0VKRUVUVzJOM3NFRFp4RmlFRWZ1em9YSlRH
UkFNaG9jSmpSTmJZCjNld1FObkhkNndFQS9haXAvYnFyeGRyOWIvTDBnM1dibGh5UmFMU3BYOFdG
alQxU0RxNmY2em9CQU9RawpaRHVRMThvV1FtdkRaRmE0czRrSVJsaGlDQThpK1NLUHN0bk5VK0VK
Cj1qLzZtCi0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0K
-----------------------ef789f235e5489f3c98e496f664b9d8a--

--------f61888d073fc25c43f260f50b35dfab37670d2c0d7df4b6ecb14f2c13642502e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmayzzIJkETW2N3sEDZxFiEEfuzoXJTGRAMhocJjRNbY3ewQ
NnEAAO+pAPsG1aI6G3BYH6F8IrBPdFeCkyRZAKfhKLDDGHVrWaAq5gD/UWPB
6xUe0IjZrfwoOGV0EERlcLFEqzv2tjq/4dJygg8=
=Oliv
-----END PGP SIGNATURE-----


--------f61888d073fc25c43f260f50b35dfab37670d2c0d7df4b6ecb14f2c13642502e--

