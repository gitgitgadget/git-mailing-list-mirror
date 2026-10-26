Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793002028;
	b=vXqSJSF9g3McTd6HDwaUpBfvnGuWJ69hdrLeka8iZoxdiAolVhTRkvLBjCL+JxDawJCB
	 6OJFGU4E9UR5W1aVnuieuE+QirfezvkBOHf/vXfD+i/xMZMAHIt8TWjtMthUDt8NNS+6y
	 BYvq96FTSOWXJZBFYV9Bz17I0qwEpICW9FuG+Vt4TJ821QJRCRcCZcjprja8d3agmoQLO
	 ZIELPXcRgoCV4VhhJRYWZzn1VBo7vI1SwRPYGWkegoc8kjK1B6U3vglwf5V8aGA8RJMNk
	 ub8bkT05c3SSQ1ljfELUiQ2qfmmVn8u698IcbTslFdp6wLlEiW+vgy6cJM3gAdWJqHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002028;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=P6K1jgJbYSKTR4wnDt/aOzuhfBjgHj5qSUmCChd7baY=;
	b=ZIPbgIz2aVD2d7WuBQuSCOXA/OFPCiDzsXt7Xzzcr4yr6q/wZ0LOpDL89NXnj+C2ok38
	 yYAbXIl3ZTaHBeMqw6OpjEJQY19n94N1YgKr8iLPPPQG4ZxfaOY2Eajwdaf0b+7HqCShv
	 KHcNu5HIUJFS9R1WIDb2kelO3MmZXcqWD46oBTWDIv4CoKghLFohHPdeUKKH/LGau5uNs
	 y2M/yy86IWIHHCFZ639DqqDD0LZwq9nHyRggitTQO8dDBv6tek6v6564X+bIUkl9hQTON
	 VOOjt1HlHx5/cgdGHRYsly2WTWYg7tUzUDu/KjUexku9FPMjFWWiEBt/QavH2TNZX1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=hNilr4pt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xZ06cNuF;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EE8606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8EE8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=hNilr4pt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=xZ06cNuF
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B74A1D0023C
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:07:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 04:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793002026; x=1793088426; bh=P6K1jgJbYS
	KTR4wnDt/aOzuhfBjgHj5qSUmCChd7baY=; b=hNilr4pthG3Gek9wUQU6XvOKKZ
	rKHpccl0IxVvYZvRKHXq/IVb/BRZfuKY6QYR7W2PT0i6PbAgwInKbGpdd7KuBUxw
	8B+3s5KTGCAYenurqjUT8PD325rnBWmiNm2p1+8uitfRjXzeOr9P2mguVF3fi7Ap
	y39QcpYykyFz3RqjxGxefZeA8t2URoTKO2x1bG+RpRX9Dw3vrNatWLlOJdeCXRDs
	92QCb7PBsJfcKehRSCjsftLSeaUI69lfrFSM2Id8jxCm3eGzLta03u3q4+j8L7HD
	HdVfUV8rCBE4tLIpUaFfIVWdrSLn3ZW2iA0T0K4Gna4DpvDQUvonv+eIso3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793002026; x=1793088426; bh=P6K1jgJbYSKTR4wnDt/aOzuhfBjgHj5qSUm
	CChd7baY=; b=xZ06cNuF4Q2N4pwv5R4bRy/4wHR1yIpfuHWAzWOSO6vngWK6F/f
	tMjDizM/h+GqU2JoUqxi4Oaex3Wp2HwFBH1tL8aMp5tuxpA2n6DXjAcemPNvftqx
	kp/S15EN7Idt1h95wiwS+s38LoyyPaCi4qcHRGT3pxRjqX06vC2Q4m1RG82uBThM
	wFjPqffQDqeg/c0ztY1AWo2hzHStzSaCNUtw62zznVTTyXl6ecdoUDwcW74mEmTs
	7tBQMTUf+yIaUQH6xoZqyOmBMsqQDULAPriNQIWqFL2mxTeue7ZCsegMKTMR8X5P
	zjzS6zHxfbkP5/uU1Se8cLBpsdm7PIIBe0A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793002026; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aPa46oFGot7l9Ncdz7yWONjvwOG5Nx0necECZ5NdTn7ecOw
	fmVgxLgDFhcf1p3BvpgMMcfZFsqP5enrSOZj9PkTPLVegIvEc6G4phiYTjTE9Kmn
	CeJZyMHwxyPVXHgqly0jEiBz5v8uodt5s4dDmhawOEmNxLbVlSdg1R5GtC/N5p3r
	3XdR3zh22MoU6DF9cfG8ngEO62SyIZLBzLTZbxCXQL5OuWpX4e+lWAvFK2s1k5Bd
	o5WyVK6plLESVHvnfCotuBl9UP1zc+6g28umKIDMQDb1iRfKwW8WtHaT0UxPs255
	Cf9uNTJ+ypfnIJZ5O+zqfhOJNn//vA2v8PQJMwg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cQuFP+Y/V2KdCEAwTidHwtfy6WhSIiP7rQjJNCKwies=:a9j9S/2Y6hC/fcJAOragcxn+nIsY+gRmjvTHKix8RfI=;
