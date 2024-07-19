Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D9D59168
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721421359; cv=none; b=AbsstxXjh5hKzXGNg6R9e4SAA35dSd158kDilTcyl8xrpWcT/4vdZqYKvNpGeOILzjzwPFh1l7TVRt3mnEcHHMJG06Odu+cuGZ9SGAaQe3sOAZeZMQGYXsuhjm0aCvE0+n+TmA7fK9PDMM4XlO8DRxngR08kudd+WuHU2XsyjIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721421359; c=relaxed/simple;
	bh=2rj5pweu/jkU38D7unbhhgBgwnioeQUAMvLwhJri4pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QGef9NksYbYmTbAf+HDGtmHE93bQAxfLwMsmcVyX5ecc/nmcDyV6SCLzD77UZtbcstTNaa4ALHJCg6XILyTU3/FbAS+8I//mE+o0ouOIgf4JBWbKwSa4e6ej81NLL8/MyeV88eZNHAM7ZLO3Hr9qNjlO8th+Lz6jz9YHBLHKPoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mytechnologyco.com; spf=pass smtp.mailfrom=mytechnologyco.com; dkim=pass (2048-bit key) header.d=mytechnologyco.com header.i=@mytechnologyco.com header.b=bQM5Hw0B; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mytechnologyco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mytechnologyco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mytechnologyco.com header.i=@mytechnologyco.com header.b="bQM5Hw0B"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-82175064454so808413241.2
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 13:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mytechnologyco.com; s=google; t=1721421357; x=1722026157; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJKnTsRsLSdo8ZVckegNXx8rNCMfR9KYwcvZBNs40rM=;
        b=bQM5Hw0Bx/V3h6fgU+h65ad+Bqa+jFPt5R/Ymz8aEOG98QIXQ+n7Ga9rTNly2AXeOZ
         Oz4pP0dvsvr5jHQc05Ew2O1THOyoHucv+aY4v80QbicIklDdQqhe/XgKwoLYcWePlcRf
         85zqNXvDRZUdXZG4s5sSbDAaWznpK5L79ZRFJN0iIMtLRLnMviYZuDVzKTvp6+t7oDOk
         wUUtXPwOW09k3sfIorH4BPp0AVNlFuxe7Ogm5KcWhNdaTtwpqDzVCoziYfDhZYfUC7jG
         P09Jv2FjiRRI9XawGIH/dip55Xf20wRA6q5Gyu6x6fVtwyYKaR6woHAG6rLRLFViFD5X
         ChPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721421357; x=1722026157;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJKnTsRsLSdo8ZVckegNXx8rNCMfR9KYwcvZBNs40rM=;
        b=GOevNtspZ9AhLItQhiuDMAhR2dQBGLulqJNrVYkZxljpdbbKsCMGFGD2Iqq9t8IGpa
         +JOCfDLTcKjFU2CWIBrJZwQpVMZ9/xnl3FS5re0Jg4l7wRJo0ux9+pNDwDnH3DWWIuK8
         0IE60IQDUj+pGQ2loTwZEMaKMOOCvMgEIJptXJQhM3PbZXVw1UJuGzPQrpSjAHpQIODD
         4W5KPjOT2scIs7vbKVCIs0nLuxP72ZBZs/nxagvLjj804lplJ89zFqXKrR7ZrSGWsRyb
         g7YY21WvOnZoUBMggg1fcvg0YJ9MRTthx+meIgNL75yK+sBCzavqTwp+/Pk6XoCmFxZi
         ej4w==
X-Forwarded-Encrypted: i=1; AJvYcCXf51qbekv3Hal+wRxSd80TVvX3axxBt59iIxkODfIkIWMdBTdH0vcxHksM7BW1BvekFbe+0LA82jjwbHBI+DBlekOV
X-Gm-Message-State: AOJu0YzGnPFppyjaPz/OLdlUiGf5z2o9kyREsnrjoOSIHUlpnaYNemyb
	fu4HL81Y/6WGgT4/RCkPFeQfNVmphKn7O32Sv7J75n/rYiCVQPInbHus/gN3kHmSmFRdjrnusQ9
	aGKKTc4vuTqjgROesAGwICz6Fg/+uBbmKQ0zEP+SX8jbV9uIpvn/mOg==
