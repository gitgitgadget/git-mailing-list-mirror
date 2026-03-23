Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7354370D68
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774255748; cv=none; b=occNc8q40FnEDYKlB9lMwB0YDv8G0hQ52XYt3OzZfZVZCxkoeCc1ijoeKAmYbzeMRDE6wtqAmelMODUc9pzbSCSoGMS0VfDjZtchBEHvTIpShLgL9qKglMVjTrO0CjhnxtBHGXa6ES+/oOHy/P/rolbXIkFGejjJZvzOybJt6BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774255748; c=relaxed/simple;
	bh=1aXf2wTUKaM2pk7iQgVcHPVtj9FjtkOryw43KtTcog0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4H+GK5ysS7r4qLeHMh5lzhA85joTdU/9yeIilgVViE5ZFnQcgjMro9SGKzCEVdXtbfSfkjD9+fg1hZ0j77nXkeENO7U9eHf4Ak4GMm23dtyY1fVihI3pk4jxWVi0cadjZ8B6PKaFCcQ8BIWgeDdfsJ7/Eh4ZfXMisVcWftPllY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEDjjbKu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEDjjbKu"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b07069e2efso23611055ad.3
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774255747; x=1774860547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+KXUSwXQa4MHIWrG+t2yo0nMIg8sHH2pzR0G/HX24Ls=;
        b=AEDjjbKuqGWH2fWh8mxTxDcrJB9jwW9cN2UHE9K4/h0JCUbqxBJcrYNAv8PUbUkB5O
         iSq/fCMy7DKTCo/nWnEHVZCYzyBCoHFrSdc5n8lm8qlAxj8IrnB6zGr0hWCTbJfkq9T4
         /n+Ex1WYlvRhMJR+zN/Utk1LJ1VgeMb8sJNp7eMZPsTrt1D4wURG4Rabdg45OtP1ls+d
         uN7pztQxE06TzaxG7E/THlAK9/2qNHylzTyi6KXguzkFby5WAIqlD+od/bjkri1hxpsu
         IWWPzlnHAzsepH7IUW5gV+J984/Kb4I+VviJVlc33seqbK4zQUoEMRW0dQ9GAjKDdq6N
         OCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774255747; x=1774860547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KXUSwXQa4MHIWrG+t2yo0nMIg8sHH2pzR0G/HX24Ls=;
        b=p4LcgxgsAPg9expAl0oACqngzFqmF9smAZjlGmAQyHD48PBq+XFuX2IFWCyomo2DjO
         /r0h/EMl20ek9lgir9O1xBw814rmg3536WlW9NqXlcMWFLgC1h1V50j4wsL36vmRd0p7
         +jcW/sFWR9JJy1/LQj9KIcO0m3jXBbVHbKlzZwbcEpkBMLfGtijVxr8tGzw+RbnAwcek
         OAnh/UjuNZJ4nZnlWheEBWaHrI4OMCF4NmSaBqWj7r8Akl47NYoS6xINSeKkI1WQV/V2
         p9HR13h1R/J4Ru4RhO+UL9/eBns5aEoGtY7y9ohM4SEfht96CpzfA5EXtNxxiNN7tqRO
         8lyQ==
X-Gm-Message-State: AOJu0YxHU4CoqUzY3eV8jNqSTGQPQgq7PVAV3ekeHkwOYP4Q7AeinWy7
	xKvLQRSoR408l1e1yea66VOBTQj68IC846/EgzU5oQBdyvaA330N+pldH0fT5eDrE30=
