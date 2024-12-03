Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8901FA82C
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246993; cv=none; b=Lp5Kv1x2Wjljbgn22h2YBrYhwiQ5QxHaG5NsE+F/bEltWQy5XpuSgv4z2ErN1lNizldeqNBm1Vg0xvlWmQgCjG3DSB8w4y9FSMn7zxf204fLYQye8/wYY8YRL/jZXv8AAbCy6ENucu2RTvVc7oCV2Hdo8w9oXZjZlEcaHGelWfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246993; c=relaxed/simple;
	bh=QenBU9lqNr2ryqP+asa06IFjd+P6C9nr2naW8nDDT/o=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=sChNQ3FUuCLxfh/rnoW1oeZlylghRWJVKFls3xjxaMd+F/RhXInbL3MN3IN9BYdMB9OpfzxEVwgRPwwrhbPGYtid9f4gQkk2Cu91rmtKOl6zQk5uD8vePtZo/ebDvQQjLB6utl++xW0j9E20UEah3d/k4NJfpvCXWxX3G4P+qbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hl0QMivw; arc=none smtp.client-ip=185.70.40.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hl0QMivw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1733246989; x=1733506189;
	bh=QenBU9lqNr2ryqP+asa06IFjd+P6C9nr2naW8nDDT/o=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=hl0QMivwCzPDjvltp/bBtESADk7R9Ex8tTLtyWykovYM0MtNs11t92+7mTuiaDiKV
	 qeE5C8zK3atoPSWBpxlEC+AAbW1H3fk6RSTEpVnFA+3aQOe2kyi6i+ZMD+7H0eoIba
	 PAEBi3SDZ3cQ8GrLhUbZh/UR7N5l7DfE4nwNyt1iTVIHMFxgLNSz6MDZMJfaIGsBno
	 nxdwG3iESJnmQQImUCtCLL0yUaOXT2RE8r1hrgoHEqRY/mJ5H54E3I+nVA3VcTlNps
	 fE4KWsmCs7SVFO3v6h3GQE0vXtsBu5UcwpaIorstOr/HT8PhuGoZ2XMREWMneVL+LE
	 T7vd5Z/nWObVw==
Date: Tue, 03 Dec 2024 17:29:46 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Josh Brunton <josh.brunton@proton.me>
Subject: [RFC] Proposal to add a delimiter between unrelated history in git-log --graph --oneline
Message-ID: <FNUesYPDfyA16MXr4g9q7vW9OQ6bfbUK1umvVjONQNgEsQJZV5sIvRX9MlHfRILe4-hhINNy59uNjywL4abyJT43JVYjXU0ofUGWKQo0lFA=@proton.me>
Feedback-ID: 54578323:user:proton
X-Pm-Message-ID: a5aefac3b37a1cce02f96f9db615705fc9f3a601
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------e832ccca562ff1a09995fbad4204a5b9cd33b6fcf35c3300c6a921d8c1a3a9df"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------e832ccca562ff1a09995fbad4204a5b9cd33b6fcf35c3300c6a921d8c1a3a9df
Content-Type: multipart/mixed;boundary=---------------------4897172b8656d49eb5eced9e3fc0ac3c

-----------------------4897172b8656d49eb5eced9e3fc0ac3c
Content-Type: multipart/alternative;boundary=---------------------1b3b2a5129c1b0fbedc66c85ea2aa706

-----------------------1b3b2a5129c1b0fbedc66c85ea2aa706
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Though a relatively rare occurrence, I sometimes find myself working withr=
epositories that contain 2 un-merged, unrelated histories. In doing so, I'=
ve often found
myself confused or mistaken due to the way "git-log --oneline --graph" han=
dles
unrelated histories: by presenting them as if they were one continuous str=
ing of
commits.

To create an example of how git-log --oneline --graph presents unmerged
unrelated histories, let us use the following minimal reproducible example=
.

In ~/repos/git-history-1:
* dec7d4c (HEAD -> main, origin/main) History 1 - Add README.md
* 3f25318 History 1 - Add gitignore

In ~/repos/git-history-2:
* (HEAD -> main2, origin/main2) e5698bf History 2 - Add SECURITY.md
* 7260dff History 2 - Add .gitattributes

If both are pushed to ~/git-history-origin, that repo's log (git-log --gra=
ph)
looks like:
[...]
| =C2=A0 =C2=A0 Add SECURITY.md
|
* commit 7260dff47ffb6233b5f7ccfd62a1be29047d813d
=C2=A0 Author: Josh Brunton <josh.brunton@proton.me>
=C2=A0 Date: =C2=A0 Tue Dec 3 09:57:43 2024 +0000

=C2=A0 =C2=A0 =C2=A0 Add .gitattributes

* commit dec7d4cab044e37dd340b487a4d1d8b8b0cac867 (HEAD -> main)
| Author: Josh Brunton <josh.brunton@proton.me>
| Date: =C2=A0 Tue Dec 3 09:55:50 2024 +0000
[...]

