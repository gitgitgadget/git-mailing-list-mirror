Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9114014A0
	for <git@vger.kernel.org>; Fri, 22 May 2026 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467827; cv=none; b=IkNDv+iy3cXT9YIpN/vfksb4zUP6CNEgCV6UKmiTBiWfz6lrFKsErFRxa5vGROVTGhA3Y/w2Pc2Qkf74DAa/BwjLQzHUNKF/TDOP3lueDS+SP7kBQTWp//BgazNA947rpVZtSbKTEI+xrbVPWbaOjQDrMsNVZNomXbfBa6MBOvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467827; c=relaxed/simple;
	bh=0d290nwWWcJRzs6lIVs4Ig8I0NR6T1mqY9zntra+a3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLeGWx+RTuUEsh/QIXSbfL5uh0QadnaJSFA7Ppf3vlaDMa/hZBe0VKV5Uzx+SkevboubC3/iKQbPwvqAt4C9mN4wNOMTtjQsmevCl1vJFDdLmsQW/0B5qj14GOn4skGA1lTD/BEPuxEmIWmbmJA9ap/b2OvAROPcHtc05eSh3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GFybE/9r; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GFybE/9r"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7cd35604a95so68385637b3.1
        for <git@vger.kernel.org>; Fri, 22 May 2026 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779467825; x=1780072625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0d290nwWWcJRzs6lIVs4Ig8I0NR6T1mqY9zntra+a3s=;
        b=GFybE/9rgu7/s2EXfDNOqyv9uCXDZh8Sgr8gP4VnSM3EMt/4erxoSXYB9ja5T4vXQb
         +DGWuji0avY4OorXk9L2OKOXEX8gy5Lcd/zZF4Q90kPnq3cCItNAY7kImi8KcRq2CWzn
         jkDSUp+mTGDqgY/3AmBGHqVTmkVYX5qdpyy06NmberekjgFi10a5QMBjMleXbhYgDSxZ
         NmluC7h+zaW9JBpRBW1FB7NiOr/yrOK1hRH6b3c61omBuOU1bQ0B+vdaXe3IQr92/sbD
         xI3bbaLDhWRJjAkOWa3nSYzD8tw/xcIXdiejk/fWbTXWQfxHSZkbQ733dANmK9ufrDj5
         8lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779467825; x=1780072625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0d290nwWWcJRzs6lIVs4Ig8I0NR6T1mqY9zntra+a3s=;
        b=lLAoQ+VILjw9QRqkMrFDZsnW0KePtYq9C74zpSdYnmdxJzu5QD7j3EZjmp8FMjg2iW
         HZ7VbQpoIX3HGXYKTAgHoR69DPVwL3hz83A/3jZGoiw5z0ghwfizG3HPwZg2pfFfTbOd
         KVwfOdXBJkNAVg/GolE6ll7Evy8XUVK/ANfPMfYslFS5cHGoo6jtmfUGZVNNz7yDYAbC
         ixQbeNdbG4XF8X2JZMXUXBt4Te1le/FHB6C+2dqz8UwujcwDoJ8Z9ZrM3PBfaXhYKfmz
         2KlI9f2RAjHS9BOZWkmtM6618qSx3D76EtPhaZZvmUzyJXhnsiIDgDz6T+OyyhIP1iaN
         3yOg==
X-Forwarded-Encrypted: i=1; AFNElJ+JkrOzhEtuP3FsrQvQCa1cYG20vd/oF0A6jGSg/u4f6LR5Ihs2VSqeOYUtcL16gHjrUJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdcf4iaKj+rAj+2wzWv0z/TxRH/z3e6/unyeK/z5wglPn5ho0d
	43M9BRzFqxIZaXCmHFJFDMEJfYdFD+K/5eUXyGiARXj02uEO5zB6JLK8O0cekczhFBA=
X-Gm-Gg: Acq92OEXGOnl26XRIr0X6fnr4Ha5RR6m5LAf2g5UvhpRTykewzwT0gBhZw4MTKk/Qhk
	jWtqMeWQsyPVz8ZLiTNxYq+bzIUCLNMu6d2QzoOGnZVBBwVZox7d5+FoClUKY1vUpyMye6l4dq8
	TDtAmDwBG5iZ0c+grg2CwgQKa04lomd12O22HjWc7/EvxIkqk1LqWEjsBBqByyyQjO+b2Kzvz+w
	OaZI4hqPQuOmlHFX/E+rzxXtNrR7FVOKmyRKPc2ekc/4MNXGgPNLobOtfj/MRtXQi0NX/tnKyBK
	pSOFufYrlnrGTKDUZNqt7a8Lm395xrIvDfxO39mDg42AfD6yJwRM9L+ZgIdOsvQ5M8uBue6afzS
	FgPQlKmKtCatf3vcB3pv989vJJJc9IjhBPCbrtn++rmeD470iYmRIeCIkTUMBjj8oBjOxwOdIek
	YNMvY54c0Ekh/AqQZpqGFRRjDkK9C4aebMpb8JTEs0xfudQXU8/J/tQy/F0GH54SsGEmMXU//Tq
	vuYEodLXn9hhaYr4qBmPUJBRTElvBKHLXySRhfLbgcC6DCHY/W6ofsQhvM5afuhWBU2dacxJ4VB
	kQYbDeC6VmN3Kw4z+1UnEEn8Ngc=
X-Received: by 2002:a05:690c:64c7:b0:7cf:eae6:7ea0 with SMTP id 00721157ae682-7d3574262aemr34834567b3.12.1779467824930;
        Fri, 22 May 2026 09:37:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d3873d080esm10528877b3.0.2026.05.22.09.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 09:37:04 -0700 (PDT)
Date: Fri, 22 May 2026 12:37:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im
Subject: Re: [PATCH v4 00/13] pack-objects: integrate --path-walk and some
 --filter options
Message-ID: <ahCGL+AsIaR+63Pr@nand.local>
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
 <agz3/ZxZZHBKofR9@nand.local>
 <4d7a75e9-8260-4e33-a786-72e0aa3026ae@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d7a75e9-8260-4e33-a786-72e0aa3026ae@gmail.com>

On Thu, May 21, 2026 at 07:01:33PM -0400, Derrick Stolee wrote:
> > I'm curious what your thoughts are there. I think barring that things
> > are near-complete here, though I did note one issue with the t/perf
> > changes (that is my fault for having a bad suggestion on the earlier
> > round).
>
> I like the suggested change to t/perf but I don't share your concerns
> around the '/' character in the path (I go deeper into why in the
> thread).

Sounds good. I think a minor re-roll for that would be good, but I
better understand your viewpoint around the '/' leading character now,
so I think other than that we're good to go from my perspective.

Thanks,
Taylor
