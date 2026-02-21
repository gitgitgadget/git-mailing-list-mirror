Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB351DF25C
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771695110; cv=pass; b=JSmvrlM0wr8O0YJYhOG0tY+dWl9+pO1aQHdueV+sbqteiPHDtuXwypzwf+8+iPmHYVNUZKQaNSYLv5IsFNiA+gbY4cC3qJ4I9bo0iaZeff6bqY9vvzkSvdyHOuLOQ0NT/31CC5qwtzDlLUUxFjF/6DLGA4B88mPrI4O0aur2peo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771695110; c=relaxed/simple;
	bh=3Ef63nM9vj02s6l2CalEstUHcw0DetLXaa9PhnjvPUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NS0/4KSW+lxHxJIYUXETwgq9lmhXmFvAK6gCbpGnlYKHArue/A6hznbors4ThIyRJrPk0ap9w3d+Q5LtuE8AgSeUA6G2Dsaun6ptANXIw42SubfwqkxYpOeTulQXcf0uAoe8ZSkwROrwQ8dXvG7E/0ThvGiL5F95eIdLdhPCAXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEI/zlQd; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEI/zlQd"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94abf5a5e51so1910341241.1
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 09:31:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771695108; cv=none;
        d=google.com; s=arc-20240605;
        b=ExgxYMEzqZD2isocwf5PFAttGUZJYsyrN+RQigRfMMGlv+FJKFrPp/bUHfnNDAo/bb
         S0fAY4Soh95mDpNj3iHndq0ZWTunEPe16IwKSl0wrWB0HvvNBJCEfjCbhepxHofqJphj
         tePz8EwKdSh7ZAmdhkn+yI9t0yIay6Ejr+Bhx3Qa++b3NL7WQyyf8YsftRiQY9NeM8pZ
         h/ncDN0gOgzNA+neubadh4E0EVQE89s5/SVbfmp699vMkWS2+BOSsFV4QkOeuk+uqJoM
         Z65ModLQ005eOi82kD9DqtTFWDPgUGl+bW2yYNXvZskBGWX/GSKaj18Yhhcye02f7xdQ
         n7mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Ef63nM9vj02s6l2CalEstUHcw0DetLXaa9PhnjvPUI=;
        fh=gCYhJJQ6yqSuiQ4WpGYbuWbDC5XxyZrcy6/BxvrOLBk=;
        b=foBlec+vsl2QQqIPY4Z41JFmNg8wXvY3P/0Ln6fEaQDE4rDRvEGIHEjM77IcxNPOhL
         4snLa1B7IWxXRjOxqRvCcuazBW3Ng1XCuBKMiE+HfdUX7X4wDQ/ZBA5WzN/xQVusIgwh
         pw9ctVLPLTMjO4y/ww/VCIriND7YTYJU0rXWZSeShgbP6h7D3cNx08E1TdHeQ1LcOD9W
         2Cohb4+1qLZpV2cVLyw85aTba7GaVCVwh2XKFLWd55gNf2y5RCU8fAg61w4oBLWTQY84
         zqGb1cKYREWaCZmXrIv6J8XhJ/RNzuyyjCfl/FeAeSjw+z6/pZg9dQIaaO7vXoRTHrys
         +09g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771695108; x=1772299908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ef63nM9vj02s6l2CalEstUHcw0DetLXaa9PhnjvPUI=;
        b=KEI/zlQd7l+jsKx0/UHw2Law+yzwN6TzRzm78UULSGhxzeXJfKIYEAbw3cyl0spvur
         JU7/dWToIbO7T0+iptoqw/sZMf/LQDYPoQaWB2Mix9pmHn+nh9p4xXOJnKLfA38d8gb2
         Ykps8zIN5DBIGRdD8WzmPJ/R6S2oVQpOnu1uXwMdi/dUg7s1bNit+B97smlQZL3YntBO
         xhzevvdXrDzaYiZwZ8m43+uFVcLzKKXHw9REreLvKXkCL8sgINuRQ3CP/CnF2oNx7W3D
         mar/KT4SG4I7LHZk4DSL6tDT3DXGBOkP8OXPfKZzxcUEfVvzzhonBIQ+TckTKeJ8iuzd
         b12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771695108; x=1772299908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Ef63nM9vj02s6l2CalEstUHcw0DetLXaa9PhnjvPUI=;
        b=GPpiCeQHjIkoXfaYumAXNRLnUfkenhGfDT7ikLBtCF9lQ7fjhdmoDM5jaQQJUdia+3
         z8rWwZYRY+j6E9Vnw1Stw1GhbBU8Xxgp0zCa8GSjyE0kHOS/Cq915ZQOtsAOtPGHurD0
         tLW7NQmc1SXgJ20PFkirwDOqT0rZsM23VzViu2rf95dmcff8HmRjBn3iL/6xMP0VW8Ne
         CS/0Dv6w2kMcP28xzs+nal6yrPSjV2WaIS8ncWx0rXAhuVmu7o2yXHn2M9u8h1Zci4xW
         ocT474kZnLcDKtS5CdLroNrkAc01kd7NQZkjnGBiEmd3tNdUNClq7uqALRf+ftYRfKB7
         zdIQ==
