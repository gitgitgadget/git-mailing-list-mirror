Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A5D20C46F
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637452; cv=none; b=O5EsnYYaIwSG2X0nbOOvsJw62SSZIKnR+uuBEnvWjX2dVeH4pwfK+Qe1AuksRBt71aPMzOMYiwceX67FrzPVNrE6c/zfxjXC9+foSBDpVPV4a4ZuvPu+ycUxul/SoMdG3FmZGDfVn0R9vqHLJwxqhE3eYIjgYza/lnAKCj9fSqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637452; c=relaxed/simple;
	bh=Qr5R+Gps8x+ZKgf3/RZ1q6T2zS4MoAuVhaOjPFLg58M=;
	h=Content-type:Date:Message-id:Subject:Cc:To:From:MIME-version:
	 References:In-reply-to; b=L8j41rA7qrpmm2oSLNy8+RoZk25YHqf50e1K3wULqKhSttXs2fTaML3zJBEp9woqzCcuM8Vg6ymRilDJkWKHjuUWyE67pOBQPQDj3nkBWRNUmiVP0F/hkHVL50Uh1SJIQTanDuk8G6qCb5086sEAEj09pO2om40gUSxwV3w3uNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=jKqB7Gis; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="jKqB7Gis"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=Z+Sfx9wqrHeL6WQVp0wVqzHp8V4Zi/X0SILltXMQrkQ=;
 b=jKqB7Gis3pseR2vzzvXHTwBbnSxmAciJVir/+6yqQC3UbdQYEKJDCi5tpu+9522vxUHWU1ysj6Sc
   0RyOVuUTD/wHBqalAelotGV434GPfGfzkZBydTrp49t6c+DrZUXK3qxMJyIHS/uGo05IlxcTdH7u
   z+FojFk7VoNzqDatNwSOkfh8upYjLR6KUVGL/8n3/c3G4VTCjzf+6HPU7HL+5hM+BZVv8eJehFCb
   kE+U4+UejtSENLdQ+OImztZPsPijIqkK1P4xsvPPBaT/2LsvhMSOH8oPX3DcPNmrTjpCGfrrlWvE
   1SVoc8BoiNrQnmUYcwCohfiYPHLtZDCN48oJLA==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL600MZUP6QF630@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 11 Oct 2024 09:04:02 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Content-type: text/plain; charset=UTF-8
Date: Fri, 11 Oct 2024 11:03:30 +0200
Message-id: <D4SUTJDV0Y04.3Q8YED2MVOKBL@ferdinandy.com>
Subject: Re: [PATCH v6 3/6] set-head: better output for --auto
Cc: <phillip.wood@dunelm.org.uk>, "Taylor Blau" <me@ttaylorr.com>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>
To: "karthik nayak" <karthik.188@gmail.com>, <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
References: <xmqqzfndndfm.fsf@gitster.g>
 <20241010133022.1733542-1-bence@ferdinandy.com>
 <20241010133022.1733542-3-bence@ferdinandy.com>
 <CAOLa=ZSV50OkDC2p5AHHW0u+fAtLMcCX36W1SuT8AnTkX7HNZg@mail.gmail.com>
In-reply-to:
 <CAOLa=ZSV50OkDC2p5AHHW0u+fAtLMcCX36W1SuT8AnTkX7HNZg@mail.gmail.com>
Reporting-Meta:
 AAHMmVLZzPZS/o+H4svL0TEGtjNH6/98eocg9PEqbxhdnsZHmm45YksMQBZnH1qB
 weo6SIjE/5FjXHdpOZwlom0JfpsSytH0nyR3nmtDnAyUvFy937Wr79PeMQH2OjIT
 KwVi/XY9AucPd/kMFI/XVNijSCyJZV9kvVfKyJW5VLGBNgss3bYTl5i48GvbgsuI
 IS4WQPSH9549K3qa5J9Lpvuc155iI8FWogDsuAV1ZiHpfnWkXZa1RbEZShLoDKHU
 iKbcWna2fD8qt1b73g2FYwLDnW+ylaH1iotBYUGLvXvrA7KrZKR6/d5YmafN4npj
 rtG/YZ/b8WT2EEBe4L4wzJV23nfDUExwU9l0qTvQ1hpSfH21fCJP/ojEMAu7zFS6
 YM/6sF/80DDZ/i3jaoVC2+MTnpzxsaOvBF5p0M48AbQ/O2+bMKD15TgLYKszVuhy
 Yb6Pfmlq4s0z88dwJptGhTHomEyR0TKcvilN2fQn+eLgTRAi0r4gEYo=

Thanks for the very helpful review on the series! Most of it is clear to me=
 and
I agree with, so for brevity I'll only comment where I have a question/comm=
ent.

On Thu Oct 10, 2024 at 23:05, karthik nayak <karthik.188@gmail.com> wrote:
[snip]

> > diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> > index 532035933f..77c12b8709 100755
> > --- a/t/t5505-remote.sh
> > +++ b/t/t5505-remote.sh
> > @@ -429,12 +429,51 @@ test_expect_success 'set-head --auto' '
> >  	)
> >  '
> >
> > +test_expect_success 'set-head --auto detects creation' '
> > +	(
> > +		cd test &&
> > +		rm .git/refs/remotes/origin/HEAD &&
>
> does this work with reftables too?

You got me there, probably not. I'm guessing I should use git update-ref or
something similar to set these values manually instead of editing the file.

On the other hand, is there a way to force the tests to run on a reftables
backend? t/README does not mention anything about this and since in a previ=
ous
round it already came up that I forgot to update the reftables backend, it
would be nice if I could actually test everything with that as well.

>
> > +		git remote set-head --auto origin >output &&
> > +		echo "'\''origin/HEAD'\'' is now created and points to '\''main'\''"=
 >expect &&
>
> Nit: might be cleaner to use `${SQ}` here and below
You mean something like this?

	git remote set-head --auto origin >output &&
	HEAD=3D"'\''origin/HEAD'\''" &&
	echo "${HEAD} is now created and points to '\''main'\''" >expect &&

I tried a few variations and this is what I could get working, but I may be
simply missing something with the backtick.

Thanks,
Bence

--=20
bence.ferdinandy.com

