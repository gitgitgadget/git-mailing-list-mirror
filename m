Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CE617F37A
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712781900; cv=none; b=BhmCOlbPn5iK5gE/pfqDlH1gS7+aC4aICMMgNHTzi2GyOf8nsZoB2hm3mQoOzWGS0uFfbHK+cJEGxvk6w5+p/badQOh4LS5xop2M9GFh8q3ZB58HrLZlEc2g9suS3ZuzOOQCWNb5b3vj3dmrcTnj17NS6rgp63qoIBBYnCpyMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712781900; c=relaxed/simple;
	bh=IZ12B8ei5TBDkRmiW9R7oHFvuYYvRb6koh0RuvnXAAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+eHYKiyrFkwOdz2fy6qO2PmARE6VbBN4PPg3jQwC7sEtuaq9PfBqfJVEfNchcjoq9K7BEKwT9WZoJpMhrpcKaHJQ6eUE1zoTFBCZvxHKqWTbjiqDMt65Sddrvwoab2E8qqeTkH1Evh4AXqsxZcGEomsFXXY5z7bY+LL4sFdCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVnGNsRB; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVnGNsRB"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2228c4c5ac3so4199958fac.0
        for <git@vger.kernel.org>; Wed, 10 Apr 2024 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712781898; x=1713386698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VS+k8lhFPdmidF8hT7FFUVoV2UKLn+x8HnR2jIWKZCc=;
        b=KVnGNsRBWNiGKY9fWRk5zwmreZSGMXeg+HhUx7w5oTPO+WVBbWtBdLKbHeZuFvrg0l
         Q6Vx45RJovbOOn8zDFL0Sre0fMG+PAu/z52nf9LrV+vZb8Vtrqlu07xE38eMtA3SPCHj
         Rzj/DIM6iFZ7A3nHHsi3be/aWIwqk9EIC/sZZ+HzW9E+7FWel1YbUR5q5WxUJ8xSj8du
         ar2vwZOT4NM4w6hTgOJNsd5GAjxwOcFxmc1flGT4ShA/15aixbGbFtEjE6QGbe7SFY+j
         QFVlyprOmEQYf84ivjx5V5soqiEVsO+GqVQBX+QFWIoMpeQJVuszZsXsjCzXskHhb2zr
         z5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712781898; x=1713386698;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VS+k8lhFPdmidF8hT7FFUVoV2UKLn+x8HnR2jIWKZCc=;
        b=JOSVSK0BsANGGdXNz/tVwCnG3jKDSS0TOTFtGaHWquy/7lyAzq8xrl2n9zc6HTY2ir
         timarkzcQrLsT7c51Yw6zcPAC/UpWBDpGwNlsTGXf17/Xrj10FFVGNKMfrFLf45rYYMf
         6B3RG0kkQQyLGFgUBWiP4SoErqelgYXr2IKVIkMZog8S+p4m12QNFvza67/wy5g0jm0X
         rrN/eWDDSS3poqWXDIjr7/0fHP22oLHEuukJ0LDApgV79P14OoZBJZyJ1E7QlPNragnh
         eeKr1kKTU6uITlT9JR2CIsV1L+mmxys/UZgwmaaxMOw/ejlR6Ya5Nhn8m8RsRsMKv6yg
         CVKg==
X-Gm-Message-State: AOJu0YzD69MHv0t1VhCIsQ8JSVON5J/p5gI5oVzKMvGhpdlk6AbSMAhp
	Bh0WIrj0fL5PUT0Qyeexlfs6h9VDJUkFKnRNHeMzPqWraahfoZRT
X-Google-Smtp-Source: AGHT+IFG93rc6lntNiPjL9o+vfDNE63DnUSwYdZZ1ekiwrk08kbQW7O4krxZQPLENPoc4+V2Of17YA==
X-Received: by 2002:a05:6870:2e07:b0:22e:b3c6:96cf with SMTP id oi7-20020a0568702e0700b0022eb3c696cfmr4145835oab.49.1712781897955;
        Wed, 10 Apr 2024 13:44:57 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id ak11-20020a056871918b00b0022ea736b093sm28334oac.57.2024.04.10.13.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 13:44:57 -0700 (PDT)
Date: Wed, 10 Apr 2024 15:43:58 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Luca Milanesio <luca.milanesio@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 12/12] t0612: add tests to exercise Git/JGit reftable
 compatibility
Message-ID: <t4powjtw4yapbivatafkez5e2ha5gcssintxam47ibkvjlb4le@ob5deeaxpzqr>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Han-Wen Nienhuys <hanwenn@gmail.com>, Josh Steadmon <steadmon@google.com>, 
	Luca Milanesio <luca.milanesio@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
 <160b026e69547739a526fb6276a895904a4d33a8.1712555682.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160b026e69547739a526fb6276a895904a4d33a8.1712555682.git.ps@pks.im>

On 24/04/08 08:47AM, Patrick Steinhardt wrote:
> While the reftable format is a recent introduction in Git, JGit already
> knows to read and write reftables since 2017. Given the complexity of
> the format there is a very real risk of incompatibilities between those
> two implementations, which is something that we really want to avoid.
> 
> Add some basic tests that verify that reftables written by Git and JGit
> can be read by the respective other implementation. For now this test
> suite is rather small, only covering basic functionality. But it serves
> as a good starting point and can be extended over time.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t0612-reftable-jgit-compatibility.sh | 132 +++++++++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100755 t/t0612-reftable-jgit-compatibility.sh
> 
> diff --git a/t/t0612-reftable-jgit-compatibility.sh b/t/t0612-reftable-jgit-compatibility.sh
> new file mode 100755
> index 0000000000..222464e360
> --- /dev/null
> +++ b/t/t0612-reftable-jgit-compatibility.sh
> @@ -0,0 +1,132 @@
> +#!/bin/sh
> +
> +test_description='reftables are compatible with JGit'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +GIT_TEST_DEFAULT_REF_FORMAT=reftable
> +export GIT_TEST_DEFAULT_REF_FORMAT
> +
> +# JGit does not support the 'link' DIRC extension.
> +GIT_TEST_SPLIT_INDEX=0
> +export GIT_TEST_SPLIT_INDEX
> +
> +. ./test-lib.sh
> +
> +if ! test_have_prereq JGIT

Do we want these tests to run in CI? As far as I can tell these tests
would always be skipped.

-Justin

> +then
> +	skip_all='skipping reftable JGit tests'
> +	test_done
> +fi
...
