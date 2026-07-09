Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4638C3E3DB8
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582429; cv=pass; b=aQzAMsgvvhb7PT065yqZ3e/u20guINPpmicYXqtxfD/PVIHgor0yj+QFznlsLs42oAVa/20Pg6w69iCg6sk/y0zveyx7i1GJm6R/bffnAugv13oF2aLYxIHaKHjzwX3WAYFiZOAsUfggPR1ZKzkXJ6rHcLOqJq7boOYneB1bTaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582429; c=relaxed/simple;
	bh=kGYrs+TAy3Oet+o5qzb1ogagw2OALmL6+PYIAGktTBw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rYw9G28d434XlenBTmwpib9Msf+FPzhdR0yuzlfgErFkapHjRIjB/2rIxpVNo/1i3ix0pQTDD0o5GV9BmJZ62ptSYSYco5k+PQv+XBhHbH2bVI+xDCKJoTRsw8yUIXYereoIDLtks/PN+4hvgfNcGj375vfWIolQGJwM8ZXHsaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xy9/CXvE; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy9/CXvE"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b013aa02b2so1019375e87.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 00:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783582426; cv=none;
        d=google.com; s=arc-20260327;
        b=DvRnFnU3I3ME1JUhFCTHzJjxHDDR4jCF9G53CH2gVMc17Z0kdHIgp4D/fKOGK0xdHV
         +FIC6jAptiNzxPgdf/SwyfmE1uCn18yK6DvjLaPQPmZQleZ/Ul3o6IheGZJk5/w40UQ9
         xLAphLe9boBg5jVGHxUuAINwbdvw9/T0uOkMC/1nCL2KYhT9GM47Wl1UkxlHPcviuV2M
         6PAuZxfonRE+eB4jvMq3EWmfx4FTK6rllzaJqOWpqQCxM1kcmsDEGsVsqZhjmrCG1XpG
         0Zk3hvtSxQ0RuClCC2xkcscjqOgDdyaW+W4cNRSnyIAO7x+INUrDrcKMWngAFrWFHU20
         Trpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=kGYrs+TAy3Oet+o5qzb1ogagw2OALmL6+PYIAGktTBw=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=HVNAxdeNVbZqAiuRfYQ7aCFxQS3RcQg4JMoVkuXs8jUFud+cav2yx4DmLJzlGSVDY6
         lY1BjKFxx83fIcdm9V1McDtR+2Li+yKFIsxIQK6SXupBvL/EKDZhFicBP/a44VvtlRAT
         Jrwy8sBtCedA+1ddUmvFcFL+AuKA2TDx32UusXgmZ5cdI601ULAXDk+PxY1M5dc88KE+
         duTRNWxljFetDRvKu++9MpX4AwAamwjRfxGpJfLXWFeDKaPAlJpKJJgObLKTcofpQruA
         3KaHHrL4tlyPdm5BZlnnGd9T+CcpWGzOGoqe4ZKk0gkNPY7I0EFM9NASl5Zv4bDCZbth
         vQaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783582426; x=1784187226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kGYrs+TAy3Oet+o5qzb1ogagw2OALmL6+PYIAGktTBw=;
        b=Xy9/CXvEpa3YKJRnm/QZiGW+OIZChMhhM+qlwNFhLReO9eoV4n9KVUsjYzDdV39/9V
         3Kg2x2wMIk+MpEZuFj6hRNPG9pOnHAKGzmEdLRdrF7moFNv4snoYHwzXJJf2tznir8jb
         clRhVVZYs4na/Obf0BCUYGcUndAC188P3uC6C9z/qAI86AF6IOm8Jtra6gxtSQ4BAcBl
         YkTRTfz074VGF0FF+avvPPI5Kq02hU18cPO/LeAWYfpMQ8VFXAeA8TwouhotoHMC6PXK
         xyqqALZtQPdRY9XTFk5BG/FUzuUy0hOjQ1uKJdpQCgATmQniOStL0nNKvBpGeeKGNo//
         K/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783582426; x=1784187226;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kGYrs+TAy3Oet+o5qzb1ogagw2OALmL6+PYIAGktTBw=;
        b=Oml8vJdJe85q7kE9uqv03+ExFBw2xFLImiRgXdilnXLWRUZLo5wPJIW82DRELwBWcy
         HmVwNSepKel2uGQ2wUi59NY0sq2N9+kraQxqLXv/ZHZ/lDA8+bCiu5jSdQ6W7z6yRiyG
         v9obG5TTNOJbUnDG3UFHAcIyLcF+ERswe1gXVFZvDGTz2GvifM4rAhy2RHio9Mw2uB0x
         47bc+THX2sA7NnJHBLZchQ/gZ2sm3adTfTvgWFcRFjbFO2u+228CW6mrGmqRqOqVg44e
         MNEm1rcmvhF/GMx1eARJ9YaTyMjoYyeN8Bs0ZWen76jI5Qt6/Shh+NgKHi4JvaUld8RG
         SXog==
