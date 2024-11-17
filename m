Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85CB1DA60D
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731879173; cv=none; b=WNVnmLbILTeCpZEDNiz/WvQWDSeh/WSqLum3/mPw1RkPyZdu8m+hscTwke2C8BHUZXGpaqIu4pVxTHXnAZUESLFaWhWRrImxuSF7UsVyUNxtVRz/acM++OpUShCnLT2GBCJzzAf+UiDKJh8t3tbvFSuSSo3sZ5vpcmiN2vun3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731879173; c=relaxed/simple;
	bh=yoRh0S3Zzo3riQsDPoI7628F2VEk/+LkmrhB135dlhk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8mjbx36gPw6w4OmhjVs22e0jtIYn4Axp7NsS+siueeidTAJxuh8bzkBUYaYVueddVUzNcJa/hkav0KuZhyik0q169tjl/KpWY6qwnlEscaQMTaljfJOHNoDGMmjlD9k61RjxX5H10MF4cLcD3SacKXyh4eo6WzNXRLDUSZBJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DCTAGMm6; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DCTAGMm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1731879165; x=1732138365;
	bh=wQ5ZnUakPPQ7jYJwtIyiVyuBrNtFoVuTQpnFp7gNNbc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=DCTAGMm61SQfMc0FqblZ/i7ZloUDhXcPp+8q5oOZc5Tjmdk9XRFH6He7pj9uobZeU
	 keaWlcaWS3jFVDaM1HmEdDT/Ehk7baOK3WcnNZn5NQX1ZnAV8+x63L7JVSEGabgJ1D
	 F6pvVOkqGUYe9nwk9Qk5AvMxeCNQIDx454g5C2d3T7DQ7v9sy19U7qTI4OTK6K3fyu
	 ffhmozoDLf9KVTaHwV5n7HfDozgj9ITng2X7DC8gImg2VwQYnfzOMv8dMt2bltdD7y
	 0o2b5a7YyMjmT9WUDZvpQYBF8gY19Tb4625zwkyrsEcIByt1Mz2xbSpANhbbrd8B48
	 umLBUyfPKtijA==
Date: Sun, 17 Nov 2024 21:32:43 +0000
To: phillip.wood@dunelm.org.uk
From: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, Chris Torek <chris.torek@gmail.com>
Subject: Re: What is the diff between a --soft and a blank reset
Message-ID: <xDO5bMcFOIbJ5FhdpoxteVDBBjf5xXcVxQ5HboXdp-l_JojbIZ5gKERafNA0DdIFubVEupPQ3NqyoovEgsFJannL8A-9WqpzJIq-5sC0chI=@proton.me>
In-Reply-To: <5f401732-9b3d-4c45-88a8-a9e3d9d14fd9@gmail.com>
References: <myxdTw4K7jcrlKX-HC0edNKB3mgkjGJPAejkxWTcab03uT9uROZlO28zjhmnogOvGCJkag5q_Zvbok0VUyVjlkw5Goz3Gwe3l636lCYnGic=@proton.me> <CAPx1GvfT1iNnpJ0Jv0vhdHrwD-pDOK81MnUW2-Fk_zcJkW9PUQ@mail.gmail.com> <82f3cj_ASv_HNkdAe-1doxp6Vii0saBTB2wYbcwCEC3vDJpiwXvN6a6Agw7qNhKsGpBD8EbDC2u4VipTDJNr19nYcVV4BqV4GgNG9ysr5y4=@proton.me> <5f401732-9b3d-4c45-88a8-a9e3d9d14fd9@gmail.com>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 14963f460cd3f07e94f64cd7aaf2e1f6b2d685c0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_2Kid3zYH5MAa6sxOFjLBR47dHzcb70smIuayNbvpF4"

--b1=_2Kid3zYH5MAa6sxOFjLBR47dHzcb70smIuayNbvpF4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

My reply to Phillip, Chris, and ML.

My pinpointed question "Does this from --soft: "leaves all your changed fil=
es "Changes to be committed", as  git status would put it.'" mean soft leav=
es the adds indexed but before the adds were commit and without commit wher=
eas --mixed would erase the index having adds ready to commit?" conscerning=
 what the difference means in pragma.

Phillip, I stated that my question is pinpointed. I will repaste the questi=
on above for the ML to focus on. I will admit that it is a complex sentence=
 and complex problems may need to be described in complex ways.           I=
 used the word ADD this is the word the software uses to add (or track) the=
 file. When talking about git software the terms git has applied to the act=
ions of it are authoritive. An ADD is not the change itself but the trackin=
g.=20
 The manpage terms the soft, mixed, and hard : modes. A mode of git-reset.
 Further the official Docs page uses this as a reference https://ndpsoftwar=
e.com/git-cheatsheet.html this visual should be accurate as it comes from t=
he OFFICIAL source.





from A_bughunter@proton.me

Sent with Proton Mail secure email.

On Sunday, November 17th, 2024 at 15:21, Phillip Wood <phillip.wood123@gmai=
l.com> wrote:

> On 17/11/2024 08:54, A bughunter wrote:
>=20
> > My reply to Chris.
>=20

Stopping spam is constructive. Usually with rule-books like that everybody =
else normatively violates higher points and then uses a lower point in the =
code to attack another or initiates a violation and then cites following de=
fensive retorts (self-defence) to be violating while ignoring the agressive=
 initiator. As such reading them is not worth my time:  only a tease of wha=
