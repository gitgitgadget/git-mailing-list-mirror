Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792556319;
	b=zmExaWglNNkBOYcabQr3LetVbH32ELth71Hj03OcqpNePCRH2+9Hf8XFnrCfX8xM/sj1
	 ucdZgoPuRkCf0MS5m4x55J9Vibrn8V/vnXM3VLoySKzbXUBSJckis1ENgkQ5Wo64o+QyN
	 S9jk4lIaTQ0kfxX4jYxVaNEQ4Yp7U5B2keiXka4GV8T7Br0yufrhH5Xl4YGPd3l3nzu5Y
	 gifcx9PDAxXfL4kn7S0z+fJMI/Wpwijk7oxU087ntvihFJJsC7Z/HCsLKwvva78KlbltG
	 IoJ9nB9Qxhh80aFnE5srK3PpBKeeATQVFZzIJ1qlTe066zhoJ1usAsWUN1cAmXst4/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=ypRCpJ7i2cc9ny8jkT4RL61NofFAj35po5vAgSE92BA=;
	b=RFsCAmkn7ERsZgzKKV4JAwlhPi3QWKzyBDLNt+4KGpwL+s2xFdd33Ag23Y7SMqa0MVLJ
	 94Lm5ou8HUtGNwoWU5Tvz2DSkwJotRgFwnv8ppF14GfdXLI9mwisA31HRTADac4VJoJU0
	 e2XXLdSeRtOtVHCzDvetbDly6oBHZbMEnRMB17Cv9TNNOTUBNTp1npb8ReyLPtIDxCTZS
	 9Fgd+iHRQllzKWotRT/8tpKAnusDl7kewlhBvhwmk3Dv1BGn+sFAjgEArK56fJLevyjGS
	 cGV05QUOz3WPa2vpvTSjdGJcqRvEVB6CamUqAr+7bwJ5Cx5MFhySeuh/v4PTy+885+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YmqLV0n0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB6606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 04:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13FB6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YmqLV0n0
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6aa8d04fcddso665870a12.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 21:18:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792556317; cv=none;
        d=google.com; s=arc-20260327;
        b=qqzSraF5H4bW7GHFgL5yPsTQw3nb2xHhk7hBwAp+oR8JSo3XogXA4mpE82dJghLegq
         ZFjqPHxjXAtmzFJ+1CBuU9EgNFvPMzoNUJyA4tbmEohW9SLGjl/cXS1eRuON7PfYAMtP
         N+r4wg/gvcr/29eIfJcGR1DhTX3nxUuOI2WCypW2FUpTqfB7dD80pagae62boLRQnYDS
         aSEjPCGDoQw6v9uSg64p+kMWs0PMbMIgg5WpPpqMeSWDrtDmIp0cAfuUSHuIYPSf/Kva
         rN6z0TccAZOysGKz1N5pP1s4kKX6BFhRP3rZr3lEQx4n5+akSBgXLP+j4W2dbK/5DH7X
         Vx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ypRCpJ7i2cc9ny8jkT4RL61NofFAj35po5vAgSE92BA=;
        fh=3c7kCPPMsY5iFdD5z6xAHpYJz++xBXV79sKzLXGfiLw=;
        b=CtBT26GVevL0O/cEyG76SO0HMgLyhVwyB3l+KEGc2YJtNwvCzBG/vjxo9NtuOOxP6G
         /dD+ICXQHIenxCHeCm/I8dKGfiu6eCZwWBtnc+OrG1PuZyX6SRa7jGEZb1k02bkhlzRp
         nGFT2s8nrfDf+vql25n2AvkpjKea3JNDRORYkqCnIpdeMdMyosGhzYMQcxCpciZOQkn0
         pt4PwLBcJfjb9544SR5xG108qiyN5bhnYBCT33KRmqyg15vUac2fuFkhiW6kCn3mtaC7
         xG3xYHdFxqL1AjfSiEvKtB2+m8ds/rLe5p3k9i3iDulLANj4xGPj5p88eC7Bjy+24HJU
         7nGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792556317; x=1793161117; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ypRCpJ7i2cc9ny8jkT4RL61NofFAj35po5vAgSE92BA=;
        b=YmqLV0n0jECrdXM1mMSRi8sEvhrLJESYjRbn1gYt9yyrgpGhjxa7Gh+iHNvq9HU82l
         tu0uJfTh0jEpl9qaYNISdeTdSmFanfX7a8dDTJQ6khb4P8lUvZqa2T6rGH0tOr6eZi76
         fL60l+iDxRezEuR/nLQY0RChGEbwbZzx+6EYAv+h3SLixIlO0lGLmVqMVduQtJ0KzXbL
         K4qzXvU6DsUOozm4mX3+zMXbMtrA453SDTwmcQisn2JbsJJ6AgZhwZb//FLA+Rx6TBkl
         OcIPFGWGo+30svc6YFuwaNEUiZxfEqbVR3w3+0ctFB2KmD6pR1Zlje9zqlgUBEKkRf97
         SbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792556317; x=1793161117;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ypRCpJ7i2cc9ny8jkT4RL61NofFAj35po5vAgSE92BA=;
        b=qx4uawfzyznrzq0loy4dT2R/c2XQmlB7yjS2oX3x8h57yk7Jg9LNr4kxKWd98KNZlq
         8H/GuG9bYldRk7uIFtydYO/vc4UIGGcju/rz/7X80wsFblgMfTSnk62RArdpboFJPqJ3
         vtCr5vkl9Ytz5VrMfdLvs6vk9VtEKqQFhjAJZ5XmxRUmft+Ha1PuWt3s9oWhFEVD7srL
         60bRFGnvWoEFY/gK3b2ZkqnR2VwKAnrwxwnPgIaTsPfocAMT51TQ3o+mGnN0stDyGQlR
         HtdTcayE1lU+Zgh5YRzFltdNsNBulsFLOqNjqaAAm0mAjgDJHqmAoJzxPgcnX21PCjs+
         BbfA==
