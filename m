Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8AC17E9
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713660776; cv=none; b=cz4xf2EsbyFwSu3DYHDvyxr54tUxHRjMJ9Q8fiNy/d1IiMTLnr2Bd8ffhd3xKgsZzn0DB7WqY2dHXlMBfIy95RVwji1CcdVxp0DDm/bAaCb6tyo6RUma6SRLtqL/GfhUXCnVI3dkOEKwmNXks2srVzN/kr8n7ImNN5hqDdFDlm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713660776; c=relaxed/simple;
	bh=2Xwwtr0KoSDpw2JPkh5127yN510m4iGimK+Ur+xWUIE=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=REFVnBzkYSQuVPAm97J55UDvJQns63OXnetis6mheTJukHof4Jy2GDaTBCTJtC9FgDeejvrsMMfW3/FIZPAcSbeaGFYMWDQNuRyGr/IwTs+nIfsGDROTr3QFo8akUWD3Holywpe2IKWSSYpkPoNf4tWwhuc8ZlUZh48pI5MtFis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=BGmmrL15; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="BGmmrL15"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso4963407a12.1
        for <git@vger.kernel.org>; Sat, 20 Apr 2024 17:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1713660772; x=1714265572; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NJLRLQFYGV3sRTADaeJ45tmiPwzwAE8rwFlVRLzeul4=;
        b=BGmmrL15Onl7KzCbxRnle+5dVMvi6bnFggdlC+Gj0KThbmrbiafbOMl6G4Essm1T41
         k9CO9SqRri72bKc61sk0kYJPfEwIR+EBG/SqwTPrOb1hXzraS+DsOdG5JPb4e2lWO1xk
         y8cnnLMZlKaEAbrspd3F5HXKqpNdI+bvj8FG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713660772; x=1714265572;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJLRLQFYGV3sRTADaeJ45tmiPwzwAE8rwFlVRLzeul4=;
        b=Oj4pfDZAIjcaEfWdHTUlWBDs0kigvVsiW8Ws2T4fgUWitWTfHmnMo0XTGCV3MYX2K5
         GUZmlREIFvzeEceMxR8GbB9FCJ1DpxwwNjs18F5n6BLFBZ4jpHrWQCum4hivohrHxY7O
         y9ENQu70OIl07bTRYl3tGKbejrMScyep7lOY0rrOavJ0TsDjNc+ONb3CHeLg3rz0ZYlC
         RNTwW1BMoJWQFAZnQ8ghpv/LnyrIjV/6EFreFeaUYvLT75KLZrepl2HIbjKx99d3t9Ty
         dIAYlPEVS45r3Hk72OcA2PG2MjLvvXl7C0eCMhw4iVZoPH1f0zN9hj+x/6Nd8dO+LdfT
         PRfg==
X-Gm-Message-State: AOJu0YwTI5MMM7yVhHOBsIm8r1CLk8HdZsXsbnYu7FivGz8TOY20so3V
	PS8UBShatoPyJMKeYDTfJhNFtcNKYteXfr8Ng5quuJjS+d2ckMYpH9ZBGVt0nd86iE5/cjg9nDF
	D
X-Google-Smtp-Source: AGHT+IFYiqE9YSkGhDK9k2te9ZmkFUC+tKlzLuLHR02UeCG0UwoGM0PC25C3fe0W9x7bne723vSy3A==
X-Received: by 2002:a50:8718:0:b0:568:9d96:b2d1 with SMTP id i24-20020a508718000000b005689d96b2d1mr4229106edb.32.1713660771420;
        Sat, 20 Apr 2024 17:52:51 -0700 (PDT)
Received: from able.exile.i.intelfx.name ([109.172.181.47])
        by smtp.gmail.com with ESMTPSA id h25-20020a0564020e9900b0056bc0c44f02sm3822154eda.96.2024.04.20.17.52.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 17:52:50 -0700 (PDT)
Message-ID: <65f32df3f49341bf192b606914d44cc937f7971a.camel@intelfx.name>
Subject: Building with PGO: concurrency and test data
From: intelfx@intelfx.name
To: git@vger.kernel.org
Date: Sun, 21 Apr 2024 02:52:48 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

I'm trying to build Git with PGO (for a private distribution) and I
have two questions about the specifics of the profiling process.


1. The INSTALL doc says that the profiling pass has to run the test
suite using a single CPU, and the Makefile `profile` target also
encodes this rule:

> As a caveat: a profile-optimized build takes a *lot* longer since the
> git tree must be built twice, and in order for the profiling
> measurements to work properly, ccache must be disabled and the test
> suite has to be run using only a single CPU. <...>
( https://github.com/git/git/blob/master/INSTALL#L54-L59 )

> profile:: profile-clean
> 	$(MAKE) PROFILE=3DGEN all
> 	$(MAKE) PROFILE=3DGEN -j1 test
> 	@if test -n "$$GIT_PERF_REPO" || test -d .git; then \
> 		$(MAKE) PROFILE=3DGEN -j1 perf; \
( https://github.com/git/git/blob/master/Makefile#L2350-L2352 )

However, some cursory searching tells me that gcc is equipped to handle
concurrent runs of an instrumented program:

> > It is unclear to me if one can safely run multiple processes
concurrently.
> > is there any risk of corruption or overwriting of the various
"gcda=E2=80=9D files if different processes attempt to write on them?
>
> The gcda files are accessed by proper locks, so you should be sa[f]e.
( https://gcc-help.gcc.gnu.narkive.com/0NItmccw/is-it-safe-to-generate-prof=
iles-from-multiple-concurrent-processes#post1 )

As far as I understand, the profiling data collected does not include
timing information or any performance counters. What am I missing? Why
is it not possible to run the test suite with parallelism on the
profiling pass?


2. The performance test suite (t/perf/) uses up to two git repositories
("normal" and "large") as test data to run git commands against. Does
the internal organization of these repositories matter? I.e., does it
matter if those are "real-world-used" repositories with overlapping
packs, cruft, loose objects, many refs etc., or can I simply use fresh
clones of git.git and linux.git without loss of profile quality?

Thanks,

--=20
Ivan Shapovalov / intelfx /
