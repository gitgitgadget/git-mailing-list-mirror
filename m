Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D269C3C4167
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465619; cv=none; b=FTmftNBhkPDZ8Ep81gfuNsD3UXwftClXrCioDSSx5vr7BkKxanDkCvbNrHtLfgAlENW+m9sGVuUBeCpswp4TMbyseq278FaZsd9gYsl7tKYGBYYGiD+LRcV9b32OMvleYh1I3WgBSTqZPb4HQ1XHnMaUUBPg+vILxfJ1s9CF6oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465619; c=relaxed/simple;
	bh=lgk+d1rJuHyl+v5UBJDeUkSvoqAWhqn7VeIjLEnuddM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=BjWiRRjQUmqCnvSnZ9SnyxLh4NNbcFoNqR2NUsZZM5YAyM/VwvB1ERABavKvZkS+kU2mZPAvP873W5T/IBZyT7borVFfCNgW5LJzriEjr+IHnHBMTeZXQbhydUnu+WIcLuzmZor3x0HbGxhkvfUqG43G0vF32FzfglF9JXTA8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=orcCCWog; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orcCCWog"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81ed2a00f12so45888057b3.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786465614; x=1787070414; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lgk+d1rJuHyl+v5UBJDeUkSvoqAWhqn7VeIjLEnuddM=;
        b=orcCCWogwsT9GJ1gVgDWYOEj2ph+fOhqTaHpuzYmHe9Mhjk8apcIJRfhDZC94hNh4+
         B+6yBlZ/dGs9dSLxAll6Y60YknaABIWCtrsv+7ioBQ3EXNkU2EbCjEwhwngUKiqxGTJe
         PTEO0a2JI9OErzpW7dmTguch0KQz97VBPxwBvU1vkScKJlMnlEN3NcoR6D+8a1a47w+0
         3h/Gs+rq9s0Dbw8l1YHFSqSWB3UdQzkhZ3OgDjUfWMNzK3AaxFxvkuienRZvfZ7nLSFO
         +lOp5IKvm2pClIu3rp+Cuj3Q80MFIqlVPrDL6XaidEjWLe7B0kqq2WMye80SUTRpiaOI
         DxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465614; x=1787070414;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lgk+d1rJuHyl+v5UBJDeUkSvoqAWhqn7VeIjLEnuddM=;
        b=nCJH5QkapFwypsF+hEMFGz7l/eHh8kejDcEom+cbVJCXgWwrKMky2UvoGd7xBOcaKj
         kTdFF3Gfr0leYCAJ7+/eiohRCesFVzVAmb9nAdeYc/HfZpplcvTkcRa8RRqwYZMUJt3I
         NfeBb4Sr+nTgeNpfxuO3YakUOYkZE19MZ8S/N7bWG1i/7GGgOacWXdQoCxDxtsv7XZDb
         3NsV0K80JoYlhrsSdmQ+/6FRu6DJym8PfVlJLGp9VzurtCsmHXAuBbTK9zT7ETrAB3YW
         UVwN+Yfh8G6y4gCIEGxHV/tQ9lxozvb1TnS2Y7Cfg9E9Xbw2ljB60abTatVv4ikEWdvI
         tH/A==
X-Forwarded-Encrypted: i=1; AHgh+RoPiW+3e0cNouZCv2U/hB8A7s2I/HqJFZqYNPlceMgISMc1v8JSY9OOnsbHCv+/8V6WgCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk84SXTtIF+/8/D8Mnc2ySgXCWexR1/3eN8jiUlUlvsD/uQa7o
	5KsovalBGUakkUFHbzOsbf1krfRvDZdQts5DlLbB5GQwyAfVH45QT+8d
