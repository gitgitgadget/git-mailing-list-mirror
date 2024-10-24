Received: from sonic318-26.consmr.mail.bf2.yahoo.com (sonic318-26.consmr.mail.bf2.yahoo.com [74.6.135.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E8A1E2009
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781411; cv=none; b=RWiCRcHGh7hzGrFxUWk3GlpYJO7PR3beZcKen5dkJI7rFgwo4iEO5rGWELG1aGl3rok8cMUAwZdAoYQS0vNxU+OBrjfq0X7kFbTS632oE2+XVwhDJflFxY3pEjN0Q/s59b6nNuKCuMO/DOGICrRkGf1f3NwRM9Qh7yUmJkrdxew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781411; c=relaxed/simple;
	bh=T5MMJVYlh4qYArkrMNigy2au6L2HvRlZICtps4DEN98=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jiE2IE1TGCgzs285tzS43OAJM/OomZg7j1eaRdHbonVJCir5L86xg6zX0pE8bej7qx48TaUePic46Io1Xl6xqCO2/yXDIcJV+RaLdkRhPbGg2VZYiyjaO+hpF6tQJtKNlDObnpfMCclJqKv8F76sIJSDVeqmGmRf1aNFhJWw3Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WrRUdbD+; arc=none smtp.client-ip=74.6.135.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WrRUdbD+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729781408; bh=T5MMJVYlh4qYArkrMNigy2au6L2HvRlZICtps4DEN98=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=WrRUdbD+bO++jLrRpcEhRcchgkOICIILkawvDFqLHoxOI3C5cV/jbcITD07ZJZl6G6XOuYiM6gASPsDCZ8ksZl8gWenNlcFb8hk6J9HPivLvdaLtW0ZCot46oDKyxoqgN0R1mrhZTelGYK0tNNXvGnkQP+rj2L8uphhDvcq3qG1BhOoxRFpHjf/bxwriPJ4dzBKLe65m9cRjDegCNRO5o4oEyfxiJ3L07fsLHJ6SgsbUSS+rDAVTXgl7EyTwIBJ0uuciGV3jhjQtZq08HQje+UopI2TTGD7lB46W2uKw239Lm6YEVtbQASUp4QLR6gMojzQuR6wVFBAweeVk8vZoLA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729781408; bh=kPe74sFyjonrhA+xGflvdqhhf8DgoeghOVnP8xlZFDw=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=VsSvlufWGqxcE6OERWndviq4HUmhF2qOSEEphIMRM6rswMD9dCWrQdmO/LNoLnjlb5QRjspnMOj7mQw4RK2KVqQQtOKM43FLg37LOkCc/O5tajXxjgA3OGkSH3NVbyqwvuhzkVQ7A/EZOBshDMFXYpXDvvBwh1ox1SEvwgiTMle1dR6oGlpYpsx7F1baS3wQ2dDnujeoc1e1gzeiBqCfL/deJpHy4akz1iv9ieocPcIBc4cgJcqbjNl3+ccp6hbzAUsNj7WAOlVPh33a6kmUcM/Vn+EfjGLx+RwEWad/FI5zH/Hs18/zOAAxaBu+iT/YyYe0qUil9tS3UCs/CpkMpA==
X-YMail-OSG: wZ6B7NgVM1m3tn0u55oVUDr7r.R4a.9OzB4WDBdagVINfrTZYbj0TDmn9FabVxw
 imQVRe7kGT91LZ0w5CdqxREjmoedGtyXuSL0FYRr635iZHskfwe6TRLIVxqh1_BOxNsH2nkR1uh3
 wIEhDGmiBJN08Wdudx30Wx9dc3utLynSC7_AEWfn9Be5KYFCpOAFi5iEiTZOpREZC4Rre6bnbEvu
 P.3JDcDcwj2YFK.CDDOs7Bay__P60ESKRB6RwCYr5xnzB9DZK9WCEndjP4iy0PbJQrVBZ4GMH2nD
 ZSg1oY_b9yjUBzLRLSbPI3pxwAh8ECTD0aTnJCMGlBgXnmpBFCCMuR.Qztiij29vkzulLG.DgPyR
 0yNbTbZJly0pWlsDGmYmt0Hbe0Xljl2A0igsr7wzuGB2iww2fuxHS54uRMyW_d4dnSgU9sbDGRPX
 xWnXNOIboZFiRCFM8H4YsGuXRjTxPswBbc.r2RaPGeJPOOhqcu4uYn10VdM5L0wbqfsGx5t639Zh
 UTJ5Xxuv0sJaLALDxW8uOcErUVmqcCWIDLVgRd1CLf1PXr18n3eSHXEwdFHmM8NWr4Errz0gyivG
 UkAoVTA_kNJC8G7pOxV8K2vuNOkYhUcA6JPCrmUzIgo8YgLPB3X_Gzjrp0zWZdK5v3udp50piZA2
 JC_M1lGWPTuok3FM9GIMx.z3mevJ2mYO_h81WJ15A4LYBQXManPnhv_dGzsNLjzd_hxFYsC23zU0
 UTVN0cFGYSn.FGNAhEebq1Hz7PuhbLypLt9Ww4zvXErXRcr6D8gEDTpFn8YF_nuLeSuIU_JxdxdY
 dCufX7S3qPOJC4nqrJwyY089sBaaBwsxoRpgon3Rk5DumaCBb4ziS782auV6cSWR1ZIeDwLnntn0
 QY9BthyPpG4dmMejBt1XAwPSkfA__i990zEM07uSV8MYa.TTte6taWiqjPGYC.9vIXXcOMpML5kF
 fWkPOwwS7SrqPzYE7Xg56F7KcTchXhPmkQTAt9QIj4RZ5zazUpmVKmHReXYVV9JLecg5txDOvzVS
 4Ka8yGpfKLIV5pXX9X3egZ_W7m3KvpmO080BY3edq0QD8ZOstC4BCA54aTVf3rfxbx.fqvafeKO6
 w6gitOddlt4PuWfpKYh6f6HbChMrW9ZP2hXR0a.QCB0tl46xO4FjVQkvNWXdVbVyE3Shwi2CFbLl
 gKzZ2LZmmqU.I7q8zrEbusRWQCrL5ggBTrFLJvAFr9ZLT36ZyaT9qWcZrxTj7uIqcn1v7ZeotAG6
 RFWRsj0_8GThJN8NGS1hT69uff1V0qLh4KYc9XumLFSKvNYh0gbqcZVIPZjB.dYa.Drnmi2Icyh.
 d5651sF3Jmlz1ZXY0V5.7tTLOqL2eK50Q.m8cw_lvoMUsEWxFzvvQjQ6mlV3YOETx1jxhOB0He2R
 RZBXBr0y3erM0hGaSKWDz9inxY6FptW9_Jw6RflNNMetVUuyxJX6bkrx_UhOB2xD3x0i.zm3FVu6
 2XjHXl5M5xlFTu3h6hLsneHNokqjDDkNVbiBFgEAXhrEoqXEPfaXRX7IzEKIlL7OorC4El9aOTtR
 uYdA7zZ.FP4vlZp3wq_YHXrZWfvya_jiWsORpXt__UxsDEj.zJDmbcONIY1oeZyE.Y.N7zNVEft.
 WHZq57kUrA_24kKhjIFX0bsCr8hLkWdWrX730BQbVPRACPyEWhrnwqJo-
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: ebd95639-019f-4742-b152-e895b20c7036
Received: from sonic.gate.mail.ne1.yahoo.com by sonic318.consmr.mail.bf2.yahoo.com with HTTP; Thu, 24 Oct 2024 14:50:08 +0000
Date: Thu, 24 Oct 2024 14:19:12 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: Taylor Blau <me@ttaylorr.com>, 
	=?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@cepl.eu>
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <1945074076.3173992.1729779552281@mail.yahoo.com>
In-Reply-To: <D542P2ZTHIUJ.2GEJYE41VTC0J@cepl.eu>
References: <D52FCQ2F409N.1S5Q8XRAX5YU7@cepl.eu> <ZxfKbsapf3MAUmcy@nand.local> <D53YJ81WH001.2KRT4KHARKLC4@cepl.eu> <1101848017.3146876.1729770380522@mail.yahoo.com> <D542P2ZTHIUJ.2GEJYE41VTC0J@cepl.eu>
Subject: Re: bash prompt evaporates in subdirectories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22806 YMailNorrin

 On Thursday, October 24, 2024 at 04:33:14 PM GMT+3, Mat=C4=9Bj Cepl <mcepl=
@cepl.eu> wrote:
> On Thu Oct 24, 2024 at 1:46 PM CEST, avih wrote:
> > ...
> > - How did you install the git-prompt support?
>
> Using the git-prompt.sh from the package, but it seems to be the same as =
the upstream one in contrib/

Good.

> ... using the script from git-core.
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 . ~/git-prompt.sh
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PS1=3D'\w$(__git_ps1)\n\$ '
>
> Yes, that works:
> ...

Good. So this probably means there's no issue with that script,
unless you can isolate a specific minimal example (with some config
vars, PS1/PROMPT_COMMAND, etc) which behaves badly.

> > - Which shell do you use? (bash? zsh? something else?)
>
> bash with ble.sh (freshly updated, but the problem can be reproduced even=
 without it)

ble.sh looks pretty not-small, and I'm not familiar with it.

> > - How is the (git) prompt set in your shell startup file? (~/.bashrc,
> >=C2=A0=C2=A0 or ~/.profile, etc). If you don't know exactly, then can yo=
u please
> >=C2=A0=C2=A0 attach your shell startup files?
>
> * /etc/bash.bashrc is
> ... (generally default distro files)
>
> * ~/.bashrc is https://mcepl.fedorapeople.org/tmp/bashrc
> * ~/.config/blesh/init.sh is
>=C2=A0=C2=A0 https://mcepl.fedorapeople.org/tmp/init.sh
>
> ...
>
> So, the problem is somewhere in my too complicated configuration. Any ide=
a, where?

These files load/use ~/.config/dotfiles/osc/osc-prompt.sh which is
not linked or provided, and I'm guessing is either the culprit, or
the issue is how you use it together with __git_ps1, which I can't
help you with.

You may link it in a reply, but I likely don't have the bandwidth
to look into it, though maybe someone else would be able to help.

Or, even better, you should look into it and bisect your config.

For what it's worth, if, with that same Tumbleweed live DVD, with git
installed, I add your ~/.bashrc content to mine (default), and add
this final line:
=C2=A0
=C2=A0 PS1=3D'\n\w$(__git_ps1)\n\$ '
=C2=A0
then it does work correctly (with your GIT_PS1_* config vars etc).

But your PS1 is:
=C2=A0
=C2=A0 export PS1=3D'\h:\W$(__osc_prompt) \$ '

So I'm guessing things go wrong somewhere between __osc_prompt
and __git_ps1 invocation, but I can't tell where.

Anyway, good luck.
avih