X-Google-Smtp-Source: AGHT+IEKOaGBXPWc3JOh33G9vL9XDnLhwHWOLUT4IuYaED5G798GYSsZmYqx0on7JhlmR85ZIF/1iILh7ktS16uFb30=
X-Received: by 2002:a05:6102:80a4:b0:48f:df86:db3 with SMTP id
 ada2fe7eead31-491597faba5mr11542103137.3.1721421357005; Fri, 19 Jul 2024
 13:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKexjB-+6VXE8YXrc1YaOVE6bKs05Ty4XHMSBPRHUcUrxpp31w@mail.gmail.com>
 <ZprI_wP1km8eA7HA@tapette.crustytoothpaste.net>
In-Reply-To: <ZprI_wP1km8eA7HA@tapette.crustytoothpaste.net>
From: Roman Dvoskin <rdvoskin@mytechnologyco.com>
Date: Fri, 19 Jul 2024 16:35:46 -0400
Message-ID: <CAKexjB_kya5ux+OZPXVumwxVt9HWD2v3TMF7aFbMxXzYYV_t=A@mail.gmail.com>
Subject: Re: Bug report
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Roman Dvoskin <rdvoskin@mytechnologyco.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

Yes, you're exactly right, I renamed the branch called PLT-51 to
PLT-50-2 via `git branch -m PLT-50-2`. I may have pushed while on
PLT-51 (and perhaps that's when I noticed that I mis-named the branch)
but I did not create a PR). Then, I renamed the branch to PLT-50-2 and
expected the rest of the flow to continue using the new branch name.

rdvoskin@MT-24 platform % git push

fatal: The upstream branch of your current branch does not match

the name of your current branch.  To push to the upstream branch

on the remote, use



    git push origin HEAD:PLT-51



To push to the branch of the same name on the remote, use



    git push origin HEAD



To avoid automatically configuring an upstream branch when its name

won't match the local branch, see option 'simple' of branch.autoSetupMerge

in 'git help config'.



rdvoskin@MT-24 platform % git push origin HEAD

Enumerating objects: 27, done.

Counting objects: 100% (27/27), done.

Delta compression using up to 16 threads

Compressing objects: 100% (14/14), done.

Writing objects: 100% (14/14), 2.91 KiB | 993.00 KiB/s, done.

Total 14 (delta 12), reused 0 (delta 0), pack-reused 0

remote: Resolving deltas: 100% (12/12), completed with 12 local objects.

To github.com:MyTechnologiesOrg/platform.git

   9b7fc2a..b66bee8  HEAD -> PLT-50-2

rdvoskin@MT-24 platform % git config --global push.default
simple


On Fri, Jul 19, 2024 at 4:13=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Hey,
>
> On 2024-07-19 at 18:34:29, Roman Dvoskin wrote:
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> > I renamed an existing branch to a new name
> > What did you expect to happen? (Expected behavior)
> > When I git push I expected the new name to be used to match the remote =
branch
> > What happened instead? (Actual behavior)
> > I was prompted to use git push HEAD:<old_branch_name>
> > What's different between what you expected and what actually happened?
> > I expected for the new branch name to be used, as if it was always the =
branch name
> > Anything else you want to add:
>
> I'm not sure I understand exactly the message that you saw here, and I
> suspect if I don't understand, it's possible other people on the list
> don't either. Could you copy and paste the exact output you saw here so
> that we can see what the prompt looks like and the exact response you
> saw? That would help us understand whether the behaviour you saw is a
> bug or not, or if perhaps maybe the documentation is unclear.
>
> Also, to be sure I understand, you did something like this:
>
> ----
> git branch -m foo bar
> git push origin bar
> ----
>
> and you expected the local branch `bar` to be pushed to the remote branch
> `bar`, correct?
> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA
