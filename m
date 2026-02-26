Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286D3ACEFD
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772116310; cv=pass; b=cgs059XhGjQBa3efO1GQkmA19AGgkfU1xQK3I74rLQPbjv4O81apcsifuoQ1H6ABrKJA9/6cQEPyp/G6A75jPtvtN/cKRAz/BH6zAB5YHo/CxYPa8oTomQlJCyuVxXPz+DbglNxqywz1/HR4bBA2qlw6nH7ihhrPxKfpT0Ri+eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772116310; c=relaxed/simple;
	bh=sJlhj6DqM87fRtExz5/BW2Tvj3+uRm4r86zoWKfYtXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HU8++U1L/wldeAxkKCVpVlf/2vTc+lzjoeGMiIEu2jsAStsS4bcXFJO039j/6BvJr1C5QhOZrQhxqVlHRiqkFTbqaT9vjo1o+HkE2+NSdaCAX9j2+cn4UkhdDDIF++D9GJ11YzHaWVfmxrcLdAsBE8BLjkOMGUVWG/zYHet+F68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFlpdXxm; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFlpdXxm"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79495b1aaa7so7785507b3.1
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 06:31:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772116307; cv=none;
        d=google.com; s=arc-20240605;
        b=CCS3OIvDj8ivhHdUtVvCCJ1gQYK8aODO0r8lQlriZg8Ttwogd49QDoDqSA+tZD6M0p
         v03xRxLMeLVsr1dTlDaYIIvR8YB9PFNCv8WEa9PUqh9aSjV4n+RPsNjjojEzKv87xLlo
         GVqZv735qRdbNbswEbpYfk1zLbyv69o7oTbLUCe3K3/ToVMSKM1cVtznTjvZv1uymPuw
         eUcElGhyrx5BksGzv92jjojLxgQEnjWEndr/HK7JBBfOrZVeETtkzDUDiTiKXhkQ4fT0
         n/UY11a/+a6Rzu3kqQ2FwxV6d3Gy2/LItl5R+J0/XxiBOzMR/agdoipRpW4CLZ7fy8Qj
         6EeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sJlhj6DqM87fRtExz5/BW2Tvj3+uRm4r86zoWKfYtXI=;
        fh=ScZ/ikSy2559JyhTqbMtlTXvx14z2n4cNGqCa6I9g3o=;
        b=b4d/XM/Evjxp9BLxXzBo2weudHBF6c26FWkzV+nMT6nQ5DUVDIGVIBZhnuLUjFWpg0
         pDvHPI2B6yXW46G7WmkIzTQbxRwNq0nM3Mu6hnc6Mdf4ZJe5r9MIsHj2IFAdKP6WytcW
         a1rvQPkiyZC+q+50ov77cjuBFjUrgwIVziv014aUeeavxpvTpsYovlx3XU7jaO/5L8VE
         QIqJux3u9u+xLohAVnpePkUvFvMl7xKdzgdQCe4xdgkNRD+BieKso/N+4yV9jQwwgK3N
         6ICFaYbOR9skYgK3/lVdhuMgFG01oVYr4ZPrsEgrdJ3+LPxkVKUcgOKb6CH3WjSYuLD1
         CpdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772116307; x=1772721107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJlhj6DqM87fRtExz5/BW2Tvj3+uRm4r86zoWKfYtXI=;
        b=bFlpdXxm/PUpZ5VDkqNgYLQLQ0Qkp+kZ+r4x8BliHahKuqnZuh59izMTHgjXU4buHE
         HfksPWyA1oGAYzU8unTSIMgnVAUIVxQSumq0M78p0zC7y9Feixha0Lsg2nH+FrAVV0wV
         1Sr5CcrYvS7n1NevR2mzXYUSLfUp5j29DzSkUemEzj40OG/qfYVq/T0cXlN7I1zp2FSb
         OnRKXHy6u9PjGeedxGuLeonYbSKOVJ3vBkahMpzDgjOWaBDD+bBYnFleste7/IxQfj0K
         mXNO40hjR4/bSAmewCv9/01cnzoG57BEY0zRtFpwqkIm2zaB3Jh3okpymHP+GymKMawI
         bK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772116307; x=1772721107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sJlhj6DqM87fRtExz5/BW2Tvj3+uRm4r86zoWKfYtXI=;
        b=pluZ9VCaDL2O1aI3RP8naMgQfET6SDqqEvGJzMLIHDPXhNdNpzFB3pAOzysrpw7QZW
         Y9aOLerM/R6YyB7cVolHS11hZ6J+qsL7f0Od9CcEf50BgcyXlkuNrBOmgK6HJPnu6OL5
         ChnJPIBtYvDfAXpVGZrlXDunpGQGc6UNBevKjnNqS/FLGs96zQ1XwpgpGNzoJrqr3KEy
         IiAq9ZG0N1zVvBKoXxytmC3zjrliJxM/g6P4uwhtE8Jx3IjMqApHHvr+a8ghPS8TlFsm
         ensILC7iTrNdEfXyNMwRzcGnKEhS/pbsDldTAx9kZ4IRzSgOycnwbPWx3qwj+Xkkz8+q
         y/jA==
