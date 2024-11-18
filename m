Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C013DBBE
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967500; cv=none; b=UuUcdl9hemvL59LnJSdIaHqOXcGePXICWKvVL75cMZrbDbS48gUTf/UFItfzuKykft2xOMwud6ZRwfCbzDPOM+LKUa1g2UbvXMtseVV/8Um5I/Sv84QZ8kl+l2xrIZu94ih6EzzOaHHd2r/tzP/dcD5P3kbuDgCjVAA4ViDXVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967500; c=relaxed/simple;
	bh=9SksPcOOnYFsLzns6FfldAdVANx+5+OFnDstanHQjSQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2g84hsUfUfEhrHmJJLbxRmftHEQHjJS25bX2OfaDaAxsFuE9ZQcvUEM3vBkbegPlS1UItThkMLvRBsM7pxDtYXrXGS9zCfDGog4f2l2KU4fqz4VxfZAHj8S8ghm8x1cCA0P+j+AB4cjvRFAhSc4vtjJ6lFSe+pFLd1AFpODzL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NS9kpaB6; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NS9kpaB6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1731967491; x=1732226691;
	bh=9SksPcOOnYFsLzns6FfldAdVANx+5+OFnDstanHQjSQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=NS9kpaB6EXimdiIBdcWI29iWp5csmHesAaRXGHVKR5QbB16wixmxE/cmhfqoRQTPw
	 GIQVwqv6gXS+YQmSC5EcEiOHWoSBLAFPk1lq8b1Xttt9KJ5efrKsXJU2Uwqp9Ks2Y9
	 v/nq6TwqmAelQI4H05j/UAJMcGIBoWKMi5XtDAYrDj5i5b4edpGtbC/OwEXn0uP6jX
	 jfQBsU9sPsUKM9gJN6p0D/mojc3gnI+tqLeqt9CcZRVsGt74HdVl2Z+1lCJmxgC7tc
	 mb4wIz7eLtUsNBKBUQVM4FTAKw6eEq9pn7yeZzOzNQQDEeb1jdGoLj4qaJaGlPBZQW
	 Bw4/0R1yN2j2g==
Date: Mon, 18 Nov 2024 22:04:48 +0000
To: "brian m. carlson" <sandals@crustytoothpaste.net>
From: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [bug] user may be cornered into delete files #9901
Message-ID: <kQjk0kPkRFcFhFJzAV12mEO_0RDHGLeoWoxbFVwNfXa_i5MJ4o37D-BHTdCnIS6a0EwTKprHrAY3tHl8OPZ_9wpXByHFk0gP8JUlpUmJuIg=@proton.me>
In-Reply-To: <E864saUi2ZoNwlZE8pH1_m9QQ2-E48w-hUk3GxH02I3_djQS_NLKyq3vbwbf39pf-RuAQUzds2kx0-RNZepTb4iEVKs5qPiJz2eKHuLZxT4=@proton.me>
References: <P_ttzPnNTtUgpAy8cg_ntLvwskJhz7cmv-fFgDw0K4Y2vOCx8v_AXxHtHEuBtpREOQu9pxpvK6JgLusc5Uyn2wDZ4HZvC3ttM4k-Ry6jBs8=@proton.me> <ZzaJzm4kyYbcDSgm@tapette.crustytoothpaste.net> <E864saUi2ZoNwlZE8pH1_m9QQ2-E48w-hUk3GxH02I3_djQS_NLKyq3vbwbf39pf-RuAQUzds2kx0-RNZepTb4iEVKs5qPiJz2eKHuLZxT4=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: c1bfc4329ace328d33a7d8873ccdee5ec723c728
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_GayaNvpVWq1iyS5EPgyP8spoelbVoI2EylnjSzyo"

--b1=_GayaNvpVWq1iyS5EPgyP8spoelbVoI2EylnjSzyo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

BROAD OVERVIEW

bugreport[A], question[B] and use-case[C]. These are all related but separa=
te threads for the purposes as labled. Please do not cross-post or cross-qu=
ote. Focus on productivity and solving these. You are welcomed to view and =
participate in all of these as I contribute more.

use-case[C] - git question (short) rephrase with use-case added.

ADD, ADD, ADD why cant they get that: ADD. ADD tracks files for commit. It'=
s already been commit : push failed. Failed pushes piled up. I need them un=
tracked. How do you undo an add ( many adds): simple question. Without dele=
ting any files, to repush 1 by 1.

