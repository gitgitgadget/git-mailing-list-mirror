Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794770690;
	b=MJS+ZYApSbZ4lgQEYj/l9kssmyXvXAZicVVmqGrxh60EI0sOaSXNIsFfWHOvIQvH4SZK
	 U+EjPQl5y3gnh9kvcmV0Hd9plHfwQU4xoB7MlLeEyKlgSDTSikNGbR7IyNF4+pBwVKGxC
	 WY3BUI0r6z+P1T2z/Vr0MQlQvLrtOeoMdzbQg4sf4cGoBnN1vBJw9Qpr25UkzWQsETsTt
	 M4a2PhHky2lz1EowGY5qFqPdSHqhwwPlkhM7PeWX0GG4aPPgBamSJuzPT5bZFQM1Upvrg
	 rQHd6ZRihQJ80Ov4kKzjtTl9kHKzPGwOXLGRnHgH+uEcskt3HDBoBNhOsevpG3ZHRCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794770690;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport:Content-Transfer-Encoding;
	bh=C/mtNbs5JlM0f743tU6Y2ZcB100CInUsWNcpQKtdeSg=;
	b=KFIsfmMc1/HgtBsZMAf7UeIXKv7dguATAHZ69BEjzB8NgQlhhlGWGvn6xphabQpuOTav
	 cAuo6LYfmTmeozaFC3plNMSn+3fSRZW61z6rMbN6ZrzV4EcR8JhE5Ql4WU2/NhVFM6PNF
	 39PNTEXrDuB0knAGq0NMfRxytyXOiVLRE4cJ2ZGs7E7wh8zBjAldq0+quYLZ7CYNoQtyO
	 Mvn1GtApOhGSD5dlK+2po/iLTiSs8RU5kNMRks9qy3Ucgcn+dsjKiqi+GC/eSFRdJP7AE
	 FdfkIYJ6axHnsSYhS+vkJkrbzVu6hlysA23m7ZwcbKOlWtzsxtVuGh6/6s4MMxjOYnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=YiYmzFIc;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCDB606A31F
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 19:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFCDB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=YiYmzFIc
DKIM2-Signature:  i=1; m=1; t=1794770687;
 mf=PEpvaGFubmVzLlNjaGluZGVsaW5AZ214LmRlPg==;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:rC8aly9K+3nAq5tsKAujPZbS8QSP
   +R/3qOqfTY3j4gEt4c9rdimAiAXUHJQQ+RgmjzncK/apefdEOL+ykKxq4ZHmNEDe/VaM6EirfEI
   GofrwHNkWSopgdCknJ6BfNsfdMHDVPmpZ5U2zP+Jb3qIHiX1ghMZYn4pSpf32c5J13pvx81yO+o
   hzAOw8vcmdx28K/LUMOFKt8siHU5FcJlMeC5ovfYqxOJ33QdT40oYavKAZaK9kAyB7Z1g3tA91F
   +9Be6VuR+LiaET25doL/c8+FLLCP1w2xX+3rsmrbFKIM1eJIyFgvb3TN0jLTCjoRDDCCBqP/Obl
   +p/sUVeBVL5JwA==;