X-Gm-Message-State: AOJu0Yzsb5kLd33umPG6aX5EVT1YLKR9mETwpLBFufNt5TLY8ThVm/Pt
	flDfgKnpTjDG6VJqH68XjyrkprQgiBAjP49KXCi/jBOvNpaA0A8hvPMHFEYf/pxn7gRqGM1JJ/R
	0Zh7CJpSxoehisqRY0IkKpp7coWE/iJNI6UP6T45NzYbV
X-Gm-Gg: ATEYQzyYqzT5JG9zmu3PQz49hwx6NLH/etKPhLbQTqw8F57Aqw05ArdKuy3EM6K43jp
	gLq6KDJixpYYEDfyrDJtCzvAV7LyMve0/b3eiJO0Hs9Wv8QS+CzjlqI+coPEqwPR+CBEgKTn0JX
	TeLcOwesjblYokR7WbahqFEUllNzsFkMSWxI+8n/4tHIMiUqiG5Jq1anuhK6bAYNSd3wwV2DPY4
	3qu3TeX4nRuEpnEoxtIJbFaaDjCI81ybUbgH5vEnumb65gD/aF6L6JvVFKIJzvYEN6Vx0Opj5mv
	1GAl/TxUwPqB9w9EMkH3n1KGLCNN4VUvMHwgUcdWNmjgncIjTYc=
X-Received: by 2002:a05:690c:e1a:b0:798:1637:fee0 with SMTP id
 00721157ae682-79829157044mr184732817b3.52.1772116306523; Thu, 26 Feb 2026
 06:31:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABFJD6-7_bkixVA4Oj_JV1N5hMqFXFqBvK4KBAjM5hqcgC=_rg@mail.gmail.com>
 <0009780A-381B-4025-9C66-376680AD75CC@gmail.com>
In-Reply-To: <0009780A-381B-4025-9C66-376680AD75CC@gmail.com>
From: Santiago Leal <santiagojoseleal27@gmail.com>
Date: Thu, 26 Feb 2026 10:31:34 -0400
X-Gm-Features: AaiRm50Pn385fA4uf-JEywEcTYjEJifj_atCCMT_dzCor1EBqFlxLWOskAULaG4
Message-ID: <CABFJD6_daPbAB52fmBTd3px7s1hqHjrTk8gbdP0BATDmjKe+wA@mail.gmail.com>
Subject: Re: [GSoC 2026] Early Introduction - Interested Contributor
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm comfortable with C, but I need to review some concepts. I'm
currently unsure if Google will offer any monetary incentives to
Venezuelans, which is a bit discouraging, but I feel that
participating in Git will be a good way to improve my CV.

I wish you all the best, Santiago


El jue, 26 feb 2026 a las 10:15, Lucas Seiki Oshiro
(<lucasseikioshiro@gmail.com>) escribi=C3=B3:
>
>
> > Hi Git community,
>
> Hi, Santiago!
>
> > My name is Santiago Leal, a Computer Engineering student (3rd
> > semester) at Universidad Gran Mariscal de Ayacucho in Venezuela, and
> > I'm interested in participating in Google Summer of Code 2026 with
> > Git.
> >
> > My technical background includes:
> > - Languages: Python, JavaScript, TypeScript, Rust, C++
>
> Are you comfortable with C? Most of Git's code is written in C.
>
> > I've been exploring the GSoC project ideas page and I'm excited about
> > contributing to such a foundational tool used by developers worldwide.
> > I'd appreciate guidance on:
> > - Which project ideas would be most suitable for a newcomer with my bac=
kground
>
> Probably all of them. GSoC is for newcomers. I recommend that
> you take a look at Abraham's suggestions and read the
> "Git Internals" chapters of Pro Git [1].
>
> > - How to set up the Git development environment
>
> Git is really easy to build, you'll only need to install a few
> dependencies and run `make`. If everything goes well you'll have
> a `git` executable that you can run.
>
> Tests are shellscripts inside the `t` directory.
>
> > - Any recommended beginner-friendly contributions to start with
>
> Take a look at the microprojects page [2]. They are suitable for
> newcomers and finishing one of them is mandatory to be accepted
> in GSoC.
>
> > Thank you for your time!
>
> Thanks!
>
> [1] https://git-scm.com/book/en/v2
> [2] https://git.github.io/SoC-2026-Microprojects/
>
>
