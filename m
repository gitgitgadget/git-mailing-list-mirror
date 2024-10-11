Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33C804
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728670170; cv=none; b=bUp6e+0pe47/p/7xnlb3oJR0X4sbFHeXeA82UP9eEz1qVU98f6mGsyeyDUXzFc11ZkhqfW4N5/6cH3FeNmeQj8OkkbEcSIuLUxM5TryZPGW6J6aT213g7DTNTL6eQfnMOuGmauXVICc+0scgilZtB7TwlTanG07yor3mclpb0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728670170; c=relaxed/simple;
	bh=ydcOFXRKfj7WfIHCR+aRXwP0vfRu0PLrmAjed13emdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHiujWSvwjQRvJquCujfeRsnONH3LnmUvwGJLWsIdRbLez4AamTN7I7mITYVDFSNFPsTfV1GwihhP16xKgFh21xuTeB2vhBDG/b/jHj15q1j2l4QoBoPRx17HenR+RsMw2KyfplwKLe7G4VYlsKpW5TIlGv73dqAOuempBa8Usw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbf3f7272eso1442596d6.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 11:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728670167; x=1729274967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhVGzd50APDG+o24MSwgQVhQlD+GKgKPRlVEeAaS7aE=;
        b=S+mf34LWH3dEye5m7MygkY3tPqi5NC0AsOMHfoT4Ld+G6vsX1cGGYJacvPVhGQLKc2
         ryLiSGSOMirzjPEReg1V1Avz4oigJkuHWi/BttuGWh0+/PqazOzANmFPR8p9GAwL5vHn
         wa1k4N2B+foiNR5FdVRAAM61rQDji4KpsdiwCj7qDoNgjeQID1p9cnYGeEr15scFl1Gv
         r2xH3Y1p3nvwd4GQE3EwjowhtwnculBH6s0Q4wOWCUuQyRht/mwNGGHu2+DR+f5MJmwI
         uqDg4szX48Nx+im4eCPuzs4u5lx1slL35qUeN+f7nSWlYAPGWt1beWNtvmOIRRxhGSgN
         Jmug==
X-Forwarded-Encrypted: i=1; AJvYcCVlRU6BpGnxoEXysw+hQnoVW7mlwf2VTxXIfc+tqq951d7/8T+uuYhK8/9eC0m0mdU0eSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDakFGqq3Sl2xX/kWzodunGLszNV1AVjpsWhCwHr+t7ljIvLBT
	ahMhKWwExJU6u4StmENzFRztL70efGnbcsji7ps+nSTeQ6m/Z2DrWgAhtrBF6F5qYRQpUv+uqQU
	GLs8B8Y5VNlQgd4r8PX9HsPyBEv8=
X-Google-Smtp-Source: AGHT+IEdBH0ckvhDVOjdxvjCI2lJY2S6DFBpVIILCfWoYIiDacGJaC4vaG9NiFrXEOcR+KfCXh7hE2oSN7EH+Qy/uus=
X-Received: by 2002:a05:6214:76c:b0:6b9:5c25:c41e with SMTP id
 6a1803df08f44-6cbeff323d8mr20890636d6.3.1728670166782; Fri, 11 Oct 2024
 11:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010235621.738239-1-sandals@crustytoothpaste.net> <20241011074022.GC18010@coredump.intra.peff.net>
In-Reply-To: <20241011074022.GC18010@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 11 Oct 2024 14:09:14 -0400
Message-ID: <CAPig+cRmyZhq1qtomTFP7p7XMqrCP8-u7ah8D2+yUtrL880y7g@mail.gmail.com>
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perl
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 3:40=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> On Thu, Oct 10, 2024 at 11:56:08PM +0000, brian m. carlson wrote:
> > This series updates our requirements for libcurl to 7.61.0 (the version
> > in RHEL 8) and for Perl to 5.26.0 (the version in 15.6).  I considered
> > the mainstream LTS versions of RHEL, Debian, Ubuntu, and SLES, but
> > omitted consideration of paid support extended LTS, since we cannot
> > expect Git developers to have to pay a large corporation lots of money
> > just to test functionality.  This is in conformance with our policy,
> > which states that versions must be "in line with the version used by
> > other long-term-support distributions", which does not include extended
> > LTS distributions.
>
> I don't have a strong opinion on the extended LTS issue. Like you, I
> don't really care about dealing with paid support. OTOH, I think in many
> cases there was little to no maintenance burden for these older
> versions, since we'd already done the work to #ifdef them. But I guess
> since you broke up the patches, they can always choose to revert or
> include what they want.

I may be in the minority here, but I'm fairly negative on this entire
patch series. As you say, supporting these old versions is effectively
zero-cost, so how does this project benefit from these changes which
potentially "break" Git for users on older platforms? I see no upside
here. The cover letter provides no strong justification for
(potentially) inconveniencing people; the argument about being able to
utilize more modern Perl features is weak[1] at best and is not
convincing.

Although brian is (quite rightly) concerned about security (or lack
thereof with older installations), it is not this project's
responsibility to "force" people to upgrade their insecure
installations. And it is not at all uncommon in the "Real World" for
decade-or-more old installations to be running in production
environments, and programmers need to work within those environments,
however, those installations are, for various business reasons (such
as cost-effectiveness and known stability), unlikely to (ever) be
upgraded to more modern versions. I, personally, deal with such
installations on a very regular basis, and in my experience, the only
time upgrades are undertaken (in production settings) is when the
systems break completely and there is no choice but to replace them.

Finally, there clearly are real-world cases[2] which benefit from Git
continuing to support older platforms; why should we abandon them
intentionally? And why should we turn down[3] the periodic trivial
patch[4] which trickles in to help people on older platforms?

[1]: https://lore.kernel.org/git/xmqq1q0mh9gn.fsf@gitster.g/
[2]: https://lore.kernel.org/git/CAOO-Oz0NUA-YeyFT1MJ=3DXKyLWJvQoFH1b-F0EFO=
zvy8iWka3KA@mail.gmail.com/
[3]: https://lore.kernel.org/git/ZwhMmGt0kZvaSzSL@tapette.crustytoothpaste.=
net/
[4]: https://lore.kernel.org/git/CAOO-Oz1KhFcyErVx1Qb142PtPJS=3DUpgSD-Facck=
qNS4_okAtFQ@mail.gmail.com/
