Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792674904;
	b=ae18hFlcLyEcEDs/ZbMzRFOp1k0U1uXCOKqwhPCKGHEK8DQDEC13SzRErLMXL43nLZo5
	 dTMIlWGZ8vxUqukERq4g55m5/37xM9RQl8Cf+PSxnR8PsH2qE7ahjPWxXyOmvEihfxsyg
	 wjUYnfYIkiC+qA2+bRJZTOjiRnjgfkSiFp6Y66p8hot3AMcDmBHUv0wxVCiKBaiwMxzaj
	 9k6BTvAyToad9fjvsb0N4LB23AFB+wdJi+BCtEZtFg72P+vhfEveohve72CuFogR/YJQ1
	 qRJ8obuCOQHqzqEKoF4jEqIaOM7uu0BAbNghxJt6HyCvfzpLjE8bRPunbVWtakSMDlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=cjUsqgZZth1eqxAlntKd6CdIpuBHJp2+yqm8vzlTK2U=;
	b=Uw4L+//kfLLCtRhKHdmgMAvOT/jsQnON+C5pnsXvaidHVfMf9Pid9jWPKmkb0xxF/byc
	 yIu9EC8AF7SvJX+xTphqwx9X5VLNTFGb1kGyh5Uxpwt0rE4HQkqUwotKF/DTh6DBveniC
	 qJGJLzLXCYOdQKJb1iSBAw91GahJ0fbxZb9PWDJBaDvN4g+7EraCKtAnPnIH1CY8cEYX4
	 Jpp5Gvcm4/beDTv2SdGLP8mWab65sF8+zRLf+yJyI7TR5nNVQjVLLsXSFtFx7GlrorEkE
	 1207VsXrrzhUrqSG8xqkj3+JY/8dpr7pUXaAKzwIxxXRKn5f3w1F89cDnGEDi5wlf2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ltjRArp4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FFE606A31E
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 13:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51FFE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ltjRArp4
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e940d5d2beso7296445ad.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 06:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792674904; cv=none;
        d=google.com; s=arc-20260327;
        b=Pxi9pKDESo16gIHtWLU5nOU9ucXNFcFwZYehmmbs1BnYPprROACsQV6eYaedaDDNMU
         HHYDzqlJXITBfENr+JItPYbg++bt9Iyy4ZhE2VXkoZHyHj2eCmg/4ir4YCUIGojE9bdy
         LSddLrE7TkMKo8MuCOAo4Ukt/cPNG5Foxpmw/HBNKfl0tOKSMgjSVZw0gwX2Qgals68F
         4m+2tMNDduXyC5B8L2zHCE4KRCZ8bEGNp8wAfqQrOp26bPD4lmO48h3hmJoJFn/ep6a/
         cdjY3nRF7ObygKwRUUzqN22y9ZmF/sfPw9PtsmlHwRHZO708PwacskRHWUQ4RVrWMU1r
         ZXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cjUsqgZZth1eqxAlntKd6CdIpuBHJp2+yqm8vzlTK2U=;
        fh=XFzWQYBXScgxool/pwAxjUJoclOVldXyKbEJT+x+pf4=;
        b=c5yjgkU8S7BFRoUUjut5hiApeZ2JwijJP6qq7tmAtcSRBGJzvZns8PJpxIOOhnGDSa
         0uHqYmbFx6O84E7n2yuxYOeM5AaOV5+Dr40riT6avl2nSC52/YixZ75accmsQIvfZWMm
         +i0ocqhD6YL2BW/a2GP2SDrBzt1UPllLfWoGv105tM3DFL6yRbriTitePoQWppK3uwCa
         joC+9etUe1q6JnVeFYl/0IKkojrIaEdfQ3CBjoBSgFfjPUlCeijk3WqalcQ3Q4zCRA96
         VRxRpTxYmH++IW/MIFhguTBY8ngCrVRDvS05ML84joi4z8wrSF+xOyMJ7TvG+rhJs9W4
         iyYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674904; x=1793279704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cjUsqgZZth1eqxAlntKd6CdIpuBHJp2+yqm8vzlTK2U=;
        b=ltjRArp4BbfkAfM1VhEGfIpAHoskyxl1CLg2RDh/FrhdimYHtiEVjEebnzqdwdnfEl
         tDAXTay0yPMBHWVhgIQTtz+5EKsbfi84X6llM9rp+mIPolG8MA3E+ENGa83C+2rIa88n
         eGR+7V/fAOEFYpj25y0/AftAkeedX8VpuAXc0GFpbxnxtwiIkk0qxC8aUgtixwSGiYex
         iFoJOVGkma0BF9ioleTRe0W2h2ut7j4IvxDITeSib/rP0Z77vZx8kOLxGy6ZGWbWS+4V
         fRaqKLI0GuU4ISrf58BYLcy32ohpBKE2oImRApER3A6K/mHWhVNQCVO2GTSDKjPritfd
         7g+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674904; x=1793279704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cjUsqgZZth1eqxAlntKd6CdIpuBHJp2+yqm8vzlTK2U=;
        b=FvVwhq1BKbHYZDCeQlLrrE24VJZejb3i/9G81OcRlGJbLoNoftR0yOMRGDGgbc880t
         k/oGJmJl7dBv+l9veyLrK55JFVhxlSmv8NvUpGtjZtI3Ne4eAdk/NTvcqO3y/pw4HViI
         JLRIMkW5sP4HNwEg+IPbvwlvP9qbZG91R2OFpWwzZ0X9rrEmfUemMrny92JNRr0wtKs4
         d/KUkKEyy4n5ZCcjTkFAJPCkfls3ptzU+RWztZUp+hoaeTEkOVKrhCFEMFFrU/LjR/AM
         KIhhURX4rDCJWDOaJPnErYObUanVWLBQfiskh1J211UovAPMkkErXxla1L7LX0odC3tQ
         IQDw==