X-Gm-Gg: ATEYQzxXhaqtaBskw/fnQ6/YuDqfoWlBSsaGAAwRiIA4W0SI1A7dRlxxzi8b0sg4F4m
	0YdfU4X3wtxSMbIsvpOVioIptVMfyJFGgPfgP3jPyT4aA2++tBueclQNkiyJHZwff8jREA5bdbv
	1Ddac22eNwyVnXVhhZo2aZe0KTYPxeBs7fZejouY3gyT/B0SvgGAwa6Of7bZLK76JMIBWJZaM2z
	aV2cHfarbZjNG+yRl0FRMupB/vEtYGBW7OwIb60rWcWddGhPKrY1ZhGYPx0h58aUthjois8nDGl
	RBm0s0bzD1Zkdx2ZmqODdiyTyIkOHcL/WmiMw27+a1liv1aD8g0FPbswgrMj3/oR73SWuJXraR3
	69qxHQmpkBOlT1KMhAeBEqt9dwR2o1vq3o4L7Z/u84v6WNCzZjkVzOwRBY+RERPGmmyHIvGcSNY
	EHyyUApvTDCG5JA3e3O82A9/CH17FjOpPT68Dhn9YDrMA6DJ7hbb2IGxEbLEPCukimqdVVN58Mt
	fzL73gqTfPqOSvaUeUb/iaAC83+GIohhNq1X8J6eqURrtK496nToIY=
X-Received: by 2002:a17:903:2f87:b0:2b0:7ca0:3fe4 with SMTP id d9443c01a7336-2b0827dd702mr103808125ad.43.1774255746831;
        Mon, 23 Mar 2026 01:49:06 -0700 (PDT)
Received: from ThinkPad-E14-Gen-6 ([220.158.168.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08368ea1bsm124208605ad.68.2026.03.23.01.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:49:06 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:18:58 +0530
From: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [QUESTION] Improving disk space recovery for partial clones
 (GSoC 2026)
Message-ID: <acD-esOCTH3PpK9y@ThinkPad-E14-Gen-6>
References: <aa65h6Z_TrpJbmkj@ThinkPad-E14-Gen-6>
 <CAP8UFD3sicsPd903FU8bsj2B_4Q1DE1xB+--OxryY_jhL=sHdw@mail.gmail.com>
 <aa7XkqhcG6Kb6IhN@ThinkPad-E14-Gen-6>
 <CAP8UFD2iM-z7F_FeDkP5v=1OAJhS2AcFsgPnicvHNFMUcmxbpQ@mail.gmail.com>
 <aa8VWlv7dosrrRwv@ThinkPad-E14-Gen-6>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa8VWlv7dosrrRwv@ThinkPad-E14-Gen-6>

On Tue, Mar 10, 2026 at 12:15:46AM +0530, Yuvraj Singh Chauhan wrote:
> I have been studying the different commands and how they work, I will put together
> my understanding in a pros and cons list for each command and send it asap.
> 
> Also the contributor application period starts March 16 and ends on the March 31.
> Can I complete my proposal for community review in between that period as well? or
> should I rush to write a draft version before that.
> 
> sincerely,
> Yuvraj

After some studying here the four options for placement:

Option A: git backfill --evict
Remark: 'backfill' semantically means to fill in what is missing. Adding removal semantics creates confusion. Project idea has also signalled backfill is unlikely to be the right location. The traversal logic for eviction differs enough from backfill's that there wont be a well structured shared code.

Option B: git gc / git repack
Remark: gc is already complex and runs automatically. Stolee's concern, that background tools like VS Code running git blame will immediately re-download evicted blobs, which argues directly against automatic eviction. A user who runs git gc -a does not expect silent network activity.

Option C: git maintenance task
Remark: maintenance can be a long-term home for scheduled eviction, but only after the core eviction logic is stable. An idle-detection heuristic (not yet designed) would be needed before automatic eviction is safe.

Option D: git evict (standalone command)
Remark: User-driven invocation is the approach that safely addresses Stolee's re-download concern. When the user explicitly runs git evict, they have context about what they are about to lose. No background tool can trigger git evict accidentally. This placement also avoids semantic confusion and creates a clean audit surface for the community to review.

Please review so that I can create the proposed plan accordingly

sincerely,
Yuvraj Singh Chauhan