t would be nice if you guys followed the code of conduct.=20
> Messages on this list are expected to be constructive and respectful to
> others. I strongly recommend that you read the code of conduct [1] and
> urge you to remember to be constructive and give others the benefit of
> the doubt when posting here in the future. If you are using an LLM or
> translation tool then I would suggest that you try a different one and
> get someone to check your message before sending it.
>=20
> [1] https://github.com/git/git/blob/master/CODE_OF_CONDUCT.md
>=20
> > On Sunday, November 17th, 2024 at 02:57, Chris Torek chris.torek@gmail.=
com wrote:
> >=20
> > > * With `--mixed`, `git reset` adjusts `HEAD` as before --
> > > it's usually wisest to not have it adjust anything for
> > > this case, in my opinion -- and then goes on to copy the
> > > files from the `HEAD` commit into the index.
> >=20
> > I didn't give any case: What are you talking about?
>=20
>=20
The docs call this mode. Ask yourself: Why would you call it something else=
? Doing so creates confusion. Also if everything you say is written with am=
biguity sure anybody can apply their own meanings. A snippet from the manpa=
ge showing "modes" from man git-reset follows:

git reset [<mode>] [<commit>]
       This form resets the current branch head to <commit> and
       possibly updates the index (resetting it to the tree of
       <commit>) and the working tree depending on <mode>.
       Before the operation, ORIG_HEAD is set to the tip of the
       current branch. If <mode> is omitted, defaults to               --mi=
xed. The <mode> must be one of the following:

> I think you have misunderstood what Chris was saying. My reading of this
> is that he is taking about the general case of a user running "git reset
> --mixed".
>=20
> > It look's as though you are pasting a custom manpage for git-reset
>=20
> > based on keyword matching. Essentially spamming the mailing list
>=20
> > based on a keyword match.
>=20

Spam is not help. Taking the time to rephrase entire manpages when given a =
pinpointed question is spam. Or rephrasing introductory tutorials of which =
I already have not answering the question. I obviously already have the man=
pages and it does not explain, it is not clear therefore rephrasing it with=
 lax words does nothing to help but only add's confusion: having conflictin=
g and scattered jargon makes it to where the user cannot communicate in a m=
eaningful way about using the software.
> Please remember that the person you are replying to is trying to help
> and has given up their time to do so. I think that rather than copy and
> pasting a manpage Chris has taken the time to write some bullet points
> to try and explain the different reset modes.
>=20
> > Yet another manpage being written by a thirdparty when having
>=20
> > conflicting and scattered jargon makes it to where the user cannot
>=20
> > communicate in a meaningful way about using the software.
>=20

I agree the terms must be grasped. In order to do so you must write compete=
nt English. You would be able to take a visual yet have all of the informat=
ion in correct English. To the good credit of Chris he appears to have made=
 a small step towards describing this visual ( https://ndpsoftware.com/git-=
cheatsheet.html ) in English. However what Chris did good is not enough to =
answer my question. (Or break the curse of what Chris admit's to be poor in=
struction)
> Whether you like it or not understanding terms like "the index" and
> "HEAD" is necessary if you're going to be able to communicate clearly
> with others about git. I cannot see any non-standard terminology in
> Chris' reply.
>=20
> > You vaguely show the difference (e.g. soft means job #1 and mixed
>=20
> > means job #1 & #2) however not fully answering my pinpointed question
>=20
> > "Does this from --soft: "leaves all your changed files "Changes to be
>=20
> > committed", as git status would put it.'"
>=20
>=20
> "git status" lists the files that differ between the worktree and the
> index as "Changes not staged for commit" and those that differ between
> the index and HEAD as "Changes to be committed". As "git reset --soft"
> changes HEAD but not the index then it may change the list of "Changes
> to be committed" because HEAD has changed, but the content of those
> files in the index is not changed. It will not change the list of
> "Changes not staged for commit" because the index is unchanged. As "git
> reset --mixed" changes both HEAD and the index then it may change both
> lists show by "git status".
>=20
> > mean soft leaves the adds indexed but
>=20
> > before the adds were commit and without commit whereas --mixed would
>=20
> > erase the index having adds ready to commit?" conscerning what the
>=20
> > difference means in pragma. We and you need to learn English or get>
>=20
> > off of mailing lists: stop spamming. I say we because you are not
>=20
> > alone.
>=20
>=20

I disagree: speaking and writing English is a prerequisite for communicatin=
g on any ML.
> Telling someone that they need to learn English or get off the mailing
> list is completely unacceptable.
>=20
> Best Wishes
>=20
> Phillip
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc6YPgJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAJmIAP4wl4TnJFVLNlfOdBwd42oilKLueb9+AP4UaYxJl98pZwD8C6+2
GVtF9HFuKdJpn1/rOUPO5sQ93vdr6x6YJQcKswU=3D
=3DMzyb
-----END PGP SIGNATURE-----

--b1=_2Kid3zYH5MAa6sxOFjLBR47dHzcb70smIuayNbvpF4
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

--b1=_2Kid3zYH5MAa6sxOFjLBR47dHzcb70smIuayNbvpF4
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmc6YPgJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAEP0APwK/SZo
eA5E0ySCYkG+uSgAv8n00DEzbuBAX6KcdvjSIgEA+7+CIOyN4FmED4CWUkyARx0xJk5tRwfZDWCO
uFov4g8=

--b1=_2Kid3zYH5MAa6sxOFjLBR47dHzcb70smIuayNbvpF4--

