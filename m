Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715260;
	b=czY7C6mLwjeboZYvwJWTXRvVh4tVMXWPcpOY0KmGkiZKJvMGKs4mD2ui300B+LhD0xeK
	 VvtKWqFUnoXpc+YoMA3REtL9/n9gIoC1i764Kk2baVtXEzTqsTPt/Y0MNomlMesE/30or
	 YSaImIczLNs5t3nUprHIu08pCfJdQz9eOY8MuXpjt07qeP0hICo+1biNV+oG5wAOYU2O3
	 JLOL6RButXRxESAOveX3F1obXnKAKd+vmRg5Q64JSgRqK9ppnM2OBYjJ5xx2qTJ82MzK9
	 14F9F1cQi8AoSqP/xrMPobhnpwVnRzAmLSe1cB4WaOoY8GuetrMAOIeM5dBsKTDUOZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715260;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Subject:From:To:Date:Autocrypt:Content-Type:User-Agent:MIME-Version:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=rPO5+t0xAg/Cr0JBtpxu6xzLMSNudJJgXO6Uc35ytRI=;
	b=V7i0mf+C2DDLPVlQRGmzSaxP9lI8II9eTmrO37HvB0YycCTBlKcOS3egUX1HKZG4gWyf
	 sTZ/q+2gIYUT8cogDpiuu5x5KjtdRRxGFcEGun0mLUgs+H49T+ECmfcG9d9I7RAb7ubEv
	 vFbNmMDiNEUE0vpzvXsp4XNQ54jvSO9HJ5WYInUC+s3V+DAIOdqZFixD2hxgu0zdPTEfm
	 ilKBzs5OceGLDPAxZAzwT6rr1E6mV+/qn6w9xEf2av8hNkG1ojTknOls1vgawOR/JSzqP
	 vFgLRwTC8TPd7CBmL02hre7clHPoJq4LOLiIZqycvzqbsOfSFfbvu22zzoq/Hi7mVIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=abou-samra.fr;
	spf=pass smtp.mailfrom=abou-samra.fr;
	dkim=pass header.d=abou-samra.fr header.i=jean@abou-samra.fr header.a=rsa-sha256 header.s=s1-ionos header.b=2K9MEg+z;
	arc=none smtp.remote-ip=212.227.126.133
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02D606A326
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 14:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA02D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=abou-samra.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abou-samra.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=abou-samra.fr header.i=jean@abou-samra.fr header.a=rsa-sha256 header.s=s1-ionos header.b=2K9MEg+z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abou-samra.fr;
	s=s1-ionos; t=1793715256; x=1794320056; i=jean@abou-samra.fr;
	bh=rPO5+t0xAg/Cr0JBtpxu6xzLMSNudJJgXO6Uc35ytRI=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Date:Content-Type:
	 MIME-Version:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=2K9MEg+zsK70zQznm3iuZ3F/esfdJQDOtfiMbT+s/98fHztJVYRbVy8FdrVG20DY
	 4axgQaMa+zc9f9ZaCgN0jN5UOXvKTFUWbKHkJGNr7gG9n52l7jjItlR5mrrAKxpMy
	 RoYNNHe9uazD5ZIPXFEAphI8smLniqJ3ZIasddDYYSqSJAi5EBpYA0Xqw6dq+e8yd
	 rHmTmcE66QMFnL5A5Rtg/ncgzwmPMLbsLSXObEHW2LVgvpQLlwyDOjqjzTm+XdX+C
	 thWK7fICEaWOjmUEibRoXXHnPzekaPsILEX/2qipZ6lOLwA0YgHhzbvGP1A/iamc3
	 cXQM4kLo4hAZkKTvUA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [213.165.67.103]) with ESMTPSA (Nemesis) id 1MVMqF-1wz7NP2Rrr-00HzXF for
 <git@vger.kernel.org>; Tue, 03 Nov 2026 15:14:16 +0100
Message-ID: <4dd76eef8a2a355ba435e8c784c1e37f3fe47074.camel@abou-samra.fr>
Subject: Strange word diff
From: Jean Abou Samra <jean@abou-samra.fr>
To: git@vger.kernel.org
Date: Tue, 03 Nov 2026 15:14:14 +0100
Autocrypt: addr=jean@abou-samra.fr; prefer-encrypt=mutual;
 keydata=mDMEYz8qHRYJKwYBBAHaRw8BAQdAKa699V3Pc3AOAg40hnai7Ljs1uAOxkeopSA7uz+TN
 /q0JEplYW4gQWJvdSBTYW1yYSA8amVhbkBhYm91LXNhbXJhLmZyPoiTBBMWCgA7FiEEme0ysZyhsg
 bwY8wZo/D2C4kzl/4FAmM/Kh0CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQo/D2C4k
 zl/5MjQEAzHgLjZqtPK4nM5d4a+c03tUmYTKsGnfiHYPbSwD7V2cA/1kL/iF8C8wN/K//1+8vRd4i
 uv1jrPbpLv11LHWg+EkM
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ldBXJgrwJBYkXqcbGkjY"
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Provags-ID: V03:K1:+NUoWtB3JCgHPWU2U6BKa7XJoFv86wXTDzAtLuwqf322vezdJHx
 RCsvsUWgb8IGAVVOq79+T3Z/xXoS3rObfrMBhNsQqctwm6AAWmOPGYcVlkVCjT/B0iEH9Ja
 bQI6XwIVnkbr4DlkQS5IW1v4vOnRgYdqgCyuvXdOMeDfospz4noP9loi+bbRzid6+zEWx/e
 dQoE1k2++rGXfBpMC76lw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m0Tb7QShcRg=;IMZF/P8dCSwr/f366EQ9unxlV1P
 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
 w+XYRTye39jdnAaBfsCjuwD7gYCcp3g=


