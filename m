Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAD11CD2C
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 04:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784521893; cv=pass; b=ezDUCprtFBs0UMNEBGYXl0oh+JwaGyZ81bT9ChBBNJHa5z2/V0y6gFTKmrsZ2f/d+W3zZ8sRk/8LMSd8/mW5hw6IDq11IDBN6DvtfaCzZMTAYyFNjdcgg/1mOWzGDQAF/UDxCA9HDQ4Hi18rH0cKZeZwvhDTy77DWKSCZ135soU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784521893; c=relaxed/simple;
	bh=USstkdWF4ZRKCIhki+OIIyltGW91HetrW56moeu4QBU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jLD8fkgaSHP1eNpXVtwf8nhDLo9WKbNGpB/XN4LSMjc2PfXBkP94qWgX6lMbzH/X9cqoM1klW8yPRzVrZvOBTZ36lgTU60ZtH1fsyOJ21LcERa2zCjdVOFJDBRmdgSJ3H5x0wAEQf8cIlSjA0WbeZXTqCnOvtQYWD45reIns+0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIr0hohy; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIr0hohy"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-668432fe416so1039736d50.0
        for <git@vger.kernel.org>; Sun, 19 Jul 2026 21:31:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784521891; cv=none;
        d=google.com; s=arc-20260327;
        b=ckraoW4xwKYU5/Z9rW34oTjNgWKjmri9SmhPof2TqApzhsx5DlTXbzxllBSubX3DkG
         ECeGLhDBnUUHEgpcSyf3jsWQwvluf3Pg/bewaxS8Fu+Hg7Ypnn/vbsxrOfr+O1rgkbct
         czIO/witPlRnrTDPzvoOJr8Z+OlPFFHDNR0p/bPcIhzdpMS0RnnwhurFrJn2CV0Ln+6R
         CzoO9+MOBrXtOQlju/Y5oyHxgEdLhuQreJolY85bo0jLS3JQMCOgBWGWWcFoLYWmUC5k
         HU83Jrsv7QNNv7BsL3vzRTSitPrlSihKTwq7xjSHeBX0cw7q0p0EcNSKpfFFR8GqaeWU
         IRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=USstkdWF4ZRKCIhki+OIIyltGW91HetrW56moeu4QBU=;
        fh=QnVQ3wfWHPhiZMoMSXPWuRxIZpGYqet0mF2rlxd0t4Q=;
        b=jqNs10Ia6u5Ywc+5K/5MFMgkFAhXG0TcRqUn1+cqNxV3KtbgtgWRAVH/kJmT1QCpqW
         DQcBa1Vvy/8ByPSYHVR0aNr5n+PI0p34rBuh3/gax1LL4QQflbBMSsOdEwKCz7ArtciH
         JK7c3BXaDwkA99yCmVzIwfccYUC6dHyCwVep1dvJ66uot7YkMrI/RC+nPzRsC8trT9Vh
         85uMP9nCVKgvlbA62cC6Johfx9v3w2cYunUuTSFNl8CscyLL3D1diuEtIr4pw4uopy8G
         ULjlFUf+luoMkZAqRo2t9FUZ6ISSNSRjHx9AqMKdX0BpXbN1NLyadPBjC2rnNJLMzj1j
         LB+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784521891; x=1785126691; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=USstkdWF4ZRKCIhki+OIIyltGW91HetrW56moeu4QBU=;
        b=EIr0hohy+tDMqXrocxitwfwKkDPbdK39/evmcwHlXO3HvS37QDskzLGhfX6pWr1p03
         skDX9QuIKY8DqoImEyoFIZ9y54Da4Fo2fcR25s7JZ6V/kmlvq2VLTsD7TBREFc9KgPMI
         YAwvk1XLVRy430FMnMdHW8P1UuobH4k0L7YiobK/HcKSUVTebBlKJlJ5zEElOiu5jGdY
         TzTjzPhUcaCq8vDHLOGEqXTJNZJEL9mXnPhGEbzspN+z8+FWCwbhAsE8WIXNDWxAj5DF
         8BEJGi06tZogWXiHL0KmLur2lm5u4Gh0USchGpxYb9WeC/3iQmSp6aEqrUBOWkh27PJ3
         1tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784521891; x=1785126691;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=USstkdWF4ZRKCIhki+OIIyltGW91HetrW56moeu4QBU=;
        b=OhdxgmkjyIAYs5I3PdriGNkwara7cTwbmjc87v/Zd4xd44+EBcXjuXcm9cuFKCOgrJ
         Lw1YAwH4IU672s16G6mOO4+bLkeIH3RSadagUJXplQjXK7Pp3DGydc17M1ITZ3eB1amP
         71FlbnnJGV7ClWIYIY3+BD4JOIXxD2Il7gbelyUkveQuwDEp0BmRBzVrv1OANwi91p8l
         3DRJXKTFWvigcZrmsS5nXremTH34lQSYddLDYxuh9fTX7x/qqEokStWmDdXcdaI53Eus
         2CbeYyjwpWz7EY4/olOR3u9TQvphhbZrWtcUg3OfMwkQdjUIgvYu5pSgw4sv3z3ky8YZ
         PLDg==
