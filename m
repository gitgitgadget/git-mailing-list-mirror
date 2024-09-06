Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F9158862
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617300; cv=none; b=gh/zlr5II+a3dY06VZMC9NHA3TbPu4I+F4hE6lMDhZ05j6Nk18q4fdfr9koNBSuUi0jalrObS4iaGTaiWs0VShMxVISdokLkgPxJMfBnD1t0FVV4jznjdcEtGXcm5uvrtOagk0FA2sQ+UGNqS859aQu9jJwR1PvVl/ibDNWau1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617300; c=relaxed/simple;
	bh=hX9+3VxeE31eViCoqQZSg+kRJBaCbVh6XWm0IbntM4Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RpvTHWK8KTZpWSJAGwSY/aD5Zga6uvOY+AZpikVLd4GXhHjpA+Ui+rSSrW15kq7qFEi+Yb+ybsqwIY3dQaMh+eBHcbkUkrHx3MnhNxJG73aEsOLWiuG313f5QCxFXOFlkGFltl7ARUU0bOl9qdfeHsD/PhjPaPGOofxpCGOA83k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=WZLXJhEu; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="WZLXJhEu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725617295; x=1726222095;
	i=johannes.schindelin@gmx.de;
	bh=w95ylElKp+5j0NiKaL18vlhI1gDK4VdSq8MXzb8uFmY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WZLXJhEudYASM1uvwzDsC9nCaU+f7XNcbmWxr+lHayihKpEb7hZEb1n89jfMenOg
	 mQI1uh+IlY1J33mxaI7vT1Nu9agvfLBw0AuAglyouWIdF99ETt5AQWj9MD9bYUQgl
	 /lHt2+89nbP1GkMMIZ/tUvYRGmaSfMquCukvLF9jhJy6sGntNiP274Q2t0io6ybIU
	 /X52KTau/zAKPp9La5p9zVztXJaqhswpkHl/YUKssa+uV65ROJNlrDZ05OD3QF4Pi
	 hH5PW8pLaO3AIgzuqphe6pH5ptf2tnCkqIs35atvwz0c4/tOXEGkwshcAGe4Gqgup
	 2UhF1TKjn55N78teZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.88]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42jQ-1smVt11Ypc-0004n0; Fri, 06
 Sep 2024 12:08:15 +0200
Date: Fri, 6 Sep 2024 12:08:14 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?Q?=E9=AB=98=E6=A9=8B=E5=85=A8_=28Tamo=29?= <ttakah@gmail.com>
cc: git@vger.kernel.org
Subject: Re: word-diff-regex=. sometimes ignores newlines
In-Reply-To: <CABiJAjbEpYkcrxj82uQ=O27tR9fKoUFH0=MOCobDfa9cWsbdAA@mail.gmail.com>
Message-ID: <d0686080-6f7c-8128-dc24-ecafc13e0120@gmx.de>
References: <CABiJAjbEpYkcrxj82uQ=O27tR9fKoUFH0=MOCobDfa9cWsbdAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1113078053-1725617295=:4934"
X-Provags-ID: V03:K1:yrkpKk6SNtF3SHPOogHpesk5NDV5AoFDUHU1WoM+q73C2LPeiHc
 BtQ1j1T8+7qG/ZpKauzCdjE40nJWyAsn4AONbRKWM6HjI2tYEj98aKEqVabtiOSgqxVeGND
 /IV4hylqeIEVJvQa4MBK3WSj29HRbI3DdownCncure2QNcjKtW/EMX1MOTumGAyIGfpSn5B
 t05ztbAlrmPpOE/XYoJ9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GKpv7o56K70=;mDY0bMkoh915YcHHzuOORhovvZj
 lq0xCfi7CMVFCDEa0FjQqi/WzR3t71PvaZzADwVcW/YxD15Hw/DOKlTlk1FJR4oMnKxyAafCv
 lITYU9v68UKAt17/tAssdMds1LFygtUZ1PxEJeS2ywstfyTqUollWnk/lkICuV0rtg5GKy/JA
 X82GVZ6lq/kHut5Cu1e7uwn1k15gbRFpIokyeE3vgaWU21+pCgHaINpCkin4BGsa0PMePZL4z
 6qI5VMdhPpESzIGcmRmSNEKDke5RElccJBLQ5C/XiSwknpP1pBtEn1+UUBNJbO2U+UfQT2aT5
 9kL39A8rs96PumeH7cNkzmTTGhkekKqWWwLmDVfsIBvWjiNFaFzmYcXjlBv/JIH99FrTRFSss
 cE4udJDq1hcQVld0FL4B6FrKDMUdVawrsTngc0hxGQehXq9eq227XxlUNTdZ3+EXgFCmkk+C7
 ZHvFsOLMyJW6ZgIkoi8YWLpS5rTT06NQfc25Ye7Xf5S8D/iqeyHe4KMIYa8/LOFeOQl8l+3j6
 bZoiBBHE2o9W4BKXz+WnXZR+rAm6UAKgIFtuEr/7/HtjdbLh68LiCBLb5UXsmEnjymt73fGgQ
 HyJiWlMzs9rmdjwRUfIuDF2OemRQBlBkdUrNgV47q4KE0xRGHJTGBDRxw3EOrSXtUpM+AwEXW
 v88hZgUZ9aZ9Zg3w4KNlI5qBMxLcJue+IB/nHsX8e5dELMQQhI0gOSMMDjoJjUtE6ZMtMAQfl
 ADvH0F9BiHoHMXhz1qPHfMCDOrdXBi1tM916sqw/0NCNKooNvtAk7uxu6R+Ip6OCeMa3sZyxm
 yGtgh+E1m3kMvaFWFFczF0AA==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1113078053-1725617295=:4934
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Tamo,