--=-ldBXJgrwJBYkXqcbGkjY
Content-Type: multipart/mixed; boundary="=-wGv9YnAbelJyyW3pl8xY"

--=-wGv9YnAbelJyyW3pl8xY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Attached is an archive with three files. file2.txt differs from file1.txt
by just a few words, as correctly reported by git diff --word-diff (using
Git 2.56.0):

```
$ git diff --no-index --word-diff file1.txt file2.txt=20
diff --git a/file1.txt b/file2.txt
index a9eaedc..a75008e 100644
--- a/file1.txt
+++ b/file2.txt
@@ -1,4 +1,4 @@
\subparagraph*{Context}
Our object of study is an extension of Turing degrees where the oracles can
feature certain forms of non-determinism, as in this riddle. We call these
generalized degrees the \emph{Arthur=E2=80=93Nimue=E2=80=93Merlin degrees},=
 owing to their
explicit description by Kihara using a three-player game whose players are
conventionally named Arthur, Nimue and
Merlin=C2=A0\cite{KiharaLT}.\footnote{In=C2=A0\cite{KiharaOracles}, Kihara =
uses the term
=E2=80=9Cextended Turing=E2=80=93Weihrauch degrees=E2=80=9D. We prefer to e=
schew the association with
Weihrauch's name since we never deal with [-call-once oracles.}-]{+oracles =
that
can only be queried once.}+} Whereas Turing degrees are defined as a quotie=
nt of
oracles which are functions $\N \to \N$, Arthur=E2=80=93Nimue=E2=80=93Merli=
n degrees are a
quotient of a richer set of oracles, namely functions $\N \to \P(\P(\N))$.
Informally, when a program that uses $g : \N \to \P(\P(\N))$ as an oracle m=
akes
a query $n \in \N$ to the oracle, a set $P \in g(n)$ is chosen in a benevol=
ent
way (=E2=80=9Cangelic non-determinism=E2=80=9D), then a value $v \in P$ is =
chosen in an
adversarial way (=E2=80=9Cdemonic non-determinism=E2=80=9D), and the progra=
m receives the answer
$v$. The mathematical meaning to =E2=80=9Cbenevolent=E2=80=9D and =E2=80=9C=
adversarial=E2=80=9D is made precise
by introducing a game where Arthur, a player restricted to computable
strategies, is allied to Nimue, the player choosing $P$, and both play agai=
nst
Merlin, the player choosing $v$. (The details of the game are recalled in
\autoref{section-arthur-nimue-merlin-games}.)

While [-this game was-]{+Arthur=E2=80=93Nimue=E2=80=93Merlin games were+} i=
ntroduced recently by
Kihara, [-the concept-]{+they are a concrete description+} of [-
Arthur=E2=80=93Nimue=E2=80=93Merlin degrees is-]{+objects that arose+} much=
 [-older, having
arised,-]{+earlier,+} in a different guise, in the study of realizability. =
To
reassure the reader unfamiliar with realizability from the outset, this pap=
er is
meant to be accessible with only a background in basic computability theory=
,
except for \autoref{section-topos-theory} where we explain how the proof of=
 our
main result can be understood from the point of view of realizability.
Nevertheless, let us recall the historical link.
```

The only change between file2.txt and file3.txt is the addition of a
blank line:

