Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6B03D6673
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355359; cv=pass; b=DYu7B+zaD60e68RcPHfEDbFXcooV6el1DZWCCUx5TQmLG4yyIIqDtiKnifCsUsZgQbVwne9Iu5eQdVzl698fjGRrte4bSxMDG2vI7ffiK5OyAzO6vVDxQ/KehJH8OGM56bUOGRTBO4lWQdo/eKkPW/GvrHTNxWbzWvwLpD0OnrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355359; c=relaxed/simple;
	bh=0wGcdvoLXqNxorzohT1XB1kzGDl0mJFuyiM1npLULZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIZ6+KK3/M1fkMQpGPonjnLk4PphSfBqx7Zgts8/d29Th+vc4pwuwXoj7LjKNrzQNy9HX4XbCvceuDnFSBoGMiXAhd7cW1QqMmcn5hm/Bje7WSYVnJq30p0Y7OOQuDT6O0ESjEr63ZVn4PHu+AIAAltQ7xpH8rGxHqskDQv4EAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0oebFEj; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0oebFEj"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12a74039dc6so999891c88.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 05:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774355357; cv=none;
        d=google.com; s=arc-20240605;
        b=k5BI+ZKdyG0QhwSRnAGXgL8iR8muphlJ8RDAzeFL5s174p2xe4UM8s0HJhM9LS8ICe
         UFXy/m35r6VbWiWUqdRn30Dxj+Edb4QI5u0IETqUMN5kyCQBb3CvymcLLwWiZ2bhGtUk
         +km7dvJeqffeh0d7YnPnl1id0j7DppJpnYK8tnPK5O3pSkB6f+SvduLzgQghPCgRCzf7
         bCKliqTMXfNsVX9vnC7U6RxctoR4C6nEdBO7eYYfK2qqDNEONwL43wkUKEC5mKsF1NmM
         Gv0OqghGa5HiOv0OmrL97QptUa6O0yfPFtJ+drHQkHUT/fFomCDhUMPY3DZUwMdgVzpe
         MgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PZhS0FJBcFLM9WNW1+lej5+QT/EoadyYwBZFsJhezB4=;
        fh=lTfQVUOxvx+BtGC8eiUlK74R0gQvsfN538dEofM7fAc=;
        b=atgpexfWzmgn9Te6/Zkn/8nes5+Q4Cxjpg+6B3f5mnOwhwbVR0gY53DQYsS1pt6tr/
         RED+S3qPwSzz4sGGhWFNwf2hDX887Q1+Xh/XWd76YHWXxWhUz4DSBTsnheRGoYf31C4g
         Z0Eac53gVuGPs9a9KugAvKqB+dkythfsGhnsyqAMiOApkrTpBJa3FnNIha5jWno+WKOU
         f9Z6Fkutzrq0hVUUXY8uCxDsK2Y3LlFFITCdtlBM2yzevPfuy6tUTSjWRi9HtO5PDqQu
         dlTX8gEeO/sc5/A6lVQdeNFSH/D1qVtPEe29Rwd9k35/sV3V/SBfCCif4EUIHzA1rPKu
         w8uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774355357; x=1774960157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZhS0FJBcFLM9WNW1+lej5+QT/EoadyYwBZFsJhezB4=;
        b=N0oebFEj1J99WGGQ21HwzbMSs8KFie/USlMSI6tpyouxqwQ0LsU6ctBGFkdpCfM7r5
         uotIn7CVdoZPhLguJZIN3FI/QYILhKhz9WY7DCL/Nz2FUsqRPycqSwqiRzZ1GnJBqqox
         MF/fAxZxEPfQ0Kn/gmzxzS01I9ssllyibvgDMZlAmYGkTD586b8vNcvnY3Ur3XDRA8iw
         FdrGNxY+4ZQADKMjDnmp4NY6lI1EUX8S/kKMLOty+VR/mXXy98ioVfnnCCU8y9hw32gZ
         jI9X0Cqw87+aAIohtmMmnPmKOL8bG5Ghi+t/da/4g8SegS+qfkhdetZI0uIrHedTTqLQ
         96Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355357; x=1774960157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PZhS0FJBcFLM9WNW1+lej5+QT/EoadyYwBZFsJhezB4=;
        b=IiQnPyANkZdYNLpFVVkeqHmDlgwcZQT7aGO1988xN0GnosUm5wAR7Uiq6SuX9cPdEd
         bXY6hCBKRRz+cTin8p7p4qHTehU2vocJO5Fkwu1Gdk45Xj44HvMJV6HgVjFIwhRFIiJu
         tFe69nMGzutN6HuBDhph8BamstB39vbq8RhtlKsHcs0cZjE4Js8NxiF7gqBuOdK1T5Zc
         V4CsAlsxQwQGKPs8GPad8xshKS4WaHYmWmRAad89r4PtQ1Cvnn6nK4ZoH25vHhTLrbZm
         chwLgs4A84CSGKx0EikFMXsa3RGwC+tOO3qjjy66DWTN2j73fx7pPJFVRC88ymYBWhXT
         iNqg==
