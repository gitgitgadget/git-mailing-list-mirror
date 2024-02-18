Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72CD1D696
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708288850; cv=none; b=RDqQkdRONEH1BhE4/stwDy10h8vclsuC1T+7r37q6xfYNZyZ3HxCtcol1QDsZvKFNrk1DBm0TqFqV/226jNd9QUlxNVxJNkXFmElqvr6ADN7HRhKE/WAcMsp4e2bqYMl8c02m/M4YzbLr5w/FdoMPBvvh7n5v788Du2Fwa904Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708288850; c=relaxed/simple;
	bh=U8qkQ+vDmNldWCyVZB++kbciamgNToyD4IqkrJNl7uM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ANR4KuIH+cfa3658PZsTWm25R2AL4tbnYZry1ottqLmMK7ns8QlcOKlBOxhPsIGERdAmzDOLoo3Zd2n3qN6GgqzAnxjJA7kUL7tHdRsIx3xpltz8MCRjD2jx2OeauxraOPxkoR775Y4RUawgMe2KZT8SRuYWqkjEpPF4eZSGNyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1AKLxCe; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1AKLxCe"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33cd57b7eabso1918724f8f.2
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 12:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708288847; x=1708893647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asXl0+B/W5Xr2pFZdJp+Uj32keMOV6eT9at6YhBA0VU=;
        b=K1AKLxCeL4PB/+uahuxXwM8QgLndK8Ia/wDCd7lwT7sJv9i1G00/JBrNko++ujfXw0
         pZ+eeZXYbDwodeQQR7d4uCvbSItjFJL+UhTV70pokX/U0JhEMEpHYhBn1TBJBqh9W1p6
         pXnEFVgIZ4MtP+WVW4Zf34kV6LuP2EiaVPz1yc9v3uLO2kiBnf/LXiWB3wFe6WOLr+G4
         jUCkjF/PCVu19qXpLQ3ySPokS80gtp3//nlqObgWreOPJoyYZEmSSsca9PYsNLFFXfyg
         qKNTP1IkmbE7QSNPiTlfVAVCEhdqEo0wZ1Tu42EUevE+zTrNQzpwLsFrYLV/16nbcQrn
         zoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708288847; x=1708893647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asXl0+B/W5Xr2pFZdJp+Uj32keMOV6eT9at6YhBA0VU=;
        b=jvO5Medo9tZ9K8sluYSMxGVcKKYATYGe4MV5OzN9GtuLHgvisOlssv54c3PmiyjjU/
         D8UMWtJzbPHitmo6uxpRlQj+kuPdY7Diqv/9NCWhhsx3i1sxu1qN5TJa3gKiH8/OOg/K
         vZNXTR7NbXGtyno1Fhe+4LUBwuHQ3wZ5B4xGis3qfEPlwtVbKTapWGRkCsXj5vb6slv7
         Nczs7x70j5Z7X6/LvC6SBFt1gAL3sgkrezukQKbePEHA5QY31r/IanHSMWWAu/f6RV3W
         6jjd4PYjmEVch/wUh1zI0ORXtmBznl+XhHCpJ9D2ra16omzQUpHA83iZurEA9vrBeTzk
         NjGA==
X-Gm-Message-State: AOJu0YzVZWPfSDDRdrL3zcMppXh+y/6PswzQSUbG5+gizNuFs83XLn1f
	KGoENFU/YaED+xk/oRyDLedZuYDimwfabviMZE4X/JXMavsH1tfkJ3L5xUcl
X-Google-Smtp-Source: AGHT+IEkrGbUQFFgs+IZuilbovyORb0RdCqxijQF0O3uYTrbz1CL9KlYn5WinWJalcB3f7lq2wad+Q==
X-Received: by 2002:a5d:43c4:0:b0:33d:3566:b5c8 with SMTP id v4-20020a5d43c4000000b0033d3566b5c8mr2799290wrr.13.1708288846877;
        Sun, 18 Feb 2024 12:40:46 -0800 (PST)
Received: from penguin.lxd ([2.26.197.149])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d55cd000000b0033b198efbedsm8294283wrw.15.2024.02.18.12.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 12:40:46 -0800 (PST)
From: M Hickford <mirth.hickford@gmail.com>
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org,
	mail@boanderson.me
Subject: Re: [PATCH 0/4] osxkeychain: bring in line with other credential helpers
Date: Sun, 18 Feb 2024 20:40:44 +0000
Message-Id: <20240218204044.11365-1-mirth.hickford@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> git-credential-osxkeychain has largely fallen behind other external
> credential helpers in the features it supports, and hasn't received any
> functional changes since 2013. As it stood, osxkeychain failed seven tests
> in the external credential helper test suite:
> 
> not ok 8 - helper (osxkeychain) overwrites on store
> not ok 9 - helper (osxkeychain) can forget host
> not ok 11 - helper (osxkeychain) does not erase a password distinct from input
> not ok 15 - helper (osxkeychain) erases all matching credentials
> not ok 18 - helper (osxkeychain) gets password_expiry_utc
> not ok 19 - helper (osxkeychain) overwrites when password_expiry_utc changes
> not ok 21 - helper (osxkeychain) gets oauth_refresh_token
>
> After this set of patches, osxkeychain passes all tests in the external
credential helper test suite.

Great work!

Could these tests run as part of macOS CI?
