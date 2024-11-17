Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711F12C9D
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731809275; cv=none; b=R4JpiAUXEoKK4tipnry8tUJogO1pXWGevm30FArkMQFsSSlSyG32fs8kbrmu+3vCLsaiC+RSmlvjWilnMWHtujUTQSf/9LourUHerMt0rYClxeSWUwjXdh8772S4mCl86X/qvtoRCnJbspFd0FAbiuJR3EOx66h9CJNrf9/Nfl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731809275; c=relaxed/simple;
	bh=pQ6qMIFU1RHsM8wm5maoi6wFRKXbGy4EAhSpvKUoXM4=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=B97yZYqtVPREYQQYG479zGnzALiTPaYObLapcB2Okd3BDYEOhxUvftRbe7+hbwsBxWMiisLi82PgjxMLrhIr9rQAY1f0ELkei8aEWXncGWhCfCWefRJDTi0U8ej5tC1R8YssA51LIxkUdvHnyzcvwI0jvo3H7ulk1/FZV0RSejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DAy/cj6F; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DAy/cj6F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ahrxk32rt5dzvfoirpyliuwabe.protonmail; t=1731809265; x=1732068465;
	bh=xmSPrDpbd3VEBXR8jSUgBgdMwpKtq79yR8lhcNdSqvQ=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=DAy/cj6FjCOCqaBikysYluhpbzxT3/gyhshtTzSBTBcLfI83vUFVSye+rAtrtQZpf
	 Zy96hYoov3J4kguZtmYLAgLmLcQ81UV61yrPdmwzIed6WCpLQRNxVNmsnRpkTmnhMp
	 mRTPQMjrH9/s7ZiP0QfZquWCASssSoDbwZttVcwqx7KndamyV7XSm6hGAk5NrKvihJ
	 fHeEn7NWdHKERLV1BVbc4tOKNsXkecruzsBwfCKCar6NlV/bkvvECNmzGckIq8Qmth
	 /Rpw9GJ9cFemQ0XHt7D7ySBQ55fWD/eiESkrpoOR1KZAyTUTI69sCwgLHbUmx09QrO
	 onT+/oeAOO7/g==
Date: Sun, 17 Nov 2024 02:07:42 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: What is the diff between a --soft and a blank reset
Message-ID: <myxdTw4K7jcrlKX-HC0edNKB3mgkjGJPAejkxWTcab03uT9uROZlO28zjhmnogOvGCJkag5q_Zvbok0VUyVjlkw5Goz3Gwe3l636lCYnGic=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: b01787dc34015317ca6f63b16e42be5377dc07d6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_j4M2oaNvtj9DAUSQE5k5ymr83NlpWarPkh57sHsH9aE"

--b1=_j4M2oaNvtj9DAUSQE5k5ymr83NlpWarPkh57sHsH9aE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

What is the diff between a --soft and a blank which is --mixed reset? Does =
this from --soft: "leaves all your changed files "Changes to be committed",=
 as  git status would put it.'" mean soft leaves the adds indexed but befor=
e the adds were commit and without commit whereas --mixed would erase the i=
ndex having adds ready to commit? This is how I gather it however the manpa=
ge hint's at being written by a thirdparty and having conflicting and scatt=
ered jargon makes it to where the user cannot communicate in a meaningful w=
ay about using the software. The difference here is touching the index but =
what does that mean in pragma: what does a git repo index handle? Isn't the=
re some better way to find answers rather than Google advertisements or IRC=
 wrong answers.  See the snippet from the manpage below:

git reset [<mode>] [<commit>]
           This form resets the current branch head to <commit> and possibl=
y
           updates the index (resetting it to the tree of <commit>) and the
           working tree depending on <mode>. Before the operation, ORIG_HEA=
D
           is set to the tip of the current branch. If <mode> is omitted,
           defaults to --mixed. The <mode> must be one of the following:

           --soft
               Does not touch the index file or the working tree at all (bu=
t
               resets the head to <commit>, just like all modes do). This
               leaves all your changed files "Changes to be committed", as
               git status would put it.

           --mixed
               Resets the index but not the working tree (i.e., the changed
               files are preserved but not marked for commit) and reports
               what has not been updated. This is the default action.

               If -N is specified, removed paths are marked as intent-to-ad=
d
               (see git-add(1)).



from A_bughunter@proton.me

Sent with Proton Mail secure email.
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc5T+sJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAKvTAQCQIJGVcxvf7jSYvcPMUyeF15FriACM1QzPX2pyn++bxwEAxuK2
c5qmTxALcRE4OKHk8UkP2S0gHqnos75thGKMwAI=3D
=3DIlx7
-----END PGP SIGNATURE-----

--b1=_j4M2oaNvtj9DAUSQE5k5ymr83NlpWarPkh57sHsH9aE
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

--b1=_j4M2oaNvtj9DAUSQE5k5ymr83NlpWarPkh57sHsH9aE
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnQEABYKACcFgmc5T+sJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAA8nAQDIOkbw
T+MSuRF6AqRwiDIl0w1wmLOtczXS4vsw+wScawD3W4tOo12Xo5jV+IUJtUX5EwhU3hrex+ZFp3yF
VzqPAA==

--b1=_j4M2oaNvtj9DAUSQE5k5ymr83NlpWarPkh57sHsH9aE--

