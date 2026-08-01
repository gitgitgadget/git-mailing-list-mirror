Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A611C69D
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 07:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785568053; cv=pass; b=OGeD/LBPk/nOnNSTOTcBO81JY1KARigw+MBwYpVt+lQVuAa2riUihTAaAbOPc98Xo0Nu1H4DrZdV5M3KZdV+PsdGVE0BBcVMufg/omggWvmVyYFwnf2F8mjMHXH4sNQbUV86h5q3cY60l92eSARBSADbg2Uawt23jCYED+E5PKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785568053; c=relaxed/simple;
	bh=qJmUolBMMne1ZW0q1T8SDrf6qf30c7Lyy68q2M8tSUI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Mp4fvwnXbJBSJzIm6lSa/9npAVUDNJdoQgwTSKXDSy10DFKsrLqZ86IPx4rNuWAdurmH3b0lkKweKGBjLfToCIOgKXIXplGGzGKlrH8FQC1DbG63NCbnd1UPp5tni4qFkc6q4np/4/FCVXrKRXojIFZ3rK5kRITXuKcu8ZipcNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJmQaGvI; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJmQaGvI"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbb662575d3so984846a12.0
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 00:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785568051; cv=none;
        d=google.com; s=arc-20260327;
        b=lNzZKrTTQ8SYIB5RoV0ftM05lwoc71y44pSbhmDDxs2n/K0ax1eSnpAc7EubIJtgtj
         DgPgSh3dKuUlBGveuvIwWjCOOJJ0f9uxWFv9XCqilT4oj4VjLiGEMPErlQvm4AMXrN8A
         mNfCKL3XAq36ScAOdIPS46VUbfpr7ryAg98XP1JuWkfr31ZzeM7SM8lG4QBmE2Rz7hBQ
         8TfHY6eqZeT2om6LGMMEgwvAEAe7HaE15LUAekZK7nPI6+bHUrH+QkmeyxyXS8wwQB3R
         8IQgOC5a2lw9MRPeko9WJYi/Tnm1+06ToQscENLSZerf5MKjw9eI/1fISp2cfGsmBw/4
         ORWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=OecQ+nJE1IHT/WsalAyuGVJo5P1oJDl705sELSu5RkE=;
        fh=nIk/YnC7ljcxOjHPcrLSH5LrKfxyGnW1nB8nvF7YORA=;
        b=AKAJ6WiwsaIRgFvhl3RD8+yLI+rFRexyb6wANy7ltxR1euc4PeDVRIYNO08fTVBJuf
         GwpcrWHxjyaiyzESy9sHpVBuEZ15LkWZxegEmeJQ3K3ySgBlt0p2F+Y1f/8NMIJk6yuu
         MYJcwtcOCqyTzJj+WBBE3olUxQpUfyuF8Mtvd5zwAZL5l09IYV36ZpjCAPfMSaM+Vz6n
         G3PYRqCsuasPRlWHc9HtEEwFKot3wa8lr8HRUO9FOYWz9LXqqdu5wMICycaZz4N692vR
         NuqJLFBHvz1HOcuV6EvL9VclB9y32PzoLwQKxplT1f3Ilz0yj+yYca7OuO40ZkjSSzTs
         0Q1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785568051; x=1786172851; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OecQ+nJE1IHT/WsalAyuGVJo5P1oJDl705sELSu5RkE=;
        b=jJmQaGvIdeOuJ+ekYKFbcpU872P8lc/20jdzlYAvybfMjsHFHmEaTwMI09eK+pYHe2
         mgcGytMZDjBETkrR0uK0DysSGEgIGDigJO4Dwux1kN2C45TaYNcR378AEHuKUhTEOEzl
         pfe6iXgRaoi+WvZQoGa0CXUF8FScM+UpPZ4HTZvbMbObcDaSzoWv68w6juwdIXj5Nu5i
         yNR24rhWv+/dNmt+cOLWXWV/xyN4JVlv6nEObj+j0YJwoV6Ebs2rWDmT4mxLT35hr5ag
         o0ytYdzlnRqWIL8QG5g/jPZgJqum7i3czf2CTTlFGJDMc5qN2GM/tDFM6Q+yP9kySNE+
         hBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785568051; x=1786172851;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OecQ+nJE1IHT/WsalAyuGVJo5P1oJDl705sELSu5RkE=;
        b=qTRSurEWjVwsr/4Z2oFuhmJaMyQbLo9FGeYx/+NwRCFDC5UwNzd+3qIYcV649TQvn0
         fISbH9CWBxeMUxrp+uaVoBfApPwExREHE5LI7KB3U7QMY/kZ1uaDDHY7Z3yvxjPae8Gp
         bwY3BBmk1F89nF4Zqa6rT+B1XMEmsAZNIc1xZL0lMOet6fzD6H5B/wodhO6A54XpNTRe
         EmhEBXR0sEGj0b74EdahvBVONXDEygK7JgiJm+PM66PLBoueDryvZFz7YDK/CGSCff5s
         3cNe8fSRaJtB4caGew3hiivu9m2FYAGB5J76y8LdHYm/byQowL5/megbyLVMYcdRVge2
         pnjg==
X-Gm-Message-State: AOJu0YyiMJ9XAvzoJu5e/Gi3XtgoD2k+AYXeimcVdAKH5EmBsRmw5oi2
	tuBCWmqVnGsUd35Krm9POF0FQSKmYZjazdDpDoqVku5sBzO4DwSIm1c0CULRMpHUAraQbFacoVg
	R8ZXApANEt4bgN50zdOxYCfvsARDkP+LpuJTHO+I=
X-Gm-Gg: AR+sD11X4DaMS9r46InvDcmQdq/8HmDsfCn1uPMoLtYt68S3XvCF6fj4QN3C8UZxQne
	SefS7wtxM7/Fs1z4lriD8o10NVeU64YHoxE3E2F6wNfyZmSavpBGlfwpY9I3VrwwYFxIEc8SFTA
	47zf8MLffxuQuOgtxvoIk6oZjk3sEKw37VGWu0buWuHWUEC4mdOJ/cB7eWfWMqwD6UEI7CAR03m
	mm1lp8n1M2wicxY153Ufy/1Hot+tydE1PdjWH+OheW6bjkCM3xExALev0821xl9sZhkOHKwklDd
	OBCoOG8dQqMo3XFFQbHuVa42sTO3we2lkhnQ7wDpYHAoHzhz81Zs7GRJ5TL7AR2tJ1vY6H6ZACh
	2gc0I3ZHuk4x9L5v/SuSvnK81IuY1F5oc
X-Received: by 2002:a05:6a20:729d:b0:3c3:cb39:669a with SMTP id
 adf61e73a8af0-3c92ab70422mr2622120637.73.1785568050971; Sat, 01 Aug 2026
 00:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 1 Aug 2026 09:07:19 +0200
X-Gm-Features: AUfX_mw5cdUZLQWNkJsoJsVTxX9h8I0i6hirgcuZJUvV_SKjFv0iyYY74bMLTkM
Message-ID: <CAP8UFD2QgMt1=wMDj-zxTwSwMo+8Ft2-trj7fq-aBkWpjm0=Ow@mail.gmail.com>
Subject: Draft of Git Rev News edition 137
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Bruno Brito <bruno@git-tower.com>, Patrick Steinhardt <ps@pks.im>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-137.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/853

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition early on Monday
August 3rd, 2026.

Thanks,
Christian.