X-Gm-Gg: AR+sD11Ynb4o/uod9B+4GEwOmG99qE2G5sd9IPhzk7Ej+l/pD6B/reWTbNddlEBPYX7
	Wh1cQhpzCT0DX90/KYU0Q3SvMeEn181dUUCOEdzhhRmA1oTvluT+3VcJX2i3i4lu+F8qj98wJeV
	i8F/0rGwEZHQYr6b3qJwq1U9UNe+dIoZeAMbeD86MAWjIVr4MSeXxhxwc70Y0cZ5L61tcYCX+Eo
	0zVl3ZWoxmSKkEmgiX3MNyDkxgNLi1H6A2hKVH88DdWfuy8nxDOBnLuMSyBUFODUdLgajK938ep
	bI3TXfG6x6hyrb1tlI6ggqDG4dtO9aAhQ3e+JutVcFLgQun8bMFWNiI3f+0WYlllPz7uHEWoY0L
	xrHa2RcqSKoCncqoPO5MjKI/Bwc7SmvgKPyGHGRWuRO2GOQdRt5GFnpQfezZl+QrPwy2hKwVh5U
	fNuBjMDjma7CaKUjk/Zn8wTDSnP754EiUyKzAQrKd38/v3eRuQBJ4mGb1e/U00hoGI69g2Xlgm9
	mtqvuRnWRu/o4fG9BU4KmCmr9n4frMMpu1J52FH4BzsQzOpC1MK4zzeXpyta5CyEU7+BwrwhO2l
	RkNH2ocQbl7Ks8F/3GALv5gCi9ia5txF1w54Iw==
X-Received: by 2002:a05:690c:e1d4:20b0:820:1014:526a with SMTP id 00721157ae682-83042f82e8dmr10481447b3.29.1786465614083;
        Tue, 11 Aug 2026 09:26:54 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:556d:681f:9688:f449])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82ec3902275sm12269747b3.23.2026.08.11.09.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:26:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
Date: Tue, 11 Aug 2026 12:26:42 -0400
Message-Id: <59E4039A-C9BA-4EFD-8022-77C73EB51ED0@gmail.com>
References: <annHlFwu4NKwmcLr@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Yuchen Tian <cat@malon.dev>, Todd Zullinger <tmz@pobox.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
In-Reply-To: <annHlFwu4NKwmcLr@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (23D8133)


> Le 10 ao=C3=BBt 2026 =C3=A0 08:44, Patrick Steinhardt <ps@pks.im> a =C3=A9=
crit :
>=20
> =EF=BB=BFOn Mon, Aug 10, 2026 at 08:27:51AM -0400, D. Ben Knoble wrote:
> [snip]
>> Back down to being on-par with original code. So that's good. The next
>> version will include some variant that reads a struct member instead
>> of going through repo_config_get_bool().
>>=20
>> But which? Reading the private_ member is obviously wrong; I suppose
>> I'm supposed to use repo_config_values() there. Or, rework the series
>> to put this member in repo_settings. I think I originally assumed that
>> struct is for things that are settings that aren't configured by
>> git-config, but=E2=80=A6 now I'm not sure. Looking at prepare_repo_settin=
gs()
>> shows lots of repo_cfg_*() calls. So I think I see how to adapt to
>> using repo_settings,
>>=20
>> Patrick, Junio, and Tian had a brief discussion in
>> <anlmwaEtwcCPse1N@pks.im> about the split creating confusion. I don't
>> really want to wait for it to settle to land this change, but we might
>> want to work together on identifying the best path forward for
>> core.useNanosec :)
>>=20
>> I don't suppose it really matters to me which struct I put the member
>> in. As I said, v2 will definitely fix the hot path lookup here. Just a
>> matter of input on which struct we want to use this time, I guess.
>=20
> I think `repo_config_values()` is the modern variant that we're slowly
> migrating stuff into. But that struct only works with `the_repository`,
> so the question is whether we ever use "core.useNsec" for a different
> repository. My hunch would be yes, for example when recusing into
> submodules, but I'm not sure.
>=20
> Patrick

Thanks. I=E2=80=99m working on control-flow analysis to see what kinds of re=
po values end up there. Of course I=E2=80=99ll also run the test suite and s=
o on with the repo_config_values change. But the analysis will take some tim=
e.=20=
