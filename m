Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62BD1EBA0C
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741816259; cv=none; b=XoRM6iWa5WqoTMdYhztGI8i2h8P4E0AyJ4XcrgttpoRFyptrnAvT6JeEkD225oqKCB/J7ydQrX90oMtq4+XxCC1WDA3xBKQH1r2gXAXhWlh39/3sCLiVqjwoniZLOU84zT/1keAIPMzxggy3uNNHtxiH1EQKFv50TWWdEOvQDBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741816259; c=relaxed/simple;
	bh=nqWWefwT9MRv4XciCIdMfcmcdiXuDYWgSw4mBVMqgUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWP8J50qfOS12KBuwdnThpw1CN0gTaRPSz+Vc1JKLxO+vo9pipSyA9z3gW0MtODzUcWVwqbtT2G/HbarKCW0YSIHkmXPjELooRz8ghWz3llAJVjNLhmM7744TpgszpJqQI3W5Y7RQUW4rLetle5RPNp8gHrA38HzPwGzVi8OCJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=PqSZq09/; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PqSZq09/"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e639040ec74so1371304276.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741816256; x=1742421056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HX3xHj9J/jPDFSoKL90Lbbc2Ebl09j0XNgNhtIcwdBo=;
        b=PqSZq09/EYVF6wZc25VRrzn/sstaOndNn5qhBN6RCTUOJpwFOPemkWatFbif3pAcLr
         nB/QhNBsO6xK0+BM8eW5FyhXS1SN81xG1RL2UUNh5DFWLUYppLGALpXGohtYEGRLEc1A
         JHqSXEZuLTz4FeemUGBh5mwTnQM9YhoNhG92ovyaUs5FiPN5slzqjiVBXDj+eBTQEfBc
         W2JbfQd/91GPjO6Nxiptm6aQnXeqH61MTPiLnRTVg4cmBMefhXSB6YH5YLzPHmCJMLhM
         geXO3if5Lsu2TmaPd9/01IZtvISF4g5jU2c9bpDy59MJio/VFBFKICZSKA34zI3WPGxk
         JJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741816256; x=1742421056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HX3xHj9J/jPDFSoKL90Lbbc2Ebl09j0XNgNhtIcwdBo=;
        b=NuHMrlHX7bISUrazVS0MxZkQprRSg9bGGlr0z/SLSRjrHK8TWPBCo4lKrGGADJ5gEF
         ar8EcUs+h/xZGLpBwxCJ1ugMD55MQKVuO5hGIhNCk7b3V5THGJW+ZPz/Hh/Zcooh0msS
         zG2TmOJpOyopSAnyJSXM+YuhoY4VRDXyT+adzn4ol4KOFS4t5LZPqV4jo9VpY9/E52Ya
         LwRyfeP/hjVs1kT+CkeSUtooPLeGVVOBjmVz/neQadhV6UwlAZ9dtvTNjlui9oGw8jAB
         TWl6wQN5KaIfFdX7R4JmJQKgODZyZxHL6yM6rlnQO19f+60vV9Epyu5Dsv2hRoaDljmO
         Hs9w==
X-Forwarded-Encrypted: i=1; AJvYcCUJWwyNUQczhy911rHjYd2xwRLfQUwDod/nkBapU6EWQZ01mUZKbXmDEMq+b/GJVGqzS3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyr+5lKdzdvg3SM6LYP1H0lxPMcnAe4I4/dB2U2paNUVRLBXpJ
	AXargki4mDw/9Z7/OkKSITSmwRY6g1HKTQi/SKwrZKOj1inPzzZCLbOCsrGGiOY=
X-Gm-Gg: ASbGnctZ1FBMJL1xYMT/iFLw/+DyGCmOSvWWLKZM496cAlSU5rGOr4g9KtByxG9iW/M
	/GZ8ukrVtdSlGmdgJq1nJHdZ00zc2ntvBBnXDoXfKSDBNXVOEFPl5d7Ajk9fSDfRQbd0mVWukTx
	9CGd14Qsr0DxS/S5L9o0D0YfoE8VarMi/01FxfFq0FqWECAisQi9E9rPxi4zHW4QhIAPXntNbQL
	KQRk2/JRZjdmCJVpAXUxHII7H182svI0dOz39/0J7pmWdeOs7XKL8S/lo/FS7FIZ1Y5mZ21Pky8
	PjIlJFf93EyXm2xcaac+Vu6WWzbt/tUdF9ddnRlJ2c2vDwEA2qfi55U94dx4BZyRBAVymKUlWlQ
	fhAeJc1LFGUJLEftfQq2CYlmUe1w=
X-Google-Smtp-Source: AGHT+IGsin/JeqPJ+yXsH6pu4iOFCfViUlFeQaIxnRhQ59CChqvpmS1MsTl2klQHqgr/2usVsvc9qQ==
X-Received: by 2002:a05:690c:3683:b0:6fe:d004:e2a3 with SMTP id 00721157ae682-6ff2f735523mr2518937b3.16.1741816256646;
        Wed, 12 Mar 2025 14:50:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2c2edb8sm33565467b3.73.2025.03.12.14.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:50:56 -0700 (PDT)
Date: Wed, 12 Mar 2025 17:50:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 3/3] merge-ort: support having merge verbosity be set to 0
Message-ID: <Z9IBv6ia3VHNmF1p@nand.local>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
 <c2a2be336e0ed7966b6ab0ef004f150537167b55.1741362522.git.gitgitgadget@gmail.com>
 <Z9HopHJKPv7CXI3R@nand.local>
 <CABPp-BHoHsc8Pov+d3B6i9T4sRg2g4-tt+hLYg1VHT07XLyncw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHoHsc8Pov+d3B6i9T4sRg2g4-tt+hLYg1VHT07XLyncw@mail.gmail.com>

On Wed, Mar 12, 2025 at 02:44:24PM -0700, Elijah Newren wrote:
> > Should we add a test to ensure that we don't regress this behavior in the future?
>
> I'd rather reuse `git {switch,checkout} -m`'s tests for this purpose
> rather than adding new ones (and perhaps the ones from git-am; can't
> remember if those also caught this).  If you feel strongly about this,
> I'll just squash this into the later patch and make it bigger so we
> don't need more redundant tests.

No, I don't feel strongly.

Thanks,
Taylor
