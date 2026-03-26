Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AFF4369A
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 21:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774561619; cv=none; b=ngyepDRsIoxaJbPlsHldwkVesDyc2LZwItQr/SfqT+5CGHazgogy0KG3iQDFL2Gn217bgWkbHH+qWgnLMVVoLIeqzBR6ooNMpZIe8aQmbVEmlGgmDlpA4bYqYAdxMgkpo+JfAxYStkM/RVbIjo7SKg1OxyVpP5qUIqxni/aeqUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774561619; c=relaxed/simple;
	bh=JNrFSEg/v8k9uMH/lsk9WodQmU2RQ3OtkrddC0wbCuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghpONrpbKZZ+fMzUXVI5NoEAPA9aOI9vmHQIh4iwTjTnCNfv/Ha4rJsMULlz76xUrvxCEqpVDR0q3rl970T624Qe8HBHfnt9Uvt0o6XODrgkn/M26+8881HCubHGIvnQJ+KZNajpkzYCF7AEjGCqMMELvxzx1PBX49iDhlHdc4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=LwmhY2s1; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="LwmhY2s1"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79853c0f5b9so16365497b3.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 14:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774561616; x=1775166416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5A3GPUXsurAhgoKcAbdUWkzNhIpQzGyIy/+kbCFxJKU=;
        b=LwmhY2s1UtzUJ+KAobQ9lg/TANsD9uu6krnkpbAdlGOFeP//dGk9Ia3ORdft/susWi
         LBYFtgIdGxs7f2ssau4/bhmYY4jR+wa9/zO9NQb89da0ZAz5O+z3c943HJBfoSNWfT81
         zc5PQ/gvZGQHMNj9LsvgMA8lFiL+DxRriSd8oKvUSl85w7R2OF/hp5/YML+OCLx9LM/L
         +kSS7OQE9hRoagOxI4M0JsUoAIaakqcDSiWUjvXIHrJfpJw0I4JvKTD5CEPtm7CG5r65
         dh3yWkhxa84wX1zxDPTYr1Ota39TVmGph9vm9Cy/nIhSzW9xntp9nOyCer/X+f/HL8YA
         r0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774561616; x=1775166416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5A3GPUXsurAhgoKcAbdUWkzNhIpQzGyIy/+kbCFxJKU=;
        b=Eu3dsNXjptf2BCpHA//WOdGDnZ4m+Qz5oTZBP2IxdLgC/lujacEgTntoAL2JTZN/kW
         s203Pn858N7nQlrPfxYeUP+FHD8HN+HNINTGbRS6BvVTn7iBQOktjqO6Yrp9eEIUqKOP
         0TR1OwYMlGjVWF10onuR6TrRSsEG0Y2faNDg0VO11O89IIJFzFINNSjeT+uzr7Xhw8ri
         ZwqjFp9wqoWbj8zZly1KiwNA5FqJ8jwLU2saiNwINS8gQ7C15RllnEG8LEGwzDm/amBF
         TXuxL8HYp31xA3xs/VBwPwpio+zAHa9r6TuEZrdrxgVmibGTikZZ+e57Gs7A3wQNl9I2
         VbDQ==
X-Gm-Message-State: AOJu0YzkdAoh+/YAR1ESiouqAkQ5mtojDC7bCILUsPZX3eEp8kpTGcSj
	BvAr7wVWNSF0TFS9/DbIeaicnWPnZU2M8YuaZM/jR7WftGhHCpoI7FF/PVUsctEeDhs=
X-Gm-Gg: ATEYQzz5ixkmBmMQccbDiVTPgP5Xi6MWFTWc6Sk6wYIsVwO7NQsO4NL1eDAvL0U34ja
	YUCXvIYje5dN55lNwiGAIRyWhaiabTu/bvzpqgHLYjww15JsHvzoAdt5WA9cmwCpnEkhTcf/Q8m
	8gWj7JFLBYZ/FqdQlIUo+W9jS8LttLUVdEbHAa2w2nd4eHZvftvNPgmblcPh3s4NXeSpLhLnALK
	79rSffG3rW0vEDFZVnHrD1W37pOLj0t3ME8tF7BA25ifQuAPdWCGkyWuAuq9jBHzhRcuV2iMN3Q
	65O121oAJvuNpmquYF7OlAGCNQtNDozS5Ws5NR0jkgWbDFyUk+plH1IYfASh88FbXikcQcD0K3X
	/jS796QqGrR/+Yg19JOVXeI1deHCF3dxUwEO29WFDYyJeYjAdzGDib0YWBNF56viOFug0+Z2Y0m
	NMrKDAtz53R8Xv6HK03gf++gQoNyGzpo6YemR/tt7Gj++T2uLpNAjTyTkAJWZzZpH+Z5kuoPx+y
	aUOweqYJyrozMHaIIwurndt7SltIg==
X-Received: by 2002:a05:690c:6d88:b0:79a:4419:719f with SMTP id 00721157ae682-79acf65eb94mr98948077b3.36.1774561616523;
        Thu, 26 Mar 2026 14:46:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64ef58ca09csm2030817d50.5.2026.03.26.14.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 14:46:56 -0700 (PDT)
Date: Thu, 26 Mar 2026 17:46:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/5] pack-objects: handle excluded-but-open packs via
 `--stdin-packs=follow`
Message-ID: <acWpT2POwnfI2Yzn@nand.local>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774482700.git.me@ttaylorr.com>
 <4511ea3d-35b0-4a62-8dac-250a86c0e0f4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4511ea3d-35b0-4a62-8dac-250a86c0e0f4@gmail.com>

On Thu, Mar 26, 2026 at 04:51:09PM -0400, Derrick Stolee wrote:
> Sorry I didn't get to v1 in time. This was an interesting series
> and fixes a bug well. My only quibbles are about some minor code
> style things, but I do hope you'll consider them. I struggled to
> read a few things and the changes I recommend seemed to make the
> logic more obvious.

Thanks for reviewing! The two main comments I picked up from you were:

 * whether or not the new enum should be non-anonymous
 * changing how we lookup entries in the strmap when processing input

On the latter of those two, I think that the suggestion you made would
break one of the test cases around handling the same pack being
specified multiple times with different flags[^1], so I opted to keep
the current logic there.

On the former, I don't feel strongly either way. If you do, I'm happy to
make that change, but if not I think the series should be good to go
as-is.

Thanks,
Taylor

[^1]: I wish this weren't the case, but this is my fault for not
  forbidding it when I initially wrote this feature.
