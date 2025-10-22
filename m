Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6226ED20
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141024; cv=none; b=kCDm9L36jvXPrcoIQnC7xrsUiAtapj9mAGbwEUOCjO3lTp5qnPzqNWb/xmSIy2xjZbXGGYHJe8sWzjKCK9qC+wPG1dz2h6JoB7BB9hNZPevGkD5vQL5OcJhRPzrPXwxoa1sgCR6Xxphz7kzQ/m4k0gvx3kRyyFI0iurE00geSP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141024; c=relaxed/simple;
	bh=1rzKAb9WKCwbqwd2YecnrIXy+HaT/wX3owrbhlPS1GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwMexZNluj8+zEYNTxI5opunuVJG5Ed060ysGMpHzNPAdAXe63kIoSJgjKFaa6ktxT7cmUHAAYcDW9wfp+6YatfvxyH0QE9Xc81Mn4/DKcMiIBKPtYwEl0YVkXQkZQH+RJbhSbheruT2tvo9/zs5qb5Yb5fX2VXkLq5ZV5ZBvCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UijjzO7A; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UijjzO7A"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c2816c0495so3887873a34.3
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761141021; x=1761745821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mAf+JoTMUaFRS0Laj+e+hgSZ/DCRmFkB+c45tN0fgc=;
        b=UijjzO7AB6zVV5ogqnzYtpmbEumtreWu1TqoI2EXChRVTs1aGaihryB97tsy81IjUW
         /PdcGH4LuKifYpEOxagCLWf4WoptqeR/vkfApGbagrj4nfzxomxse+MQNV8GibDvq8VE
         nrIb++Lg5GHEjHuMOfVKPMESeYHfURIDX/v3Ea1SQXcgySBGq/1HkCvSTaWWs0mFSffF
         JH7MNteRo7URrJVUSjXsIqbATZ4CwB4F01Ktd5i56TMHYpWfPv27Hv703c7E5sBBXzMn
         URVNkdNFaKn3Pr5JY+xjtektrhp8PZUYhyzrfDYodpn7jpOdog5V1a9qgt2m3yoR9Bgz
         9tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761141021; x=1761745821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mAf+JoTMUaFRS0Laj+e+hgSZ/DCRmFkB+c45tN0fgc=;
        b=kOf2EBZgjlFG8PhjmTE87ZQgPqAu2MRPmBLtqMmKTdcdUIDA7AD282flOMRepvJUO/
         vx5xBy4IeU+1K52X+0jZNnwNMU7P5a7kRc5lRiZNSlrgIM3gKNsh4HibP+xQU+ZN/i0/
         0unVKGT4E8ohBoXxBf1Y86Xgds7NOocrxQG92aPkTSerRNxIkDAqy97HYOrDEXVK9iLd
         WUOINcLozurPFKDwsNqMRL6nR9eAQWSoaA8QhctSpDdEslmahHF5kA0HuIltnIxN/Q8o
         JFYuTzGGeXb/o7FVerUq9pWs9d1bLCq/ovMcMfy0eRlI79ArEoZI0CDSTWqoekZntGs/
         v8qg==
X-Gm-Message-State: AOJu0YyPvflW9NAqt4ulSIqZqG3W2a5BImqckYlpIUuFZA8pfl5AD1VD
	AIXiPnA+2LHyhzEiKEowVy3inwrm0mfLhaY4n2rZTkciMIOmj+305KC9
X-Gm-Gg: ASbGncvuEF1GIwI0lwvhAsxtSMD2JsuvGXMRdiFymvAu9Hily7ghCiapl+Dm7ZFkymg
	a7SfyPEc5AZ76d3Rr9h221FL4SfEYrezyrL5uFGrO7aJF8Lozex44nLodIfESNcD3juHRKnl9QY
	3Kn+nt0JVUy96kjYYCcG20kg2InNtF+sbAntNoQxZES/QYdpchs0qq2DN6qLHwvZgG2ZrjK2jAS
	J9I9hUNJNcpmvDFmoJ7UOXkNNxfyfw/bPF2u4Nicn7JXg0MQKL4jOLDidnHs+6ChXpUF5VeWJVL
	S7ReyS/5p2clINbGV3JjlvEut+YDjxIzyAatrG2sMiIe0TZ/4jTdmkzF9j2Tw1rcAod6P82sazJ
	rJnCZDwuRkK4xyzVJAsJ33PdH4Ya6pzo791espXpqHUKJhup5MFsoSCCt0TeRp6cWdTeWGWOOYP
	3BbYuV
X-Google-Smtp-Source: AGHT+IGES+5GURlSVVdTv5A2xkMyXYi5iuQpB3rWbCGnBxIAI7q0rJhit13+lPtjSYzxKAd6gF8a9w==
X-Received: by 2002:a05:6830:348b:b0:789:6393:5c52 with SMTP id 46e09a7af769-7c27cb00a06mr12554638a34.13.1761141020979;
        Wed, 22 Oct 2025 06:50:20 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c2884849e5sm4638787a34.0.2025.10.22.06.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:50:20 -0700 (PDT)
Date: Wed, 22 Oct 2025 08:50:17 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com, sunshine@sunshineco.com, 
	gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v6 4/7] builtin/repo: introduce structure subcommand
Message-ID: <xnxnqvnz22n5tognru676vczqseuc2zpyjdkffz4svji7glkw3@loo2xq33wueh>
References: <20251015211213.361797-1-jltobler@gmail.com>
 <20251021182601.2687284-1-jltobler@gmail.com>
 <20251021182601.2687284-5-jltobler@gmail.com>
 <aPhlLbsOFxeOv5KZ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPhlLbsOFxeOv5KZ@pks.im>

On 25/10/22 07:01AM, Patrick Steinhardt wrote:
> On Tue, Oct 21, 2025 at 01:25:58PM -0500, Justin Tobler wrote:
> > +static int count_references(const char *refname,
> > +			    const char *referent UNUSED,
> > +			    const struct object_id *oid UNUSED,
> > +			    int flags UNUSED, void *cb_data)
> 
> Tiniest nit, not worth a reroll: we tend to use these callbacks in
> singular, as you end up doing the thing for one specific entity.

Good to know and makes sense. I'll hold off from sending another version
for now. I can also probably adjust as part of my planned followup
series.

> Other than that this series looks good to me now and is ready to be
> merged from my point of view. Thanks!

Thanks for the review.

-Justin
