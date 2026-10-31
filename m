Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793415417;
	b=KzouU1qIxx2OzfGxIVMSgu1MRY2HeSDwabRvF0uoTGNxzA4rpJZimgwdvmb2VYXzgmX3
	 Te+kjRvv8RQyefFqwWixEHc4jo9nQY+xf/omdYQjWBRKM9rl67/v+pTHxYSosMdu5H7wu
	 DxlrLw1d/e0hVrnyh7UwliPzJUql6ld8FXyGNs6ohGuAekk1HdKrhdHdvKM0PSiyDSYq5
	 Zx8j6/fw+djfe6G2lLma1bMPfHuAKgB4eS+usNCpO4LP2JrZcoXBxirt3a2+rHxBUn1vE
	 yrabB6tZiGxt9Vs1kNkd7pkfmD9CJLysOz8VFkEGSpVwNHhiOA5G/k/AURopDqnDQtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793415417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=HfCIwk0CWuZ41anscP39i6vwLx1nsXGcjlWYE3baMtA=;
	b=DMqtpTyVY8uG4ud5eCwPAkqjGyphjAmVyR2ETy+tqcAEv21IfLr1z0Vu6OyRgCKrELDq
	 pm1zm3FpPP3HOhVb92Y7edQcd8hSOpwnjCLdGLLNVia59JCFHdvNei/k0eEC3QCk1BX42
	 KxzMa0APk0ArHhjtODgnlrEwkHkqWlfIWHnkp5WIR/py0A34c+tp8SzP+/LxjOG4VcNSP
	 Rvs26iMBxWI1LSB6Tx75JMqxTUBEWxPBPEEqTMH84AjZZAlWxLCaoxgxESI1Xl2UEaHKp
	 rB44Fd3Sf1IR5tnoZOvGAYN1BjCImvWnn92s5TdXNd7t9rKC6qMyQruZ5AOddj6Jkww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MfLtOdiY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCC7606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 02:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CCC7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MfLtOdiY
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3ab3dd9681fso12226921fa.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 19:56:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793415415; cv=none;
        d=google.com; s=arc-20260327;
        b=OoXgdHBkQiyV5nNgiI1Edk4axTd0QPXWbi3xAITxI34Y+Rr7IY2wsLRC4VdhndGpbl
         ZpGAtVXDt0aSHXXyWs9V4E31RfhX88pKsvmDdHLUBpRA5ku7ZyN8PbRf6jZxXM6fcE44
         1QeZd4vk1rZgSUBrVgYqmtmyTZ0jiBj3BLBmN5F13PAJ1N9lRH0yZKRkdgXv1vjdYraT
         y1Y5qM8r/vt1gDFFhDsq5mBjPIZhImHXMXGQa6TW24XEVh5oOU1FyIm+2Yj5I3LlQX/e
         QapDMiNU3K/D7Wi/U0SCMprtw9/Z6qSisOD9PVGUlItlEHA30NGekCErKoYLBhLjzkkZ
         PxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=HfCIwk0CWuZ41anscP39i6vwLx1nsXGcjlWYE3baMtA=;
        fh=ekSb6daRsFcvNYmhtYHUsasQWPOViUPSAHNEpewI2BA=;
        b=Iqihct8v+niPJZrtuZIhyWt5rbZ1F/XU7SYkRRZ3L0FB38ryVSQdzNq9vcnG0UYaxD
         c1KwmNtwgGBnganJ9syiJsAWOiS92pGMIOvpYb/Fv6ER0ITH7GOLJ0S3CFZIvF09IKpI
         y1a7KNTS3+rYvgXF4DNFaes9IzyocuPIDjQCVCn7RjHaezUWezGwCIOyrH2zq7Da8LZJ
         CPcklTo2C10Y6BihtJ1+HZwjoFl8VKRsRK4StXccVvlzUXZYCSOKXmQfxkpTHWq01T48
         XDocvOcZYukmqC+alWvuk8f0Bsq4K48GJY8DfekYBiU982qHZMYlMLOUUVL4Sv2maatG
         3+yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793415415; x=1794020215; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HfCIwk0CWuZ41anscP39i6vwLx1nsXGcjlWYE3baMtA=;
        b=MfLtOdiYeYkB9CvVVXY9m9/zdAUi9XbDTeF1PJ+PQV/0av46BUBKN5j4bybMXWtABe
         dzpHiFSPsEFDB8R5xeflCyymV8TXcOvXxC5EP49EYJlyW3zOePD6K7Ta+rXlEXfZHoMH
         RHDsiGJAoHSzrn4iqWqW42cq0sNjB4cKUAKb/4+TtRsIwe63ydAGndl4ZDOarxnhNZ+4
         SMUaumCWuKExRmnP3+hBD6gT2Hvi/XsDzTk9RMuRYLT0yyiIGzWbMJwtHq3qX4UZln45
         iSqh7SIsjjFWtazyJNCwtog1J3vUfUbk3yR25MhRyrzKVOR3Jv0Xl4biNkbu7h4c5fbk
         lD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793415415; x=1794020215;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HfCIwk0CWuZ41anscP39i6vwLx1nsXGcjlWYE3baMtA=;
        b=yA3PcjiqNcar1/6rJyE2AUgYbAeuyMzDvNYgYzIlYlCO1ZG5eyx9lhWx9EBXkEHD2q
         1HfxtuL5sdqJB7LBI1jDmtzURO1AU6yMFZDlzi7IPaQEi24CdmKyB/K3Jhovex2G9Sly
         elc3nbWy68WJx0ftGFvXQOB8g9JM1Vlv8MQ4DBFShQftdadpqbn6HYKfXlsLjEddHA8Z
         9d64+AQ3B/7fHDFXpomfkjplwVIc8Tw0CBcWpZuvFH+cVHVmOpofK4vTM3TnkieYXsjQ
         +Gqf8EXj/DzdeIdACDlR1oCXD2RnSw5i8wbT3uon9Pr4py2HmdGDmq5+wU01snHS39nq
         jyLg==
