Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792822247;
	b=mMxidG6IXe8Tpq5IFoYJsky834Ixl4bokAVCvj8KyiXqTS7ywS7pss8NCNxfvsJnGCtB
	 2HO9FL3/Q7D/dh0ODJGtf454gte4vTd7FRZXHivSLbxehVpNjeG5t2Kk3HQCgiuDh64tA
	 8b7UeTwas0y+LDmyfqXswnynV8Zb7HtHFn57TTbPQM11P2gAujnd+3O8JlefpQXMoeBa0
	 MJCZEmi7HhOUpSZg3DBrfr7RcEUkbpqRz3/bvEqfyvQdZX5znTLa9tdHE8CtF1Fs1X3vq
	 mx3vjc6L87hb0UeIMeLlNE36y5zGFnf4jI3D+4tZsusSymHmhGxhUrXLiIVBnrWkryA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792822247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=L4x8OxdhHlWQ229gd1WJcWwuF5NIc8jMCvWRzK7OOug=;
	b=rsDG4Ei97+9brj3BCmn8boRahEmM9961jCh8v8BTMm6wNM9q6TmOr55WA4sp8Z7T5aIe
	 5mDAIJj951vmMkop1YucEkvRdsB9yZ1hEDq08T2Y3/EsCJdQdp+rCGeZ52GWP8upFwSZK
	 isOEd6trIUVSd93FFB+DMoWV/gRAxjW0TQhR/isAMI71pD6qUl9flrwqO0K/VrzAxGwLO
	 OnSeEaHdJRBiGwc1NxjXeUiDQJKXZd2GNesyuAUslR/JbDAA1g9GBlEdCoDNqv5qpPnkr
	 NwxnhJz06K0D3xg0fWsluHpSeTqh4GuhlYbiBGCuA3JeB8tJTuyW2BNTB54u12lLF/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d9tNBqBm;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B35606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 06:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3B35606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d9tNBqBm
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a218b13c4bso6981165e9.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 23:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792822245; x=1793427045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L4x8OxdhHlWQ229gd1WJcWwuF5NIc8jMCvWRzK7OOug=;
        b=d9tNBqBmI4+00MiPp1SkXAPF0hFLfHt+f74mcJv2JVKLdBqNPTV2HhIst+qmJyBnKJ
         lsIfiS57QEzj6Bd7mDtC5v60kwcKz5VrqvtzOPl0z8T3SbxF8s+XHdVVgin3hjLsncEn
         DixkEBhk/wyRVNhCufciGeJ9zFMAolJizOQyNaJlHG0BeYCYudQrc9iwRQV/bd2XNvrz
         jGDC5nSllb2WDfGTTJyQnXe/3ccdaDugaXbpTLW+cst2YOFZjSolckBoxm5GOjiPwSt3
         wCgV3jDkE+jnEcoc3GneOYcpZbEnt2EX/4ASrknaltcIY2WoW/sq0X15vURdkkh2avCA
         hIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792822245; x=1793427045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L4x8OxdhHlWQ229gd1WJcWwuF5NIc8jMCvWRzK7OOug=;
        b=NiofgsDSoJXM6rjBWT42IEROoTzX+4APIF2siFXMD6yM7RwkE/1bfxjO0+fcem+Etg
         lt5tOWKTVGrZIKIMgpEfICswXX8IgUp/++3aQqs6qGZ5kig6wpCzwVNPR4H0VgLx6/EG
         bok5boY52hlbU1c/Y+eSi+nKnR2nMrmQnM62P3dhHdY6j/tkLp4tjRshqOZ3cvwAE6wt
         5WF/BYzsktYgEfR9zDxdxAC3o8qPpxxCKuqskgGCPaWVTJ7bO95lLwqGRQzbRJXyfanB
         8vQc+ScGjFGqfTmi8u6DmpEczNT4YlZAidY8aUZWKJjvBNsL6zLJhNF0DPsNoluEHZEL
         CEaw==
X-Gm-Message-State: AFq9FYJr7fR/soWQT5oyMZ50ejSRnBd5aFPenWieM3d9MmVxwWrAK5o1
	qFucPQOty7AqwIGpI/vA+5ZbV4dvIK1XHJ/+YitdZ1I3KwkoyUtKZpiu
X-Gm-Gg: AYBFou1ECih1+kb3LcM56f5FkORUG0maZ0tZrC5SGig7KyqLMzqu6ZZzkO6pvBN1wyW
	bdrcry5+fZ+ZjvrWF8wRPnk9L4WLXXlD21dyD1IvTsCJq6OPC4UDNt6oWYQzYyUUIvpBj3zG5rB
	cMoAMwXHmwrDbNHnISIJQC2leSRBm7RTUlCacTPLcSVo+ws07HmtQSXPF6NelZ8nH7Egy50KlIG
	+0YpSKTjfdzybr2KdcRo6bRErZiT1XNn8PeHVk1q1ORa/4girbYNMk9jDZamQCdjNm12MHLjv/1
	0uvro2hUUGVac3aLYUc4BrHFIrrcVObXtVte4ZL02vArFIEEmZMcsXcZZg9/IMkV0APdHsnMjKZ
	7AJPduMPnvx4ztgS53BN1RlnUxPnHVaXEfeG0TirlDtiCIUYoeUD1rLpVdq8EMsazNyiHdtXQKs
	J26WEwYNGaw6sUPAOWoUt92EtMhvTXtQ1Ba+T9yCE/DPrO5WvLpk7xZYVq5mHpKWWkfb7C9ZaJa
	ErcXCZdyHZpgi64dwEBZx3ZZuRhiGnk87ynnA+g6Jju1PlaB8RHNX20Ph+/NtOV6qflAYcvFS2w
	UtF7PPdcSroGmTGUUpfmspAaDE/XfFHAmHj/9piznqRDrj55nEZSOF7l7wl89Sh+3fnF4F8Nfve
	psk4g5ddT
X-Received: by 2002:a05:600c:c173:b0:4a2:883:4adb with SMTP id 5b1f17b1804b1-4a35ac9ea4amr14096915e9.22.1792822244926;
        Fri, 23 Oct 2026 23:10:44 -0700 (PDT)
Received: from HP ([105.163.158.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece13aasm2184625f8f.58.2026.10.23.23.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 23:10:44 -0700 (PDT)
From: Tanga Joris <tangajoris@gmail.com>
To: jackrawlings2011@gmail.com
Cc: git@vger.kernel.org
Subject: Re: Git crashed on `git apply --check`
Date: Sat, 24 Oct 2026 09:10:17 +0300
Message-ID: <20261024061017.100191-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.236.g7e34d8174d.dirty
In-Reply-To: <CALdwsC1cMKZgRPZA+pBaJe4PPs9q9W0K9CQLmM2bgUCyysTB-w@mail.gmail.com>
References: <CALdwsC1cMKZgRPZA+pBaJe4PPs9q9W0K9CQLmM2bgUCyysTB-w@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thanks for the report. I was unable to reproduce it with the patch as
quoted (the "diff --git" line is wrapped in your mail), but I can
trigger the same assertion on current master, and on 2.43, when the
"--- /dev/null" line comes before "new file mode" in the header:

    diff --git a/n.txt b/n.txt
    --- /dev/null
    +++ b/n.txt
    new file mode 100644
    @@ -0,0 +1 @@
    +hello

Was your patch handwritten or generated by a tool, and could you
please check whether its header lines are in that order? If you can,
please attach the exact file so that we can confirm it is the same
problem.

Thanks,
Tanga