X-Gm-Message-State: AFq9FYKiAUTcQzmoxLm4MQ/ZMiQvHNYGcL/eX7WhKJ+MfFISXcj8ZGLt
	o0ye0pa55n+Byl/DK0G93YqvXfxRaElGN4lWKmUTNXwTlnrjRNqjwX1khqS3KK2tZ+aaDMt8+X6
	qDONnTlEk4e5o5xsUsMljUrwDqwC+e4ERoqcIIIUY3A==
X-Gm-Gg: AYBFou1oaU1Qhj+drlvNWE1LIWs997tpHJ4I8l2DfLTPr0o0XJ2fzGifjU/0YtQYgg4
	0dYq1Xs9MkiRzkz4ucVL7mWNSCSwX9FFnVgDku31OuU/3qnEigdsOzkBOILBVPXuWrnAhSXI99S
	d9xnf1G9EmC7S8utw/Mo3F0H7CshoU1DrVykjIss3UiGTSVJ9LArm8RHxfV1qmyHrNxEoUBFPkR
	fn2+oZS7dHzoZD/G7mL2ubyrm3eIUmFCRkrOYBPHF9muDnkBSFI1O4dkGVPS50ElCQFwj9mnDnq
	a+S835lm80quJBkM9Ent4IfK/La2tANcXqZAchXqXPv5mKI/rlYZBRABjmyEQA7/bX8VxNOeA5n
	BTbEbbfzXNCijG0DhGKNJ89fa4MHitow+MDOTOhCU7bdE8A/tdEcfeMKNkYI76QBS0Hs=
X-Received: by 2002:a05:6402:4607:b0:6ac:7d58:dbed with SMTP id
 4fb4d7f45d1cf-6b408e86ac9mr359440a12.3.1792556317271; Tue, 20 Oct 2026
 21:18:37 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Muritala Mudi <ibnmuhyideen95@gmail.com>
Date: Wed, 21 Oct 2026 05:18:25 +0100
X-Gm-Features: AclHuK_1J8dvFqu27tT3FC-KpkPnsx2sWUvC5YK1Vhvz8ZoGwVUIRfGYluiM3oE
Message-ID: <CAO=0-S64w=n47n6yfYoKJie2aFi+T88Sp_qPmFe2RW0xWEwcdQ@mail.gmail.com>
Subject: [Outreachy] Microproject: use Q_() in builtin/checkout.c
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Usman, Christian and Siddharth,

Thank you Usman for the welcome. I took some time to look into the
microproject I want to work
on and one that got my interest is the Q_() pluralization
microproject. I will like to work on builtin/checkout.c.
I searched the list archive and I didn't see anyone working on this file yet.

I noticed two places that can get improved with Q_():

Line 1088, " ... and %d more.\n": this is at the end of the warning
Git shows when someone leaves
a detached HEAD and so commits might be left behind.
Git lists up to four commits and then shows this line for the rest.

Line 1492, "only one reference expected, %d given.": this appears when
more than one
reference is given before --, e.g. git checkout a b --.
In both cases the number is always 2 or more, so in English the plural
is always shown.
But for languages like Polish, which have different plural forms for
2-4 and for 5 and above,
it will be inconsistent to use the same form for all cases.

In po/pl.po, the first message currently has only one translation slot.
So using Q_() can let have proper translation.

I noticed that line 1405 in builtin/checkout.c has the same issue.
The same message also appears in builtin/worktree.c at lines 812 and 951.

So I have two questions:

1. Is it OK to convert these messages to Q_(), even though English
will always show the plural?
2. Should I also include line 1405 in the patch, which will mean
changing the same message in builtin/worktree.c
as well, or should I keep the patch just limited to the first two
messages for now

Regards,
Mudi
