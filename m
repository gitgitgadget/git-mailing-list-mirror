Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F837E308
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151556; cv=pass; b=cFmtORoTsXukMTyX0hlrtTyXpaZGdqqqTA6e3IpwHq7wjpoqODZE0/TWGwzf/EZx5HVB+Yzdt1eWDChzwqWTpHaHNUjtzDEhznYwU1LmioZDnoBLLeEGn190UOV3L6tMfOk02TXUd1houyWXC0JJhWJtPXc91LGRjGHQzPHw/mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151556; c=relaxed/simple;
	bh=Mb1Jlxkh8QSySaIYKyMvy4Js+yxiOdNOjMgTZz+tlgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHad6UECz4LJbyVfclRaxialyR9L2mDtEquu890BcsAL+necw/dCoJihjNLS7vRmlLHck3BN+Q9K5D/KHmY985AdIbwQ1zaK2uvNzxlsXROxmZqjKwAxRtsX96yulGUmmbC7txASYq/TFGucVgpUY0BFtdEHzdA3tSjf/LkX2jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ht8fa/91; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht8fa/91"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8a154cc6a48so61601426d6.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 00:25:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776151554; cv=none;
        d=google.com; s=arc-20240605;
        b=KabP+zMmUgExosc/e2XLlntB0nu9Z7PwD7zXRfhDC4rgUxbsnGFkkcaVCcTkPLbR1B
         cxrMXM25H45p48NJVEDOwA/20/dsEn83Z3htS43nC+PRvBWAVjXXZFb7QmB5KmQi47eK
         pPj8cjPTgKHP/+N9AAyRDY5KXE3r8AzdKRXnBvrddzhLwS3o5Hdj5Mk3C5ui4reL0cSL
         kXyglN4+x55mCN8ldQzffMA46u1v/d8F93oo8gmxUefqe+5O1orO7RSo66hKq/3V1yz7
         5TVQeuyUgZ62/zy6jEIyO0tkDwRVRwi7yim/IMWnovlpUiWbi09dkx7NApLi28hvHdXj
         73UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NyJZ40DvHkvBenqitgw1FYOPuSxmAt7tw3biY+4kB9E=;
        fh=ywgr8dZQDv4nzD8nPW+LJ30hjKQZT7Hjp2iyz4cjKnc=;
        b=U+CnN4UU7fU5GW0uP1QyLS6Kms/3EavouyZ4ZS9Q7fexmwGxvRt7kZbUof7n1Y4g1F
         8ylK+KysGaNYhAPEafR/i1xc/TknRqsFWDFsRASWEHrg6/ceJKe23xJjR6xvD6hH2b/x
         FbDUAvavL4nxUfeSLNFmhVczkk9rdvsRIAkhNSi9IG1YlXKv34OH6lM0J4KlemP5fm43
         c/oeUJT5DGofouXLDh0XFE3s9Nk2LUW/SjdzyBRauBOV7OPhH87P/Kn1ppUFumiWubqF
         YoQAPlyxkhbx1eqe5q0avzcbtPAfEHW7GpcXoi9UKkS9M8UTJv53QSKOJE5xTs+nn297
         an9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776151554; x=1776756354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyJZ40DvHkvBenqitgw1FYOPuSxmAt7tw3biY+4kB9E=;
        b=ht8fa/915xkU0aDmyH19fIgEtEf1mhlPg2exv3MFUkoW1fqHpJA4Rihim368bWwBll
         t4TfJRFM3nRbT0bOPyMnwaoDK240ZxcqzJhBB7IbKGd910HGDmE83rOepKnSiTUeRHEc
         AdYG9xlGoWxaIbdihUf6u6b69rIBLesQDp33a3lNCj/6UciJUa6+Lzb+l9EpmAJJY7EX
         /50CFXI7JdSSBOgOEPrJoLueC/jdlbaD6U8WNFzKpjM/a4X6q0k9nwqwJ5B1oczptfEP
         FzmshuMu544W3RXOIwGHe60iOzuTGM4cmHaUXLNvwnXwoBukN+c0TRSQAK7DM+4zpYtR
         FMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776151554; x=1776756354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NyJZ40DvHkvBenqitgw1FYOPuSxmAt7tw3biY+4kB9E=;
        b=GhztLaSSOcGRyP+s/uz3nIO0lI+nH+IQcQunxlw4vzPV5B6e0ls8hMpD/B3RwkhL2Y
         ggk1DnxxjsS6mv3lXTWI/MBDVUdY1ZsI6oOeDSj+VCuNiV2prz8EUFP3hMt+n1rmTSXL
         fXfSN4rbBm4WP3NEujME1L8iK9lEIkPI7xZIiXkHyhRMf2jvUiIzx0PRwF98Fwa2M+W0
         6OtCEQdJ/iNhYtmH5p2x0Cpb5/RsNJu8wqI5XMc7pAeRMkxYqPcJeXKji2L/F3ezMTaU
         fNop1x+RGKY1cAe9owpwJbhobbIEU0R4dRcvl7vivL+qp5pDhXqKTmqgSjs2w9KzEEZa
         /a5Q==
X-Forwarded-Encrypted: i=1; AFNElJ//kubdb1KW6/Ic9b5JqiizcGO9AQdEmY894DmF1XAUxq4Qph3PpNEUEnWhtg52h+uTe9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YznZAqe/WlSvy1A0080ZE4hgDScGybFL0WCrXDh60PEto/zt8ZZ
	tzayXzlu0tJTFrsP73hDlLe1ShvY0sxGl5F4N+btOel7ht+jam7U4PLug1FswH0zPt+TdaihIJt
	CBkvHcR2Im0TUo4z6P/RqqFoIlxP9JnFBGicI58nZ0g==
