Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795850938;
	b=N+Otgi5HNoBnqpR0xngHedzq73gFQBN6as0QPmiAsRzAZjDw3lQCWyjycu3tCUz9PdCp
	 tsY1ZzheFeOrLH+wa6q3fC84McG0D2Pz0KbWzrpAFvcNKNWu7MQsO/hiB31b67c5OqzNm
	 /il76byBAWGiVNk/TdRfLZYJA3hWvhrgHwWagpd3ut9W/bvWEEWviT85o7I/ZI83gtfFM
	 KVaZo+hGlAJVs4hufiOSEP69ZeN0tawfCj6ZxbRB4fAs7dIJIjYXf9hZKrn2ubrMj8nw3
	 vgSvdenseWHlIePLxNi0ov5FFC3cQ5roC6yg1cAcEYnHmlWPb12o3Ne2ZVYCZrMy+fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795850938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TmmhZG8oOStBizCYb3IDfNVjHLeeYsI9R4Pzl4gljGI=;
	b=zebwuh9ipcrLdqjRqK7MNlX+cDM34OXKP2c9ByIWGLsOTbPBrIX0I9sL3D2RnB3VI4Cu
	 YLygiuTOUikQsBdY0Qux05tUbLlXK8xLzcK+oQpRkJCYxoRoSinSRZ2Z/9fjUikrIneUt
	 oVRVZzRI6fs35GQOAJzhIF8gakOqYSGt/3Qe6lEpjxt6tTYLQwtAtu1gYwm0FIn5pQMNJ
	 Li3cUOa9lOwKtl7J3JttIy4EnRqWHUeXyfG+2xZ/HAKZdj/eWPj1jnmUltq3h+qDB/1Ux
	 pGCktOsaT/hEwq/OHrMrAJoEHj4gJE7c31ZJXiCfSiCDjG4J9hbRsv1pfsGF0XWa2fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LygdrRl1;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57484606A31F
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 07:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57484606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LygdrRl1
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38431138772so11599763eec.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 23:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795850937; x=1796455737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TmmhZG8oOStBizCYb3IDfNVjHLeeYsI9R4Pzl4gljGI=;
        b=LygdrRl1my4rQSxmBbS9dGzFwXyZgjF4hGQgQtxbKlnGoFdqQfIBCOwZqSe8skpUCJ
         yxuheGiVZt+TP9Ts4fqaGep8AherKfUbxRO+nl/kwAy4uTU34yPnhdTwS5EG/ZWj2LzG
         gi8pSUwYYCy3UXCsG7Y6Hg1udCLs9vfOzFpGq06iUcFTBfpo3Lar235nQoPZMs/1jv/T
         0q2fRCfOh3qeJiboarVuaeGNLHunjMbtnWXg+99KEoRfDx/01Qs6VNGw3OcIMH+xvuyl
         GHJEVa9SsHmOMYcp48IyAHIYuhTCGaY20AgIabypIyGiPRGvuMve1WtXnabI/EvacYJT
         +vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795850937; x=1796455737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TmmhZG8oOStBizCYb3IDfNVjHLeeYsI9R4Pzl4gljGI=;
        b=lCWVecnpziBhJVOdPcAD1yJcQiLBkukSKv6C9+tUmMcttovidVmycf79sWiQwia54W
         AET8lKRl+W1+jNvyui69Up80z7qrJwq49e+jvoK7Y447dPdZgUxXXJJO2YQcNoiutAhv
         Ng/GZAVJPUIYNb50LlwSDBoPIBsQjB5AwqywZWwtA9XBfWyhcnCxsnIFWhEvyQmFrr5K
         ZHwLSb79/tGKaY/0fQ+Gj8IauqaIuzqU4ETMHPXTbk67VZ3mYQOG4gwIAg0Qx5ZQCiSG
         N4JhuWtUJC0wJvNuQSuKpb4O/531wpzBFXjok2VOdTOOAXEIYnzq3UogFF5url5YqcKs
         R64Q==
