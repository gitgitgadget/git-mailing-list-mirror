Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC8A3B52E2
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770382440; cv=pass; b=MYapTxC0egsdMzGJftzseTp40gx9n6J4dWEthnQ3LR1dtcYLNMOpGyaMhz7mVZEt7F48hDYgoapcO2dEiHXoRHXZ/9kc3iqhhzLnOMCsl+1juesQdBBB4P6Q/jfiEW7cu/vY7UfzmtW3OJcijNXStWpISVl4NlRWGQUD0xuSprE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770382440; c=relaxed/simple;
	bh=lIpNi6eRb5MBtT6P2Z86QS1DfCLnqi1vOcN0Ytx71Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpbjCcy/VyyDI5bgW+M8pDeUXPFB6fXr8F0rl619mjAepZx6fyRmp3hN2Rr8cCXjGpqlhvfxauFzJEji9gVkJIEuoPUNcNuRW/aNSZQwQmhGSwM30BChCcIQj7SivgzJ0TgJVVHwrPYrGc+mASXf/doyQznXr/KT8Tk0F8QZXuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com; spf=pass smtp.mailfrom=eficode.com; dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b=VYsWRjF7; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eficode.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b="VYsWRjF7"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso3968859a12.0
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 04:53:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770382438; cv=none;
        d=google.com; s=arc-20240605;
        b=L4apXBkp6yWFb822R8seHS3i3Q/BlDhY2IOa8Hk0Uuu4Pi9WszOrZQqT5FNZpKPhKn
         OPZT3/vIzWM9yIcNEm4cYaIh2VWrJ0Q1oyB3wzOoVUUMUT97TAY1vOH/d756RnHKE5ri
         epQFWpxfdfQVJK2CxaoKovjkPumUMaVEB4/EtCch2XXfHvFgVwW0Pn54DhY0OZq6NgZx
         sqiYB6Zg/b8RdYpca5tmya/k7uOIi3Qfihu2gDdWmyz1ZTe6K2lNW95ov5jOy7EQF28g
         3wCLBV58KzmsIS9OFXcKQiFrk9IpTEBlFBTH+aJVSmo50P561fYAbtlxfP1Or+pyOQBg
         hm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVs+pQ16chkMHlhRJ0Yqw+NPyNPUEpvSSt25AVRVSdI=;
        fh=lAnSMoZYTR1ITd42ASwJkkEYd0Z3a0KLDxnGpCd996o=;
        b=eqRuhnbuBVK8528dhhMPTCcoBnBoxsuPHLXIRg43AMT6cRivhJXU9YaodNjN32911Q
         pwq/ctt6q/ZOLonzqX2dixVUikuMwCnIn60XjF5+wBXfEW7ZdRb13g/H85Pu+IfJOXPa
         bQYnDZ4XuZLeZHjdVC9iP2aJu8ZNSCOc8a5tNS7Aq7ZyjiuDuw1uzLD1HaFOkGl1hqkj
         0sFHRkj/c5rOd6Nr3oEIr3jh47ADHKYIsJD5tAHvVWehKrytDbAr1hEKQlT0Xfu5YaYg
         Le9uvMznat+4IjOv/NrTICpyA2mQZTO0xN1xpsYj2dcRPYIZ0D1AcHZ4H4ZxlYSBdROZ
         /C2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eficode.com; s=google; t=1770382438; x=1770987238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVs+pQ16chkMHlhRJ0Yqw+NPyNPUEpvSSt25AVRVSdI=;
        b=VYsWRjF7YovodY5VA0OueeAduzs56ED+KYKf8I6oMPRxsSYGHCYzCWjp020SuEBPFn
         CH3nSFRS7fwJvpBbb6GyWYxFH2/ilQk1egzJD6QRUXWPO4+IT3dJun8q64SF9Bgj4nm1
         /tRwuQBribOX3u53oJ+9sp4RzlKQOx3CN1YG/KY3+XO5azsNtS9G3BQHCDrlNSpfpTBr
         OfniYI8mUFnbNqATS3HpW5JqjXXd9T2cMSIpxZc2Pi5gSe51l1tPKVZyUMg80sptNYRM
         YztThUju9GxycPbcBk0BHfi2k2X4wnOToZbjt3P4t88j/Fd6bd5W+hxdHrV18BFmzpZv
         jLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770382438; x=1770987238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eVs+pQ16chkMHlhRJ0Yqw+NPyNPUEpvSSt25AVRVSdI=;
        b=BT/JQcz5W83oGUjqDdi6xBWmWgnYwItBiJyoHLCCgOfcMIE+ybhElGlVf1B0f+CC02
         8Wvgrf07/qO7ZsDZyWI4ZQOOVszgqQ+pT3mwPcKm6fiur1O8vU2mzIloO/HXmYgyqIaq
         SFl188TmT0t9HoxQWHCvGtT+avm3xHo8bZ9PJx04UIYF4/tynPlHybPiAMg4ZFu01Rkh
         BDTwUpesH6yUKr0j64k3OU9Ipv1eyMMH1Q3dow0BrS4tgwLX7sG0gwdee97SDy9oiGex
         UZ6zOKGnixvGWGq5UyEvfnLRaqsVGpWO3wgtgj/yRewt/76qYcQiyouoo7SX1cqVKQak
         +ZyQ==