X-Gm-Message-State: AFq9FYLfnMrdb4gFreVuZIBVblCMiCRRagkQh+7R3HngvrqqDak6N5Xp
	mkwoG7+ugVp14tnyJ66RUCB78TGn5H/U0y7FOd3+hm9nAnDL1NgsQSLjGZjmCOStgmVK4k0iixd
	5om/1et4lXpBqCzFf4X2KaLRO1qV7C4RnTJ6/
X-Gm-Gg: AYBFou3TKtfgFlX4soK/vJAoYpO+DXcwIuu6I3Dv53/DlOZDD1Jq31WUzk4alkYTyIr
	278bSXkcLdNektt8sZYB6GHmQC/8l8kG3VS8tEu5ScUnZb3DNcK7B2xRcF4TA61nwXGuhS6Sl7i
	Q0E8nLkdkoY9c+rWvRpi63Z9u1q9wIDGlNfF+Nwz15HpAGj281UemjWcSPNxAvKUVLErRVzXYxM
	x8zeRIVUuYgzH0Mf1Gg/Alfy7rj6ZbZz165KgaA9uo6mOHHcxLtAm15IHJq/3QdoPv1DuO9te9e
	5KfqNWh9kw3J1/eXsObKP8+IXesiOqr3bekM4mVXYqHKGn6T9KDc+16ChVCNCJBKVtovkvG8QRD
	F/0u2MbtSScTbXaGzEuVVZm00QbjQP/UaF/PlTP4=
X-Received: by 2002:a05:651c:2122:b0:3a3:3170:5420 with SMTP id
 38308e7fff4ca-3acb7962d8fmr9517721fa.3.1793415415188; Fri, 30 Oct 2026
 19:56:55 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Chris Torek <chris.torek@gmail.com>
Date: Fri, 30 Oct 2026 19:56:44 -0700
X-Gm-Features: AclHuK-AUUaRYboyUon0Z1XFk_csubwgj5xkYGkmmtezZ7L586QiI8RuTyBKit4
Message-ID: <CAPx1Gvd3rAcgDf-rBPOuZFf2=Y+=JxJDdr6AJTvdtpL6Vsk43w@mail.gmail.com>
Subject: sharp edges in Git configuration files
To: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

(let's try this again and see if gmail html-izes AGAIN on me...)

This isn't any kind of serious bug, but I have been playing with Git
configuration files to determine a lot of precise details about
behavior when reading or changing them, both with "git config" and
with the implicit changes made by "git branch", "git remote", and
other internal operations.

Anyway, one edge case that causes problems occurs if a user manually
edits a ".git/config" file to add include directives. For instance,
it's possible to take one or more [remote] or [branch] sections out
into a separate file.  The following "ed" command will do this (not
very safely, don't do it on any repo you care about, just in case):

ed - .git/config <<'END'
/^\[remote /,$w .git/inc-remote
/^\[remote /,$d
a
[include]
        path = inc-remote
.
w
q
END

after which some "git remote" operations that try to update the
remotes just fail bizarrely.

(Note: gmail may have whacked white space above, I've set it to send
plain text but gmail is...what it is.)

The obvious thing with "doctor it hurts when I do this" is of course
"well don't do that", and nobody should be splitting their .git/config
into multiple included sub-config-files. But, in the spirit of robust
software (and perhaps just as leftover bits?), it might be wise to
make Git ignore include lines in config files that are intended to be
Git-managed directly, such as .git/config.

Chris
