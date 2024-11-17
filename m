Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53A1DA23
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731833700; cv=none; b=OqMJ+5FU53WZ25WEXaTCkCiJ0B+6aMNxSVo1fla1JV0ZolAFMgdR9q3PlKc8X7uKryhKIymW3uReFw8nYcf9t12NMq54wf5S6Mv2hhr3ApzhfVXcFvvZty1xCCIbxQTWw36JMlnY90m1/bB/ocY7IyMu1ipQxLn3lWKSDHDjvvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731833700; c=relaxed/simple;
	bh=O9dBL8l2LoO5uPbeQvnzGCq6L0PpY2eIV04F96l7WN0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WL/SUGNHw/ZK2Kdd0cGrknPxWjw7txDNKHNKT3X6j0dZtV3SXnX8zTEEedORwBmyWB5qhNjs7cPhhtZhTxpD09nFwFgVddQgpEjmupP1l1WBAN+PMvQlPKAAAFktPsvtqhjqE0n9FczaO4+ROB0BAA5Dx05cBoAYylwq95u47k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=mDutTWM7; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mDutTWM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1731833694; x=1732092894;
	bh=6hvmjexrT0Asmcu95DBxQJ3CWNXrnRwY+JU9L+9tEc4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=mDutTWM7vcFgWmGIGNOyrkAmPVwPZ0BCUSLhugh99A9zflwtbFAxez6VZBuyfFUjC
	 8KfYgB4nKOoEJfqKlZfEPJSsAhCet/1Eb5K0WhFqP+uAwHWWeIYztFTq61Vegqi36T
	 pqFKLMHhTtnio204Z8iYMo+4Qc4h0ekAFoVgYTPPCSQ70Op4N04Ahr72JMtvu3d4zw
	 5aBCYZ/Tj4hHJxD3fHowea4dYgQldRYtArUC8yHoqSYOzXRyNnLEQVzCTZrnVKDg57
	 hGFzzdv3iKcejJXHfp6ufNkTfh9YHvwXKDinUmBQtwSpestFUXOfkLB+zEJZfjKE+Y
	 +UF9u8JBXvjUg==
Date: Sun, 17 Nov 2024 08:54:51 +0000
To: Chris Torek <chris.torek@gmail.com>
From: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What is the diff between a --soft and a blank reset
Message-ID: <82f3cj_ASv_HNkdAe-1doxp6Vii0saBTB2wYbcwCEC3vDJpiwXvN6a6Agw7qNhKsGpBD8EbDC2u4VipTDJNr19nYcVV4BqV4GgNG9ysr5y4=@proton.me>
In-Reply-To: <CAPx1GvfT1iNnpJ0Jv0vhdHrwD-pDOK81MnUW2-Fk_zcJkW9PUQ@mail.gmail.com>
References: <myxdTw4K7jcrlKX-HC0edNKB3mgkjGJPAejkxWTcab03uT9uROZlO28zjhmnogOvGCJkag5q_Zvbok0VUyVjlkw5Goz3Gwe3l636lCYnGic=@proton.me> <CAPx1GvfT1iNnpJ0Jv0vhdHrwD-pDOK81MnUW2-Fk_zcJkW9PUQ@mail.gmail.com>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 99dc3c41bf3431968df45444ec6ab5b477cb35c0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_Prg7GPwkHAiQ4pa8nSSBHy3RK7hWvprQW0ef2lbgI"

--b1=_Prg7GPwkHAiQ4pa8nSSBHy3RK7hWvprQW0ef2lbgI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

My reply to Chris.

On Sunday, November 17th, 2024 at 02:57, Chris Torek <chris.torek@gmail.com=
> wrote:

> * With `--mixed`, `git reset` adjusts `HEAD` as before --
> it's usually wisest to not have it adjust anything for
> this case, in my opinion -- and then goes on to copy the
> files from the `HEAD` commit into the index.=20

I didn't give any case: What are you talking about? It look's as though you=
 are pasting a custom manpage for git-reset based on keyword matching. Esse=
ntially spamming the mailing list based on a keyword match. Yet another man=
page being written by a thirdparty when having conflicting and scattered ja=
rgon makes it to where the user cannot communicate in a meaningful way abou=
t using the software. You vaguely show the difference (e.g. soft means job =
#1 and mixed means job #1 & #2) however not fully answering my pinpointed q=
uestion "Does this from --soft: "leaves all your changed files "Changes to =
be committed", as  git status would put it.'" mean soft leaves the adds ind=
exed but before the adds were commit and without commit whereas --mixed wou=
ld erase the index having adds ready to commit?" conscerning what the diffe=
rence means in pragma. We and you need to learn English or get off of maili=
ng lists: stop spamming. I say we because you are not alone.
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc5r1gJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAIesAQDkkFYk/snBkgshpusegy9iQB9bzbgPq0ErIwvIE0YYcAD+MGd5
Cb6hNTakaoa1GEM5/0kSLEqpuDWECaUefn8/ugU=3D
=3DK4lg
-----END PGP SIGNATURE-----

--b1=_Prg7GPwkHAiQ4pa8nSSBHy3RK7hWvprQW0ef2lbgI
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

--b1=_Prg7GPwkHAiQ4pa8nSSBHy3RK7hWvprQW0ef2lbgI
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmc5r1gJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAADLPAP4kZ8po
1i2Tuyww3FqX1EcQOOupsnThwmOCLs65EDiq2AD/aSJpssAee6SpQVeybdbnyu2Oj5pJQxoZVbSa
Zceatws=

--b1=_Prg7GPwkHAiQ4pa8nSSBHy3RK7hWvprQW0ef2lbgI--

