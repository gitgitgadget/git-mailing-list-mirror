Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85053215175
	for <git@vger.kernel.org>; Fri,  9 May 2025 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746814480; cv=none; b=C46OAI4DhWy1zijbaqWIjbSo6FtjnWvQDL7gAlEAhfHepPBu5I3uCsrfNcODiXNz3qM+yjmJVEP4sja45doIpBfPvAv6moqWCmY4i9whWb49nNoA26x6kYJaE1pjpegKTluZWenFskS1s7OMAZQrGH2dS4Ac+ooC/av42yMjNIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746814480; c=relaxed/simple;
	bh=39sEUkN2Pv5y92x1DRCPbHEiZs+89j8qTykTjgxAYWQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxbIzdF4kSnECKnP7j5CDd1eRmMlSR+V42QG4Lx0b4MGuOMY/0KUHwheRsE8nMlai/TTlwnTTvQZGz+JcRg+oXW+j8GyizbNDRLvROEnTAjK8OcNYzWnrKJ2AoCSZ0NwLpq4okKyCaVrGDa6EvwsX6wFbEtrzIeb2ILz6eZ2cc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=O7JJ7VNW; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="O7JJ7VNW"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 549HxNMI017906-549HxNMK017906
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 9 May 2025 20:59:23 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1uDS0J-00EbND-5i;
	Fri, 09 May 2025 20:59:23 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 9 May
 2025 20:59:22 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 9d01de39;
	Fri, 9 May 2025 17:59:21 +0000 (UTC)
Date: Fri, 9 May 2025 20:59:21 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
CC: Mr Bill <billc56196@gmail.com>, <git@vger.kernel.org>
Subject: Re: Bug report for pull --rebase
Message-ID: <20250509175921.N7Sy9%taahol@utu.fi>
In-Reply-To: <CALnO6CB6aH5DEDP3QL43RCFfaZJ3uzrAY1LdGyTNi8F3XVoEhw@mail.gmail.com>
References: <8c075e6e-c28c-4146-66bc-9bd7bc705611@gmail.com>
 <CALnO6CB6aH5DEDP3QL43RCFfaZJ3uzrAY1LdGyTNi8F3XVoEhw@mail.gmail.com>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ex19-03.utu.fi (130.232.247.43) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhaSFhIWEhYSFpYSAoNBkYDBgcKBA0oDwUJAQRGCwcFSFhIWVFIDwEcKB4PDRpGAw0aBg0ERgcaD0hY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=jY+lFEzmmcvWT0O5juQ9gl6XDF6QG+Jkr5To25kDYPE=;
 b=O7JJ7VNWrk9DnZD3FQyXBsFe9JTf71fehJ1ltC8MYRpZddXfwNu9BA0lgOPt4OkutJcpB6ObbWhW
	XxhLkzySnFXVqGfqjDevtpE3PcuuYJDgfEIns9xf90qVPO4DVKstmYBZFMPA0iOoy5iFyJUGK1Vw
	2ZRZI6WTTt64wcvKhZR56sJhN4xPbUE4xKon511/rnOR3jPzU4DUdRkuDgfWxdxQO831vAfpoIKJ
	54B1VjEn+rUwquTuSbIzxf/SurxftoC6K2z2VoDtB+J0Q4AROZdcjxAkP8y8FV4KsjyW3yECnZpu
	HO4scQQYKEUAB1sRBqOOXImCZogsGEzS+A24yA==

"D. Ben Knoble" <ben.knoble@gmail.com> wrote:

> On Tue, May 6, 2025 at 5:44=E2=80=AFPM Mr Bill <billc56196@gmail.com> wro=
te:
> >
> >
> > Hi, I ran across this doing a pull --rebase using the current master
> > version of git
> >
> > This happens on Slackware linux, using git HEAD, version 2.35.8, and 2.=
46.2
> >
> > I have a clone of the ffmpeg video package, with a few custom commits on
> > top of it,
> > I periodically fetch and "pull --rebase" to update the underlying ffmpeg
> > code.
> > I tried this recently, and my custom commits disappeared.
> >
> >
> > I looked further with a small test, and it looks like this is happening:
> >
> > The setup:
> >     "base" repo with a few commits (A, B, C)
> >     "clone_1" cloned from "base", with a few extra commits (F, G)
> >     "clone_2" cloned from "clone_1"
> >
> > Add a few more commits for base (D, E)
> >
> > Then use "git remote set-url origin" to point "clone_2" to "base"
> >
> > Then, in "clone_2" do "pull --rebase"; the F and G commits disappear.
> >
> > Then, in "clone_1" do "pull --rebase"; the F and G commits are retained.
>=20
> Thanks for including a script! I modified it (uploaded to
> https://gist.github.com/benknoble/7a5eecd522b48669c2a5207e2ed9b7ee to
> avoid problems with my mailer) to be suitable for use with bisect.
>=20
> I put the script at /tmp/bugreport/doit next to a clone of the Git
> source code, then (in the Git source repo) started a --first-parent
> bisect between 2.49 and 2.0 with the ../doit script as the runner;

Hello!

I think I found something related.  Let=E2=80=99s test on your Git fork:

```
$ git clone https://github.com/benknoble/git.git git && cd git
$ git checkout next
$ git remote set-url origin "https://github.com/git/git.git"
$ git remote add upstream "https://github.com/git/git.git"
$ git fetch origin next
$ git fetch upstream next
```

Now these yield different results:

```
$ git merge-base --fork-point origin/next @
e0522318ac56aeb88f14e72ba2db25912e9972de
$ git merge-base --fork-point upstream/next @
```

Which looks like a bug to me.
--=20
Tuomas Ahola
