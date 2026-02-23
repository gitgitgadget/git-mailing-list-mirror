Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60C378D86
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882922; cv=none; b=BkTCaILON+R8dcELEaaFUB6Hh/74LhlE5RxNWIdeGLvqjKleUI+T6dPeTVMuOI18TZcibrgi96wLyrMYKLC3EzH5dknXDeewKV2w+4TRAbc8hiSxHmagLhpmnKoliUSLjFpg0eIyX1qGPhKJaxltUoR1vtcKSFoK6hzZ6+ALdxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882922; c=relaxed/simple;
	bh=XZkGfXHZCzuy6mvFSBrf+om0WcDPJN2kqjuC8Rs8i80=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=XDwGAMGnwcRLJTBXO66CJ9e4Z4e/0A/+vCk2ufPXS3+1St+FvFNkm5PkvJgRHNczmBuI8ebFgxNt+P9wXOoSVhXlMg3TuzuCtZc4RGlag87eJCUqsyK0sRAhnzLaHlxf+y/mTf62LaDPInDLgmtTFPDncx8Ne2A6SkvlZSXJYk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2MvtE5R; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2MvtE5R"
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-64ad79df972so4682688d50.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 13:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771882920; x=1772487720; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K26y1Fs94D1DQPbXRGVqpazB0LMjeYGBztS63z7/1TI=;
        b=c2MvtE5RnVTL/JzvOXHEkZtetLAGt+ncgVOaSwzfoUT2YEpDVcnLvKOaX5PjcU6g66
         kbgVFv67WAFKziA6/dAoHk6+kNex3qaK3VqOGP89bNBwSKlfPPxn/4HXWARuu8oDjUkm
         7AYMeqLAXlRKwHIIU9OjMrXalOxmsM0ctl7ubuVl4z7V+mYyCpq/lNw+X0ecrRe2i/k8
         bjiB9bkREkLemqDoMoJPcSRv8xT2CY4b/07F4NQj5OU/1Yl4PRvyGij9jrWlVmcwy70T
         03X1RbuWK7LMLgAJWbMotbW5P3uTKQJGmsDSI5o74OhO9i0AK3BQukCQngsLvs0jhbZE
         FoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771882920; x=1772487720;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K26y1Fs94D1DQPbXRGVqpazB0LMjeYGBztS63z7/1TI=;
        b=jYzSLUIdtQhk3wsh2f4k90jVB9ngjm6svwrsKhGxvNGNFzzcyCVaPy0u52PNcVrQa5
         Kw9DlSB/IqgmmE4Xmehzy53vKtG8vD4MNxQhWdQVW8pYXeyCwtwLZg7sVhCpMz3GBQhw
         jMIhSZTw5dqXozQU2xfqv33dtR+xPrWOnxUEnpQj1fPLLpHyX7TZmtKoZV8o/U/RHSj0
         q/QlW67z3UMFo8xuMbH124NDdbWEPhOuPxJdQDVGcRk+QTb/vyZsD+V30xJSLfZDm1CE
         gSSoj4gsnv0QEAE+DkNuRSg6X8hDwb6WwY5A4lyerbBksxw54B4gQqSaj0qptM6Tg5Eq
         0YtA==
X-Forwarded-Encrypted: i=1; AJvYcCUB17TcmpI/W3fbgw2TFDzriOKM6FATG6nHzoYkLRq/N9E0+FhINIlNlJ8yeZaaHJxlbQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt912xRA3sEKwDaMn1tR5rnFDOsJyRwCtDuh0z88PSn9OBflTO
	FrH3TfsW/VYrqBDHIAA3QSMrWLAFvhFh/qS81Ilm17eNq2SoWJoRlC+1
X-Gm-Gg: ATEYQzyP25oiriyOzrQxONT8ai/RZiNa6JNWa/63Zs+df2C8HCS1cP4HzqVxGg/7s0o
	yAh2AtYorSXpqHvtPWBNUrqSCjPxi4wgzfTyq9lBEcPGAmmiCqFnRSn08KUTE2VS5OiLjHiYORG
	ir8umMd9bs8C5wnv0zgxQ9sWI2XrhSH/N2n5u71ccKchA9MAc1rxlUTua+XWLg3UpuEMp66xTj6
	vKW4CEhPq76yaqjZv6yG5QywxPUUb7ZivbCWfrlnEkHKSoEoSU9tLSzOpoasWQgx8LFfyJNq0Fj
	KYDtVMbYv0oSg8LwNF0tj6FONYZAzFm5UPP/v8eNRV4AElIs+26K1voMeyJsQf0FwT32UYVpOgg
	+iNUFjxbrMfNKlrzuPqN+x7wPTclfV7piGrtSX5yWHxaRlXodJMwWDSzgN4vJ7mhIae+ovrV6PY
	lLK0z36pbr0YZ4OzZllzLZXbrlvnyhWQBDoijUCh4AGrB6PRQARGvkcA2u8GizAklTB7Se1poJu
	4glPaf0I3uUjzN/LSMjWb2bBqH9jWyMNAbbwzkj