X-Gm-Gg: AeBDiesVLhiDHyUpn1Jfha+Estuf7bBepRxPBaGu16uBRgiM/w1nXXskrUFXbPTKkXq
	4VWZ6MUWWXxcbnaqOv50amQneSNw1IN7j9dUWAp/4LsEUd/xQQmPiiQzJPHysjG1DfBpEf0ulGJ
	q7OkV8B7GYDOiciCQPAvtAiRxwVcmT+1DiN49RBU1aGK7Ik3O6+Q5FSy9N+rYycLEZMqRmlYCiw
	le84gqa14W6OlY+zjDL9l/ssGcp9HTcL636wa1aNwMnsImCeezH/P84Jl4Z7Y5coMHZH2Jg4kJa
	zB3c/oOKSJP8xr3qClnqdRCHVBs1
X-Received: by 2002:a05:6214:3f8f:b0:8ac:b233:e022 with SMTP id
 6a1803df08f44-8acb233eb0dmr83626366d6.55.1776151554074; Tue, 14 Apr 2026
 00:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAC4ekqE0rGTeZA3fPKYePr3=J8pHe-KORgn5W026J8AAhRRHw@mail.gmail.com>
 <xmqq1pgilufr.fsf@gitster.g> <CAAC4ekquR+eCxTWifOR-X5hgd+rSen8eAUy8cxukouUE57xaoA@mail.gmail.com>
 <20260414061558.GA2902306@coredump.intra.peff.net>
In-Reply-To: <20260414061558.GA2902306@coredump.intra.peff.net>
From: Shibo Xia <sbxia25@gmail.com>
Date: Tue, 14 Apr 2026 15:25:41 +0800
X-Gm-Features: AQROBzCz_CdUT2awEI86tvq52Bpls8gQD8SkdZhgJdxupaEoU6Yog5MIK141P78
Message-ID: <CAAC4ekoduJ03xjA08GouE_r9sJHnS4aTD3GgaA3GChdn6t_v8w@mail.gmail.com>
Subject: Re: How should submodules use different sshCommand during initial update?
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you, this is very helpful.

The includeIf approach and the two-step workaround do seem workable, but
they still feel awkward when different submodules need different settings
during the initial clone.

I would like to try a small RFC patch for this.

My current direction is a general per-submodule config injection mechanism
for submodule update --init, so that config can be passed to the underlying
clone/fetch for one submodule without affecting others.

Does that sound like a reasonable direction for a first RFC patch?

Thanks,
Shibo Xia

Jeff King <peff@peff.net> =E4=BA=8E2026=E5=B9=B44=E6=9C=8814=E6=97=A5=E5=91=
=A8=E4=BA=8C 14:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Apr 14, 2026 at 09:28:20AM +0800, Shibo Xia wrote:
>
> > My concern is that this still solves the problem indirectly through URL
> > rewriting / SSH host aliasing, rather than allowing the submodule's SSH
> > behavior itself to be configured more directly.
> >
> > So I think this answers the practical "how can this be done today?" par=
t,
> > but I am still wondering whether there is a reason Git should not suppo=
rt a
> > more direct per-submodule sshCommand-style configuration.
>
> For arbitrary per-submodule config, I can think of two approaches:
>
> One is conditional includeIf directives in your ~/.gitconfig, matching
> based on the submodule names. Like:
>
>   # replace PARENT and SUBMODULE with your filesystem names
>   [includeIf "gitdir:**/PARENT/.git/modules/SUBMODULE"]
>   path =3D .gitconfig-submodule
>
> and then in ~/.gitconfig-submodule, you'd have:
>
>   [core]
>   sshCommand =3D whatever
>
> This works, but it's kind of gross, as it depends on the module naming
> scheme (and isn't there a proposal to make these more opaque? I didn't
> follow it). And of course you're not actually putting the config in the
> submodule, but rather polluting your user-level config with it (which
> might or might not be preferable, depending on what you're trying to
> configure).
>
> The second thought is that we faced the same problem with "git clone"
> itself: you might want to tweak some config after the repo is
> initialized but before we fetch anything. We added the "clone -c" option
> for that. It would seem reasonable to me to have a similar option that
> is passed along to git-clone under the hood. We already have ways to
> pass through options like --single-branch for the same reason.
>
> And then presumably you could do:
>
>   git submodule update --init -c core.sshCommand=3Dwhatever
>
> In the meantime, as a workaround I suspect you could do it in two steps,
> like:
>
>   # set it for the initial clone; this is using the one-shot "git -c",
>   # not "clone -c" that will actually save the result in the
>   # new repo
>   git -c core.sshCommand=3Dwhatever submodule update --init
>
>   # and then save it for subsequent fetches
>   git submodule foreach 'git config core.sshCommand whatever'
>
> It's rather unwieldy. And I think gets weird if you want to cover only a
> subset of paths, as it doesn't look like "submodule foreach" allows
> that. So you might be stuck with:
>
>   git -c core.sshCommand=3Dwhatever submodule update --init some-path
>   git -C .git/modules/some-path config core.sshCommand whatever
>
> which is back to being overly intimate with the filesystem layout. There
> might be a better way to do a per-module command. I don't really use
> submodules myself.
>
> -Peff