X-Gm-Message-State: AOJu0Yxude5ZBmgiQ++eglDQevNLAsc2xKSXJqFf2NC9D8/YGRxeoJrq
	3/1A71NLhSkLkm78xh6Bq3IKifIZzwZYTzjaeZsppeyo6nrggLsTOWHw1f/IPgHd+EdWHvDZDaE
	66Jx98GGFCgB+Wx36pZM44kmbVGw3IlJGsAFm
X-Gm-Gg: AR+sD13OGS+iSTg1oQaTXHPCYbIyMYEqSiZtpCehov3K6kSBUfmK6aqjWUoJylyfzxR
	sF/MWvR0mLIyB09iLeLugmnz+tUJbKIrZbWc60wlWMf8VyngfkP0EEmnvf4Pm5RXmg9cUMofLoe
	pF23qYSbEE4xO/vOAi7SdGwKTcy5iiMRXd1TzsG/0ilTzJPA6sm5TpjHnR+S26vFcsUAvIfYitL
	/Rq8g0iRnvH7A+I+hP5324hJCRnCTHoaFb8jd6LuZjlbcZhnCw4ul0D0BbXnTolJXUB0E63mozN
	9URnUtmHVVMqx3xxWtcyftQO9Lc=
X-Received: by 2002:a05:690e:429c:20b0:664:ae67:b672 with SMTP id
 956f58d0204a3-6683bd7a996mr2786888d50.78.1784521891424; Sun, 19 Jul 2026
 21:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Packham <judge.packham@gmail.com>
Date: Mon, 20 Jul 2026 16:31:19 +1200
X-Gm-Features: AUfX_mzMEw6FVev6Pd9LDJjt7HCoSRDwPqv4W6mx4M8xykVBI_LYN6d9BeCslOI
Message-ID: <CAFOYHZBTAGiugQVOJrc4kJQkuhcSDiT1ruim7A1+6EW1iKAUNQ@mail.gmail.com>
Subject: import-zips
To: GIT <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I found myself in need of a git repository that was built up from zip
files supplied by a 3rd party. I knew about
contrib/fast-import/import-zips.py but saw that it hadn't had a lot of
attention in 13 or so years.

I spend a bit of (AI assisted) time on updating things to python3. The
result is https://github.com/cpackham/import-zips.

I started the repository with a filter-repo of the existing
contrib/fast-import/import-zips.py which does lead me to one question
- what license applies? In the absence of anything else I've taken the
COPYING file from git.git i.e. GPL-2.0

I wasn't sure if there would be any interest in taking the changes
back to git.git/contrib (or if the use of AI would rule that out).
Anyway it's there on my github page if anyone else needs it. If
someone wants me to turn the changes into a series for git.git I'm
happy to do that too.

Regards,
Chris