X-Received: by 2002:a53:ca52:0:b0:64c:2114:1766 with SMTP id 956f58d0204a3-64c78e373d7mr6290687d50.45.1771882919837;
        Mon, 23 Feb 2026 13:41:59 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90eb:5600:c890:ad73:1b25:1a30])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c7a39ce5esm3711104d50.23.2026.02.23.13.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 13:41:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6] build: regenerate config-list.h when Documentation changes
Date: Mon, 23 Feb 2026 16:41:48 -0500
Message-Id: <8AB2DD1B-FAFA-4510-82FA-BBD76B442676@gmail.com>
References: <aZv54vN9DdGsvre/@szeder.dev>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>,
 Marc Branchaud <marcnarc@xiplink.com>, Evan Martin <evan.martin@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>
In-Reply-To: <aZv54vN9DdGsvre/@szeder.dev>
To: =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 23 f=C3=A9vr. 2026 =C3=A0 01:55, SZEDER G=C3=A1bor <szeder.dev@gmail.co=
m> a =C3=A9crit :
>=20
> =EF=BB=BFOn Sat, Feb 21, 2026 at 09:07:17AM -0500, D. Ben Knoble wrote:
>> The Meson-based build doesn't know when to rebuild config-list.h, so the
>> header is sometimes stale.
>>=20
>> For example, an old build directory might have config-list.h from before
>> 4173df5187 (submodule: introduce extensions.submodulePathConfig,
>> 2026-01-12), which added submodule.<name>.gitdir to the list. Without
>> it, t9902-completion.sh fails. Regenerating the config-list.h artifact
>> from sources fixes the artifact and the test.
>>=20
>> Since Meson does not have (or want) builtin support for globbing like
>> Make, teach generate-configlist.sh to also generate a list of
>> Documentation files its output depends on, and incorporate that into the
>> Meson build.
>>=20
>> We assume that if a user adds a new file under
>> Documentation/config then they will also edit one of the existing files
>> to include that new file, and that will trigger a rebuild. Also mark the
>> generator script as a dependency.
>>=20
>> While we're at it, teach the Makefile to use the same "the script knows
>> it's dependencies" logic.
>>=20
>> For Meson, combining the following commands helps debug dependencies:
>>=20
>>    ninja -C <builddir> -t deps config-list.h
>>    ninja -C <builddir> -t browse config-list.h
>>=20
>> The former lists all the dependencies discovered from our output ".d"
>> file (the config documentation) and the latter shows the dependency on
>> the script itself, among other useful edges in the dependency graph.
>>=20
>> Helped-by: Patrick Steinhardt <ps@pks.im>
>> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
>> ---
>>=20
>> Notes (benknoble/commits):
>>    Changes from v5 (<611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.=
git.ben.knoble+github@gmail.com>):
>>=20
>>    =E2=80=A2 Reword a confusing sentence in the commit message
>>=20
>> Makefile               |  5 +++--
>> generate-configlist.sh | 11 ++++++++++-
>> meson.build            |  5 ++++-
>> 3 files changed, 17 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/Makefile b/Makefile
>> index 7f37ad8f58..6f926ffb1f 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2688,9 +2688,10 @@ $(BUILT_INS): git$X
>>    cp $< $@
>>=20
>> config-list.h: generate-configlist.sh
>> +    @mkdir -p .depend
>> +    $(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@ .depend/conf=
ig-list.h.d
>>=20
>> -config-list.h: Documentation/*config.adoc Documentation/config/*.adoc
>> -    $(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@
>> +-include .depend/config-list.h.d
>=20
> This breaks the build when something disappears from
> Documentation/config/:
>=20
>  $ git checkout origin/seen
>  HEAD is now at 57edfa3ce8 Merge branch 'ty/setup-error-tightening' into s=
een
>  $ ls -l Documentation/config/hook.adoc
>  -rw-rw-r-- 1 szeder szeder 3828 Feb 23 07:50 Documentation/config/hook.ad=
oc
>  $ git grep hook.adoc
>  Documentation/git-hook.adoc:include::config/hook.adoc[]
>  Documentation/howto/meson.build:  'rebuild-from-update-hook.adoc',
>  Documentation/meson.build:  'git-hook.adoc' : 1,
>  $ make V=3D1 config-list.h
>  /bin/sh ./generate-configlist.sh . config-list.h .depend/config-list.h.d
>  $ git checkout 0aabf70f60
>  Previous HEAD position was 57edfa3ce8 Merge branch 'ty/setup-error-tighte=
ning' into seen
>  HEAD is now at 0aabf70f60 build: regenerate config-list.h when Documentat=
ion changes
>  $ ls -l Documentation/config/hook.adoc
>  ls: cannot access 'Documentation/config/hook.adoc': No such file or direc=
tory
>  $ git grep hook.adoc
>  Documentation/howto/meson.build:  'rebuild-from-update-hook.adoc',
>  Documentation/meson.build:  'git-hook.adoc' : 1,
>  $ make V=3D1 config-list.h
>  GIT_VERSION=3D2.53.0.119.g0aabf70f60
>  make: *** No rule to make target 'Documentation/config/hook.adoc', needed=
 by 'config-list.h'.  Stop.
>  $ grep hook.adoc .depend/config-list.h.d
>  config-list.h: ./Documentation/config/hook.adoc

Indeed. This might arise while bisecting, which was my original motivation. T=
houghts on a path forward? At least this issue (to me) is clearer than a spu=
rious test failure :)=