Message-Instance:  m=1;
 h=sha256:
   RjfEk21JwcveUyQ2Nc5w66A1SBQZBkeT4BtOcxetC8Y=:
   vPvG6HU2IvIUytvJi26xf3YfUDjOqYqQzfw+UC55lPc=,
  sha512:
   Dac3ydlO/pjO/q5GNP5CK8il28jMGr8VZLqjFnwtI3p1c9RY93MbTGQ5x8qnrJGQVf0Y6PxvS3v0uhIeWgwD9g==:
   8EDD8ScX4AYqmxyeaohS96SwTuLLzWMIKIiIHav0YY9VFtgQ6o9cheMZkFbTwnOdeKBGctZkTOkDv1kVnOVPqg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794770687; x=1795375487;
	i=johannes.schindelin@gmx.de;
	bh=C/mtNbs5JlM0f743tU6Y2ZcB100CInUsWNcpQKtdeSg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YiYmzFIc4Kyk1K9+/h5Wcu/4GWmoVjAlYbXaDvDW5YvCDGmPWYrvwTA+1UhSbSnH
	 1vRWR76bBTDQid6oIZyjyxWoxGOKPyKsk1gfkdKazk9BIX+o1KaWLfRbeZFc2czXP
	 9AIg2XdIZTYrXw93/SUSwnROM4qWnganWIxpQrHjHtXaAnqYt/0nVAudNeoyRpsaS
	 Lx8eZeyXWixQfiIP9l6B1QhrkQ7sDMKvGQ+1ttOIkzpAjRV7p22mWCnafoUqJ2cTz
	 Cu0Fg80+fla/3Q1RUG1UkLCUH57eLR7OhXoXy4DVMvoIL+3f7E3/l9s5ZCtpwS6l2
	 rh3ZvXrCDP6zItTozw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp9i-1wwtrX2k3Q-00QUNL; Sun, 15
 Nov 2026 20:24:47 +0100
Date: Sun, 15 Nov 2026 20:24:46 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Phillip Wood <phillip.wood123@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH 3/5] wrapper: reject insanely large byte counts when
 reading/writing
In-Reply-To: <96c1d112-1b05-4663-90c6-33374dccd764@gmail.com>
Message-ID: <2559186d-395a-0db7-8297-6bd69d3fbcb7@gmx.de>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com> <b1ed701935027a83574fae753e5cc11d23f0ea4b.1791958171.git.gitgitgadget@gmail.com> <96c1d112-1b05-4663-90c6-33374dccd764@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:KsztzkcZ5cANKaANQA22B+0DPCvhB2ic/yckHkVFayvhIk6elJ/
 t5ojvN5TIEQWLVQiesKOtmftCi1N6cSWoSyvgvwVQDID6Y7EO8pL9ILhV3cAho7BtmE5cNX
 ktkOZ5AhppqyV2L69OGBoor2WuFw1KiT4fN1SpatxZhLnM/FJFetZlYXNFcgoNlJmzBB7KG
 O6bGqJ3g0qtQ7kF1staxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hFy/DDthyoU=;C2uzdu2rhVrJzd3yFDhIE73dXGD
 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
 IPYC4UdHINmhe/634ag==
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Wed, 14 Oct 2026, Phillip Wood wrote:

> On 14/10/2026 07:09, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > Both the `read_in_full()` as well as the `write_in_full()` function
> > accumulate the bytes transferred count in a variable of type `ssize_t`=
,
> > but accept a `size_t` count parameter. When count exceeds `SSIZE_MAX`,
> > that total count overflows after processing `SSIZE_MAX` bytes, produci=
ng
> > a negative return value that callers interpret as an error (or worse, =
a
> > small positive value after further wrapping).
> >=20
> > In practice, git never passes such large counts because file sizes and
> > buffer allocations are bounded well below SSIZE_MAX on all target
> > platforms.=20
>=20
> Are we sure about that? In the past we've had bug fixes such as c14e5a1a=
50
> (transport-helper: use xread instead of read, 2019-01-03)
> on platforms where ssize_t is narrower that size_t (POSIX does not requi=
re
> them to be the same width). I've cc'd Randall to see if ssize_t is still
> narrower than size_t on the NonStop platforms git supports.

True. Even if there should be no current caller like this, there could
easily be future callers like this.

So I changed this patch in the following ways:

- `write_in_full()` pointlessly returns the exact same count that the
  caller already passed upon success, modulo truncation to `ssize_t`. This
  is not useful, and I simply changed the signature to return 0 upon
  success.

- `read_in_full()`: many callers are really only interested whether this
  read was successful or not. Those callers now call a new function,
  `read_in_full_or_error()`, which returns 0 on success, -1 on error. The
  callers that did want the byte count returned but pass too large a size
  now no longer result in a bogus, negative return value, but instead
  error out. This might not be the _most_ desirable outcome, but it is
  better than before, and those callers would have to be vetted
  individually for better solutions (for which, as you can judge by the
  time it took me to get v2 out the door, I simply lack the bandwidth).

Ciao,
Johannes

