Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC450653
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 05:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731647768; cv=none; b=eN5fzBwj+WHYffdkQHhdZzSxLqAEqEVcwoWwkd6eoNJf3CWWDCVnBX4YAKUwgzoWZgkRiKVEXTcnGfz5iNwpUvc4E5hpjeZgWDsR0kkfrh73n6EUPEBAozFHtvQKcdvfaG6aEzaWEiId3isc8kH4beh+kjERTQi/iQZWoAYTldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731647768; c=relaxed/simple;
	bh=dQZF1ILtPX+PUEMGERhawj2B/oJu6Ide43L2KGNEfGg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORqNZVUJ+OuETWZ9rHdJ2zV1TxDnDb6KwuMq+Nyw5vBRyTCP0DNdKWN0bHuyufsIpMSaaJIULnMFfANf8Ew6r+GGxw7qoVuXbA792kodgifwpJeUd2RoJY8stIKk2nRQ0IvL/T4bWVUaWbIlaB5vdDL5869a+tOBjOu7fprkBMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=K4haUIo/; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="K4haUIo/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1731647753; x=1731906953;
	bh=dQZF1ILtPX+PUEMGERhawj2B/oJu6Ide43L2KGNEfGg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=K4haUIo/BUgPJVrTpziyudf2pf8gBskl1JkUIx89qrOz5xEe6u05T9178eBw7UcZp
	 LJg1eZuSlXjjzbkYY1VluI0FbdhUtC7Y1HtZaTfAZ8kx+PWMtz3QZGMNqEpv7EVOSL
	 qTzLk5osLpjYjXnpQn3geeLl8dH8vkGKayeCnctQzgzR1cDKi0D0sjEw4/A5Uq8sGM
	 1fdESP/fDO79usT/ytwzxd/hldbunpK1FFMxmXgAmULA1Lhdb6Nw3E9Xk46kfSRorA
	 Y6Lj8VjKnP+W8+lfy13M13A+C9iqsLJ3I9Ijk4P7jxKrEAvLY1+F7DBZBljk5T/TNt
	 +4xCoHr/O3iDQ==
Date: Fri, 15 Nov 2024 05:15:48 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Fw: Re: [bug] user may be cornered into delete files #9901
Message-ID: <TOa5gGm8tmncWfFotfGhpWsRxDWvHH74skCKqc0_QPbRuWLvm-JFnDK8Y6SQxWooczbInHWtDbmmznLrDbr1pPSZ7vvPIlUAP9dSZcydRpg=@proton.me>
In-Reply-To: <E864saUi2ZoNwlZE8pH1_m9QQ2-E48w-hUk3GxH02I3_djQS_NLKyq3vbwbf39pf-RuAQUzds2kx0-RNZepTb4iEVKs5qPiJz2eKHuLZxT4=@proton.me>
References: <P_ttzPnNTtUgpAy8cg_ntLvwskJhz7cmv-fFgDw0K4Y2vOCx8v_AXxHtHEuBtpREOQu9pxpvK6JgLusc5Uyn2wDZ4HZvC3ttM4k-Ry6jBs8=@proton.me> <ZzaJzm4kyYbcDSgm@tapette.crustytoothpaste.net> <E864saUi2ZoNwlZE8pH1_m9QQ2-E48w-hUk3GxH02I3_djQS_NLKyq3vbwbf39pf-RuAQUzds2kx0-RNZepTb4iEVKs5qPiJz2eKHuLZxT4=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 89bc64aeaaf56711ccfaf079da52038291d1678d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_euSsP6j8QhxZUrnpoX1ZPIJZ3kHhwAERqxpriVlsJQ"

--b1=_euSsP6j8QhxZUrnpoX1ZPIJZ3kHhwAERqxpriVlsJQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

My reply for git mailing list about the bug and more for brian is here forw=
arded because the reply button reply's to the sender and not the mailing li=
st. See more for brian after the reply.=20

from A_bughunter@proton.me

Sent with Proton Mail secure email.

------- Forwarded Message -------
From: A bughunter <A_bughunter@proton.me>
Date: On Friday, November 15th, 2024 at 04:31
Subject: Re: [bug] user may be cornered into delete files #9901
To: brian m. carlson <sandals@crustytoothpaste.net>
> My reply to brian m. carlson.
>=20
> No, you brian seem to be missing what the bug is my complaint is this:
> if the initial push fails (for any reason) then the user must reset thus =
deleting files. My capacity is new to git as you would see on my github.com=
/freedom-foundation profile. You can run the problem again and see if a --s=
oft reset would evade having to delete files. Help resources instructed har=
d reset when asking how to undo a commit because push fails. Can a --soft r=
eset undo add without deleting the files which initially have no backup. Be=
ar in mind the files could be anything, text, tiff is not part of the bugre=
port. Any initial files would have to be deleted if push fails for any reas=
on is the bugreport.
>=20
brian, I was not impressed that you could not gather what my bugreport was =
before I rephrased it.

