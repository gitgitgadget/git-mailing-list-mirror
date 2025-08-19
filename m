Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDAD26FA5B
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605340; cv=none; b=AJ6iBPkZ6XQR73tlzZKVGvgKb2x96O5dCv/2SvleQsYrYaUOov85pqLGnIr3/Pw7RMsWe8aE3FGsOYKUxYFMD3R1KI0IZZayCNbBkJnekr10y+KY0wmiOb9lJ2D3vakJtgqF6up9/Npsvhgj3cB79GRXIveWkBSZgrv+LGNjUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605340; c=relaxed/simple;
	bh=Nd9qyNm1YuGVqQwX9HU2DMPxlL9tsd0S2oEiuEIS3uA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=sA+Ok1MZTLc0PzzQ7fDHRoKpqsMDtTiSs7Ta3wzOmlbk66Lt6D6ur1v/ayV5SoXPhUNaXfT3Z9T5JiCQy97G2qIci98jFNG+xukJr3RF/EyLl/ypTDPq0BWe79c2HrbHqVcEYrgx3BkSddqimnZ8n9UAoVPYO/KwNTA544if80M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewWyKy/X; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewWyKy/X"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e931c71a1baso5235994276.0
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755605338; x=1756210138; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nd9qyNm1YuGVqQwX9HU2DMPxlL9tsd0S2oEiuEIS3uA=;
        b=ewWyKy/XEBSG/SZv+2dc+FQVK1rL9ct1MbNSZsjnF15e4lZ8Jcad2UWROsvuBMCWJT
         vz2FaBETBW9IjpFzfy1DwXEBExt3a7Loud6DqkWz6WBiPaWsZWrWx/6C5RfxtlhakInq
         Mf5Cz0E4bfgH0HBNcDfgyoO7qimvfM+9JoYTvaR/JqAd6WeFggWn/Q6jm2PPtutJkMi0
         W+Ip8yCRADULS1QMQl/0EMhUWnCebdr+SJFX6ImMCJZOoVgZee4rv5vM1MSh7hOV4EH2
         gGqfZBjajSx4kzAEGY5I0bEQXY7oXtitTp7wnQOR/WGHEa+jglQWoyCgwjZ8NYjIVcgn
         qpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755605338; x=1756210138;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nd9qyNm1YuGVqQwX9HU2DMPxlL9tsd0S2oEiuEIS3uA=;
        b=WsWsF48CcvKwZQ0paJTggvD3NZHbed8AEzRPMlMzvQo/hH+UBfMh7+AigYZkrtxrvB
         e2FpDx4ejtEsmpeheok7Aek/FuViAq+xRh1+aAtpTkFADGdD6CL66PBpFuQC+6qUQSuD
         9ZqvVgqPOx+f0CNAcx0L1XedeewRr7dv5oHOdKGJnXE36GxNM4vPt/bsp94RFJYIa3oO
         P/EUo7B/hMtrgf7IArM8YfInGbocXaQul39/KJFBY+GY1n6B1a307ESPTHeHJvsyvIaa
         jw+KzSP/mIaj6tHJ5YwcKaTnUrNfQJF6HS0tc3HRbk4pxIw73g6/ga6OX0Pcy+VFzugn
         Q7ng==
X-Forwarded-Encrypted: i=1; AJvYcCXkmSaXx7WQECKas5fk7Ohhpx7wJGA/3V7hPwyNZ0yelCBkFlFL48PHdP7u3XUPvCluq2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLX+hrmrqiGUks4hkjz/0GyuoKAvqCF47VixopIUqq9RIeXF55
	cizv2i2ZSr9XemKv/5v91yikEGAqITxvpcjylS4RqCMTmQ9bSXGWtbIrkIAz2pKn
X-Gm-Gg: ASbGnct+orwMfXS9gsmq6rkcEdjo8unBrHRBQIn/ZezUWA0TOOIn4XT0F/NyrMSTzjq
	8AtPwwdTYsnCNp1qECmenBWBltJvWsBX1qIg8ONdaUbxxcbKV/fIWHZJ+NL71eMn1GIvGUOgE8v
	6oaQ2QYYCaudCypZtcFXaonQVQXLw8BAwTbokIyth/sAIjEJRsK0z9o4z+js8TBo9fLpleu9gwr
	YNo9tJeCOh7hlvhlhuruILjHFjiI6QNm9/U4PemydMo9yZn94c4A09upDTAhl7aqg50ml//7nqe
	EuxUtI8c3i+646cw8z0gxz5BDgHsAVTkJKIBqiCDNbWIauJqB1wRpEK4321mCE4cr0Y6r9BxdB/
	1AWzRmAoD/HDOjSoISiU4Cg6ws+mNcjk4QQOElOyKH9r++mzLzb4=