```
$ git diff --no-index file2.txt file3.txt=20
diff --git a/file2.txt b/file3.txt
index a75008e..81c3eb9 100644
--- a/file2.txt
+++ b/file3.txt
@@ -1,4 +1,5 @@
 \subparagraph*{Context}
+
 Our object of study is an extension of Turing degrees where the oracles ca=
n
feature certain forms of non-determinism, as in this riddle. We call these
generalized degrees the \emph{Arthur=E2=80=93Nimue=E2=80=93Merlin degrees},=
 owing to their
explicit description by Kihara using a three-player game whose players are
conventionally named Arthur, Nimue and
Merlin=C2=A0\cite{KiharaLT}.\footnote{In=C2=A0\cite{KiharaOracles}, Kihara =
uses the term
=E2=80=9Cextended Turing=E2=80=93Weihrauch degrees=E2=80=9D. We prefer to e=
schew the association with
Weihrauch's name since we never deal with oracles that can only be queried
once.} Whereas Turing degrees are defined as a quotient of oracles which ar=
e
functions $\N \to \N$, Arthur=E2=80=93Nimue=E2=80=93Merlin degrees are a qu=
otient of a richer
set of oracles, namely functions $\N \to \P(\P(\N))$. Informally, when a pr=
ogram
that uses $g : \N \to \P(\P(\N))$ as an oracle makes a query $n \in \N$ to =
the
oracle, a set $P \in g(n)$ is chosen in a benevolent way (=E2=80=9Cangelic =
non-
determinism=E2=80=9D), then a value $v \in P$ is chosen in an adversarial w=
ay (=E2=80=9Cdemonic
non-determinism=E2=80=9D), and the program receives the answer $v$. The mat=
hematical
meaning to =E2=80=9Cbenevolent=E2=80=9D and =E2=80=9Cadversarial=E2=80=9D i=
s made precise by introducing a game
where Arthur, a player restricted to computable strategies, is allied to Ni=
mue,
the player choosing $P$, and both play against Merlin, the player choosing =
$v$.
(The details of the game are recalled in \autoref{section-arthur-nimue-merl=
in-
games}.)
=20
 While Arthur=E2=80=93Nimue=E2=80=93Merlin games were introduced recently b=
y Kihara, they are a
concrete description of objects that arose much earlier, in a different gui=
se,
in the study of realizability. To reassure the reader unfamiliar with
realizability from the outset, this paper is meant to be accessible with on=
ly a
background in basic computability theory, except for \autoref{section-topos=
-
theory} where we explain how the proof of our main result can be understood=
 from
the point of view of realizability. Nevertheless, let us recall the histori=
cal
link.
```

And yet, comparing file1.txt with file3.txt with a word diff gives a strang=
e
diff that matches a few words here and there while missing unchanged entire
long sentences:

```
$ git diff --no-index --word-diff file1.txt file3.txt=20
diff --git a/file1.txt b/file3.txt
index a9eaedc..81c3eb9 100644
--- a/file1.txt
+++ b/file3.txt
@@ -1,4 +1,5 @@
\subparagraph*{Context}
[-Our object of study is an extension of Turing degrees where the oracles c=
an
feature certain forms of non-determinism, as in this riddle. We call these
generalized degrees the \emph{Arthur=E2=80=93Nimue=E2=80=93Merlin degrees},=
 owing to their
explicit description by Kihara using a three-player game whose players are
conventionally named Arthur, Nimue and
Merlin=C2=A0\cite{KiharaLT}.\footnote{In=C2=A0\cite{KiharaOracles}, Kihara =
uses the term
=E2=80=9Cextended Turing=E2=80=93Weihrauch degrees=E2=80=9D. We prefer to e=
schew the association with
Weihrauch's name since we never deal with call-once oracles.} Whereas Turin=
g
degrees are defined as a quotient of oracles which are functions $\N \to \N=
$,
Arthur=E2=80=93Nimue=E2=80=93Merlin degrees are a quotient of a richer set =
of oracles, namely
functions $\N \to \P(\P(\N))$. Informally, when a program that uses $g : \N=
 \to
\P(\P(\N))$ as an oracle makes a query $n \in \N$ to the oracle, a set $P \=
in
g(n)$ is chosen in a benevolent way (=E2=80=9Cangelic non-determinism=E2=80=
=9D), then a value $v
\in P$ is chosen in an adversarial way (=E2=80=9Cdemonic non-determinism=E2=
=80=9D), and the
program receives the answer $v$. The mathematical meaning to =E2=80=9Cbenev=
olent=E2=80=9D and
=E2=80=9Cadversarial=E2=80=9D is made precise by introducing a game where A=
rthur, a player
restricted to computable strategies, is allied to Nimue, the player choosin=
g
$P$, and both play against Merlin, the player choosing $v$. (The details of=
 the
game are recalled in \autoref{section-arthur-nimue-merlin-games}.)-]

[-While-]{+Our object of study is an extension of Turing degrees where the
oracles can feature certain forms of non-determinism, as in+} this [-game w=
as
introduced recently-]{+riddle. We call these generalized degrees the
\emph{Arthur=E2=80=93Nimue=E2=80=93Merlin degrees}, owing to their explicit=
 description+} by [-
Kihara,-]{+Kihara using a three-player game whose players are conventionall=
y
named Arthur, Nimue and
Merlin=C2=A0\cite{KiharaLT}.\footnote{In=C2=A0\cite{KiharaOracles}, Kihara =
uses+} the [-
concept-]{+term =E2=80=9Cextended Turing=E2=80=93Weihrauch degrees=E2=80=9D=
. We prefer to eschew the
association with Weihrauch's name since we never deal with oracles that can=
 only
be queried once.} Whereas Turing degrees are defined as a quotient+} of
{+oracles which are functions $\N \to \N$,+} Arthur=E2=80=93Nimue=E2=80=93M=
erlin degrees {+are a
quotient of a richer set of oracles, namely functions $\N \to \P(\P(\N))$.
Informally, when a program that uses $g : \N \to \P(\P(\N))$ as an oracle m=
akes
a query $n \in \N$ to the oracle, a set $P \in g(n)$ is chosen in a benevol=
ent
way (=E2=80=9Cangelic non-determinism=E2=80=9D), then a value $v \in P$ is =
chosen in an
adversarial way (=E2=80=9Cdemonic non-determinism=E2=80=9D), and the progra=
m receives the answer
$v$. The mathematical meaning to =E2=80=9Cbenevolent=E2=80=9D and =E2=80=9C=
adversarial=E2=80=9D+} is {+made
precise by introducing a game where Arthur, a player restricted to computab=
le
strategies, is allied to Nimue, the player choosing $P$, and both play agai=
nst
Merlin, the player choosing $v$. (The details of the game are recalled in
\autoref{section-arthur-nimue-merlin-games}.)+}

{+While Arthur=E2=80=93Nimue=E2=80=93Merlin games were introduced recently =
by Kihara, they are a
concrete description of objects that arose+} much [-older, having arised,-
]{+earlier,+} in a different guise, in the study of realizability. To reass=
ure
the reader unfamiliar with realizability from the outset, this paper is mea=
nt to
be accessible with only a background in basic computability theory, except =
for
\autoref{section-topos-theory} where we explain how the proof of our main r=
esult
can be understood from the point of view of realizability. Nevertheless, le=
t us
recall the historical link.
```

