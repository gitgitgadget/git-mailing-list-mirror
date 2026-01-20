Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9021F8755
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 02:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768876907; cv=pass; b=rI1WBxr9mDsIdXE3A+zhYdMjrhmew/f8ZY8x3q5YM70vZw3bA8ZMkVGGo9YeGYMjjbvNFN6hwhsLXkiHr8O0rCGss5uZEjX/iM9aducl5ECISfnAQMFXNG5n20VuvDa0+dbFdqvSIfGbRgtAi0AQswSb5TAOYUkf5wABFK/JO60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768876907; c=relaxed/simple;
	bh=0nB7zyfU+Vuu2XFkw0sSuUgwcmlONORH14SeeH6WlwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=R7Y5hftM9GB6qDrPT0f6xO5ZJL4tSxqLgzLFZY6/9qtgVnsWPjLhDyrfSUS8FWi/hw93KyTrtH0EO+vJhYs9fvvqVwYn6/QoopqzxNrx45OLGLxjs7XFEcMicJXIK86UxBFEjxC9bR3OtLyQeW9/b427KcYhLD0J8IU8cc1K3Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpnHiUZE; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpnHiUZE"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c565b888dso3837591a91.0
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 18:41:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768876905; cv=none;
        d=google.com; s=arc-20240605;
        b=XYY0YVY2npNouh8Rplogs37lZ+Zj33Lf8bWDCwBaAuzM7JQ6zpIgSuhQ5ddKeykoWJ
         5pD5d5XPwR4ruNlIdJ+2sBrY0mKdnTTQF/pBaU/ZWdoIjv7uDkIL5ty5ClCQx+ZB1q4y
         UuMjMWauhciLkN5jhEDzsG2DKdhzP8z7r4LdhLy/IMotnX9iBSj+lZo9Qi1whdw/WHuo
         k2R+ry1uMLZzxwOUHYzOAiQFOEp74S5Ky/6PQpV9r84YAeqmL9XibOJABTskyXg/verp
         tVzZDZdW2E7TF36oKAtI00bDbkp1VG9wxWfu2yyJ1cAzH9eFd3D5xtYINnhrW9R/Lq4M
         gCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u8hJTbAZcVd4lbqR2hSvoZ7W4zRTEm7kKYCIg+PsNXg=;
        fh=rQ3ADn2laSSn1m5oYTR3rNI5Abydc990M0C4OY6+nnA=;
        b=hKBdI4H/l3qNwqHFAHVS6VuPiaL6X7kD87k3dEJAuKH14WNIfkWo2glgAo9VRlMEE2
         i9FD0ngbUyBfGAQWezCzCmzjs4rj79W+cttCYXi9Gu+nRugMH2DIVFdaPoXq6Y4anbDw
         YDs9noU1hOPsD0q3XsAom08QLb/9uT1lnaqBMr/TQnxlt+Ktig5ux1uGhkpW+Lr1u27V
         VCNXS86FN2Ir3RC1diNjxb5RE413w+A2BmbniSv8Wgi6p5O8ePZIqHm5n8S+5qZP34mv
         41qp8eSXMn70A4EBADY9n2N/BRx4eVgec612YnkkB9rEmuY5f7kAfq95tQroFE9W+qNb
         Imhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768876905; x=1769481705; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8hJTbAZcVd4lbqR2hSvoZ7W4zRTEm7kKYCIg+PsNXg=;
        b=XpnHiUZEn3ziFDd701NT5Gx6L/eVnSYFuP5ykL+eADfNzvHYtmpvku9btvrR9OrZY3
         zIStXBXjuL31eOxrNlTCQAcsDu3wsjF5s4SHJWf07HLsPM3qQy6N/36I1CuuwWZs//OF
         ktk2StWgoAs8teDgEVWt1JFazBXzPqlTLS7dqwugn5+jAB6tRJKZzoxlf5vsi9ojTpVG
         goQC1sbvEsPUxWk+W/B9ihcbC2AXJxBYtCjNEAS1+k9OOLYSU7nqvBWi/2d9+25r526U
         5Vvmu+PU38TNLoE6KyWfu2Cs0tQeh20Nq37QCepMPWD60xfuUxRLpu2/kV1afSSlmIIF
         OI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768876905; x=1769481705;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u8hJTbAZcVd4lbqR2hSvoZ7W4zRTEm7kKYCIg+PsNXg=;
        b=YLpCgI65p5idTFnzIedPgra88PhlXAJqUiHUDN6Bt2Se0SIgm/1JZG3xOImHYbe4gv
         YVhuFHOfwJ3rApvvdCIB1BtvJHSgTayssIJC+GS4yUBNgj3vwcC2QYGibhdWU2czWitn
         KiF0cLyVha6J5H8giPrezpIpCydI4HYCMjIevC8nbMiSyJnAcfGw/xTs/PDhCT2K99u0
         zr8zlZiR9T5Op2mbXGsafawdjHbnLq59AysMOBJhCgMIFoSTyedwQ4IRzoV63mHvPvos
         IALAh/JnhvQLXM3YeSwnhL81r13nfpL4G1YjoxZx2szzXrfccxFhM8SLgzXWTc448jrj
         bJgw==
