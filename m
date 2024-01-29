Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF86E76054
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706557273; cv=none; b=VeA0Ud+1nVxAoUOA9/vbqzcPPn4LH45hUTX4JpqduBJ6OO4DFVdu6ENDsUJ2Kdl9DyhjdXAoTUlxVOulZv6Srjw3CHRZ0jldkLozRkRjEmzsI+PAOqKFLGXonVugdr47wg+BH6kDgWsOr8oLGWaBIl7IMK8JFr/ZJfD2YZLBCqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706557273; c=relaxed/simple;
	bh=fiYZXK61tdHid4COfCtfo0VmZNJ5ns05Er1/WMokcWQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=U+f/5tcxJxns8T5kvKyMYwH5jJ/ZU8xyqndkTl1KgaKd0PftHIxtYRddUu9WC9ds1fJBnGKMNAo1p6SAg3DxKCjWINzW2SJ3j+aJBr9BcK76NRibB6Fq7csrlFgNIqcec1Id1A+6UOS/H6ss8GMuiThUEEhVnA6yPCXDiNX21Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=VIFw12JQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NDzz8d55; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="VIFw12JQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NDzz8d55"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BD98211400BB;
	Mon, 29 Jan 2024 14:41:02 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Mon, 29 Jan 2024 14:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1706557262; x=1706643662; bh=h0M/j4CyLnGd180W+hMPMCdkQ8aPiGG9
	zSpXQhSALAs=; b=VIFw12JQsfDeO2rMXuqODzO6Fc987mwho1S4DvwZDZCI3xMz
	PRU2Z/TV7comw3F0qPL9DSYPSN1qqyXRCA14PzztTKfWJacTjJQMKuhMu6BK7GHE
	fzct2AxeUkLFNXuIY46SfA/mIZieZI9LinW7l8pEqnrBL+m8wUr1/yst7dLGgP1B
	1yyECaQXw5VxVh410rcY/87JaUQOMeYz+VSnoEHkgPL+/u/76fMwFKyJdc+Yy+GN
	xWESeDFMinNZrjPN0r+Yxa0uXEjY/zdrBqbtA7/otMJOA1UIvHM8Xx631PN1o9E6
	QUspDNl92kXqeVDmj3eTEIIX7jEI6AC+rosEXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706557262; x=
	1706643662; bh=h0M/j4CyLnGd180W+hMPMCdkQ8aPiGG9zSpXQhSALAs=; b=N
	Dzz8d55j4i+PTOxaEkjqfH4flH2zxAJr3Nk1VDZirwaWyfIXXB1Hvgvmcxtc+Kyw
	kAEFaonOSii/iYaLm83jSQRi/r0f0i7gn+SzTOmN01hZIyyeMtO3KSSeUsLqceJC
	PSv6Y2PDxYPlJANuLryqCYm954uQxTpNqXDBwcKTE7mMFckCYLVRA2TcJVv1EGZJ
	yR/g+JWCry68w54ueSO53rHvNcGpnnaPXra6BuKveURfST1UoHJ1CdVQFZvF6ZVg
	lTlX0DgoCKe6sx0/3nhRP8B8jpMw8eWWwXiRwqz1bTOBhu3jR6rVEba1jUVJ3eiN
	rIJlddpNm3AP47ieesOiQ==
X-ME-Sender: <xms:Tv-3Ze-jrE16lNS7n8jA3IlmT4DPIskX_XZOClFhdwpqilrO0pdSgsU>
    <xme:Tv-3ZeuiFNhv7yufakmvElVGKt3Qe9fivP1R5H0z6ZojVY45e9wgeJw7wHEo57zZw
    dbaOzQH-IxtGjuz4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeeh
    hfeliefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:Tv-3ZUDYLH18_QP-JzJShpwmP-i1WYc5_zPU-5EG_BuUVf0kPjrz2w>
    <xmx:Tv-3ZWf_RLZCED93p0_dEyF2q6NT7M47-JthQ3fod5bxxiIjjmP0HQ>
    <xmx:Tv-3ZTMND5qtkAz2PhjQHVXy5rIBTZMFqW2um8B2M9SejkUU79BRjQ>
    <xmx:Tv-3ZcqqHiJEqgeUh6tH9y35hti3tJzTy5HRGGQjD_ztkgo-UHle5w>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 70F7E15A0092; Mon, 29 Jan 2024 14:41:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7f97e5e4-c394-4403-94f1-6163fbd02e88@app.fastmail.com>