There is a clear disconnect between commits dec7d4c 7260dff, showing that
they represent 2 unrelated histories. However, passing --oneline as well p=
roduces
the following output:
* e5698bf (main2) History 2 - Add SECURITY.md
* 7260dff History 2 - Add .gitattributes
* dec7d4c (HEAD -> main) History 1 - Add README.md
* 3f25318 History 1 - Add gitignore

With this graph, one might be forgiven for the assumption that dec7d4c is =
the
parent of 7260dff, as it would be visually indistinguishable if that were =
the case
and is far more likely than having 2 unmerged, unrelated histories. This c=
an lead
to some confusion and/or bad assumptions about the history.

It is not until we merge the 2 histories that git log --oneline --graph sh=
ows
any indication at all that those histories were unrelated:
* =C2=A0 15177d2 (HEAD -> main) Merge branch 'main2'
|\
| * e5698bf (main2) History 2 - Add SECURITY.md
| * 7260dff History 2 - Add .gitattributes
* dec7d4c History 1 - Add README.md
* 3f25318 History 1 - Add gitignore

I therefore suggest that a separator line (perhaps a blank line) might be
added between unrelated histories which would otherwise seem related in --=
oneline
--graph. In other words, the separator should appear between any 2 consecu=
tive lines
where * appears in the same column, where the above line's commit has no p=
arent(s).
I believe unrelated histories are clearly represented in other cases.

I have considered that doing so may require that each commit in the log wo=
uld
have to undergo an additional check to see if it has any ancestors. Though=
 I am
not knowledgeable on how resource-heavy this operation would be, I am wary=
 that
it may pose a significant performance impact. Thus, I suggest that this fe=
ature
might be opt-in via a config setting named along the lines of
log.delimitUnrelatedHistories.

In implementing this proposal, the above unrelated histories would become:
* e5698bf (main2) History 2 - Add SECURITY.md
* 7260dff History 2 - Add .gitattributes

* dec7d4c (HEAD -> main) History 1 - Add README.md
* 3f25318 History 1 - Add gitignore

While if some other factor were to create the same effect of clarifying th=
at
the histories are unrelated, the output would remain unchanged:
* e5698bf (main2) History 2 - Add SECURITY.md
| * 3c3cade (branch3) Add CODEOWNERS
* | 7260dff History 2 - Add .gitattributes
=C2=A0 |
* / dec7d4c (HEAD -> main) History 1 - Add README.md
|/
* 3f25318 History 1 - Add gitignore

Depending on approval here, I am prepared to attempt to implement this
feature myself, though would appreciate input from those more knowledgeabl=
e about the
git codebase and experienced with contributing.
-----------------------1b3b2a5129c1b0fbedc66c85ea2aa706
Content-Type: multipart/related;boundary=---------------------3c7f2489a6723c7cce6f4f9b90c80cf3

-----------------------3c7f2489a6723c7cce6f4f9b90c80cf3
Content-Type: text/html;charset=utf-8
Content-Transfer-Encoding: base64

