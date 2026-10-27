Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793131251;
	b=MkHMKaHhMNf8IW58DID2y3pTsKtWQDb665FnxO3V5ZCw1KcEMuG/YTbSo6a9qff2aSx3
	 v+M2EPZBTPj1XyvlB2SfHmBFSknB33OMmFAcF9DpROIvfYoRLUJmUpqgaRZRITAOc5liA
	 70Wp0IuKW9JgvNoL9oZCpuKCq1v2ECmum/VCaN8UlJEdRdStMRGeGirlD5TAJEjHfwijM
	 6mgd0IcIWUjK6bS+SowmAYo/M438+oR0hgW2/86ExRdbYn3OwUEOeJUSVkANBQvkmcGll
	 IBxXMfhKNxDfOzmbUAhvqdcolLrzfD3/lc5JGtakqv5/syfb2awokHO6k6aSToKinCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793131251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mwlB9xYi2T3FZNHpggepkIhchwphsi99w6wAWu/euss=;
	b=OQzCnY8S4qGsxqKAFZ3u/1BLZk5DTxPbVgChjOAYrUBAMMVvndlUOAPB8zAB/6pnmdSO
	 vqEt3xKOblkL+CrUJiGBhn8T6PI3dMwT+wtyEEIpRVBDMK8KOKqvaKlV+atXreb73eC34
	 JgcHrot7NXVa6dXS9cx+0/2wg+lxyHoAuww95ekfHZ+avXPvUPRCxdWv8zwKqc2Aq0vVK
	 D3XFVMsIGkoBInYfdBr7HwfX5VkBRw2X9Y109tC2WbWHlzYXerRLqN4RwisZKQ9A+scYv
	 Y5N0dIBydgoJlUGSpezP2th18OSSZfjWLizNvRNgj4jaiC/gpoGTyp1gPKIsiAaE02g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WW8ilSyW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03013606A322
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 20:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03013606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WW8ilSyW
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so381894a12.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 13:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793131249; cv=none;
        d=google.com; s=arc-20260327;
        b=s7pmPBDf+sDxDGyOcm+4jP9zf0sR9eZT/b+jSK45z/ClZBf7lgs0qbRfH0vIivFyzC
         KWMFpZamXAffR5SKlsrXrc6KJ04Sq1Vty51PAO8L+JmIsGFCMIFueXnm0k1m7Mpxk66W
         qEvngiHcEcPs2chNbQNSVqSuaC5jpRck7va9tvYvJ8/qlmy7rU6y17CQEK7jmw2ZgilN
         82mTd8nUytBjcP+rPtf9XQ06ZgvMp9OVCgO/NFhQNuAZgGORWxnmrutUlszGkDKsIU7m
         NTKl7gAg/PAXmHo8XtPItnWN0juLFVKRtX8kfsDzBjnqK6CzlVOXpLvMOSuJF4jSDVoz
         qejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mwlB9xYi2T3FZNHpggepkIhchwphsi99w6wAWu/euss=;
        fh=geDTdT8e9qMaY2SUynxj8NYmIo2jBmM2HM2/or8Z770=;
        b=WotAnkP5yHfg6N9VHjU1uOdfxRbGjy1NQHi/eDUrr3ZUIKpcMajCB3BEqNsusOKfJJ
         J5Y/ehFN5aUZbUHspzc+DylfhGGgDTV17f8OIGiNAxyXgj6Fn//9wN11ls/VmEZ2cb6p
         ArzU/AaaE3Ujel7Qn384/BXqIEaHVlou5eRljCTNSfEQZ6EpxiGvLs9TlmpUIXirvnHb
         QMUz8sgnMAGfohb0AwZuPCCx+1VHBJC49Ol5JYKJdtwlBsN4Ki0Y/IaDwP+4+G+dytZw
         1wWdCJurIwvhGtR+eEt7RpcAcfGVDNlfTVS4LcfUf8HLDm6h7GNL1vJU0+5AJ15yW5gm
         O2zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793131249; x=1793736049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mwlB9xYi2T3FZNHpggepkIhchwphsi99w6wAWu/euss=;
        b=WW8ilSyW3nsxX1mBO1NTp0nF3+s/4vwsU7NT54ulSkG8aj4bFHANBhQoyGfolP+NGV
         4YYwz9KxTRJ2+hq5Ar6dAeMbJLW4StvTbozUktFWxWPmnrZH13CMeHilDja8KMg51YKY
         uaqS5AZUHe5AYJEn1xsD1YSH5XiiOYI9lXEkPWY7pEFrVlsLEJl3eLhPIZksluM7p1l5
         QJ38hQLwtnRM0ByOfLl4SgGpsjiTdXzj3ph7+byNnh3xqAdq3748NB05XQWa4FWYF4ZH
         X7nk1B/3/Tqp/YH+zGv1TDB3ZlcFUv+tN3xM9eOkMQkKKHfNj5lc8/dt8AV+48crEXbe
         sXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793131249; x=1793736049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mwlB9xYi2T3FZNHpggepkIhchwphsi99w6wAWu/euss=;
        b=bnR1hdctluAuqHn8JO1Rovm8RFfYF7peHIR2dABm5A4Ris7qXdw1H0rka24j5aYrQw
         ZCQgevgPfVw6bpz4/wlYwWB9MbVzsFAFVuIS7diSi4/Xzj/sahqruEcY7X9lex+vYsD9
         oCVpIizITxB2cv+gv3dYBKW/gPrb+owkpkRXu0zpebbXPjAGgt9m/Ak0ecFqKZQJDooG
         9vQ8O4zfMG03jfsPvqscknA3mXqnVkFHfZTrzHxe6wYd3aSDgodZ2uRkB7hVa7PaK0cO
         fUGjcDjlBy64vVv9VZEqE54r+uGYehTc9dY239W1Fr0j3P2hVhgoLjD0WKceZQYV26tz
         HUMg==
