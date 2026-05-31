Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6B157A5A
	for <git@vger.kernel.org>; Sun, 31 May 2026 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780225278; cv=pass; b=WHL0lxoF59VGFcwX+yGNkYPn/3P2OMnIAPJuAN2MuX8IA/amR99sU/QVJdnyCoKfKyx1OEmpBr0eWnEi1b90EM7NUSomtNSrUwdK4HaX2E/TIjEtHP1gr4Iamlp7zm4zimAzhwD/gyqOSZuO3HMG68NGHDYwQzSXFhFLfvPQBco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780225278; c=relaxed/simple;
	bh=sO1r1P/in8H+htHOw/khxHDm1efS+Vj796hI5ZzoyCs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rJjEtkLAv/ip0PqJHce9pHkcK+QU3KpO6q3IHB1y4pNy4qbcNCtrjt2Q90sZ7D+sqtrdsVYCb+aDB2mUMW0ZzivS3FpCs8Dx2b443pOWR/jyRGWv685CBlmzThPDiaXimMR7VbPYwXb7rsMWm03ic6VT2K55KkaBfUbB6qEGYNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4+toSrQ; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4+toSrQ"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-13721dfd471so7978254c88.1
        for <git@vger.kernel.org>; Sun, 31 May 2026 04:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780225277; cv=none;
        d=google.com; s=arc-20240605;
        b=H1Uh3vG2vQHL+93lKv/yENnKnpYL0/vOnHZu04PcVFQwCObc9a0b0mKszhrY2KkI9i
         qXlW1gL0Uiir7tfszzhQEbWx6lCTs40tddmXqL/+pG0I4gr6VNBYnFAdxjxPsepCf3eM
         I+tr9r/V/qDzTycw8KWV27mf2Pk7RSE66ENS1AmKCJR03ANgfKV+5E2ReZkRu8M/HssV
         JkRLs87V6RsEmBkCTdlwBjWXS4pyttjn1+lsTEC5OEotILJf6z0vYeF16/9n7v8IIS34
         eAucHuwSdywnRC/IgxFmfbHreaa+b1ahHrVlzByJLiEBdgTAV+m+L2nSfmyS+2k1rUMy
         0Jmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IHSKaixxsXS3A0vij6FpUzOpqAY/UZa8lwqjilmt6c4=;
        fh=Z5fqQ1JTxD0RfUHq+ieuiOIxXWErYlQo8d5Olo/1o7I=;
        b=j2u+sJiS0ZdocZbEgzXNuYn7/t2g0oFq3z+Y4ZznsdWh86pt1ORtDjRDlrHId+iSPK
         5NSrEPE27qX5S5i7c7w8cSSiXgldI3qQdF1/72winOXTuuPikWdmv9ggt2Y2/Lnk/o4X
         Gfzl41M3NEbLFW269hiM64EuaNIymzSf/QB8LoBPzSIxvBZ8CkSnJgYeyXgmJfrQ+SG6
         8GDguAOOZlLjZGT9f7SjT6H4L/SN5I8SCIZmg271rjnTU1kvRBxCTdAYYL2CU2q+nQHH
         q8xOAbrQyScYy/caLc76hUbNuRTR3SDgF7h3rOOnWlKWyh1SJ/JwK8i4oprv/oNxJ2LH
         3liQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780225277; x=1780830077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IHSKaixxsXS3A0vij6FpUzOpqAY/UZa8lwqjilmt6c4=;
        b=R4+toSrQqxJxlMvo8+XO5xL3lCvsIq6eNJLw05JtYHUQjDETu/WKUkK6TljSpEQ62y
         hISdC5dVS2D2xZhYQ5cbs9BnqZqy9F3G1K6UB4VjLO0QXQWC+thub2wvNUrYOlkX7htD
         8XHQ228OZTsZqLOY5Ujy4YvmcNe75pORCt2fkUbGqXr2PMyFm3eIpxwDZygk5wxP10j5
         eNS/l+1R3gdH+m20th6mGWZzWg08ahnoaWLvPBXvw0fxAoENqMLP4aEB35p1ktdnkabk
         Obo9Fqtztmp8B6vKqQXu3ZwISajU71ZhTgvbu9xG1PZzbGhsGW7pfCDlzs17/P2zmFyS
         JlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780225277; x=1780830077;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHSKaixxsXS3A0vij6FpUzOpqAY/UZa8lwqjilmt6c4=;
        b=hkpbLBB08mxK2JHEve9wxF68ESGVDJ49aRjiHn6oWjrtG9CTznZemhqR2U5VUD8ZbA
         njepplPVxmnaaOVhb5aRQ8b3OLvVwIZ5bzx1J4r8WdhOFulOio33q0dmlPqB6qNCaC6q
         mJ8XL8Oksm+EGM5dClY99l/2kbA9lfGxY0sfzzAcSPhDoDVrmVRs8vltfTLRCJel3CM9
         8TJ0LK4czeAR/EYpb+VEUXoU31CtH01TmpLu51Msudwn/BmBIt/gNBo4WBMhi56EExP0
         yy2bpjLEWLDANCOZMjnQ0Se9mVVRp00aXa00AMBXd70ySBXDCtczXhMIqaXVkUaTuGDE
         E+/g==
X-Gm-Message-State: AOJu0YyAGrmIUJx9gVLeHSlJ+3vEzyDDSZUmakcGp+pK4meHCbpzC11W
	bYGyfFgzZ5tVWAlLad6kaYn0t4JgSzuQUwVZ/7+pEgfahlU1RSkv7WJukh8cyEeQIkjDEzRO8I7
	kvuQwhwhn+R9AnFNtgd7qLUuSvtjAp+0BUZps
X-Gm-Gg: Acq92OH77LERPHpyq0RproSfmG3IGn6fNiKX2eDEA6RqI1PO9VefGP/2IbOzte0umqF
	KvEDyJxQyP40O/JUfrXdszwD7G1SEg22bb99D+EQxtxsg/FW39l2wMHQyEC4AfiWQisa8JszNhN
	XHVJgC7j9IyKB3NCAtobnJksgMObCdZuROVBRoQO6PFA4rRnf5j+9fd4V4Z86uODb6VM6ImoomR
	B5bQt8/l5osZ1Y6KxiJDkcbw73+PXdAcxS/5oDVvbeZMl7k+kTRzuEYykZZ0tQto+csEQUPAsIC
	0paxO3SGJWfzKrbmnK+mOsCdwG1uxsWDQRQiF2aFEqAETxMyLBs+hh5+mHaMCrqrDZ9JM8vZxgv
	/ErI=
X-Received: by 2002:a05:7022:6299:b0:136:5ee8:5fae with SMTP id
 a92af1059eb24-137d3f0f117mr2542674c88.14.1780225276594; Sun, 31 May 2026
 04:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 31 May 2026 13:01:04 +0200
X-Gm-Features: AVHnY4LM9ewtnyNrGcyfQ8Xgnkr4kDn-V8UkiCSBDo0-IYEWMEECxIONB9qyTbY
Message-ID: <CAP8UFD1cUEWOWDHZ=6MZxncBCswMMhw6mWTsUzjj1e5huN0T_g@mail.gmail.com>
Subject: Draft of Git Rev News edition 135
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"Matthias A." <mha1993@live.de>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-135.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/844

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Tuesday
June 2nd, 2026.

Thanks,
Christian.