I suspect the answer is: "you can't - git provides no means to do so" - a d=
efect, bug as we call it. The answer to this use-case question likely will =
confirm my bugreport and I get the feeling this is why they will not answer=
 the question they do not want to accept my bugreport and have a bad spirit=
 to argue. The excuses they give for this will be that it is not typical: T=
his can normally be solved by repushing. However it is still a defect and i=
n my use-case there is a slow or intermittent connection and no sha-backups=
 yet because this is the initial creation of a repo.=20

The above question is a use-case[C] seeking how to undo without deleting fi=
les. There shouldn't be any need to know a use-case in order to answer a te=
chnical question. I am open to discuss my use-case on this thread. The use-=
case if of this repo github.com/freedom-foundation/kjbible

My original bug report is that the user " may be cornered into delete files=
" bugreport[A] Summary as of 20241117 brian does not believe it's a bug and=
 begins chattering to Peff about how to fix the bug "There are Git-level ke=
epalives during the similar compression operation".

The full question[B] which is a child of the bugreport[A] is here. Summary =
as of 20241117 my question was mostly sidestepped and spammed whilst the th=
read devolved into a political drama about code_of_conduct. I am not open t=
o discuss my use-case on this thread.


[A]: https://lore.kernel.org/git/20241115093214.GA1749331@coredump.intra.pe=
ff.net/#r

[B]: https://lore.kernel.org/git/xmqqr079xty7.fsf@gitster.g/T/#t

[C]: https://lore.kernel.org/all/4hiTc8Kx5yNhYuN8abv3QFJBuptM6VWZ9OKvkdZFlS=
I5y0zoK-lN_VHf-QCSEjllmSWvu9V-tbrvFOx17_P0Nq8UKxEcK3Rs2d02FjbYuUc=3D@proton=
.me/#r
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc7uf0JkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAABh9AQDQxbp7CHRFU0poLOuwPdICYc07bOUMHu/EXC4SweKiPAEA6fiT
yPK2ueIqGYTPzGYtEHLxw7wsV8ZuXS7mE6HseAA=3D
=3D/xm/
-----END PGP SIGNATURE-----

--b1=_GayaNvpVWq1iyS5EPgyP8spoelbVoI2EylnjSzyo
Content-Type: application/pgp-keys; name="publickey - A_bughunter@proton.me - 0x66540805.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWnUwWDF4WUpLd1lCQkFI
YVJ3OEJBUWRBSDBJNDdqRHNQWjZndmIrWVVHQm5BeDdKeWYxNEFWT0gKeGE4eTArZG1ONWJOTFVG
ZlluVm5hSFZ1ZEdWeVFIQnliM1J2Ymk1dFpTQThRVjlpZFdkb2RXNTBaWEpBCmNISnZkRzl1TG0x
bFBzS01CQkFXQ2dBK0JZSm03UmZYQkFzSkJ3Z0prS2tXWlRsUXJ2S1pBeFVJQ2dRVwpBQUlCQWhr
QkFwc0RBaDRCRmlFRVpsUUlCY0F5Y1oybE85ejJxUlpsT1ZDdThwa0FBRDlGQVA5L2RkVDYKNTZH
a2E5TnRNdm1kb1k1a3ROZ3FiWTVYYmQ5Zng2a1BFNS80dFFEL1hpaWFsS1FIam13QXRiY1NlMVEr
CjNjeFlMeE5oalU3bXluUXNwdjlkeEFET09BUm03UmZYRWdvckJnRUVBWmRWQVFVQkFRZEFuZnAv
ejJGdwpSa3B2VWdmN21xWUk5UktuVFZhZHdHZmdhUUxobXdnM0x4TURBUWdId25nRUdCWUtBQ29G
Z21idEY5Y0oKa0trV1pUbFFydktaQXBzTUZpRUVabFFJQmNBeWNaMmxPOXoycVJabE9WQ3U4cGtB
QUppOEFRQytmbk9tCjRWajlRbUg0SDBHVnQ3UnVPUUsrd09RMVBSdnB5bVNqZXlCSk93RDlHWXV2
eE9BVks4aUF1cEorcHB3TQpyMzZWdWtJZTFwWHVIbzlSaGp2ZUF3MD0KPUZRRncKLS0tLS1FTkQg
UEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=

--b1=_GayaNvpVWq1iyS5EPgyP8spoelbVoI2EylnjSzyo
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmc7uf0JkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAMzRAPwJkahB
zHdjmbLpbLXUfgXMywSHA9tkADAsZxuKanYnlAD8C0onHiMVf6n25kUhzreEJakj1IOGxt9bjQZV
D8LYagw=

--b1=_GayaNvpVWq1iyS5EPgyP8spoelbVoI2EylnjSzyo--