In-Reply-To: <87il3enc1i.fsf@osv.gnss.ru>
References: <xmqq34v6gswv.fsf@gitster.g>
 <CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
 <87a5ow9jb4.fsf@osv.gnss.ru> <xmqqsf2nnbkj.fsf@gitster.g>
 <87plxr3zsr.fsf@osv.gnss.ru> <xmqqa5ouhckj.fsf@gitster.g>
 <87il3h72ym.fsf@osv.gnss.ru> <xmqq1qa5xq4n.fsf@gitster.g>
 <87ede56tva.fsf@osv.gnss.ru> <87a5ot6tos.fsf@osv.gnss.ru>
 <xmqqzfwspmh0.fsf@gitster.g> <87ede4fg8s.fsf@osv.gnss.ru>
 <xmqqzfwrjdul.fsf@gitster.g> <87il3enc1i.fsf@osv.gnss.ru>
Date: Mon, 29 Jan 2024 20:40:42 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Sergey Organov" <sorganov@gmail.com>
Cc: "Elijah Newren" <newren@gmail.com>, git@vger.kernel.org,
 "Junio C Hamano" <gitster@pobox.com>
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024, at 14:25, Sergey Organov wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:

I agree with Sergey.

Let=E2=80=99s suppose I=E2=80=99ve never used git-clean(1) (and I almost=
 never use
it). I read the man page to find out what it=E2=80=99s about. Oh, it rem=
oves
files that I haven=E2=80=99t tracked. That sounds dangerous. But I see u=
nder
`-n, --dry-run` that I can simulate what it would do:

   =E2=80=9C Don=E2=80=99t actually remove anything, just show what woul=
d be done.

Great, this is what I want. So this seems to mean to run `git clean` and
just tell me what would happen. But now I=E2=80=99ve already read that it
requires `--force` in order to do anything. Which means that I don=E2=80=
=99t
want to just run:

```
git clean --dry-run
```

Since I presume that would give me the =E2=80=9Cno `--force` provided=E2=
=80=9D
error. Which means that I want to tack on `--force`:

```
git clean --dry-run --force
```

Now I figure that this will run `git clean --force` but switch real
deletion with printing the filenames.[1]

Junio wrote:

> What I find broken is that giving one 'f' and one 'n' in different
> order, i.e. "-f -n" and "-n -f", does not do what I expect.  If you
> are choosing between do-it (f) and do-not-do-it (n), you ought to be
> able to rely on the usual last-one-wins rule.  That I find broken.

Now suppose I have noticed that some git(1) commands have these
`--[no-]do-it` options. I know that I can leverage this to override a
previous option. And that is useful when I for example have an alias
with `--do-it` but for this invocation I want `--no-do-it`. I read about
`--force` here but see that there is no `--no-force`. I then assume that
the only things that have to do with `--force` or not is that option and
the `requireForce` configuration variable.

I=E2=80=99ve also seen `--force` in other git(1) commands. And they usua=
lly are
about some specific scenario rather than the whole command itself, since
e.g. committing one too many times doesn=E2=80=99t really hurt. But I un=
derstand
how `--force` applies to all the useful work that git-clean(1) does
because all the useful work is also destructive work. So this is what I
expect from these options in general:

1. `--force`: require for the subset of actions that are potentially
   dangerous or may be unwanted in some way
2. `--dry-run`: simulate the action (specifically print everything that
   would happen but don=E2=80=99t do anything to `.git`, to untracked fi=
les, or
   anything else)

And I expect these two to be orthogonal. Because I might want=E2=80=94if=
 the
option is there=E2=80=94to simulate some `--force` (e.g. `git push --for=
ce`)
with a `--dry-run`. As in: what would be printed? I wouldn=E2=80=99t exp=
ect
`--force` to override `--dry-run`.

=E2=80=A0 1: I=E2=80=99m never this careful in real life. But this is ab=
out deleting
   files without any (from Git) recovery so I guess some prudence is
   required in this case.

--=20
Kristoffer Haugsbakk