PHNwYW4+VGhvdWdoIGEgcmVsYXRpdmVseSByYXJlIG9jY3VycmVuY2UsIEkgc29tZXRpbWVzIGZp
bmQgbXlzZWxmIHdvcmtpbmcgd2l0aDwvc3Bhbj48ZGl2PjxzcGFuPnJlcG9zaXRvcmllcyB0aGF0
IGNvbnRhaW4gMiB1bi1tZXJnZWQsIHVucmVsYXRlZCBoaXN0b3JpZXMuIEluIGRvaW5nIHNvLCBJ
J3ZlIG9mdGVuIGZvdW5kPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+bXlzZWxmIGNvbmZ1c2VkIG9y
IG1pc3Rha2VuIGR1ZSB0byB0aGUgd2F5ICJnaXQtbG9nIC0tb25lbGluZSAtLWdyYXBoIiBoYW5k
bGVzPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+dW5yZWxhdGVkIGhpc3RvcmllczogYnkgcHJlc2Vu
dGluZyB0aGVtIGFzIGlmIHRoZXkgd2VyZSBvbmUgY29udGludW91cyBzdHJpbmcgb2Y8L3NwYW4+
PC9kaXY+PGRpdj48c3Bhbj5jb21taXRzLjwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PjxzcGFuPlRvIGNyZWF0ZSBhbiBleGFtcGxlIG9mIGhvdyBnaXQtbG9nIC0tb25lbGluZSAtLWdy
YXBoIHByZXNlbnRzIHVubWVyZ2VkPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+dW5yZWxhdGVkIGhp
c3RvcmllcywgbGV0IHVzIHVzZSB0aGUgZm9sbG93aW5nIG1pbmltYWwgcmVwcm9kdWNpYmxlIGV4
YW1wbGUuPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+SW4gfi9yZXBvcy9n
aXQtaGlzdG9yeS0xOjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiogZGVjN2Q0YyAoSEVBRCAtJmd0
OyBtYWluLCBvcmlnaW4vbWFpbikgSGlzdG9yeSAxIC0gQWRkIDxhIHRhcmdldD0iX2JsYW5rIiBy
ZWw9Im5vcmVmZXJyZXIgbm9mb2xsb3cgbm9vcGVuZXIiIGhyZWY9Imh0dHA6Ly9SRUFETUUubWQi
PlJFQURNRS5tZDwvYT48L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4qIDNmMjUzMTggSGlzdG9yeSAx
IC0gQWRkIGdpdGlnbm9yZTwvc3Bhbj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFuPklu
IH4vcmVwb3MvZ2l0LWhpc3RvcnktMjo8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4qIChIRUFEIC0m
Z3Q7IG1haW4yLCBvcmlnaW4vbWFpbjIpIGU1Njk4YmYgSGlzdG9yeSAyIC0gQWRkIDxhIHRhcmdl
dD0iX2JsYW5rIiByZWw9Im5vcmVmZXJyZXIgbm9mb2xsb3cgbm9vcGVuZXIiIGhyZWY9Imh0dHA6
Ly9TRUNVUklUWS5tZCI+U0VDVVJJVFkubWQ8L2E+PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+KiA3
MjYwZGZmIEhpc3RvcnkgMiAtIEFkZCAuZ2l0YXR0cmlidXRlczwvc3Bhbj48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PjxzcGFuPklmIGJvdGggYXJlIHB1c2hlZCB0byB+L2dpdC1oaXN0b3J5LW9y
aWdpbiwgdGhhdCByZXBvJ3MgbG9nIChnaXQtbG9nIC0tZ3JhcGgpPC9zcGFuPjwvZGl2PjxkaXY+
PHNwYW4+bG9va3MgbGlrZTo8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5bLi4uXTwvc3Bhbj48L2Rp
dj48ZGl2PjxzcGFuPnwgJm5ic3A7ICZuYnNwOyBBZGQgPGEgdGFyZ2V0PSJfYmxhbmsiIHJlbD0i
bm9yZWZlcnJlciBub2ZvbGxvdyBub29wZW5lciIgaHJlZj0iaHR0cDovL1NFQ1VSSVRZLm1kIj5T
RUNVUklUWS5tZDwvYT48L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj58PC9zcGFuPjwvZGl2PjxkaXY+
PHNwYW4+KiBjb21taXQgNzI2MGRmZjQ3ZmZiNjIzM2I1ZjdjY2ZkNjJhMWJlMjkwNDdkODEzZDwv
c3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyBBdXRob3I6IEpvc2ggQnJ1bnRvbiAmbHQ7PGEg
dGFyZ2V0PSJfYmxhbmsiIHJlbD0ibm9yZWZlcnJlciBub2ZvbGxvdyBub29wZW5lciIgaHJlZj0i
bWFpbHRvOmpvc2guYnJ1bnRvbkBwcm90b24ubWUiPmpvc2guYnJ1bnRvbkBwcm90b24ubWU8L2E+
Jmd0Ozwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiZuYnNwOyBEYXRlOiAmbmJzcDsgVHVlIERlYyAz
IDA5OjU3OjQzIDIwMjQgKzAwMDA8L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bh
bj4mbmJzcDsgJm5ic3A7ICZuYnNwOyBBZGQgLmdpdGF0dHJpYnV0ZXM8L3NwYW4+PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj48c3Bhbj4qIGNvbW1pdCBkZWM3ZDRjYWIwNDRlMzdkZDM0MGI0ODdh
NGQxZDhiOGIwY2FjODY3IChIRUFEIC0mZ3Q7IG1haW4pPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+
fCBBdXRob3I6IEpvc2ggQnJ1bnRvbiAmbHQ7PGEgdGFyZ2V0PSJfYmxhbmsiIHJlbD0ibm9yZWZl
cnJlciBub2ZvbGxvdyBub29wZW5lciIgaHJlZj0ibWFpbHRvOmpvc2guYnJ1bnRvbkBwcm90b24u
bWUiPmpvc2guYnJ1bnRvbkBwcm90b24ubWU8L2E+Jmd0Ozwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFu
PnwgRGF0ZTogJm5ic3A7IFR1ZSBEZWMgMyAwOTo1NTo1MCAyMDI0ICswMDAwPC9zcGFuPjwvZGl2
PjxkaXY+PHNwYW4+Wy4uLl08L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj5U
aGVyZSBpcyBhIGNsZWFyIGRpc2Nvbm5lY3QgYmV0d2VlbiBjb21taXRzIGRlYzdkNGMgNzI2MGRm
Ziwgc2hvd2luZyB0aGF0PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+dGhleSByZXByZXNlbnQgMiB1
bnJlbGF0ZWQgaGlzdG9yaWVzLiBIb3dldmVyLCBwYXNzaW5nIC0tb25lbGluZSBhcyB3ZWxsIHBy
b2R1Y2VzPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+dGhlIGZvbGxvd2luZyBvdXRwdXQ6PC9zcGFu
PjwvZGl2PjxkaXY+PHNwYW4+KiBlNTY5OGJmIChtYWluMikgSGlzdG9yeSAyIC0gQWRkIDxhIHRh
cmdldD0iX2JsYW5rIiByZWw9Im5vcmVmZXJyZXIgbm9mb2xsb3cgbm9vcGVuZXIiIGhyZWY9Imh0
dHA6Ly9TRUNVUklUWS5tZCI+U0VDVVJJVFkubWQ8L2E+PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+
KiA3MjYwZGZmIEhpc3RvcnkgMiAtIEFkZCAuZ2l0YXR0cmlidXRlczwvc3Bhbj48L2Rpdj48ZGl2
PjxzcGFuPiogZGVjN2Q0YyAoSEVBRCAtJmd0OyBtYWluKSBIaXN0b3J5IDEgLSBBZGQgPGEgdGFy
Z2V0PSJfYmxhbmsiIHJlbD0ibm9yZWZlcnJlciBub2ZvbGxvdyBub29wZW5lciIgaHJlZj0iaHR0
cDovL1JFQURNRS5tZCI+UkVBRE1FLm1kPC9hPjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiogM2Yy
NTMxOCBIaXN0b3J5IDEgLSBBZGQgZ2l0aWdub3JlPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+PHNwYW4+V2l0aCB0aGlzIGdyYXBoLCBvbmUgbWlnaHQgYmUgZm9yZ2l2ZW4gZm9yIHRo
ZSBhc3N1bXB0aW9uIHRoYXQgZGVjN2Q0YyBpcyB0aGU8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5w
YXJlbnQgb2YgNzI2MGRmZiwgYXMgaXQgd291bGQgYmUgdmlzdWFsbHkgaW5kaXN0aW5ndWlzaGFi
bGUgaWYgdGhhdCB3ZXJlIHRoZSBjYXNlPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+YW5kIGlzIGZh
ciBtb3JlIGxpa2VseSB0aGFuIGhhdmluZyAyIHVubWVyZ2VkLCB1bnJlbGF0ZWQgaGlzdG9yaWVz
LiBUaGlzIGNhbiBsZWFkPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+dG8gc29tZSBjb25mdXNpb24g
YW5kL29yIGJhZCBhc3N1bXB0aW9ucyBhYm91dCB0aGUgaGlzdG9yeS48L3NwYW4+PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj48c3Bhbj5JdCBpcyBub3QgdW50aWwgd2UgbWVyZ2UgdGhlIDIgaGlz
dG9yaWVzIHRoYXQgZ2l0IGxvZyAtLW9uZWxpbmUgLS1ncmFwaCBzaG93czwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuPmFueSBpbmRpY2F0aW9uIGF0IGFsbCB0aGF0IHRob3NlIGhpc3RvcmllcyB3ZXJl
IHVucmVsYXRlZDo8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4qICZuYnNwOyAxNTE3N2QyIChIRUFE
IC0mZ3Q7IG1haW4pIE1lcmdlIGJyYW5jaCAnbWFpbjInPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+
fFw8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj58ICogZTU2OThiZiAobWFpbjIpIEhpc3RvcnkgMiAt
IEFkZCA8YSB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVyIG5vZm9sbG93IG5vb3BlbmVy
IiBocmVmPSJodHRwOi8vU0VDVVJJVFkubWQiPlNFQ1VSSVRZLm1kPC9hPjwvc3Bhbj48L2Rpdj48
ZGl2PjxzcGFuPnwgKiA3MjYwZGZmIEhpc3RvcnkgMiAtIEFkZCAuZ2l0YXR0cmlidXRlczwvc3Bh
bj48L2Rpdj48ZGl2PjxzcGFuPiogZGVjN2Q0YyBIaXN0b3J5IDEgLSBBZGQgPGEgdGFyZ2V0PSJf
YmxhbmsiIHJlbD0ibm9yZWZlcnJlciBub2ZvbGxvdyBub29wZW5lciIgaHJlZj0iaHR0cDovL1JF
QURNRS5tZCI+UkVBRE1FLm1kPC9hPjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPiogM2YyNTMxOCBI
aXN0b3J5IDEgLSBBZGQgZ2l0aWdub3JlPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
PHNwYW4+SSB0aGVyZWZvcmUgc3VnZ2VzdCB0aGF0IGEgc2VwYXJhdG9yIGxpbmUgKHBlcmhhcHMg
YSBibGFuayBsaW5lKSBtaWdodCBiZTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPmFkZGVkIGJldHdl
ZW4gdW5yZWxhdGVkIGhpc3RvcmllcyB3aGljaCB3b3VsZCBvdGhlcndpc2Ugc2VlbSByZWxhdGVk
IGluIC0tb25lbGluZTwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPi0tZ3JhcGguIEluIG90aGVyIHdv
cmRzLCB0aGUgc2VwYXJhdG9yIHNob3VsZCBhcHBlYXIgYmV0d2VlbiBhbnkgMiBjb25zZWN1dGl2
ZSBsaW5lczwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPndoZXJlICogYXBwZWFycyBpbiB0aGUgc2Ft
ZSBjb2x1bW4sIHdoZXJlIHRoZSBhYm92ZSBsaW5lJ3MgY29tbWl0IGhhcyBubyBwYXJlbnQocyku
PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+SSBiZWxpZXZlIHVucmVsYXRlZCBoaXN0b3JpZXMgYXJl
IGNsZWFybHkgcmVwcmVzZW50ZWQgaW4gb3RoZXIgY2FzZXMuPC9zcGFuPjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+PHNwYW4+SSBoYXZlIGNvbnNpZGVyZWQgdGhhdCBkb2luZyBzbyBtYXkgcmVx
dWlyZSB0aGF0IGVhY2ggY29tbWl0IGluIHRoZSBsb2cgd291bGQ8L3NwYW4+PC9kaXY+PGRpdj48
c3Bhbj5oYXZlIHRvIHVuZGVyZ28gYW4gYWRkaXRpb25hbCBjaGVjayB0byBzZWUgaWYgaXQgaGFz
IGFueSBhbmNlc3RvcnMuIFRob3VnaCBJIGFtPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+bm90IGtu
b3dsZWRnZWFibGUgb24gaG93IHJlc291cmNlLWhlYXZ5IHRoaXMgb3BlcmF0aW9uIHdvdWxkIGJl
LCBJIGFtIHdhcnkgdGhhdDwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPml0IG1heSBwb3NlIGEgc2ln
bmlmaWNhbnQgcGVyZm9ybWFuY2UgaW1wYWN0LiBUaHVzLCBJIHN1Z2dlc3QgdGhhdCB0aGlzIGZl
YXR1cmU8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj5taWdodCBiZSBvcHQtaW4gdmlhIGEgY29uZmln
IHNldHRpbmcgbmFtZWQgYWxvbmcgdGhlIGxpbmVzIG9mPC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+
bG9nLmRlbGltaXRVbnJlbGF0ZWRIaXN0b3JpZXMuPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+PHNwYW4+SW4gaW1wbGVtZW50aW5nIHRoaXMgcHJvcG9zYWwsIHRoZSBhYm92ZSB1bnJl
bGF0ZWQgaGlzdG9yaWVzIHdvdWxkIGJlY29tZTo8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4qIGU1
Njk4YmYgKG1haW4yKSBIaXN0b3J5IDIgLSBBZGQgPGEgdGFyZ2V0PSJfYmxhbmsiIHJlbD0ibm9y
ZWZlcnJlciBub2ZvbGxvdyBub29wZW5lciIgaHJlZj0iaHR0cDovL1NFQ1VSSVRZLm1kIj5TRUNV
UklUWS5tZDwvYT48L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4qIDcyNjBkZmYgSGlzdG9yeSAyIC0g
QWRkIC5naXRhdHRyaWJ1dGVzPC9zcGFuPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+
KiBkZWM3ZDRjIChIRUFEIC0mZ3Q7IG1haW4pIEhpc3RvcnkgMSAtIEFkZCA8YSB0YXJnZXQ9Il9i
bGFuayIgcmVsPSJub3JlZmVycmVyIG5vZm9sbG93IG5vb3BlbmVyIiBocmVmPSJodHRwOi8vUkVB
RE1FLm1kIj5SRUFETUUubWQ8L2E+PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+KiAzZjI1MzE4IEhp
c3RvcnkgMSAtIEFkZCBnaXRpZ25vcmU8L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48
c3Bhbj5XaGlsZSBpZiBzb21lIG90aGVyIGZhY3RvciB3ZXJlIHRvIGNyZWF0ZSB0aGUgc2FtZSBl
ZmZlY3Qgb2YgY2xhcmlmeWluZyB0aGF0PC9zcGFuPjwvZGl2PjxkaXY+PHNwYW4+dGhlIGhpc3Rv
cmllcyBhcmUgdW5yZWxhdGVkLCB0aGUgb3V0cHV0IHdvdWxkIHJlbWFpbiB1bmNoYW5nZWQ6PC9z
cGFuPjwvZGl2PjxkaXY+PHNwYW4+KiBlNTY5OGJmIChtYWluMikgSGlzdG9yeSAyIC0gQWRkIDxh
IHRhcmdldD0iX2JsYW5rIiByZWw9Im5vcmVmZXJyZXIgbm9mb2xsb3cgbm9vcGVuZXIiIGhyZWY9
Imh0dHA6Ly9TRUNVUklUWS5tZCI+U0VDVVJJVFkubWQ8L2E+PC9zcGFuPjwvZGl2PjxkaXY+PHNw
YW4+fCAqIDNjM2NhZGUgKGJyYW5jaDMpIEFkZCBDT0RFT1dORVJTPC9zcGFuPjwvZGl2PjxkaXY+
PHNwYW4+KiB8IDcyNjBkZmYgSGlzdG9yeSAyIC0gQWRkIC5naXRhdHRyaWJ1dGVzPC9zcGFuPjwv
ZGl2PjxkaXY+PHNwYW4+Jm5ic3A7IHw8L3NwYW4+PC9kaXY+PGRpdj48c3Bhbj4qIC8gZGVjN2Q0
YyAoSEVBRCAtJmd0OyBtYWluKSBIaXN0b3J5IDEgLSBBZGQgPGEgdGFyZ2V0PSJfYmxhbmsiIHJl
bD0ibm9yZWZlcnJlciBub2ZvbGxvdyBub29wZW5lciIgaHJlZj0iaHR0cDovL1JFQURNRS5tZCI+
UkVBRE1FLm1kPC9hPjwvc3Bhbj48L2Rpdj48ZGl2PjxzcGFuPnwvPC9zcGFuPjwvZGl2PjxkaXY+
PHNwYW4+KiAzZjI1MzE4IEhpc3RvcnkgMSAtIEFkZCBnaXRpZ25vcmU8L3NwYW4+PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj48c3Bhbj5EZXBlbmRpbmcgb24gYXBwcm92YWwgaGVyZSwgSSBhbSBw
cmVwYXJlZCB0byBhdHRlbXB0IHRvIGltcGxlbWVudCB0aGlzPC9zcGFuPjwvZGl2PjxkaXY+PHNw
YW4+ZmVhdHVyZSBteXNlbGYsIHRob3VnaCB3b3VsZCBhcHByZWNpYXRlIGlucHV0IGZyb20gdGhv
c2UgbW9yZSBrbm93bGVkZ2VhYmxlIGFib3V0IHRoZTwvc3Bhbj48L2Rpdj48c3Bhbj5naXQgY29k
ZWJhc2UgYW5kIGV4cGVyaWVuY2VkIHdpdGggY29udHJpYnV0aW5nLjwvc3Bhbj48YnI+
-----------------------3c7f2489a6723c7cce6f4f9b90c80cf3--
-----------------------1b3b2a5129c1b0fbedc66c85ea2aa706--
-----------------------4897172b8656d49eb5eced9e3fc0ac3c
Content-Type: application/pgp-keys; filename="publickey - josh.brunton@proton.me - 0x4DBFDC41.asc"; name="publickey - josh.brunton@proton.me - 0x4DBFDC41.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - josh.brunton@proton.me - 0x4DBFDC41.asc"; name="publickey - josh.brunton@proton.me - 0x4DBFDC41.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4c0ZOQkdNUmFMc0JFQUM0K3BD
VVdubXRjekFrTnUwdVpwUm1UWU52L3loMVpseWZscnZqSTFPSFRLTHAKOGFlNUZ0TVRuU2ZTQ0pv
UkVNemVLdjBBWldPOERzamM2L1ZMNWxPWGFmN3paUEJ6RytNTDhQcDgvdXF1CkdJRlhRbFpZSkpa
TzgvRHpLS3M5VmNkYVNpUEVBby9pMUVrMVZaVjQ0S0RCcXlscVFBWkFNa3ZvNkpEeQp4cnZlODdJ
a1MzM1NOT0tQcXMxNUlwVU1Fa2tZUEV5M2czUHlmMld0SGFXNEc0N1FLNXYva2tOT1h4U2cKS3RG
SEdxdnh4TmlPL3dudHQ4cEhuS2hVL3gxWjduM0J4STBvbkFUbTlrSXJIYXFYRlJzVjRhMzhGVEZq
CmxJYzUyQmEwZCszWm8wRENzWjlUY1NvUzVYSVJNbnZQYlcyRzJmcnR5a3FIby9hK1pscW45eEk1
SGtwdgpPQUpTM2crbDkwN045K1Vlb2xwNlpwdFN4MDZ3Z1UxVU9TMTJ1WEpxVGpzQnZnR2JVZW5R
amlHWldGVloKd1NtYisvVHhwaFVFcG9HVVFIY1YrekRUQlNyV2c5NDhOeFVzVGEzN2RVdkVIQzFG
dTVmak1lZWxodnNkCjdmVnBlRzRxMVJTQ2RVbXRHSTdYVlFRQUgvRE9Gc3NDd1dJSnRNa0NkY0dY
RFcwVHpySlgya1owRWx4Zwp4TnlpTHBmTEZVa0x6N1I2VFk4MHE2aFcvbVlhNjUvVkFKdlFMdUhv
bS9nbk56ZlNQcVNFenJ5Nm81TWYKUE8wWDQxWTUvVXM1SU5zcXpud1J5TGdoN2JkbzRvUzBUemFo
N3BaQmljSy83NXI2U0ZRSFhxb2dXZ2U2CkMwU0hqMWRYWGI4NVVsU05zTzhUOUs3QkZ5YWRlaS9U
dlFOemJ3QVJBUUFCelM5cWIzTm9MbUp5ZFc1MApiMjVBY0hKdmRHOXVMbTFsSUR4cWIzTm9MbUp5
ZFc1MGIyNUFjSEp2ZEc5dUxtMWxQc0xCalFRUUFRZ0EKSUFVQ1l4Rm91d1lMQ1FjSUF3SUVGUWdL
QWdRV0FnRUFBaGtCQWhzREFoNEJBQ0VKRUJ5c3N2U2Myd3BUCkZpRUVUYi9jUVRsVlVHRlJpd3V1
SEt5eTlKemJDbE05K0EvL1crYXVUeStpaUhaQ2hsS3NVNlBVNDk1VwplWW83YVJaRXV1UnVibUJK
MEhQSnd6dWluMjE4ankyT3RKbStKMjBpZjhiT25RUmdIUXQ4c09yYXhYdlcKeFYzRnBhUVlBWnh6
MnU4WFl2ZG93QUhucGVMNm82TXFVOVZMREk0Z0hHWVVqSm5RS2JLMFpTZzRpbVJVCkNTcG0xa2Rp
OFo0MnJ3TXhydzBrRXNwanExZWhqRllTY1hRbEpJV3lZcHpNOWRDS25xZlpOQmYrRTVjdwpUMjZY
VzRwdGNSam4yTlNzdkU5L2twNjVsMXczS2ZFdlduODJYTGdUemUrVU1JZHMzMzh2bU1Sa3BtSXYK
MUkwcVhmaXdvbU9XckV5cVB0NW9uZWZ4ellrZm9jNjlrRkFFUFFObVFQYjJVOStJRTJJRWJIckNG
UWRMClY1UjhvcVNWcWtSTGI2ekp4TmRWcTA4cjVvaVk2dDBxY1Npc3VkNVVhNTJpZFR0V28rKzBE
WHpJN0szegpTRUN5emV5ZllFK25YZUVoMU5lOElrdjJqZEtrdHpWeDZrT2MrUk1abVRabG84Y0U4
TlhmSTZqWGljRy8KYjdOMUtkdXgxbG1tekRsN3BsTnJNR3JaRVJYYTREc1lTM0I2Q0YwTHovTmN0
U25VYTUvaC9BQXd3SFpUCnhoVjIzVVlYMHhiUjFyZWpsV3ZnMEtQb3Y4OUxCOEhLVUdVWmozaytV
T0krNUx0bVp2N1pKQ2J5bHprdQpEZlpKTGNKWW1RS2NnL2JqdnMxbmZxcFBvSHVGdzJWNUUzYlVB
K3pKc0YvOXJJNWdXTXRlRVR2STZxMWYKdTJ6WGdQY3JpWjlIeGJFTjVRVTk1NDdERytSbWlIRXZG
b1cyT3RVTmtQUGFIanZ6aCtRbWc5NDdHcS9PCndVMEVZeEZvdXdFUUFKMytpbnJ4WEwxVzR6eG5r
TmRneGtqR05jY2hCM1JlZ05jSk5ON2VoOENRb3BzSQprOTh3bHJzbWV6WEhBNjFaa3pCLzNWSkh2
WG1SS1ZtOUpaQjNqbGlWaEhCWldkaTJQNkUvVWlNTjM5S2sKck5rdkQ1ZkZKNlFxQzBETmZnci9h
aGZYKzdyWG96SXNCaHBuQVFTRVEyZ2dKNVRZUHF2cTBSRmJPM0dPCm9KcG9JME5BWlZLcmZYS3BQ
YXNKT1BiREtMYlR0MG1VbjNuTXJVSzV3S2paRTJWNGcvMkhOandqV0JjKwpiWWo4QittT0pDelY2
YTFTbzZQTUlkQ2p6MlVaU3had0tnL2sxL3pjSHFBb1RZUHZsVXJTanlPTlJMYmYKWlM0R01ZRWlK
UTROVWEySnJBNU5rQmZzZWFxeExhTFlQSmkwdk1yTlFRcnZBQm5acUM3bEd0N2hTMEt1CjlxSmdI
UFlYMW80TFY5RFloZ21DVndTWFZIc1h1ZTNXd1BrdG5vbWRKS0J3M1NxeFZ2S2RNTklUVUNKbApG
OVkyMGxvMUd6czlMelEzUFVxZ0FleldpU1ZmTVNwS1M4bTI3N292NGxweTRka0o0bmZXbElRK3dZ
RDcKT2VjL0NmM2FaN0RicEJzeU9YNEs4bTVyZi9iUGZSRVlQd1ZXaVpLWUE4OWVoZ3ZsVFhvd1dJ
dnpKS3VVCjZLMmUyQ2p5eXJhT3JKRG43eTIzb0xQYjNUUWFuZ210YjdMWklvODJOVG52U0JBb1A5
ZTBsc2lXYmtPUgo1MFl5dDJ5VEx3aWJGRkNLaG1GbkRkcU1nYUE3T1RGbHJESXgxd00xQzRRSlpH
aGMwNktsZkhKTzRXNTcKZHZUL25yYlR2SEFZZlRELzlKSVRna2hjS1BWV3RaVFhDOWZ4QUJFQkFB
SEN3WFlFR0FFSUFBa0ZBbU1SCmFMc0NHd3dBSVFrUUhLeXk5SnpiQ2xNV0lRUk52OXhCT1ZWUVlW
R0xDNjRjckxMMG5Oc0tVOENqRC85UwpEd2xRUGpuaXdTblRvU3ZuSFN2cjluQ0xHQ0ZUODBVbzIx
cXZKekl3Ym83a01GT1AxSEFDK0Q3RDM3UUoKN2QrMHVRMDA5Unp4L1A3bW1xdHpISkpRMGZ0bzVX
R3ozUkRzenA3WkhtZk9oNVVyQm10Q1NUaWYxTTF3ClBDWTN2YU9jUjZBbEpvLytqaktMVUNocVU1
YzVqbGROQVdGNlBRNEhHZkwxR3pZakZ2cWlUNUFBU0dSMApoVldRaTBLWVBxZDh0VE9MdFVtOGZZ
SitwUDNhbCtwRHRwVzRPeW8zS3YxVG9qOGlTSW82SVlLTnBobzEKSEZTcElnZU40dVdzenY4RUU2
SEdLcWh6b2VPK2VQeDNqVnVtSStjT003V1ZGRlhrOEZTUlNSL3JvdWRKCktsV0dYYmV3ZnVDYnMv
VzhaNHkycnpieUlEZmIzVXIwT2h5YXBoYjFvbTZOUmVVd3R3ZTRQMTFJQ2NMNwpIeEJhL3R0ZXFj
dEREUmZOL2RhdUJ3NTA2V2RINkZpZ1BvaGxOaElEV3JEMC9rYW1kak04L1BFMkV2NXcKdmhMd0p3
b3FkYlRlYlJpa2tDMi9kMzBSNGt4a0lGQ3cwd1JUUHBIbkMyTHl2Q1lBNkM1ZGJ5UU54QTdnCmd3
QlhyOCt6SmdhVExyZWExeGorbTJJaUhCVTZTZXFxM09pWjBhTXUzNHEwU0VnN1BkM3IyUUM3QTF3
SwpYeG1NdytYMld5Mjk2STdNaDIyTklBcTdhNTB4OCt2cTJYNTVrVWJMK2JJYllRYml0YTEyUWJt
S3dJMm0KWmV1NjJXQTgvMTVZK2paQkFoU0kvY3dWUGtTWlZrZHExeGxubksrVU9TemM2TDJuMWw4
Vzc3clR6c1U4Ck12S2pLK3ZqeUJjUnRtaGhXVDlGQ1E9PQo9OHZFVwotLS0tLUVORCBQR1AgUFVC
TElDIEtFWSBCTE9DSy0tLS0tCg==
-----------------------4897172b8656d49eb5eced9e3fc0ac3c--

