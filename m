Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052D3815E3
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266766; cv=pass; b=iRjCbG7kP5XcpQMHu1N0fg0mdxSloFpqURqGwMSBlMh4LTdZIzRjKWJvqJ6mkJELa0Ll1qN5RwGJbAA6oVO+UzNIjQ/lXNt9qWS5CERMz23i+znNzIWFvZbZtcUGZwrY2KhkVXp4+DP1F9nyUwoytAg5X2SWCibx4n58hG/durM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266766; c=relaxed/simple;
	bh=E8ByVuZf4yHGujSLAH9Ti+q2YpJLxFr1cpNQPe+GkvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpNM+Ysa+xDoucGpGP88PH8qa/+svBFJjjWUBOP4XnqrwWZXFBRKGFr1dy9NVhsVYmEVzoLkZYlqCNoufq85b/swLDiopYLjxTJyh6CbhFa1xEyzdH6Uju3HqMb2pQE4P4pheUH/CFETOXmMeQ32rYwmPNgM+PSJ8wuByByiSQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2Wix3YZ; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2Wix3YZ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so42060805ad.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 05:46:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788266764; cv=none;
        d=google.com; s=arc-20260327;
        b=mGL8xUr2ngZeVzEXO9uxpwjKc9MtF/9mQXb4dcEa89lDfAu69u8IBTC0U5j7niW/Um
         yz2t1L3XnFYowxRJA6RVIVYWKTg4iNY+XxFPYkYlN5d1GPB6AXmMNyvlVWLic8h8/MM8
         o/xI2eGaR8nrhm1oGtN8tH8xHd00VgI2do6OtiVFakWb83throLglQyBGf59BXnrMhsd
         qnFP3ojIXf6lPM07Ho3TV3jAwTOlxwe96m1oc+0Sc1ssbY2QsmOOj7+YQaZB0m92SDfB
         cupAbb03Z1E9fvnSrpO4BukQx81Z2ML4Gxbni6U93G/RbaXYb5piznTNSN3//MacPkGh
         0hMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cXjNKRQ4zH9NnWscLvfXkt7vXGDbCrgIUbckZQ1DorI=;
        fh=hOcouSehTpwraVgAnrqkz/pDkMU+Dp8yK0zKQAltm04=;
        b=aosO0a6TnQp5T8H5WjmZA4iNbGzBYBZ6xTECfWdiyehjcf4vQGAbl5CuvfefCC/Nuq
         KQanY0bwDi534/C4x5i0kQlOWJGys4Q9V3ZL95Ufs5aZsdVwZyVEBublxUKcBQ7VYVVY
         tbNr5eSs4meJPhCH6Sz/z3ArBaEzTfsnfnLWdri65Oh6rc0DI8sdw00AGL4j8K8K04mm
         qe0FRJzkWd5wnKkUMsbxiw6CuBOqKfIq2wUqpTHCG2Jz7o55RwsAbCjvYJgcVjEqy/eh
         iNmeqCpPctrWVkVAVsfZ7diz2VtvH/hSHsG3+bgCpV1abYuNLpS6LzF4/od2EE8i3RRT
         FAog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788266764; x=1788871564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cXjNKRQ4zH9NnWscLvfXkt7vXGDbCrgIUbckZQ1DorI=;
        b=j2Wix3YZs90cOSfOVjUuHhA873XU+s82HtjzDUeghCiaOxFA6O/q/WaEg/2nDsV1LL
         XMJuWfkNIyb71Y0p6/lX9rf4rmnaWle4WXMsPJZyFi4QTZSDg4qqhxkUcPYEJY3a1KHu
         psdQXPSKkgInzyplxW8lzgophp8gIQXXr/j7qggH1tsDWy9DNoMGrT39/n2NRnt8NPrM
         pfcjCORs4BQUWT9DgmSLzpgFmnV0xjgGJwJjP5lU5RYuTotpi8vYExL9wlV7qODfJGNt
         CNbh94kruCpMTUEfU+TBhrDnh9oDbg2hHH70wcbJLKIKbfTfhh3MJKTmPyU5j0dzay2t
         ZFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788266764; x=1788871564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cXjNKRQ4zH9NnWscLvfXkt7vXGDbCrgIUbckZQ1DorI=;
        b=pa1TePs4CY0N2646Y/CEIrnUyWIwrbkq2BGaHsL4mAFtg5IilbaxUnRPUy4/xY7Q/e
         QRhDEeqx8DyrBF2U8k2lPL3r6VMUo3eUX+5up5egR2tMwAn0GddhveXg7NHJIaazKP86
         x21s9kVkkaLPnGOIMPfEXqsCl4DgM+wDTz0PL9JPS1n26e6nstL9nhy07oOuguqHHbRL
         Ezfu0jdKCnNWCrtBkJgoBDuLbZVNVrKEfoZlinGYhNdTYQ3c4SDWnXRk9DZrTNE+wypg
         Lnao1d74Ia4hfz4aBvU2P5grTqmj7mesbhImqckMzM0h/BInsKFYprusyv2VPMqKJGfk
         B1Hw==