X-Google-Smtp-Source: AGHT+IHCPGduJwOr50GhfgQVV1Bm6oHotlHtX9u67A9e7m7WW/gXNoHG4qAwveNC80vldOYmLuO/ew==
X-Received: by 2002:a05:6902:1001:b0:e93:468e:dcce with SMTP id 3f1490d57ef6-e94e619edafmr2671474276.12.1755605337471;
        Tue, 19 Aug 2025 05:08:57 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:3425:d86b:b13a:793b])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94e6749b90sm620073276.2.2025.08.19.05.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 05:08:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Graphical tool to merge and reorder commits
Date: Tue, 19 Aug 2025 08:08:45 -0400
Message-Id: <A6B4BDD1-844C-492A-96A9-40F09F2DBD3D@gmail.com>
References: <f2977c6a-b588-4e30-b7bb-dfa6d4b8b45b@rd10.de>
Cc: Bernd Petrovitsch <bernd@petrovitsch.priv.at>, git@vger.kernel.org
In-Reply-To: <f2977c6a-b588-4e30-b7bb-dfa6d4b8b45b@rd10.de>
To: "R. Diez" <rdiez-2006@rd10.de>
X-Mailer: iPhone Mail (21F90)


> Le 19 ao=C3=BBt 2025 =C3=A0 07:28, R. Diez <rdiez-2006@rd10.de> a =C3=A9cr=
it :
>=20
> =EF=BB=BF
>> - `git rebase -i HEAD~11` (or so;-)
>> - move fixA1 and fixA2 under A and change "pick" to "fixup" for fixA1 and=
 fixA2
>> - save and exit the editor
>=20
> I actually did not want to count commits or look at hashes, I wanted to co=
mfortably click around to see the diffs etc. while I make the decisions.
>=20
> After such posts, I wish people like you had to buy their next online plan=
e or train ticket with curl. }8-)
>=20
> But let's stay on the command line. I could learn new tricks.
>=20
>=20
>> And done.
>=20
> OK, git rebase was happy, everything is done.
>=20
> And now it does not compile anymore.

Perhaps there were conflicts? Reordering patches doesn=E2=80=99t guarantee a=
ny semantics about the code :)

>=20
> You'd want to go back to the initial commit sequence and try another appro=
ach. But now it's gone, or at least it does not come up anymore in your git-=
gui. Or is it really gone? Maybe I can dig up the old commit sequence if I f=
ind the right Git commands... But that is what I wanted to avoid in the firs=
t place!

Try =E2=80=9Cgit reflog <branch>=E2=80=9D: it will show you that old commit.=


> So I guess I should branch beforehand, just in case. And then move the hea=
d back, and rebase the commits there. Or the like. And don't squash yet, jus=
t in case. And then squash later, after everything compiles. My keyboard is o=
n fire.

Exactly: this is what I call =E2=80=9Cdefensive Git.=E2=80=9D The objects ar=
e immutable, so when you spoke of duplicating head to attempt upthread, the b=
est way to do so is to write down the commit hash (e.g., by labelling it wit=
h a branch). That=E2=80=99s =E2=80=9Call=E2=80=9D you have to do to duplicat=
e.

Then you can rebase or perform some other history rewrite, which creates a b=
rand new set of objects. If happy, abandon the old hash (e.g., delete the br=
anch, which notably does not immediately delete the objects). Or if not, res=
et to the old commit and try again.

PS Have you tried using something like =E2=80=9Ccommit --fixup/squash=E2=80=9D=
 and =E2=80=9Crebase --autosquash [@{upstream}]=E2=80=9D (or possibly =E2=80=
=9C@{push}=E2=80=9D=E2=80=94upstream is the default)? For me that automates m=
ost of the typical reordering I would do, although again conflicts are a pos=
sibility.=20=