--------e832ccca562ff1a09995fbad4204a5b9cd33b6fcf35c3300c6a921d8c1a3a9df
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsFzBAEBCAAnBYJnTz/7CZAcrLL0nNsKUxYhBE2/3EE5VVBhUYsLrhyssvSc
2wpTAACOChAAkup+j3Q/o0o9r9dw1z0vXvygfgsQAJ4yLQOJb1v0/1SF21J3
RTpuep2+Q0E5wVXMfL+CCsrE8e2jy8uFMn8A3FlevID5tMJXcsaE9NtHLO2+
SnA3FUinAbW/lnVzBtXqjN6ZUrQu4TLdavgm/0E4A50ShiCvbidVocPQkIMT
jQcNLjumX7iVfUGBrprgutxEEz3KUPjBR9aRu/E16ST5WYWm/RjZAurvVYnM
D2oS7H5nswPA/EBIlzqQ1GJVdlF4kNkneJUr3o7x30AU1ZeRR6izdQhVUfZQ
Vq6LFmVoSEAWIPrv5P0ind9266oe7m3C2j8gIzloYUjDopQiFkG8aUddVZBz
vPAjnqAkB/fBNK/PIhruVGIs2KV0nJBgr86SyCESrtOtBth5YAryDcZtIm15
cTv1uL2oPh4rkieoCBZyOWkayCxwPemWDpKS0ECu/5c5WOENXYF7RiAVLtBI
r1xnUVRfUwNfuj0RB4dVVJskZlXjJV8+d4hUO44d0mday4ZleAYu8/bbV/PS
NLyi6dr1SUJ+/2lAVfMMaZdTzC6bLmP6UbmG4OM+d6H4k+5wLF3xUHPXPh7W
70STLoaGUkKQYb7f/7qHD5WyQConLXHNQpoYWhoF126NI35sGMWO7+xy35k/
ZopHCvlmswbSfBKF0Paczqae9EmxeuLYP70=
=56J1
-----END PGP SIGNATURE-----


--------e832ccca562ff1a09995fbad4204a5b9cd33b6fcf35c3300c6a921d8c1a3a9df--