X-Gm-Message-State: AOJu0YwmbD0OENnX4meCB47OuDKPXprPdjNoNLkT//aJTH66MJDXMpYQ
	49FZqPzxu1/ZTyujk7O7Z4tq8cCcCwk4cBTjmcdFH5R2TMF5MxaBJ/4QNQlh7A95po93rXq/Wj+
	K7zCloAM19JRigNJaHjMdFHYuVQ6ds6w=
X-Gm-Gg: AZuq6aJCgBzrNvzQJkx0UymQhHnx9Se3nwXmk/vfgHlz5P2/resZHXWUa08E6GejPa5
	qlvF2DMbkx7FRJdhQj2ifMv1dOJU9Hwn0GKzDxFY/OSAts6oLEe2QdfSfDspc1SBqxSMg3345Pb
	JH1YN6dpuB29IvATcoDqAUfXzuA/apO1tmr6D+lLilgj23YneDghSG2ewC807gViFt8qi6z2TYp
	5ctirOWARf4xdESk1z/u/aGNt/7zIHhcfivbQzzcyX+X0h0NtOkRYyW/DEwjY4EEqxkFjpfEyQK
	qD2+Pqo3kJ6pjY2F7N8DsEoiwtfcny26Tvf11h8=
X-Received: by 2002:a05:6102:c4b:b0:5df:aff3:c42d with SMTP id
 ada2fe7eead31-5feb30da707mr2115416137.32.1771695107846; Sat, 21 Feb 2026
 09:31:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHU-3nJVDmdU9FGiPTxR=rL7nZEC3K=0Xyc5gAZNCRYrQMG4uQ@mail.gmail.com>
 <CAPSxiM_k8utRBS7SyHTMfH97hC62CtDguiV1SDXGB3M3JkdJ0A@mail.gmail.com>
In-Reply-To: <CAPSxiM_k8utRBS7SyHTMfH97hC62CtDguiV1SDXGB3M3JkdJ0A@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 21 Feb 2026 23:01:36 +0530
X-Gm-Features: AaiRm53OyCAdnIeezMdbEx1hGDnUMYDT2clq9EgCk1TUf4VR90Mb00dtKKtBf6E
Message-ID: <CAPSxiM-J7EjfGVyVs8w7wc0graOx17mjySXyHVJONyt3KZNUTg@mail.gmail.com>
Subject: Re: [GSoC] Lambert Presentation
To: Lambert Duclos <lambertddg@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	lucasseikioshiro@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> mailing list. You can use /preview to see how your patches look.
>
> Also, you need to read [1] to understand how to write a good commit messa=
ge when
> sending patches to the Git community. You should always sign off your
> commit and that
> is missing in your current patches.

Disregard this, I see your patches now with the Signed-Off. Good job.
>
>
> [1]: https://git-scm.com/docs/SubmittingPatches
> >
> > I=E2=80=99m really excited to keep contributing and to learn more about=
 the
> > process. Please let me know what you think would be a good next step
> > for me.
> >
> > Thanks!
> > Lambert
> Thanks for your interest in contributing to the Git community.
> >