X-Forwarded-Encrypted: i=1; AJvYcCU19S78y50lYhJH3TVh43auZaJjCWqk9FCJ0vU5r39JNbx2W3T+zWMpW/S+4vv7Xd2odG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG3GEFhaDlwEt9px1DxAHhMpyuehI3PYyXKetSMTsQY1R3l3ga
	8Wt9ktAhclYkkJcAJzi/BOh7wSuKobowvUqUtadDhAYvjZ1UP2dTSfcP28are+R6uSHTjF2dfMn
	/ShAZBse9Dt7x5bxKiP2pYKaXDR+kriA=
X-Gm-Gg: AZuq6aL20gZATo2O6jqDvSVSVCq1YQo1OmZ/5IxiTTtFe3GvRcrx4CLhIcosjzdhHuv
	ywL2hTFskRGd0zRr12SN8KKPC7BAT6ZGn8+y9aOiEHW2l/t2ScMi9R1VhPPu50xQC6cxvk8ZLFl
	i347sDaFjtxK6Jt4enVr5Xsyb4L40t1mkRlbO0Jf1JUcmsZQThA+KbmocZTLDOG0VKTRhfI0YdN
	ntGZ3W6Ql4fjJL9Ur8t1dPYGJHVXeSGOfrwFsFC37VeV50En/FbNgumaYY2F01ePDUXfDQ2eG4C
	2TJJRLzAdLupV3FQfH8sKhq/mxRWQ2pmxBzRGV2MM+bCaf3d5bdqxakdnlVSOCEH0vdTrnQxAoc
	1yUU=
X-Received: by 2002:a17:90b:3e4f:b0:341:8ae5:fde5 with SMTP id
 98e67ed59e1d1-35272f92726mr11242388a91.18.1768876905455; Mon, 19 Jan 2026
 18:41:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
 <aWD2x154F5f-c3pL@pks.im> <aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
 <20260115211448.GF1053259@coredump.intra.peff.net> <xmqqa4yeblsx.fsf@gitster.g>
 <c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de> <aWnekt4ESo0bKpOT@pks.im>
 <CA+B51BEs7kuJ7s+K2vbZLSoaq3krGrqVncQAaTjSSNazFLY3tw@mail.gmail.com>
 <xmqq3445bn33.fsf@gitster.g> <aW3bSYCIPMhJT1mf@pks.im> <aW6tMtg0pEKq23TX@fruit.crustytoothpaste.net>
In-Reply-To: <aW6tMtg0pEKq23TX@fruit.crustytoothpaste.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 19 Jan 2026 21:41:34 -0500
X-Gm-Features: AZwV_Qg0zExiQmTXDKPAYEE80m95_CHuxkpozveKZFFzKkB05qoe3c7jcTXZdD0
Message-ID: <CALnO6CAUWwtTR4Tw1q+camc=O1FwS-GSowUehy37Cj9XhySBtA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>, Ondrej Pohorelsky <opohorel@redhat.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>, 
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Forgive my self-insertion to this series=E2=80=A6

On Mon, Jan 19, 2026 at 5:16=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2026-01-19 at 07:20:41, Patrick Steinhardt wrote:
> > I think what I strongly disagree with is that this is considered to be =
a
> > feature. I myself don't consider this to be a feature though, but rathe=
r
> > a security fix for a bug that can lead to arbitrary code execution on
> > the client-side, for example via title bar injection.
>
> I don't agree with that.  Nobody still enables the functionality in a
> terminal that allows title bar injection.  And, as I've pointed out,
> even connecting to an SSH remote allows exactly the same behaviour as
> this patch seems to try to fix, so there is no actual security benefit
> to enabling these patches there.  Defaulting this series to on is like
> closing the barn door to prevent the horse from getting out when there's
> a giant hole in the barn wall.
>
> It should be pointed out that, in general, simply using SSH to connect
> to an untrusted remote system or using `cat` on an untrusted file can do
> exactly the same thing as this series tries to prevent by sending
> arbitrary terminal codes to the terminal.  Nobody has sent patches for
> SSH to make it filter out terminal sequences.

It sounds like you say "There are other holes, so it doesn't make
sense to try to close this one." I don't think you mean or believe
that, though I don't want to put words in your mouth. I just don't
find that a particularly compelling argument, especially with typical
practice of the "swiss cheese" model of security.

> I have also found pre-receive hooks on GitHub that will be broken by
> these changes.  Just because Dscho has not seen them doesn't mean that
> they don't exist and many users who are not on Windows do not run the
> latest Git (they run what's provided by their distro or vendor), so they
> won't notice that things are broken until we've shipped the feature
> being on by default.
>
> I'm not opposed to adding support for this as an opt-in feature for
> those people that want it, though, and I think that's the right path for
> including it.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA


Cordially,
--=20
D. Ben Knoble
