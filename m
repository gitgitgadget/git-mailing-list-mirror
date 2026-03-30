Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D33B636C
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866703; cv=pass; b=ItDjzQLk47kymRYQPdREnOFCiJ1FXUhrCuryj/ee8EhA9+yUoq9NX5E7y7I3vG9kf6Rt94oF6dIlu/r7aWZHy8jdcQMG2Nu3ChPsVb/sEgz1gHMZJLrXqXa//BMOHVI19E+lV9I9n1L60Fhef43+nXP8gxEN0bUTKcNQduy0/4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866703; c=relaxed/simple;
	bh=cZxAiHE//8d8VhxN9F3C84tsqD/SqYiD0v6Uec2Oxto=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XGvgS58xGgaZI40211knrbDz47Ww3AghNi0m/arl4kEqlDAOrqxL/d6y63mPPiFQj5Tx77VEaUr3QpcBIvmmsyzXT9w8ZrK+JX0siSeWf1oy7B3cNnKrykFc5aaRlq/gTXGRPrwuc8syLlSRjOEUKuZn82qoF+PstXvL2L4+fzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez8yRvuJ; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez8yRvuJ"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12a74039dc6so3224863c88.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 03:31:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774866701; cv=none;
        d=google.com; s=arc-20240605;
        b=Jm6pMPCYeCfvREpnSW+U1Q8i/4ThOoOXS227dvAFvENC1s4FT14DSMIMZKWZ/CxYmH
         sReoM8t7lxLHtvPEL7wC0T1or7ip24E7Lb6lI7uUM1tiyqRlJbGMC9UClYHtWGEIHrqD
         bpSiLn5lK+TGCqI0wWiUcX0+qabAd/JYOWjiJbyS8DVvuEEBWG5j+5xRUl8fjriWtnh/
         SgndPNWo+x4csMsRN/F8SUcfk68MG0l1MECdBdEfrdAM8bCV4mJMc1dbPJLlAf4jgVzH
         yNll+cthCQhwdmG8q5VdAsUymB/xGBLKddyNtjeUoTcWiS+tDELpQPYM00crsPnd8OPL
         yHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ZNs31RD/zzC3LW/Jhfc48QCYbpyRdFDPVmynL5/LzGI=;
        fh=XsUYsrMPfdQl4sINpI3CvalfXe+D+KThJK+TqQVlqA8=;
        b=Igz5p9utqXYROjLVA3shM4gacNxKU1UhTIe68Ny8m0SoQjyCHsrCQkdEsZG8amrVLN
         4fwEKHWPk8hcH/UARHZnxxwEueGZLh3jHBIrzj+sFXXb9N2/wcf+C5nbEaL5gKi5jL48
         R6iVaWIoLcJmjKtFvY/T7J3q2lv8YNxRfKqDwvyJ4pLH6lv+UYX96CSXunREe/bdbSAU
         E9HlIlIeH6Pfa++eBQR7TaHABJqcGIO9UQTts0GcOssAVfILVq1Pu7uo/dCskTLsUL8w
         KNuWWk4hOAckG+93jf8DyRsP5mUWAw6K1qeWBoAvTgZLh0HBmBoYXOA1fUwB0MwAzCvx
         pVhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774866701; x=1775471501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZNs31RD/zzC3LW/Jhfc48QCYbpyRdFDPVmynL5/LzGI=;
        b=ez8yRvuJD8rQ7CSqjGItWOM+qkkxdCXagvWMm8k6OyXOW+LCpXJ5/dLdWaX9zdYv63
         TPyX3buUysTYUEdfrDTSxbpc4wopGbuCqPrxgxoR6i98q6405EvIhMtq4AeRcAJ+7EoF
         fNdbT3QdQPqy/3KiK6HmbJsSKo3l4MIyWojy1+XLJcD/YWzrNDZCV5+WxuweQJ+KzWaR
         s+83Fqi9pmve7pVpUEapE9i9mU9B5wKs5wOYBP4bjqZvYfCIn2LQOpMxKwth5x4fsUdy
         O+LhRBy8ehRjIFs50pcs8QYIvzZov1GXjUtZ8XeShvgE/G/UtkrXE/fWP9zVa5GPnL4U
         HlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774866701; x=1775471501;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNs31RD/zzC3LW/Jhfc48QCYbpyRdFDPVmynL5/LzGI=;
        b=MddZobWCMRAkm20FZ/10mjaEOhvLHkXrMPwPwrjT3oNfJWrSUXKgxZD90ND4O9Jstj
         HGVBYvrMYnQIj50c+mXZTJtAXJycun74I/QLuOSD0CErtjiL98Z4PGurrdrxjBzlDLT/
         VMcM5c/pAmvtIoQ0oqioRHfbXhP0nbHkL/CYYi4JP95ywVfRN3c6cmMfOFSryJIidA/+
         m5F3acWkdnIrnS+AnW+R0doYK1W47gbj5ip0Wmuezgq85uUDe+8c0SdOXtKyBcqdNKJ0
         qKfuFFEngwqSjwmbS4QEnKIEcqFlEnpW+V9v0PYMQ2LhT9tQ0IYV5fP0IJ2BlePJiOgk
         b+/w==
X-Gm-Message-State: AOJu0YyEPwgVeTL2tNESNi0/i99Gu+BDN+eu2Jaer0dIAikOI1BArl/u
	Xo9Bw61GZKZ5/3USgDcZSNb84H0COeF10l0oEYaGIrNcQseS8LmPyi/ycs8PfZv7EWsmAPLAv/T
	FrYsivHi5zO0YAwTXYdtkk7RhEMuSRJ4a3pPr
X-Gm-Gg: ATEYQzxvx6nM0DLbZhhI20fRho0QnuYnwENrUaP+9T1/BrMHFfYyHRPScKmQjVixox8
	9LW+4ohCuozX1f/mJQ85OmVGoFrb0OoouqtBl4kl0fb5gZU//jrXOeq+IIoPxWkyxvn6wFX7GTT
	mR8yqHgW8QQckhHb+41AhLD5I6mSNKK3j2URpJzLUPDY67+JgGEytnH2b8tEb/r365vZuvi1eKg
	yd0GTezOA5vtbTSW+3F7vl1O6EuNjxKbpyT3nKDXxg87aTbx5z2SNvKx6y0z+wpcqavaAqJEYl3
	jmm/vlANwlydfX6uZ8HKHOU1M9GJh97ZPJr9kJ3eXun1PDTSeeoPfXtfC+4Gf7MEeJF5
X-Received: by 2002:a05:7022:6281:b0:128:ca83:5aa3 with SMTP id
 a92af1059eb24-12ab283bae1mr5645768c88.1.1774866700826; Mon, 30 Mar 2026
 03:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 30 Mar 2026 12:31:29 +0200
X-Gm-Features: AQROBzBQ5w0nW12HrHTSq4C01XRtEndw-LDlDBXnt1dZTUZQXbcBjRPqMKGdR0w
Message-ID: <CAP8UFD2HhBq3MPD30jb0XJw0hciTyB=BNjcH9s9hjBoocFqQjg@mail.gmail.com>
Subject: Draft of Git Rev News edition 133
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>, 
	Bello Olamide <belkid98@gmail.com>, Matthias Beyer <mail@beyermatthias.de>, 
	Jacob Keller <jacob.keller@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
	Jakob Haufe <sur5r@sur5r.net>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Christoph Anton Mitterer <calestyo@scientia.org>, Phillip Wood <phillip.wood123@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-133.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/833

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Wednesday
April 1st, 2026.

Thanks,
Christian.