X-Forwarded-Encrypted: i=1; AKwUvBxnnwBoUKvsggNsA25upplslLYYNdF+q/NuJojagNuHJ8wkdpQ734PfNR/BeiP3WVpWEFU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrW42YYXX0zF+0iasFYh0ZbA9zqtM9Gx0QW6hN1qcLw3vrH+y/
	7el6bwG4wqBUbxf2VdNYFHSJtMMIkorYUWc+fKn0nhmqyUOh1MtQTCCuXjnyX95d+vd3ZPyYomC
	Q3X3TENFdL6jBIu7tiSHuDeXsUZ9KLIM=
X-Gm-Gg: AYBFou2wKXnh9mOIwh+4QDJf0bfAL1onYPnK8DPhONoDo0FXI8EPVC8M18pZWWToSp3
	PXasv45liUCityuIE6qDUXNxNsTcirUulYvqK21GoXfFBqqcferkx19YNYTY1t9xfpIU431aape
	ueXe9TEA3P3duYexs/mBosGWWInM4J11mOakC0ZQeiOY05NNURZJPuAsTZyE0U8GKEVT0/jMz5V
	7MaQcNeDP1qoUlChMo1Y+LPJ/gM01Dm+zNKRP+M1+S/2KzI7hWyEoWhsYyHwyc34b4CSPUIZhSq
	htYLp1WHELsNRnth6gMNl173ib2Q4xCJaiI5qEWlLJvPOEsTpSndKLg1z2M1AvkZ/aXHFNvCoR+
	8B4yPDGXnLeihX4ltKsuabGykH+aQdZp9BJEbHSXjMHyYDLr5SCIUj1E16BM20dvxxQ60dw==
X-Received: by 2002:a05:6402:e87:b0:6b4:5a6a:610d with SMTP id
 4fb4d7f45d1cf-6b49cb5339bmr8438a12.13.1793131249382; Tue, 27 Oct 2026
 13:00:49 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2464.git.git.1793104847288.gitgitgadget@gmail.com> <579C36BA-1418-4E15-9CA7-70C752A69FCE@gmail.com>
In-Reply-To: <579C36BA-1418-4E15-9CA7-70C752A69FCE@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 27 Oct 2026 22:00:13 +0200
X-Gm-Features: AclHuK-Z7jITdQrBNlX-nC4UwtaF4WIgMH22stn8dL2ais0SBO9jqz2kyq-uat4
Message-ID: <CAHwyqnX3sR9YxfK3NtPxVgmTfzfbgXX2bzPKzGGAbfC9k1iF4A@mail.gmail.com>
Subject: Re: [PATCH] Makefile: let ccache cache objects built with the
 precompiled header
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > @@ -2946,6 +2946,8 @@ $(PRECOMPILED_HEADER_GCH): %.gch: % GIT-CFLAGS $(=
missing_dep_dirs) $(missing_com
> > $(PRECOMPILED_HEADER_USERS): %.o: %.c $(PRECOMPILED_HEADER_GCH) GIT-CFL=
AGS $(missing_dep_dirs) $(missing_compdb_dir)
> >    $(QUIET_CC)$(CC) -o $*.o -c -include $(PRECOMPILED_HEADER) -Winvalid=
-pch $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
> >
> > +$(PRECOMPILED_HEADER_GCH) $(PRECOMPILED_HEADER_USERS): export CCACHE_S=
LOPPINESS +=3D pch_defines,time_macros
> > +
>
> This is a little curious to me. I=E2=80=99m familiar with the GNU Make-is=
m
> to set variables for particular targets; how does the export work?
> Is it the same but with a propagation to the recipe processes?
>
> Would it be better (for some definition=E2=80=A6) to put the export in th=
e 2
> pre-compiled header recipes directly?

Yeah, that could be a good idea.

> And, what about Meson?

I think it's not touched by this? My goal is just to speed up my local buil=
ds.


Harald