brian, For years my files have been the victim of vandalism and hex editors=
, and likely everybody's files are because I have yet to meet anybody whome=
 can describe how to perfectly checksum text.
 I get what you say brian about a text file instead of TIFF but the convers=
ion to text from TIFF is a long drawn out process which may take a while so=
 I have stored the original TIFF which is further necesarry to authenticate=
 the sources of The Book. Unicode is a problem see here github.com/freedom-=
foundation/unicode-map . Can you help to build an ANSI ASCII only Linux ker=
nel because the Unicode is a problem and Unicode is in the Linux kernel. In=
 order to convert The Book to text I need 7-bit ASCII ( see here https://gi=
thub.com/freedom-foundation/ASCII-format-for-Network-Interchange ) and for =
checksums to remain stable either BOM or a BOM notation along with the chec=
ksum. Unicode is a problem because you cannot checksum text while fighting =
against vandalism and binary/hex editors.You may know also calibrating OCR =
such as tesseract is not a snap and may need about ten percent of total siz=
e to be corrected which is effectually dilligently re-reading The Book that=
 being the case it is about as easy to type it by hand instead of using OCR=
 such as tesseract while fighting vandalism and binary/hex editors which im=
peade the process. The process cannot be verified without checksums while p=
rotecting against corruption. While.=20
>=20
> from A_bughunter@proton.me
>=20
> Sent with Proton Mail secure email.
>=20
>=20
> On Thursday, November 14th, 2024 at 23:37, brian m. carlson sandals@crust=
ytoothpaste.net wrote:
>=20
> > On 2024-11-14 at 17:53:15, A bughunter wrote:
> >=20
> > > [bug] user may be cornered into delete files #9901 pls see https://gi=
thub.com/cli/cli/issues/9901 and look into all of the links.
> >=20
> > What you're describing sounds like a network problem of some sort. I
> > don't believe this is a bug in Git because Git handles this kind of
> > thing on a regular basis without a problem.
> >=20
> > The only thing which might potentially be a problem on the Git side is
> > that I don't know if we try to hold the connection open without sending
> > a sideband during pack generation, in which case if the client side
> > doesn't send anything at all, then the connection might be closed by th=
e
> > server. I'll point out that GitHub sends SSH keepalives, so typically
> > the connection should not be reset unless the connection actually
> > drops.
> >=20
> > However, you could try pushing over HTTPS instead, which won't try to
> > make the connection until the pack is generated, so even if we do what =
I
> > suggested might be a problem above, that wouldn't affect HTTPS.
> >=20
> > I will mention that the repository you mentioned there contains a large
> > number of TIFF images about 1=E2=80=932 MB in size. These TIFFs appear =
to be
> > using JPEG compression, so when Git tries to deltify them (during the
> > "Compressing objects" stage), that step is just going to waste a lot of
> > CPU and take a long time, since trying to deltify compressed objects
> > doesn't work and is just slow. That's contributing to the slow push
> > performance.
> >=20
> > In general, Git is not a great way to store large numbers of compressed
> > images. If you're going to store images in your repository, you should
> > make them uncompressed (which you can do with TIFFs) so that Git can
> > store them more efficiently. What would be even better, since your data
> > appears to be effectively a book, is to store the data as text, possibl=
y
> > with a small set of images for illustrations, instead of storing the
> > book as a set of images. That would be much more searchable and
> > accessible as well. The Git FAQ[0] mentions this and makes
> > recommendations on approach.
> >=20
> > Overall, I would not say this is a bug in Git. Pushing over HTTPS may
> > help you get your pushes working in a more robust way, but in general,
> > I'd recommend storing the data in your repository differently.
> >=20
> > [0] https://git-scm.com/docs/gitfaq#recommended-storage-settings
> > --
> > brian m. carlson (they/them or he/him)
> > Toronto, Ontario, CA
--b1=_euSsP6j8QhxZUrnpoX1ZPIJZ3kHhwAERqxpriVlsJQ
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

--b1=_euSsP6j8QhxZUrnpoX1ZPIJZ3kHhwAERqxpriVlsJQ--