X-Gm-Message-State: AFq9FYJ1aQb4DzSiFcSvapj3Z6zUyJ3lvScGp9AZZihyB6Pix+CucWcq
	s0FRQf5cBd4N6EhbQKbIL0qudenUVAOGraVlchVlI1Sh8k5/MuvenKWxgRLsPLDiWshQGFM+Hjr
	GhAoS22Yt06jTSxKch1o4lo14FyFBIsw=
X-Gm-Gg: AYBFou1CmiylDcDnvydCQiMEpMa6gfSHMesMXC8u7FHlGMohM8u3tsLkIou33DrQd8S
	emnFGf0liT1uoqekycHLGgJeGTFqy4ovvlDYmXf3IfLiOjuZ6W/gHIyJ6A3TYZ1oeEG3ADoE8j2
	oLTg+xU08oJkCQ940/Zp99H9CufBNSUjU6uqzlrGxrvRgFcl0KOFyEln9SOqx7BUBgKwOHF0SsW
	RMU1xzdKWBAHkTEQVDoD29jHcP0rnvHPY+8e6MPSTs0dXeN4GrwAfR5Ja9S/GyxP/7EfumSxQyW
	2yY+dbnNLlYZgRRcPo3uo1H0rzmkCWymcqXqjxXDkO410KpjXccSlQ/uaN32DnIZWxRpq7f89u5
	zkyIm3uLUrAnt4qFrjU+ua+XJJ/3/ukAS5WBmJOmY4sTOm3b6Ds0u1NrKb6uwUvAlBsCayvskSb
	0dTwbCZ2FguegmuueIP/P83OOUbPSjEmhKv4SC3TC00h8wQdSH2Fm+cmA7GWXy5WaJ/Q==
X-Received: by 2002:a17:902:c949:b0:2e9:9a19:c54 with SMTP id
 d9443c01a7336-2ea4402a230mr34787075ad.50.1792674903567; Thu, 22 Oct 2026
 06:15:03 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <atHZ0gV5Pz80l3ho@pks.im> <35E6B235-6370-4F94-A0B1-4B6A941D8C47@gmail.com>
 <atcEqHErXaGiMu4J@pks.im>
In-Reply-To: <atcEqHErXaGiMu4J@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 22 Oct 2026 09:14:52 -0400
X-Gm-Features: AclHuK_i7d2FKd6xBhDYvIAbnwuA1IdbGlSSn4kQuA7-ike-3HYwmOXteYVcXAg
Message-ID: <CALnO6CCUfja_AxYjbz9xpZgoibbdvy6C4utDDQk9ONhjiOYYzg@mail.gmail.com>
Subject: Re: [PATCH 5/5] completion: drop "stash save" completion altogether
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 2:05=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Oct 19, 2026 at 04:01:15PM -0400, Ben Knoble wrote:
> >
> > > Le 16 oct. 2026 =C3=A0 04:01, Patrick Steinhardt <ps@pks.im> a =C3=A9=
crit :
> > >
> > > =EF=BB=BFOn Mon, Oct 12, 2026 at 01:48:31PM -0400, D. Ben Knoble wrot=
e:
> > >> It's been deprecated since fd2ebf14db (stash: mark "git stash save"
> > >> deprecated in the man page, 2017-10-22) and the previous commit remo=
ved
> > >> further documentation suggesting to use it.
> > >>
> > >> Since we recommend push instead, stop completing for "save" and remo=
ve a
> > >> special case in completion code.
> > >
> > > This is the only part I'm a bit torn on. I think it's reasonable to n=
ot
> > > autocomplete the "save" command, but if the user manually types it,
> > > should we really stop autocompleting its options altogether?
> > >
> > > Maybe the answer is "yes". After all, as you mentioned in the precedi=
ng
> > > commit, the command is deprecated since 2017 already! And after almos=
t
> > > 10 years I think it's fair to start giving users more nudges into the
> > > direction of using "push" instead.
> > >
> > > One note though: the command _will_ be completed in the case where yo=
u
> > > have GIT_COMPLETION_SHOW_ALL set
> >
> > I should definitely mention SHOW_ALL; I=E2=80=99m not actually sure
> > what happens for =C2=AB git stash save --<TAB> =C2=BB with this patch,
> > so I=E2=80=99ll double-check. I actually wonder if it will complete opt=
ions.
> >
> > Would that satisfy you if so ?
>
> Probably depends on the outcome of your tests, but ultimately I think
> I'd be fine with either of the options. But if we stop autocompleting we
> should definitely mention SHOW_ALL.

Here's what my testing showed (all Zsh):

- with SHOW_ALL, "git stash <tab>" lists "save" as an option; "git
stash save --<tab>" completes options
- without SHOW_ALL, "git stash <tab>" does not list "save"; "git stash
sa<tab>" does not complete "save"; "git stash save --<tab>" completes
options

I'll update the commit locally to reflect this. Thoughts?

--=20
D. Ben Knoble