X-Gm-Message-State: AOJu0YzfIR8QgcHrJKpsJw//pwLhjBp5BMR18/xcJK8lt6gOUlZnZSmJ
	fRBUD8VmJU2MJ5MUoWkweMWQ0IESiYZfb6XvK48NQmJ+AJXUZScKtDNz0/W2Re1AbFFlKFHOJbX
	q6gNOrvZyC0rfdEYmR1npr1SPMvFKg6CDE4lC/4h+z4SLRrfpoNvNMk8ea5A=
X-Gm-Gg: AZuq6aLNLZ8j3A0LsysAvF6iwBzV6ra6jSoCJpXy8I2bmqbqOV1VplkNirxzDsLN9gS
	ZSx6tTtSTBvT6CRcjjo1BIPLJ6P7p1t1NjCOf2LzJLNUtjLqbN2OfBAiAZVruRMyo0D7rvXvQ3E
	MIDL5h+vD2FBYJU/vLzw3ciXO/WS8VTj0F7Jf3b4HGjAUaKU/s1iMxSqCAmjsQ8QTy0Tr4fJ9CT
	TsjC3FuBKgOzEUpO4VkRDbdTkjyXCeIseMDJscgqZeVlQe3LqbF7FfcgoowgG6EpBEI+vCqqSEl
	vu9CH7Jtre93He2dDrqTKGCf05FjU8V//Jt+dnYNgeyv37Dz8kVtaxEUMJn/ubOCKczbKUnbWYV
	CjR1OMXU=
X-Received: by 2002:a05:6402:f23:b0:64b:3225:b771 with SMTP id
 4fb4d7f45d1cf-65984126342mr1001313a12.6.1770382437729; Fri, 06 Feb 2026
 04:53:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA55TJo_AxC8NPbaXAi7fW+XfbxnXvVKT71x3TkyCt71+vQ-Vw@mail.gmail.com>
In-Reply-To: <CAA55TJo_AxC8NPbaXAi7fW+XfbxnXvVKT71x3TkyCt71+vQ-Vw@mail.gmail.com>
From: Claus Schneider <claus.schneider@eficode.com>
Date: Fri, 6 Feb 2026 13:53:46 +0100
X-Gm-Features: AZwV_Qi0IIJNjErSdC89NTZ6FFOpgU0MX1646vFgBnhgCNKbXNEXGoxN7TK5msI
Message-ID: <CA+GP4bqVephG4creBWsqt3ez3UT_zLFb3EP3vbGouC41O4yv0A@mail.gmail.com>
Subject: Re: "git add -A" should respect "ignore = all" in ".gitmodules"
To: Oliver Kopp <kopp.dev@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi ..
Please have a look here: https://github.com/gitgitgadget/git/pull/1987 .

Would this solve the problem?

Best regards
Claus Schneider

On Mon, Nov 11, 2024 at 10:13=E2=80=AFAM Oliver Kopp <kopp.dev@gmail.com> w=
rote:
>
> I have a repository with "ignore =3D all" set in ".gitmodules"
>
> [submodule "abbrv.jabref.org"]
>   path =3D buildres/abbrv.jabref.org
>   url =3D https://github.com/JabRef/abbrv.jabref.org.git
>   ignore =3D all
>   shallow =3D true
>
> "git status" reports no changes
>
> Now, I do
>
> 1. "echo test >> CHANGELOG.md"
> 2. "git status"
> 3. See that only "CHANGELOG.md" has modifications
> 4. "git add -A"
> 5. See that "CHANGELOG.md" and "buildres/abbrv.jabref.org" has modificati=
ons.
>
> This is consistent to the documentation:
>
> A. "ignore =3D all" is instructing "git status" (and git diff family)
> only (https://git-scm.com/docs/gitmodules/2.10.5#Documentation/gitmodules=
.txt-submoduleltnamegtignore)
> B. "git add -A" adds "all files in the entire working tree"
> (https://git-scm.com/docs/git-add#Documentation/git-add.txt--A)
>
> However, I think this is not consistent in itself: The files output by
> "git status" should match the files being handled by "git add -A".
>
> I am aware of the workaround to use "git update-index
> --assume-unchanged path/to/submodule" for each ignore sub module.
>
> One can try out at git@github.com:JabRef/jabref.git.
>
> StackOverflow question on this: https://stackoverflow.com/q/66773544/8732=
82
>
> My wish: "git add -A" should respect "ignore =3D all" in ".gitmodules"
>
> WDYT?
>
> Cheers,
>
> Oliver
>