On Tue, 3 Sep 2024, =E9=AB=98=E6=A9=8B=E5=85=A8 (Tamo) wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
>
> mkdir test
> cd test
> git init
>
> cat >a.txt <<EOF
> NRZ /NZRQ/NBRQ/
> NRZ(C) /NZRCQ/
> NRZ(M) /NZRMQ/
> EOF
>
> git add a.txt
> git commit -m 1
>
> cat >a.txt <<EOF
> NRZ /NZRMQ/NZRCQ/NZRQ/NBRQ/
> EOF
>
> git diff --word-diff-regex=3D.
>
>
> What did you expect to happen? (Expected behavior)
>
> diff --git a/a.txt b/a.txt
> index 278ea76..7e6f42f 100644
> --- a/a.txt
> +++ b/a.txt
> @@ -1,3 +1 @@
> NRZ /NZR{+M+}Q/N[-BRQ/-]{+ZRCQ/NZRQ/NBRQ/+}
> [-NRZ(C) /NZRCQ/-]
> [-NRZ(M) /NZRMQ/-]
>
> or anything whose hunk has three lines
>
>
> What happened instead? (Actual behavior)
>
> diff --git a/a.txt b/a.txt
> index 278ea76..7e6f42f 100644
> --- a/a.txt
> +++ b/a.txt
> @@ -1,3 +1 @@
> NRZ /NZR{+M+}Q/N[-BRQ/-]
> [-NRZ(C) /N-]ZRCQ/N[-R-]Z[-(M) -]{+RQ+}/N[-Z-]{+B+}R[-M-]Q/
>
>
>
> What's different between what you expected and what actually happened?
>
> some newlines are ignored
> and the length of the hunk is wrong;
> git says "@@ -1,3 +1 @@" but the hunk has only 2 lines

The reason is the regular expression, which does not match newlines. See
https://github.com/git/git/blob/v2.46.0/diff.c#L2268-L2270, which shows
how the regular expression is compiled:

		if (regcomp(ecbdata->diff_words->word_regex,
			    o->word_regex,
			    REG_EXTENDED | REG_NEWLINE))

Note the flag `REG_NEWLINE`, described in detail at
https://pubs.opengroup.org/onlinepubs/9699919799/functions/regcomp.html:

	If REG_NEWLINE is set, then <newline> shall be treated as an
	ordinary character except as follows:

	1. A <newline> in string shall not be matched by a <period>
	   outside a bracket expression or by any form of a non-matching
	   list (see XBD Regular Expressions).

You will note that you can see three lines in the output when using
`--word-diff-regex=3D'[^ \t\n]+|[ \t\n]+'`:

	$ git diff --word-diff-regex=3D'[^ \t\n]+|[ \t\n]+'
	diff --git a/a.txt b/a.txt
	index 278ea76..7e6f42f 100644
	--- a/a.txt
	+++ b/a.txt
	@@ -1,3 +1 @@
	NRZ [-/NZRQ/NBRQ/-]
	[-NRZ(C) /NZRCQ/-]
	[-NRZ(M) /NZRMQ/-]{+/NZRMQ/NZRCQ/NZRQ/NBRQ/+}

However, when including the slash in the boundary characters, the newlines
are suppressed again:

	$ git diff --word-diff-regex=3D'[^/ \t\n]+|[/ \t\n]+'
	diff --git a/a.txt b/a.txt
	index 278ea76..7e6f42f 100644
	--- a/a.txt
	+++ b/a.txt
	@@ -1,3 +1 @@
	NRZ /[-NZRQ/NBRQ-]{+NZRMQ+}/[-NRZ(C) /-]NZRCQ/[-NRZ(M) /NZRMQ-]{+NZRQ/NBR=
Q+}/

I am fairly convinced that the reason for this behavior is that the word
diff machinery special-cases newlines and _never_ makes them part of the
"words", see https://github.com/git/git/blob/v2.46.0/diff.c#L2072-L2074
for the code implementing that logic.

Now, is this a bug? I can't really say. From my perspective, it is not:
When I implemented the original version of the word diff code, my use case
was LaTeX-formatted scientific articles, which traditionally do not
contain newline characters within paragraphs. I still have a hard time
wrapping my head around use cases where any pattern that includes a
newline would match a what is considered a word.

I do remember how I struggled (and punted) on the question how to display
newlines in word diffs. There just is no good way to do it that would
address all valid scenarios.

Ciao,
Johannes

--8323328-1113078053-1725617295=:4934--