Is this a bug? It happens with all --diff-algorithm option values.

Best,
Jean

--=-wGv9YnAbelJyyW3pl8xY
Content-Type: application/x-tar; name="git-word-diff.tar"
Content-Disposition: attachment; filename="git-word-diff.tar"
Content-Transfer-Encoding: base64

Z2l0LXdvcmQtZGlmZi8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAwMDA3NTUAMDAwMTc1
MAAwMDAxNzUwADAwMDAwMDAwMDAwADE1MjcyMzY1MjQ0ADAxMjE0NgAgNQAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB1c3RhciAgAGplYW4AAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAamVhbgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABn
aXQtd29yZC1kaWZmL2ZpbGUxLnR4dAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMDAwMDY0NAAwMDAxNzUw
ADAwMDE3NTAAMDAwMDAwMDM3NDUAMTUyNzIzNjUyMjUAMDEzNzE3ACAwAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHVzdGFyICAAamVhbgAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAABqZWFuAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFxz
dWJwYXJhZ3JhcGgqe0NvbnRleHR9Ck91ciBvYmplY3Qgb2Ygc3R1ZHkgaXMgYW4gZXh0ZW5zaW9u
IG9mIFR1cmluZyBkZWdyZWVzIHdoZXJlIHRoZSBvcmFjbGVzIGNhbiBmZWF0dXJlIGNlcnRhaW4g
Zm9ybXMgb2Ygbm9uLWRldGVybWluaXNtLCBhcyBpbiB0aGlzIHJpZGRsZS4gV2UgY2FsbCB0aGVz
ZSBnZW5lcmFsaXplZCBkZWdyZWVzIHRoZSBcZW1waHtBcnRodXLigJNOaW11ZeKAk01lcmxpbiBk
ZWdyZWVzfSwgb3dpbmcgdG8gdGhlaXIgZXhwbGljaXQgZGVzY3JpcHRpb24gYnkgS2loYXJhIHVz
aW5nIGEgdGhyZWUtcGxheWVyIGdhbWUgd2hvc2UgcGxheWVycyBhcmUgY29udmVudGlvbmFsbHkg
bmFtZWQgQXJ0aHVyLCBOaW11ZSBhbmQgTWVybGluwqBcY2l0ZXtLaWhhcmFMVH0uXGZvb3Rub3Rl
e0luwqBcY2l0ZXtLaWhhcmFPcmFjbGVzfSwgS2loYXJhIHVzZXMgdGhlIHRlcm0g4oCcZXh0ZW5k
ZWQgVHVyaW5n4oCTV2VpaHJhdWNoIGRlZ3JlZXPigJ0uIFdlIHByZWZlciB0byBlc2NoZXcgdGhl
IGFzc29jaWF0aW9uIHdpdGggV2VpaHJhdWNoJ3MgbmFtZSBzaW5jZSB3ZSBuZXZlciBkZWFsIHdp
dGggY2FsbC1vbmNlIG9yYWNsZXMufSBXaGVyZWFzIFR1cmluZyBkZWdyZWVzIGFyZSBkZWZpbmVk
IGFzIGEgcXVvdGllbnQgb2Ygb3JhY2xlcyB3aGljaCBhcmUgZnVuY3Rpb25zICRcTiBcdG8gXE4k
LCBBcnRodXLigJNOaW11ZeKAk01lcmxpbiBkZWdyZWVzIGFyZSBhIHF1b3RpZW50IG9mIGEgcmlj
aGVyIHNldCBvZiBvcmFjbGVzLCBuYW1lbHkgZnVuY3Rpb25zICRcTiBcdG8gXFAoXFAoXE4pKSQu
IEluZm9ybWFsbHksIHdoZW4gYSBwcm9ncmFtIHRoYXQgdXNlcyAkZyA6IFxOIFx0byBcUChcUChc
TikpJCBhcyBhbiBvcmFjbGUgbWFrZXMgYSBxdWVyeSAkbiBcaW4gXE4kIHRvIHRoZSBvcmFjbGUs
IGEgc2V0ICRQIFxpbiBnKG4pJCBpcyBjaG9zZW4gaW4gYSBiZW5ldm9sZW50IHdheSAo4oCcYW5n
ZWxpYyBub24tZGV0ZXJtaW5pc23igJ0pLCB0aGVuIGEgdmFsdWUgJHYgXGluIFAkIGlzIGNob3Nl
biBpbiBhbiBhZHZlcnNhcmlhbCB3YXkgKOKAnGRlbW9uaWMgbm9uLWRldGVybWluaXNt4oCdKSwg
YW5kIHRoZSBwcm9ncmFtIHJlY2VpdmVzIHRoZSBhbnN3ZXIgJHYkLiBUaGUgbWF0aGVtYXRpY2Fs
IG1lYW5pbmcgdG8g4oCcYmVuZXZvbGVudOKAnSBhbmQg4oCcYWR2ZXJzYXJpYWzigJ0gaXMgbWFk
ZSBwcmVjaXNlIGJ5IGludHJvZHVjaW5nIGEgZ2FtZSB3aGVyZSBBcnRodXIsIGEgcGxheWVyIHJl
c3RyaWN0ZWQgdG8gY29tcHV0YWJsZSBzdHJhdGVnaWVzLCBpcyBhbGxpZWQgdG8gTmltdWUsIHRo
ZSBwbGF5ZXIgY2hvb3NpbmcgJFAkLCBhbmQgYm90aCBwbGF5IGFnYWluc3QgTWVybGluLCB0aGUg
cGxheWVyIGNob29zaW5nICR2JC4gKFRoZSBkZXRhaWxzIG9mIHRoZSBnYW1lIGFyZSByZWNhbGxl
ZCBpbiBcYXV0b3JlZntzZWN0aW9uLWFydGh1ci1uaW11ZS1tZXJsaW4tZ2FtZXN9LikKCldoaWxl
IHRoaXMgZ2FtZSB3YXMgaW50cm9kdWNlZCByZWNlbnRseSBieSBLaWhhcmEsIHRoZSBjb25jZXB0
IG9mIEFydGh1cuKAk05pbXVl4oCTTWVybGluIGRlZ3JlZXMgaXMgbXVjaCBvbGRlciwgaGF2aW5n
IGFyaXNlZCwgaW4gYSBkaWZmZXJlbnQgZ3Vpc2UsIGluIHRoZSBzdHVkeSBvZiByZWFsaXphYmls
aXR5LiBUbyByZWFzc3VyZSB0aGUgcmVhZGVyIHVuZmFtaWxpYXIgd2l0aCByZWFsaXphYmlsaXR5
IGZyb20gdGhlIG91dHNldCwgdGhpcyBwYXBlciBpcyBtZWFudCB0byBiZSBhY2Nlc3NpYmxlIHdp
dGggb25seSBhIGJhY2tncm91bmQgaW4gYmFzaWMgY29tcHV0YWJpbGl0eSB0aGVvcnksIGV4Y2Vw
dCBmb3IgXGF1dG9yZWZ7c2VjdGlvbi10b3Bvcy10aGVvcnl9IHdoZXJlIHdlIGV4cGxhaW4gaG93
IHRoZSBwcm9vZiBvZiBvdXIgbWFpbiByZXN1bHQgY2FuIGJlIHVuZGVyc3Rvb2QgZnJvbSB0aGUg
cG9pbnQgb2YgdmlldyBvZiByZWFsaXphYmlsaXR5LiBOZXZlcnRoZWxlc3MsIGxldCB1cyByZWNh
bGwgdGhlIGhpc3RvcmljYWwgbGluay4KAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZ2l0LXdv
cmQtZGlmZi9maWxlMi50eHQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAwMDA2NDQAMDAwMTc1MAAwMDAx
NzUwADAwMDAwMDA0MDA1ADE1MjcyMzY1MjM1ADAxMzcwNwAgMAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB1c3RhciAgAGplYW4AAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAamVhbgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABcc3VicGFy
YWdyYXBoKntDb250ZXh0fQpPdXIgb2JqZWN0IG9mIHN0dWR5IGlzIGFuIGV4dGVuc2lvbiBvZiBU
dXJpbmcgZGVncmVlcyB3aGVyZSB0aGUgb3JhY2xlcyBjYW4gZmVhdHVyZSBjZXJ0YWluIGZvcm1z
IG9mIG5vbi1kZXRlcm1pbmlzbSwgYXMgaW4gdGhpcyByaWRkbGUuIFdlIGNhbGwgdGhlc2UgZ2Vu
ZXJhbGl6ZWQgZGVncmVlcyB0aGUgXGVtcGh7QXJ0aHVy4oCTTmltdWXigJNNZXJsaW4gZGVncmVl
c30sIG93aW5nIHRvIHRoZWlyIGV4cGxpY2l0IGRlc2NyaXB0aW9uIGJ5IEtpaGFyYSB1c2luZyBh
IHRocmVlLXBsYXllciBnYW1lIHdob3NlIHBsYXllcnMgYXJlIGNvbnZlbnRpb25hbGx5IG5hbWVk
IEFydGh1ciwgTmltdWUgYW5kIE1lcmxpbsKgXGNpdGV7S2loYXJhTFR9Llxmb290bm90ZXtJbsKg
XGNpdGV7S2loYXJhT3JhY2xlc30sIEtpaGFyYSB1c2VzIHRoZSB0ZXJtIOKAnGV4dGVuZGVkIFR1
cmluZ+KAk1dlaWhyYXVjaCBkZWdyZWVz4oCdLiBXZSBwcmVmZXIgdG8gZXNjaGV3IHRoZSBhc3Nv
Y2lhdGlvbiB3aXRoIFdlaWhyYXVjaCdzIG5hbWUgc2luY2Ugd2UgbmV2ZXIgZGVhbCB3aXRoIG9y
YWNsZXMgdGhhdCBjYW4gb25seSBiZSBxdWVyaWVkIG9uY2UufSBXaGVyZWFzIFR1cmluZyBkZWdy
ZWVzIGFyZSBkZWZpbmVkIGFzIGEgcXVvdGllbnQgb2Ygb3JhY2xlcyB3aGljaCBhcmUgZnVuY3Rp
b25zICRcTiBcdG8gXE4kLCBBcnRodXLigJNOaW11ZeKAk01lcmxpbiBkZWdyZWVzIGFyZSBhIHF1
b3RpZW50IG9mIGEgcmljaGVyIHNldCBvZiBvcmFjbGVzLCBuYW1lbHkgZnVuY3Rpb25zICRcTiBc
dG8gXFAoXFAoXE4pKSQuIEluZm9ybWFsbHksIHdoZW4gYSBwcm9ncmFtIHRoYXQgdXNlcyAkZyA6
IFxOIFx0byBcUChcUChcTikpJCBhcyBhbiBvcmFjbGUgbWFrZXMgYSBxdWVyeSAkbiBcaW4gXE4k
IHRvIHRoZSBvcmFjbGUsIGEgc2V0ICRQIFxpbiBnKG4pJCBpcyBjaG9zZW4gaW4gYSBiZW5ldm9s
ZW50IHdheSAo4oCcYW5nZWxpYyBub24tZGV0ZXJtaW5pc23igJ0pLCB0aGVuIGEgdmFsdWUgJHYg
XGluIFAkIGlzIGNob3NlbiBpbiBhbiBhZHZlcnNhcmlhbCB3YXkgKOKAnGRlbW9uaWMgbm9uLWRl
dGVybWluaXNt4oCdKSwgYW5kIHRoZSBwcm9ncmFtIHJlY2VpdmVzIHRoZSBhbnN3ZXIgJHYkLiBU
aGUgbWF0aGVtYXRpY2FsIG1lYW5pbmcgdG8g4oCcYmVuZXZvbGVudOKAnSBhbmQg4oCcYWR2ZXJz
YXJpYWzigJ0gaXMgbWFkZSBwcmVjaXNlIGJ5IGludHJvZHVjaW5nIGEgZ2FtZSB3aGVyZSBBcnRo
dXIsIGEgcGxheWVyIHJlc3RyaWN0ZWQgdG8gY29tcHV0YWJsZSBzdHJhdGVnaWVzLCBpcyBhbGxp
ZWQgdG8gTmltdWUsIHRoZSBwbGF5ZXIgY2hvb3NpbmcgJFAkLCBhbmQgYm90aCBwbGF5IGFnYWlu
c3QgTWVybGluLCB0aGUgcGxheWVyIGNob29zaW5nICR2JC4gKFRoZSBkZXRhaWxzIG9mIHRoZSBn
YW1lIGFyZSByZWNhbGxlZCBpbiBcYXV0b3JlZntzZWN0aW9uLWFydGh1ci1uaW11ZS1tZXJsaW4t
Z2FtZXN9LikKCldoaWxlIEFydGh1cuKAk05pbXVl4oCTTWVybGluIGdhbWVzIHdlcmUgaW50cm9k
dWNlZCByZWNlbnRseSBieSBLaWhhcmEsIHRoZXkgYXJlIGEgY29uY3JldGUgZGVzY3JpcHRpb24g
b2Ygb2JqZWN0cyB0aGF0IGFyb3NlIG11Y2ggZWFybGllciwgaW4gYSBkaWZmZXJlbnQgZ3Vpc2Us
IGluIHRoZSBzdHVkeSBvZiByZWFsaXphYmlsaXR5LiBUbyByZWFzc3VyZSB0aGUgcmVhZGVyIHVu
ZmFtaWxpYXIgd2l0aCByZWFsaXphYmlsaXR5IGZyb20gdGhlIG91dHNldCwgdGhpcyBwYXBlciBp
cyBtZWFudCB0byBiZSBhY2Nlc3NpYmxlIHdpdGggb25seSBhIGJhY2tncm91bmQgaW4gYmFzaWMg
Y29tcHV0YWJpbGl0eSB0aGVvcnksIGV4Y2VwdCBmb3IgXGF1dG9yZWZ7c2VjdGlvbi10b3Bvcy10
aGVvcnl9IHdoZXJlIHdlIGV4cGxhaW4gaG93IHRoZSBwcm9vZiBvZiBvdXIgbWFpbiByZXN1bHQg
Y2FuIGJlIHVuZGVyc3Rvb2QgZnJvbSB0aGUgcG9pbnQgb2YgdmlldyBvZiByZWFsaXphYmlsaXR5
LiBOZXZlcnRoZWxlc3MsIGxldCB1cyByZWNhbGwgdGhlIGhpc3RvcmljYWwgbGluay4KAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZ2l0LXdvcmQtZGlm
Zi9maWxlMy50eHQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAwMDA2NDQAMDAwMTc1MAAwMDAxNzUwADAw
MDAwMDA0MDA2ADE1MjcyMzY1MjQ0ADAxMzcxMQAgMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAB1c3RhciAgAGplYW4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
amVhbgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABcc3VicGFyYWdyYXBo
KntDb250ZXh0fQoKT3VyIG9iamVjdCBvZiBzdHVkeSBpcyBhbiBleHRlbnNpb24gb2YgVHVyaW5n
IGRlZ3JlZXMgd2hlcmUgdGhlIG9yYWNsZXMgY2FuIGZlYXR1cmUgY2VydGFpbiBmb3JtcyBvZiBu
b24tZGV0ZXJtaW5pc20sIGFzIGluIHRoaXMgcmlkZGxlLiBXZSBjYWxsIHRoZXNlIGdlbmVyYWxp
emVkIGRlZ3JlZXMgdGhlIFxlbXBoe0FydGh1cuKAk05pbXVl4oCTTWVybGluIGRlZ3JlZXN9LCBv
d2luZyB0byB0aGVpciBleHBsaWNpdCBkZXNjcmlwdGlvbiBieSBLaWhhcmEgdXNpbmcgYSB0aHJl
ZS1wbGF5ZXIgZ2FtZSB3aG9zZSBwbGF5ZXJzIGFyZSBjb252ZW50aW9uYWxseSBuYW1lZCBBcnRo
dXIsIE5pbXVlIGFuZCBNZXJsaW7CoFxjaXRle0tpaGFyYUxUfS5cZm9vdG5vdGV7SW7CoFxjaXRl
e0tpaGFyYU9yYWNsZXN9LCBLaWhhcmEgdXNlcyB0aGUgdGVybSDigJxleHRlbmRlZCBUdXJpbmfi
gJNXZWlocmF1Y2ggZGVncmVlc+KAnS4gV2UgcHJlZmVyIHRvIGVzY2hldyB0aGUgYXNzb2NpYXRp
b24gd2l0aCBXZWlocmF1Y2gncyBuYW1lIHNpbmNlIHdlIG5ldmVyIGRlYWwgd2l0aCBvcmFjbGVz
IHRoYXQgY2FuIG9ubHkgYmUgcXVlcmllZCBvbmNlLn0gV2hlcmVhcyBUdXJpbmcgZGVncmVlcyBh
cmUgZGVmaW5lZCBhcyBhIHF1b3RpZW50IG9mIG9yYWNsZXMgd2hpY2ggYXJlIGZ1bmN0aW9ucyAk
XE4gXHRvIFxOJCwgQXJ0aHVy4oCTTmltdWXigJNNZXJsaW4gZGVncmVlcyBhcmUgYSBxdW90aWVu
dCBvZiBhIHJpY2hlciBzZXQgb2Ygb3JhY2xlcywgbmFtZWx5IGZ1bmN0aW9ucyAkXE4gXHRvIFxQ
KFxQKFxOKSkkLiBJbmZvcm1hbGx5LCB3aGVuIGEgcHJvZ3JhbSB0aGF0IHVzZXMgJGcgOiBcTiBc
dG8gXFAoXFAoXE4pKSQgYXMgYW4gb3JhY2xlIG1ha2VzIGEgcXVlcnkgJG4gXGluIFxOJCB0byB0
aGUgb3JhY2xlLCBhIHNldCAkUCBcaW4gZyhuKSQgaXMgY2hvc2VuIGluIGEgYmVuZXZvbGVudCB3
YXkgKOKAnGFuZ2VsaWMgbm9uLWRldGVybWluaXNt4oCdKSwgdGhlbiBhIHZhbHVlICR2IFxpbiBQ
JCBpcyBjaG9zZW4gaW4gYW4gYWR2ZXJzYXJpYWwgd2F5ICjigJxkZW1vbmljIG5vbi1kZXRlcm1p
bmlzbeKAnSksIGFuZCB0aGUgcHJvZ3JhbSByZWNlaXZlcyB0aGUgYW5zd2VyICR2JC4gVGhlIG1h
dGhlbWF0aWNhbCBtZWFuaW5nIHRvIOKAnGJlbmV2b2xlbnTigJ0gYW5kIOKAnGFkdmVyc2FyaWFs
4oCdIGlzIG1hZGUgcHJlY2lzZSBieSBpbnRyb2R1Y2luZyBhIGdhbWUgd2hlcmUgQXJ0aHVyLCBh
IHBsYXllciByZXN0cmljdGVkIHRvIGNvbXB1dGFibGUgc3RyYXRlZ2llcywgaXMgYWxsaWVkIHRv
IE5pbXVlLCB0aGUgcGxheWVyIGNob29zaW5nICRQJCwgYW5kIGJvdGggcGxheSBhZ2FpbnN0IE1l
cmxpbiwgdGhlIHBsYXllciBjaG9vc2luZyAkdiQuIChUaGUgZGV0YWlscyBvZiB0aGUgZ2FtZSBh
cmUgcmVjYWxsZWQgaW4gXGF1dG9yZWZ7c2VjdGlvbi1hcnRodXItbmltdWUtbWVybGluLWdhbWVz
fS4pCgpXaGlsZSBBcnRodXLigJNOaW11ZeKAk01lcmxpbiBnYW1lcyB3ZXJlIGludHJvZHVjZWQg
cmVjZW50bHkgYnkgS2loYXJhLCB0aGV5IGFyZSBhIGNvbmNyZXRlIGRlc2NyaXB0aW9uIG9mIG9i
amVjdHMgdGhhdCBhcm9zZSBtdWNoIGVhcmxpZXIsIGluIGEgZGlmZmVyZW50IGd1aXNlLCBpbiB0
aGUgc3R1ZHkgb2YgcmVhbGl6YWJpbGl0eS4gVG8gcmVhc3N1cmUgdGhlIHJlYWRlciB1bmZhbWls
aWFyIHdpdGggcmVhbGl6YWJpbGl0eSBmcm9tIHRoZSBvdXRzZXQsIHRoaXMgcGFwZXIgaXMgbWVh
bnQgdG8gYmUgYWNjZXNzaWJsZSB3aXRoIG9ubHkgYSBiYWNrZ3JvdW5kIGluIGJhc2ljIGNvbXB1
dGFiaWxpdHkgdGhlb3J5LCBleGNlcHQgZm9yIFxhdXRvcmVme3NlY3Rpb24tdG9wb3MtdGhlb3J5
fSB3aGVyZSB3ZSBleHBsYWluIGhvdyB0aGUgcHJvb2Ygb2Ygb3VyIG1haW4gcmVzdWx0IGNhbiBi
ZSB1bmRlcnN0b29kIGZyb20gdGhlIHBvaW50IG9mIHZpZXcgb2YgcmVhbGl6YWJpbGl0eS4gTmV2
ZXJ0aGVsZXNzLCBsZXQgdXMgcmVjYWxsIHRoZSBoaXN0b3JpY2FsIGxpbmsuCgAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==


--=-wGv9YnAbelJyyW3pl8xY--

--=-ldBXJgrwJBYkXqcbGkjY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSZ7TKxnKGyBvBjzBmj8PYLiTOX/gUCaunsNgAKCRCj8PYLiTOX
/l/jAQCwSYl+jnlQ98HY/cBO+dVYJ5gsoCdwqkzHE/nxCYJXqAEAppf5fjgQOACC
cgHDJ0kftb+vAXedShoHosgcWB37gAs=
=zbAt
-----END PGP SIGNATURE-----

--=-ldBXJgrwJBYkXqcbGkjY--