X-Gm-Message-State: AOJu0Yxt+4n7ESATflKBLerwFPU1Owgcd1wrxCptBc8AHV8RwIetMTeV
	7yVCaCW+qofLgkAEafeGc2ZafG6f4hZEp+gI3x0uH762D0/79LmaWyqm1ELnQOunaZsRWj0C0Gf
	tv8jYjoNtc3DRE4RsLrouDjXTXgTntY7ObFq+2s67aw==
X-Gm-Gg: AfdE7clDkyDCVWi3qKMzA17uleZJh0EGbznsCey52LFBVQ0HUdSDn5b4T6K9nOs0Gf/
	AtYeDAkRGb82rMK4Ql2SpG7XYB1nv6SdcaB3siGlaj7NhMdG18MP4tAZsnuIqz+5/J04za5+UNY
	EQV+MFq9x+SLIaMN0zTsSmzv5s7CbD5H4Fc/NuSuSsL5x1xymVDEoUbT5VxOnjZE1129XoiEK50
	iufPb9GTnpG0nNHLSsEzkL3k/zjbff1EvqT6MJ+YlcGDzLnNDXafGdsSv9ue1Z/ExxX/A==
X-Received: by 2002:a05:6512:689:b0:5ae:bb1d:ce35 with SMTP id
 2adb3069b0e04-5b016d182f9mr344822e87.3.1783582426291; Thu, 09 Jul 2026
 00:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondra Medek <xmedeko@gmail.com>
Date: Thu, 9 Jul 2026 09:33:33 +0200
X-Gm-Features: AUfX_mwP7Xy0hZHX3EKwF9JD72v_3onRFcKZ9jzCU8j8L1XStPXmxuWNzs1H8es
Message-ID: <CAJsoDaFJLk5d7awSR1t6C7+F6d_1gv+qQCQHKzb_YA6dZzXfQA@mail.gmail.com>
Subject: git fetch automatic tag fetching - confusing when on or off
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
In git fetch documentation https://git-scm.com/docs/git-fetch is:

> By default, any tag that points into the histories being fetched is also =
fetched; the effect is to fetch tags that point at branches that you are in=
terested in. This default behavior can be changed by using the --tags or --=
no-tags options or by configuring remote.<name>.tagOpt.

However, sometimes this automatic tag fetching works and sometimes not
and it's mentioned in docs when and why. See the following examples.
(I have no any git config setting regarding tag fetching set).

All these commands DO NOT automatically fetch tags:

git fetch origin master
git fetch origin master:
git fetch origin refs/heads/master
git fetch origin refs/heads/master:

While specifying :dst part of refspec DOES automatic tags fetching:

git fetch origin refs/heads/master:refs/remotes/origin/master

What is even more confusing (or maybe a bug), adding a nonexistent
refs prefix (i.e. with no real refs in local or remote repository)
DOES tags fetching even for "master" branch:

git fetch origin master refs/none/*:refs/none/*

So, it seems to me any refspec with :dst part triggers automatic tag
fetching for all refspecs? Please, document (or fix) this behaviour.

Note: I've prepared tests with
git tag tagTest master
git push --tags origin
And deleted local tag before each test
git tag -d tagTest

Thanks and best regards
Ond=C5=99ej Medek