X-Gm-Message-State: APuU4Z9SoAXJVJ55u2fVwJCcq3PR5sSeuNu54UEmc9NmOiW8py57KSUY
	b+xltcS7AcH1kCvMDDasQST7bx7iembpb4ILyMRO9rD3g4juuO7ZHxIh
X-Gm-Gg: AZFdTZeeBc03zamkZri6w4lDyvbDGhrb6kSfVDn4gnXFwdsalApYy65AIJ+Y8QzEqVJ
	jEcqjfgTYkztVsc40eyXB7iZIgbRITVTjBtsLfNRRqUDzQ732kB0jEbl7kFCe71BqDlrRDfhJoS
	PE+3ieTIGSpDt3AAtB988Wk83kT005zG1xapJkhFjDHx8iuu6PvfrII8a4Sa2hqYrF0qdTkEkfw
	fNd58cI4G5AIIAEAtTGN/4M2w8ns6KbyZURwDWl8g6cNI3sw2JBBgiODElj9YJDdLGV9Am3/XFp
	qNJlKuqT01srE+lsZGvjDh+Gy5W/NfUAKxJnOUx/5MvyHWqbPVKFZveh+DLv19qDoHRskesGHQi
	K3fiokUMPHL/Msp1lWbxy42swKddd9oYpxHQ2FB2TQ2EIIiLtChG+pRnT6Qq3KSz22Lrz/YpgH6
	88/PfxkA0CopLVjWhtC9EjXeH6mD+JT0eOpP5DJF3Q+rb8Bbqc6Y/BW9KBerHOfNBwff1rVnPo1
	fkeximKFOMLDlV0/8tKVU612JUe1gvUDS0pGJVZ/DCvuKtKRSapopzUR/OkeJt+Fa7Ih77+6wsc
	ZiOLs2+QGezgTxLCY/3cZ+WOC2jy7FGTLWscvUWLNP3UQhQYiLdJYapiGBkfudrRYOqk8klv5Vv
	1TPHoofE6DYmkxKQoBqQLdt2viY7D4JQmPcYrR+RS/w==
X-Received: by 2002:a05:7300:1c95:b0:385:8851:fa4a with SMTP id 5a478bee46e88-385885211c2mr26618561eec.6.1795850937380;
        Fri, 27 Nov 2026 23:28:57 -0800 (PST)
Received: from localhost.localdomain ([223.190.82.63])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm83303169eec.6.2026.11.27.23.28.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 23:28:57 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Matt Hunter <m@lfurio.us>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Mike Beaton <mjsbeaton@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] dir: do not turn blank ignore-file lines into patterns
Date: Sat, 28 Nov 2026 12:58:51 +0530
Message-ID: <20261128072851.75292-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <DN6LDMN4UVPP.ZUG3AO2YOIZG@lfurio.us>
References: <CAHzAAWSi9D1mRL=A5-9GxzqQwo9jJ=45Hmxj3hVAF=8wkNZLmg@mail.gmail.com> <20261106182945.1316297-1-aniketgupta3001@gmail.com> <DN6LDMN4UVPP.ZUG3AO2YOIZG@lfurio.us>
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

Thanks a lot for looking into this, Matt.

> Something that initially confused me while attempting to reproduce the
> problem was that git-status and git-add behave correctly.  Even running
> 'git add some-directory/' with the trailing slash present, stages the
> expected files.  I went back to the original bug report and saw that
> these details were commented on.  It would be helpful to mention in the
> commit log message if the problem is specific to check-ignore.

You are right. I should have said that from the start. I tried status,
add, clean and ls-files and all behave correctly. In my tests only
check-ignore shows a problem when given a path that ends in a slash, for
eg "foo/". I will say so in the log message.

> Should this test description be more about the spelling of the
> (inadvertently) ignored directory?  That might better explain the
> specific check-ignore assertion that is made.

Good point. The name does not say what is being checked. It should be
renamed to say that a directory spelled with a trailing slash shouldnt
be ignored.
