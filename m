Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949EC2EB1D
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748933675; cv=none; b=fA0Vw0mB4zp4qmvTXefO0WBAtWlVZVQ/3bABdKCxhcS7Fwm1g9FyUh2XikgGsztkctEy6l/mz1yy+3z6AEFbL9e2R3dCodVW28Gv0N/RoJYPFxUT7UNWbrqA9gHRj/xrApWFc+S7K2gYE7M/v4q3WpAq00GzR9mNecRmnk4mT1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748933675; c=relaxed/simple;
	bh=A1sixIF9wGCntNVBQqhFaiBS70mN3AniZaYJj6xGi0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9F0B5/N6CmWP7TcC7hEJ6mcb/mR8q/hurb7hMRKik1m4V0fmuJR5BdYv/s05sv8SGyhK3KfriAxinnaal0YFaPB0hvhQEn08ZEc31im20mXZmRabuQCpqHyhALgW/I5vKXM7AzaT/NW9bCfJ/c8u7TTKK+AzG5YZCsq8Z8PdwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=cE7cpxyt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="cE7cpxyt"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2347012f81fso65181765ad.2
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 23:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1748933673; x=1749538473; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OB7iczxD9rYDkixlFc98svOD7GVpj/Zns1oP9YZkpHs=;
        b=cE7cpxyt/lFPlQ9OFciFK1sPD9h3eatSgDQBFkhglQhz9HGctx3e36hRqemy6BnbSl
         XGJG24KHs7MqcwyMzUqM2xvO0h+gqTSTep8gF5U1OZLm64m64vyDO2GqNA1DMUo7ojWE
         NZiGttUpodIilTXMA3wUoGlcS4GUKuNZf9Ck8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748933673; x=1749538473;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OB7iczxD9rYDkixlFc98svOD7GVpj/Zns1oP9YZkpHs=;
        b=kt5jEtIjd0kh4Y56Kk40fvcfkacoflwAeXX9N4wDpFDlizfzC5Lt2CafBNK7bRkcea
         Z0G8nONLcAlIyLwkqxtkLp22jFeZpkWFnVB21BEDMQllQhziBhSfQ/FxfeOiu6JfTUCj
         0ytBs4uFpqMCDYeFwXBHOiRtIx7Og84WWVgGJa+lJSBJN8EUFyJ3H6SLpyaWiyKZVGby
         kZ2lpJGppmMQ/wL99u5IwKfuApDdaIA3zwbx3RdVxoXcdHU4Z2arvUqd2tFDuy1OVINw
         FW79kYBT55/ldLRlxLdRobP3TAbY4aQql631DfRhoD79S2M90su7cjY5pVDd8dKl2ulP
         Gxjw==
X-Forwarded-Encrypted: i=1; AJvYcCUvN8PxboawGdW7KQjOzrP5h6BN6UkZg8bRLP7IUYaFZJ9Bz/9bq+ptHGt0Aqugch17mtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVzkP4u+5GBB6RUsAN0H0xP4Ooy/TPE1GfUYR69r+AmUbL6BNg
	MtHL7vca7t29WzpRzuQgjQoC/EhofGzFKnnqI3JnTRdDJd1eDTBKWgV++tQ6Tgi307U=
X-Gm-Gg: ASbGnct2sFDDHNHVgTq+F7EeW0kfio+h0VENFR4YCxiYE0zMWcu0QwQFj83DLSh2aEJ
	PCdS9Jlx7ttzculrdH1Dm1DLwe4uThAz4N14xoNfkUsB7C8lGhVuZjXsPgASowJ9Eh9sR4aYC9J
	eXLxXlsSY/dwCgI+0rhW4Ggdh2v0SLgAzVyTNSV81AoKcxrdsfMyTKA2Af48V7jOag3oWj5sOVv
	GFgwgBhKqgMkf0Jf6/NUaSLJ3fmYWgTzgmU/0Sv9IyMpMrLmk5Wa/b7wzdeBb7ZjdLYQamZAbCS
	79uqOw7UFOnZUMkf2TCBkA5rXrv3uUi46Unz77NUbrsKOs6yFPsHKOpN
X-Google-Smtp-Source: AGHT+IHQXk4A7DnSy0HoTXZfhkfIwhwQ2M7GiZu2ei1jPvj7sLKS8HbwYyeJ35HCeTx+Lp3txdnKtQ==
X-Received: by 2002:a17:902:fd0f:b0:235:ca87:37ae with SMTP id d9443c01a7336-235ca873a5fmr17575775ad.41.1748933672723;
        Mon, 02 Jun 2025 23:54:32 -0700 (PDT)
Received: from localhost ([63.214.5.91])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2354fd632d7sm52363825ad.130.2025.06.02.23.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 23:54:32 -0700 (PDT)
Date: Mon, 2 Jun 2025 23:54:31 -0700
From: Chris Down <chris@chrisdown.name>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] commit: Add commit.signoff configuration option
Message-ID: <aD6cJxFXdGfN2XGc@chrisdown.name>
References: <aCM5JY25NVPgyYRP@chrisdown.name>
 <CALnO6CBdhYFsDN=HPo9HbKeoZH7bb=xVVXUCK7nUdadLg-U_Pw@mail.gmail.com>
 <aCTI7VjK5QMht3ws@chrisdown.name>
 <xmqqy0uy4thk.fsf@gitster.g>
 <aCXqqj6gKc7-fjoF@chrisdown.name>
 <xmqqldqwya5p.fsf@gitster.g>
 <aCdT-UQtaaTQ8gyD@chrisdown.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aCdT-UQtaaTQ8gyD@chrisdown.name>
User-Agent: Mutt/2.2.14 (516568dc) (2025-02-20)

Hi Junio,

I wanted to follow up on the point around repository specificity, since that 
seems pretty key to the discussion here.

Looking at public dotfiles, many users already work around this with global 
shell aliases for "commit --signoff". This creates the exact problem (I 
believe?) you're concerned about: casual, low intent signoffs without 
deliberate per-repository intent to certify anything.

A repository specific commit.signoff would be more precise than the current 
workarounds, since it would require explicit configuration per repository 
rather than blanket global behavior or muscle memory.

Would only allowing using this flag in a repository context (and not the global 
git config) allay your concerns?

Thanks,

Chris