X-Gm-Message-State: AOJu0Yz3wIoOTk/oPDJIdx9D+RHnvGIn7DSPj0T3ZSGKfF84/FHVWUnV
	cKgDpimNw3vG081CQMhI/hOYjzlHoitzd7976JeaBCbkzOF6ogshBYCRVIjFiMpmAcK2wKLwXOB
	CDFTmn7NU4TGtIWbEikSad7HHhZ5ECE21Omrr
X-Gm-Gg: ATEYQzyAU9aorP96DROdYihEH3zl3nrFaUpIMB025cPSvf0SvORyU/Ph6SrUF5e/axz
	LUv22jJUUD7B6cEjoopJZVh+QR1B04V71Lwv0Yxk4To+CL+JeQL5sE/yLKMeHCdPl8GlwWkMjX5
	kNWb+aScpY7JtboB2lOTwEd+tC+QKx9vAHJ4qKc9Hd1n8cvXwgZ54UZvpFdmV4KYwwlUm37Kr+d
	rBFfIiZ9WX81oOHDw86ZLhAGnswHREFb40BFwGYpByGWPrPdA10dlxWJLsKsK/dh1rVvf+Rm2h5
	MfV58ZHXSV0xgfvt9YRXpxV/AsFwkPrVkqwt4Kmo0JoqGrwZ0KqW0kzhFVhchJF8fg/G
X-Received: by 2002:a05:7022:41a3:b0:12a:6fb7:87e7 with SMTP id
 a92af1059eb24-12a72590c30mr6889685c88.0.1774355356626; Tue, 24 Mar 2026
 05:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aaN5OPgoGANYlabu@Adekunles-MacBook-Air.local> <aafga8AjpxagiEJt@Adekunles-MacBook-Air.local>
In-Reply-To: <aafga8AjpxagiEJt@Adekunles-MacBook-Air.local>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 24 Mar 2026 13:29:04 +0100
X-Gm-Features: AaiRm51hcTVISO8Q00kDD7Md5B4ftNLNRuh5CZ15PsdnZGGvTV30MS2yzEKT7FA
Message-ID: <CAP8UFD16pvfP4UYJHCCenK3c1-VNTJPpMBJL_LnHZZZXUC5ULA@mail.gmail.com>
Subject: Re: [GSoC] [Proposal v2]: Implement promisor remote fetch ordering
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 4, 2026 at 8:35=E2=80=AFAM Abraham Samuel Adekunle
<abrahamadekunle50@gmail.com> wrote:

> When a Git repository is configured with multiple promisor remotes,
> there is currently no other mechanism to specify or optimize the order in
> which these remotes should be queried when fetching missing objects.
> Different remotes may have different performance characteristics
> such as characteristics, cost, or reliability which makes the

There is a repetition of "characteristics" above.

> fetching order an important consideration.
> Currently, the promisor remotes are queried in the order in which they
> appear in the local .git/config.

There is the exception of the `extensions.partialClone` config variable.

Also I recently sent a patch series that might change things (see the
first patch in the series introduced by
https://lore.kernel.org/git/20260323080520.887550-1-christian.couder@gmail.=
com/),
but it's not merged, so don't rewrite your proposal to take it into
account.