X-Gm-Message-State: AFuF++kknaLhjyZQtOCJS+gMp9nUTfo/dnAofFIgMG71KJKB+yZAKgP6
	H1/NEutM7HTiOjlni6EEke9bY7xe2h12OpzCUnnZqOTFwiMLEwFMymGdrnwp6WwRvZRuOrv0uWY
	jFUuva7V0DTGwpIXH14sAcdB7kiZmw4U=
X-Gm-Gg: AYBFou1usiW9FWWfgLcLWMods/pcSTaNCTxjH+YcfRVK+BG8L0M5pnixaSj5BTvsfqW
	VgRs5veI8Ff0jiSblXa2aBK8kwTjxXOpiwzy6Db11U0H7rhP9/P09D3Et07wI2EcqcwDR2ycfZW
	UxU6jgDokkapETnLKNle6gRWXxHBmHrp2YdjSXhMrEsraD/MENdULhRp/xJ3KZUA1XEovtIA/Kj
	daeCdoP/9UQBEXYarnY5Yd2Job5c1CbMT6OifZ4sov1TRDOzZYI7AaA8ZoO/mHzl04JSiPrfdZp
	DeSndxaYJtekt0UfchGN+NTxET4UhGRKnrTs+1BA/rIFEqTt7htf9v6cUZZwn4dTveWdhoAIN1b
	k2IBwSLlBdJija3/FmZfXjC8E0OnJ6QDw2thBWagfrwMh8egMdfWQ7j8WKDjFw3GVLvLbU43+sk
	xyikSOHkg=
X-Received: by 2002:a17:903:3d0f:b0:2d8:d4ce:7e3b with SMTP id
 d9443c01a7336-2d95d5fc28amr63484105ad.16.1788266763051; Tue, 01 Sep 2026
 05:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD33n1h587u5W+akp0MGHAgt5uMqpJVJ6HeZqTGDr2Ahig@mail.gmail.com>
In-Reply-To: <CAP8UFD33n1h587u5W+akp0MGHAgt5uMqpJVJ6HeZqTGDr2Ahig@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 1 Sep 2026 08:45:51 -0400
X-Gm-Features: AcwNN1VnWR3HNaTZth7TEmgbigGpcxJjfKsbIFQmg3dw0zWk-Ew7HgYazxLo0xA
Message-ID: <CALnO6CB_MMDrq_R8USxqVrg7+dBQaTLR-mo0DhX4QktUyOOOPw@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 138
To: Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Jakub Narebski <jnareb@gmail.com>, Markus Jansen <mja@jansen-preisler.de>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
	Kristofer Karlsson <krka@spotify.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 7:52=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi everyone,
>
> A draft of a new Git Rev News edition is available here:
>
>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/editio=
n-138.md
>
> Everyone is welcome to contribute in any section either by editing the
> above page on GitHub and sending a pull request, or by commenting on
> this GitHub issue:
>
>   https://github.com/git/git.github.io/issues/856
>
> You can also reply to this email.
>
> In general all kinds of contributions, for example proofreading,
> suggestions for articles or links, help on the issues in GitHub,
> volunteering for being interviewed and so on, are very much
> appreciated.
>
> I tried to Cc everyone who appears in this edition, but maybe I missed
> some people, sorry about that.
>
> Jakub, Markus, Kaartic and I plan to publish this edition early on Wednes=
day
> September 2nd, 2026.
>
> Thanks,
> Christian.

FWIW, the following post discussing benchmarks around topics related
to this series (I think?) and the release of v2.55.0 was shared in
Discord:

https://lnkd.in/p/eYGZb79T

May be of interest.

--=20
D. Ben Knoble