X-ME-Sender: <xms:KgrfajIHQcS7CcEYrLtVva1pxp4LJaR8MhpXscdqpUWJcpz-QGMmmg>
    <xme:KgrfaunzEKwyUYZzW4hFeXnVvF_Qe1114pYTFoSVJp3pJy1WIzGNbGUIfZPER9agl
    r_qri2JYtPEU-VFJQL73za4Nu9O3DPoMVZV8drnM1Qiojuc52c9fiY>
X-ME-Received: <xmr:KgrfapE4pZtXrOb7KmyrIepilArx72qcQMWggd1UBcQtHYw88fNqeQ>
X-ME-Proxy-Cause: dmFkZTGjHwKwX8z3NbqKjlazFEZNhO7J1kDfvZ1kX/aQIQ5QT4XC5ui7R4KBR9PMRRdpxc
    KqUPqClbEnFDmdaMF2ZBhZ/5zItkR6JTrHZ7WJQmiKunmIiGo7fKBDOcWt62s5fOSHfOc6
    +1YXZXRkDi/wB07Ign/zPudHBczyRx5hLV58h4n/vBXLes6ek8KW4Yv6ZL7Z+5LvNKUrMl
    cmvdIlDd1sMJf6nCaJzAHgd5cQkWbbXuFIGZWzqdYP56j0uQR3w02xwSOBLSJ5985QVwXC
    JhBmTni5rPtoTgYYtBG1hy8lWeblulUqzULo8X9CHYWRrf1bE01a4rXfBWALXnstDkbrIf
    ywHrx1YwtuIK4UW0DX8Axtg00uAAGlcDeZJOw/bk2GjuNT6AQmLS9FbIsiDq6smt4Z0P1h
    Hkzy0WGuAsfFNEKSHd6yj2v0b+zCdb0Mb0s95THvyqrDXxSoUrLWYlfdBT252VKHgkyPpO
    lCfp5JWechMOXeR27v15mIKwnqRmy5mjfl7W5taBNxlA+OvSNKUgePmutBxq72xfcbrCZL
    j1o2pQrL3+MtalVm2s3SCULudecNZgsr8uad6ZhRiPPRjelTR5ZpRnnYmzlFCnVIFZUGiI
    4gA8ougqJJN721KeulI7k9XDVrhwhJAryE/olvlsg92H0pkzISyoukOaLr/A
X-ME-Proxy: <xmx:KgrfamHfoYJdtwcv45mlqzUksl52iCotvh3AnO4Op33nMxXLVG2fkA>
    <xmx:KgrfauO9aoMxGMnXJ1GwpcDNCYZwVnIR4MpXB4lQJj7L3-4NUjPvSA>
    <xmx:KgrfatFM4swdAc9WInJaGtRq5TntI5hFZ6crBuQpEHmrgVWFbFKm_Q>
    <xmx:KgrfatOE3QnruVDxkZXHVCnAM9VTqpd3_PpilHBnogpABOG25Z0-6Q>
    <xmx:KgrfasAi0PuRLikxhu-cAi5QwtYm6RfdTXIWiwdQrgiIjeV7-wGlMSA5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 04:07:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e3ea3048 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 08:07:05 +0000 (UTC)
Date: Mon, 26 Oct 2026 09:07:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] ci: fail the build if perforce, git-lfs, or JGit fail
 to install
Message-ID: <at8KJi0eMEpN1NoO@pks.im>
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
 <pull.2403.v2.git.git.1792774249888.gitgitgadget@gmail.com>
 <at79nEHLDrcoCgn_@pks.im>
 <CAHwyqnVVCp9ovsHDtc0pHYrFvpmdJq74gyx9yf3+ZWkL+d=CVA@mail.gmail.com>
 <CAHwyqnVGpc5ro+TksGGv4sp_JT-_ntuQjuXfVPSaeW+BYu2Pbw@mail.gmail.com>
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
Content-Disposition: inline
In-Reply-To: <CAHwyqnVGpc5ro+TksGGv4sp_JT-_ntuQjuXfVPSaeW+BYu2Pbw@mail.gmail.com>

On Mon, Oct 26, 2026 at 09:41:45AM +0200, Harald Nordgren wrote:
> > > >               wget --quiet \
> > > >                    "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" &&
> > > >               tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
> > > >                       -C "$CUSTOM_PATH" --strip-components=1 \
> > > >                       "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs" &&
> > > > -             rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" ||
> > > > -             rm -f "$CUSTOM_PATH/git-lfs"
> > > > +             rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" || {
> > > > +                     echo >&2 "error: could not install git-lfs"
> > > > +                     exit 1
> > > > +             }
> > >
> > > This could all be a bit less convoluted if we had `set -e` in
> > > "ci/lib.sh". But that certainly is outside the scope of this patch
> > > series, so meanwhile this looks good to me.
> >
> > Yeah, `set -e` is a gem of a command. Would be good to do later!
> 
> But wait, we already have it in "ci/lib.sh"!

Oh, I missed that!

The question then becomes whether the error message is worth it. In case
we see traces (`set -x`) I think it's somewhat pointless as you'd
trivially see the last failing command anyway, so you'd know why it has
failed.

Anyway, this is all a bit of a tangent, I don't think there's a strong
reason that this really must change.

Patrick
