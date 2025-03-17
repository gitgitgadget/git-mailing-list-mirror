Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC429CE8
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250855; cv=none; b=Mpctmifih3p9e7AbV1dLxHOL4T3Xup+ms0OEkYDJgZsJ1xdKgD+jaAtvZXxlick90CYhnodfnO+N94JcbHSEWFoIOHwejvLiR2ALVVbckvTDrMBiMibnoGP50k9xAt51B0l2RGw8qXipudprfSNdg3CuAcR5PVsIj/DUwXyUTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250855; c=relaxed/simple;
	bh=qx4wu3xRbQs4eXEIiBkGt4V66LALFIjiLAU4zuNfcOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8iKGh9wE8cPco2T8dAg93lrExs6UrKXOWkEKPkywDDghg1lFzBbxrJ1fHQ7m0tIWsqYqJCcejzeEcSqSuLtBfRDScms94VeI1JJJqmgR52yPauDm8v15H3mIvV6VzafLp9CHil31x4Uh9cmp4I3JMtvbmUOxL7LnVaaAhLcx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Fvfj8N2n; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Fvfj8N2n"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e900a7ce55so70023046d6.3
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742250852; x=1742855652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RlbsrMgfFY0TMQTlT3ufvo8CPwgR8yRhKNHGaxFW4fs=;
        b=Fvfj8N2naNPuYZIvzi7e0T1wwqvFJeq5YJ5BPd7B72XRr+jEYkDCgKntwSOtvgfFSE
         Or+Rwrc4g0sJJf2SdgQ4wn8Y1O4Cd2/95rPU9G1x4W99iLNnUjbrPIaxFtoN7Tcj5YwE
         EvBYXhDQvsOjC5WPC/XipStP3FM5ThPYQmIc0PyJFsl1O6hhwt4cjJm1PofS0E75o8y/
         P4chNWgxcO35Ea5lFEbkdm3lKlCwRf06m4sLY2SgqgmNHeOg6I+w7qzNLyjnQMUei5Ty
         jq0VIAEVfQcQnyPo8fvtHiHnIX3SzNeKM2ywePjnv6RQOPesyoVYdP5UykppOfBspQRd
         8zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250852; x=1742855652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlbsrMgfFY0TMQTlT3ufvo8CPwgR8yRhKNHGaxFW4fs=;
        b=JFddreewq3b2igY7ymH11/ZSc/4dYY5vPsZklX5aMp6irS6rB0imu40zr/a2THCHFb
         jVegX19nmVeSvG3dxg1MDIRXeMdQSBWj7DMQT/jmfUzFcgDgZ0TQ6lJrYyvryAAjaBUE
         i5GXSI+v+mLdob14BERaiWYsKy3mZlCWR5wDrntsLQp3KGKEtopE1kTUApxLgHGGmXBY
         LlEIn8Y8vkZ7+ZX9NnYJ/dpc+27S1gfU4o5pp/Llj3JiYr3hlZUjtielU2qJnv6zfr3+
         6ioWNvdlFBefgKfgEmCQzcuOOMTAT3Q2BXBZMFyGjkWUBT4tNpOltJ728elZyeeIyGPV
         igug==
X-Gm-Message-State: AOJu0Yz5GG4Id7O3MEN7YZlSlGc6Vl28VIpO4mb2tgxkexegKTBeYe/y
	oD7L2mV3pyQ0QnX5+X606pCTk8vgtKnmY3A66M2NKP0qDBodpWCTbk4sSZl6X7o=
X-Gm-Gg: ASbGncv1sK1V1iEVhAL/11oJbGcZ4toWfdcWjboKLhCEMUynJoHro3G6BbF+M1uy4J/
	7OoXujTxVB4iDINBZLUYpaczFDUr6n19Vjp4+4msXeid5xM3DXgC0kVMGErFMhEn4eSD9O1N1GD
	s6SxLxKFp8aPth5hbQzJQx+FBc4Jpr49Lj7J294YI9uwLVxQ1PDd8tCD2+K/qCix0Aa7vZ+YD3F
	lKv9d3xAeL+G2IseHMrB3LixcvKiTbONQjpr7hpljZccE2GD2BGK2vm8RT8rbR0DwWTknSWVnr4
	HSeUEMyv5YyZaDo/cCKsU6Osw4LpLJx9CFt4FbkLxG7r+T9544BWGFzk5CfZHq0Y5e06Vj6Pv0j
	G6S/bHNbpn1Fy16J2
X-Google-Smtp-Source: AGHT+IE9P4qgwu5p2IKwFFxtfG85haBpZ32ZVKIWrQmygty8uYjc9i9PWu52iScd4Kb2tx6RttUdPg==
X-Received: by 2002:a05:6214:27c9:b0:6e8:f470:2b0d with SMTP id 6a1803df08f44-6eaeaa52367mr268883616d6.19.1742250852363;
        Mon, 17 Mar 2025 15:34:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade237957sm59682036d6.42.2025.03.17.15.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:34:12 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:34:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/3] Add a static analysis job to prevent assertions
 with side effects
Message-ID: <Z9ijYliQPX7PI/0h@nand.local>
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
 <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>

On Sun, Mar 16, 2025 at 06:41:59AM +0000, Elijah Newren via GitGitGadget wrote:
> Elijah Newren (3):
>   git-compat-util: introduce BUG_IF_NOT() macro
>   ci: add build checking for side-effects in assert() calls
>   treewide: replace assert() with BUG_IF_NOT() in special cases

Nice, this version looks great to me. I left a couple of notes
throughout, but they range from "could be done later" to idle
commentary. Thanks for working on this, and I'm sorry to have sent you
down such a rabbit hole ;-).

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