> The project aims to implement a fetch ordering mechanism for multiple
> promisor remotes that allows a client to be able to specify a fetching or=
der,
> a server to advertise an order to the client to ensure performance
> and cost management, and the client to decide to use the server advertise=
d
> order or not, and default to the current order if no order is specified.
>
> Review of Previous Work:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The project is part of the Large Object Promisor "LOP" effort
> documented in Documentation/technical/large-object-promisors.adoc.
>
> In a bid to better handle large objects, the promisor-remote
> capability was added to the Git protocol v2, as documented in
> the promisor-remote section of Documentation/gitprotocol-v2.adoc,
> which enables a protocol negotiation so that the server can advertise
> one or more promisor remotes and so that the client and server can
> discuss if the client could directly use a promisor remote the server
> is advertising and if an agreement is reached, the client would be
> able to get the missing objects directly from the promisor remote without
> the server acting as a relay between the client and the promisor remote w=
hen
> fetching missing objects.

You might want to split this very long sentence into a few smaller ones.

> The ground work for adding this capability to the v2 protocol was
> started by Christian Couder in [1], where if the "promisor.advertise"
> config is set to true, the server can then propagate its promisor remote
> configurations to the client over the v2 protocol during the negotiation
> in the form
>
>         "promisor-remote=3Dname=3Dprom1,url=3Durl_encoded_value1;name=3Dp=
rom2,url=3Durl_encoded_value2"
>
> The client can then choose to accept some promisor remotes the server
> is advertising using the "All", "None", "KnownName" or "KnownUrl"
> configurations as values for the "promisor.acceptfromServer" config optio=
n.
>
> In [2], Christian added the option for a server to advertise more
> fields after the "name" and "url", such as "token" and
> "partialCloneFilter" for the client to use this additional information
> in deciding the remotes to use as its promisor remotes by comparing it
> with its local config information.
>
> This was implemented by adding the "promisor.sendFields" and
> "promisor.checkFields" config values to the server and client respectivel=
y.
> For example, if "promisor.sendFields" is set to "partialCloneFilter", and=
 the
> server has the remote configured like so:
> [remote "foo"]
>         url =3D https://pr.test
>         partialCloneFilter =3D blob:none
>         token =3D "fake"
> then
>
>         "name=3Dfoo,url=3Dhttps://pr.test,partialCloneFilter=3Dblob:none,=
token=3Dfake"
> will be advertised by the server to the client who can then decide,
> using the "promisor.checkFields" setting, to check if the passed field
> matches certain conditions before deciding to use it.

The "promisor.checkFields" config variable is not quite to decide if
fields can be used, but more to decide if they should be checked
before the remote is accepted.

Using the "promisor.storeFields" config option is better if fields
should be used.

> This work by Christian is very crucial to this project as I will take
> advantage of this and enable the advertisement of a "priority" field
> that the server can use to communicate with the client in deciding to
> use the server recommended fetch order or not.
>
> in [3] Christian also implemented the option "promisor.storeFields" which
> allowed the value of the configuration to be saved in the client's
> configuration file for use at a later time.
> As above, this option will also prove important when the server advertise=
s
> the "priority" field as it will allow the client decided to store it in i=
ts

Maybe: s/decided //

> config settings for that promisor remote, for later use when fetching
> the remaining blobs from the promisor remotes.

Yes.

[...]

> High Level Approach to Project Execution:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 1. Introduce the `remote.<name>.priority` config option:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> As said above, when fetching missing objects, the order in which the remo=
tes
> are queried depends on the order in which they appear in the config file.

Not sure this is worth repeating three times.

> To make this flexible, I will introduce the `remote.<name>.priority` conf=
ig option,
> which will allow the client to set its preferred fetch order to each prom=
isor remote
> configuration, and then make it fetch based on this "priority" order.
> The value of this option could be an integer between 1 and 65535, where t=
he smallest

Why 65535?

> integer indicates highest priority.
>
> This will allow a promisor remote be configured as follows
>
>         [remote "prom1"]
>                 url =3D https://prom1.com
>                 priority =3D 10
>
> Therefore when the client is configured with more than one promisor remot=
e
> and the prority is set for each promisor remote as follows,

s/prority/priority/

>         [remote "prom1"]
>                 url =3D https://prom1.com
>                 priority =3D 20
>         [remote "prom2"]
>                 url =3D https://prom2.com
>                 priority =3D 10,

[...]

> 2. Community Bonding (May 1 - 14, 2026):
> ----------------------------------------
> - Discuss design details with community and mentors
> - Understand safety, security constraints and design considerations
>   when implementing fetch ordering.
> - Read indepth the Documentations for promisor-remote, gitprotocol-v2,

s/indepth/in depth/

>   and other necessary documentations.

Thanks.
