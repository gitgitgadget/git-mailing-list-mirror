Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E879E1
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581748; cv=none; b=RJNMiv0pKjbXkuovFd/GzoVkwODsUyASadW1Os8EXGjr4pk0ilBw+Dfyux6lVCVfQCpg4TVDFkDd/iRelkE4unB5gm78YbnjIDB2FZRd3LzO8pZK/kUuRmkRtFIOqSBTMVkUAGKPmLPnmiLxyWo76Unu7950Dbz6qVUlatMkrg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581748; c=relaxed/simple;
	bh=z5z8oFP4WazB39vDoe3uOM4ZP4MBJqnn/zbQqITGcHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5jb8YXfJ28ijJ7jNoflNVCUk2mBfOQnwzhtqa3+nWNhbhlJBtkKfDhIDhbUHWXPKh+RTMgoaYyCxD65GmHbV15UzrDPSa1Z86Si4T5hh5rcWpLCHhpPxenrAhPxmZv+R2rDokHN9ehnMkeo0XCJflqQl1Hee0ywNTjSICJIRAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=S4LBq1bs; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="S4LBq1bs"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476b4c9faa2so90539311cf.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746581746; x=1747186546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5z8oFP4WazB39vDoe3uOM4ZP4MBJqnn/zbQqITGcHY=;
        b=S4LBq1bsRW8xOL4rV4+yPskd2lFADmwPHm9huxkEavRBSlm0zWfXSEgw0m1mSODHbZ
         DVAZ7W9SCbrb3Jti7umu3wKyyhivG0h7G2Sfm/pEtt9er58+k0FoL1tz8wK1mRkIixg+
         pP04buEJ94Cp/S5rUI3Z+Cm4fPzNgQs+lwT8vLb6ZLElObtE0mqU55P8B+mjiICXuNas
         ZjjpyMtYsmdKIEuI7bBqdHTCuiN8j1AOl3W3IamF+wmStBWsJe2XZeQoxH0iV6MS1es+
         woh1HN4QhDSnjDfB7EIpsLBYPPxfz+CJ+kdVqZIl9mlwFcIFm9suE6qaBTQI4AyELY97
         wRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746581746; x=1747186546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5z8oFP4WazB39vDoe3uOM4ZP4MBJqnn/zbQqITGcHY=;
        b=LnxaIscfDyi7h6f0dh50ck6GWnjwexV5eiM388/R9WPl7CPGx0XQ0lmhNa+QATdSMo
         G+3p6LVfSsIUoYH8wla9vRPFwc31+5X2JEHKcNpW77UY9T6QhpZwrURbHGIPjNaIIX8R
         wo1b96Dpy8nh4pmIiNi/aGFC5d3aGwmAzsBS2rTT/f72yoiWyzxE7Ns97S0QSLcucp0h
         DU6IbemDmS7Y4g4FDg3F/tXwljq7OS4LEP1tirvU99ZhvytvskGs8BgiH4K0Dqw6INRR
         MEIxFY2JBgkE4l3Yw1g/agTLTA/54EuNRbuuZQjBTQSIKXaSuNWIjR15OaaFDVQV4rMl
         fQrw==
X-Forwarded-Encrypted: i=1; AJvYcCU7aLI/K4XT9C8EqnaudRPNb6Xp1ciG6eQvAUo3NSG1nMVj+ELUpQ9cekgyzBgqUCsJ6fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVzPZk3KuTR/b6zHdY9aG2VZKyUkHRNdqSnG4mBPXUk/Hb719x
	UPWFBkuNJLyPXdjttike2EDvP2XPQPb4z9RruRXY6lWyswAzVJIYuElTMDmZRacf4Z3okdiuqd2
	Z
X-Gm-Gg: ASbGncs86Io3QpSBqfJF0/7SWdMznt9+AODtDZbzikfk2ap8ZPJQDSaBPHzlTStpNxD
	YKk9YUUt3lnOZt4u5MGw8FNa4JT876GmseAcZhFArAlI7dyoqU8uI0wbEMVD4p3Mer2v4hJ7EWB
	NioWAjFi6+6XxHnDFO6VrRj1AkPef/HJqiHNftJPffyqKTh5jYAUkkhPZYJY089sbpAQGonA21h
	Yuzm1o9dl7RiI8xlTa4s+pfwLqF6E1TQsA0TCqNMr6LBhYe8bJ1Z38iyIP3LQncSnuEYCE8x7Uw
	5ISHTps9FG9ohA2DHQ8I9iBQsQO9xcnbA5xPgj4MCgqf2a03iRPQWlDuq1T8UlKHgYE2QHDtaFL
	in54Lo2IE1jxE
X-Google-Smtp-Source: AGHT+IGwaG+JJ5NXjkkq8D1PgpmdrmIpR/vsRRfXfGZLT+E53i37Lbe/GTr2NNMS8mYXThM6bEMXWw==
X-Received: by 2002:ac8:5ac9:0:b0:476:850a:5b34 with SMTP id d75a77b69052e-492265ecaacmr22042241cf.30.1746581745865;
        Tue, 06 May 2025 18:35:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-49220f82147sm6000301cf.13.2025.05.06.18.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 18:35:45 -0700 (PDT)
Date: Tue, 6 May 2025 21:35:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 00/13] PATH WALK II: Add --path-walk option to 'git
 pack-objects'
Message-ID: <aBq48Dog53bn5bJb@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <xmqqbjsau2nl.fsf@gitster.g>
 <aBVLC57bMJKjygyi@nand.local>
 <aBVY3u58R23bI/Uo@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBVY3u58R23bI/Uo@nand.local>

On Fri, May 02, 2025 at 07:44:30PM -0400, Taylor Blau wrote:
> OK, I was able to get through the first 8 or so patches in the series,
> and left a handful of comments throughout. I'm running out of time ATM
> to finish reviewing, but I should be able to pick it up next Tuesday (I
> am out of office on Monday).

All set, and thanks again to Stolee for their patience. I think I got
through everything I wanted to, and I think in total there is enough to
make a reroll worthwhile here.

Thanks,
Taylor
