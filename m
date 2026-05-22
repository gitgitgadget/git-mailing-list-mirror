Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72937349CE9
	for <git@vger.kernel.org>; Fri, 22 May 2026 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467774; cv=none; b=neVQnIQU8HTpVYB8BogvNm7C9x+xNvwsNtQLo1T2uQK8mU3nkAVZqnNRIvbXXoEHENA5/9d0V7u/j8JsoU0E2rYfepFY6VU4SvqfswGwS4wX/xSjbw3graTa8RW0I4J3fCDBjPrPrzcEKO8y67bA9Q7rGYtChsSIEqLOVWjeoEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467774; c=relaxed/simple;
	bh=SGsS0PCl6G2xaqtnqeiRt+iqlZITRKhRy6VZnVbP4xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFG2VRij7UEbKMQASQtNdYj3xDQPtDC8HS0ww9zPKCsH6865Dp2YYzh02ZWq6ghtN4K/kQ1frGXc2jOc9ete2kc2+ZbjASq+3POHwEN0h2K8awRr8yGTzcIp+GlgyJtfFyCjjMR+IFgYe4q04rCpF7uyqJTE5ZdJEeZuJWr3ZGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=k1BL9Tzn; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="k1BL9Tzn"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7cd35604a95so68373117b3.1
        for <git@vger.kernel.org>; Fri, 22 May 2026 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779467772; x=1780072572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SGsS0PCl6G2xaqtnqeiRt+iqlZITRKhRy6VZnVbP4xA=;
        b=k1BL9TznUMSPYtrDVq2W4cSV2Z8kRYMdKFS6ZaaX0zGj/rDyPOAlcdWfYly4Szx/EU
         Gzo6Q7UDr7uQOLyrJvXXfJl27UC1p9eKMxOgHmbY3hGDdLt+j/pm+b6cMoFGwOADpzps
         1TUjRMgjOgzWeSd9TGl84fVbeyMm4WFJ+SUNKdL+28cSp2wY+VoNWRaA/MWFgpxL0JoV
         FIzSoIyvpDMLZ5XDOhJ/VbE+5zht3Wijpu4CyE6tbJeie6Lyxw+/NgM/lazanm0t3y/s
         io38BLw8vHCl3yUTuP0pE6rpk6hvRn/CTBd44GNxKDYVzzeb+RT3AzxUGRC1fpFNS7Tf
         8HIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779467772; x=1780072572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGsS0PCl6G2xaqtnqeiRt+iqlZITRKhRy6VZnVbP4xA=;
        b=kr7Kvoep37IzvVFOGOf8uHqFpSeSnVWioxW9uEQjQMAdZ3Y4Fokf1h6JnEA2GvNEKY
         XOQDjmr0OptyNFdwbdcVDVPaLl4u6Msr1fpiodwW9mlXBvOyCwIM0gavWj2KKRrhsfel
         ol/7kXSiLgT3EI31cGc72RTnbihfNP6dD/crYB9ZnwIi8CC4Mln8UgkZxALaL/hL0FT3
         LD1SX4IkqhlVNSRvgnX2Ttcgv7+WXzsXP/vhYyCnZT1ilhzGlwhM153k46tj0oPZtgup
         yQC/UJ6EQdklacuzaPxCMRb5jYjKivVZSFpM+WfdrWhOe7zmzjV1eVlKWmfjV9DPTgcv
         ZyDg==
X-Forwarded-Encrypted: i=1; AFNElJ+EaYaxHFoikBGAVr49vD2kqFe3KC6nbdRnQnb9khHyoklb9lVMVQgcEGGXVC3kFsBIXxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZq/ptQv1XvwO1wlSoVFOPbWnN5bVH1Y6Bpzs6Od92p2dsElAL
	va4qj189oC9gLevmhJi34hHmf22mDAtuPehhaDL/LTMEnbiKEckEiWD7DA3hpfsxRfg=
X-Gm-Gg: Acq92OFt9Igyo9e0FvkKyLq4045ct/0TeKYPzfGes5Egp+UN6KhhVqHFA+Iip8v+oSe
	1SULcIumiK+0KZ+y8wdoco78jozhB7ZlCY+o/0vk5Vr2Gqqtml+qC8E6rB5EeCZNvQn13h2mM+v
	h7UpPL/oDBoEAS7DIe7DcC9FOeQqNQNShCAqE7QvYm518c9KMcQxQ4ZkLyxgdkOKcBsmU/f576K
	ryol1HgRy56hPp1W0zCI1EZlCQAC9uNVNvIZNcj81qpgoESY2NneiHehnEXebNbP93hY33vHwRQ
	Ciq1CPxwT5QC0VeSBogyyBp/yxz7P+JIwkT0Dntwp7osjNDXro+fu/swniFqjK7mBojRmWXoOLb
	eZxCVtl9Ljf80WMuAzXFj2EQevTsguzRt3ihnOQMlaSW+qhm5pZuMFdiWOiGp3kbsxCHzGYlfy3
	LqnRVr2o8Z2AUZgRe05NeAd8koVVdS1ScwUQQ7/PASzNrNOGkKyD2M/vafRpoSnbpd3vKEuy9km
	m7p5Kg0EAAdTxCV6PNHgHbzCro3y/38HEwi8SgySD0ay6+Z3HScmraPOQPjwrcFRlALorOZB7ZI
	3OQenv6cVhMl2sHxUpB60vsW27I=
X-Received: by 2002:a05:690c:6d82:b0:7d0:79f:3390 with SMTP id 00721157ae682-7d20d50ffc3mr67665387b3.21.1779467772437;
        Fri, 22 May 2026 09:36:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d389e0e9c9sm10573697b3.18.2026.05.22.09.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 09:36:11 -0700 (PDT)
Date: Fri, 22 May 2026 12:36:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im
Subject: Re: [PATCH v4 04/13] path-walk: always emit directly-requested
 objects
Message-ID: <ahCF+PGcJ5pACQDW@nand.local>
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
 <e77c8a6bbc22da3428751f81ff5ee79aa5364237.1778707135.git.gitgitgadget@gmail.com>
 <agzwsxV2KEkkaGPV@nand.local>
 <53d46614-7d9d-49ab-ace7-71367f6d2f40@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53d46614-7d9d-49ab-ace7-71367f6d2f40@gmail.com>

On Thu, May 21, 2026 at 07:00:39PM -0400, Derrick Stolee wrote:
> > Could we instead store this explicitly on the type_and_oid_list, e.g. a
> > "direct" flag? I'm not sure whether that type has the right scope for
> > this information. If not, I wonder if there is another way to store this
> > information, since I worry that future callers may not know about this
> > convention and end up changing the result of the path-walk depending on
> > how they name their paths.
>
> I don't find this as fragile as you do, because these "direct" paths
> _need_ to start with '/' to avoid collisions with other paths that may
> exist _and_ this meaning is internal to the data within the API. Callers
> can't change this data, though they will see the paths themselves in the
> callback function.
>
> And as I mentioned before, this is a memory-efficient storage of this
> indicator bit because it only consumes memory when it is "on" and the
> vast majority of cases where it is "off" it doesn't take any extra
> storage.

Ah, I didn't realize that we added '/' at the beginning to avoid
collisions. This approach makes sense to me!


Thanks,
Taylor
