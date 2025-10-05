Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B4225A2A2
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759671111; cv=none; b=Wal1hXwv1saU7y+rOozQX5Dvcevkwkr9om5oV0Cl3h3elYcxbcdYtcM+qo7f/pjwemd3KyooHUYKNLNPG94txPaw+pERRHvLjezXOOdu2W9kx46ukSwObC3jpvKlimNqATsCxgiWQwvqbp5VxSSbEoUPFvzEinMBbD14mm+RkNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759671111; c=relaxed/simple;
	bh=kjFOgnplf7PAhleacFRYkZhLLn9jl5Lrd7dny8dRCMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LykjydlEWOi7jkGdaPYSSI4vdR0C8PVosmbH1U7mqumNz9vMKdqDZGWwxrXwZIOlXpInkUGjsdwQm5/K24Ztk1WG4v26OojKHTDkx1sFUpwXtmXCDp7WMMv+jAnYZOeMj24cnmDMOT6zfj9luj+m2sV8gysqKQbhvZV4R8fNEhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQX7em20; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQX7em20"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-267f0fe72a1so30464615ad.2
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 06:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759671109; x=1760275909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wAr2ZAQHTAoCFN+u7x82kT7pygQM59v/pLgxM1bppSg=;
        b=AQX7em20sRIwQxaFcAUIflmjY1xFPuzC2N+HYJSxlLv766HeR+cAJX5MPZjnjlJPR6
         WtZ25To/czy+p/ndBB3rUqCkY1d4ccmCaHrR+/LlmARZq5L8ag5lrhPucZlcRUUmtzeo
         w6iqqVouTbr7Z6Gs62fXTQyaHwd6wDVGT/1hVNLVK3aCk1U0YSmKjcEBTbl7hYuaK3hu
         /2uQZMeMlV+tte9R4n4dFK1govCylnxDgT97Ty86k3h7aZsArhCtwwSEvW1N3mu8RR3z
         0Cg2RPgPeMtao2bvDP221AHC4uhGjLo0Nhzcn8I+huAbpsM+XBMi89K6OH37jAeJRWOG
         Sw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759671109; x=1760275909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAr2ZAQHTAoCFN+u7x82kT7pygQM59v/pLgxM1bppSg=;
        b=JQ75AiTMNRm3yDNzS4ufv017CnFsKTAcPZM6omhnRkqYdG0MQz5uyw5Z/yA/yjuwL0
         Rx3KgBQEH23uEo1jjjJpjX255UPFUQZgyba6pmTdj8eeltwR5zTqWLR2yEULImD7EUuI
         Ngh0377O5rL3hsUkln9xBag1Jyv66/4zltQY+RLG/HgJrSDBUNLHOtGLSCJCnzlmzl9o
         EbQWyo1NfhXbFfegwZ+NVuorHtp9oVUX8Yux9cmKPw8xgQ0J9V/z2ZrlWXDrfKVgpNdM
         s038jcMt7xJscVvH4h/wvZvCKIEqZtZYK2OUnUlerJX7uGaUFHgaNc71mta+oCTS2+/3
         vpIQ==
X-Gm-Message-State: AOJu0YwaxCr8xZL0v3feSGtlsJC7hLzSZpideWMeikfeR2skkSa9J+b0
	Kftlqx//fDCIZmo90LrhmgsVQGWhUk4ho75t7oMf9IpvDcwn6jBi3hNXFtWyHQ==
X-Gm-Gg: ASbGncvV4bw1EKRmpxsosorZeMCCAAUPvGqGu7CpCFaJWYr0iIjx7RKiIDCz9lmp21d
	tpM04UTuMHAWUNYrbdlMxESO9Jji7jxfHc1QyLJfg5PwFoY/MYnqGjTf7GVoBe8sD1LR8zjiYdq
	tevZFEWyXhUiBATXIFSOwqsS/Vf6h8jGuhcK3S78A8MjfsQW2+6SyNYKeLnefUxwoA2gPgUcaN4
	v9019YJrRp3ZFINf5hK8xSwHd1FgCvcn2R1iXqugO+MGo95akQ8lybLXglt9Do/mUxoRB8lznjx
	59YNa/LEc5xQZJBIrx8QR8VYT2XJwTCZ5MOA2D+o04hl3zVt7ydShsXbCg+3jFe1xRD727RnM8h
	FwdS06p6Ge3+7V+fECZjICBFYpF1YpwaWaJwzavvx4Q==
X-Google-Smtp-Source: AGHT+IEFB5ZzH5f6atBy4yKvr3Lb+kVa7ttfIBs6a8h934q3ltdCuwF1rDAN1EjCWQM/dnvreis6gQ==
X-Received: by 2002:a17:903:1210:b0:266:64b7:6e38 with SMTP id d9443c01a7336-28e9a6dc994mr102837075ad.46.1759671108916;
        Sun, 05 Oct 2025 06:31:48 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d1ba25asm104069505ad.87.2025.10.05.06.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 06:31:48 -0700 (PDT)
Date: Sun, 5 Oct 2025 21:31:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
Message-ID: <aOJzQ1cnUr3WhTSF@ArchLinux>
References: <aMp8yNFiXDyk2hP4@ArchLinux>
 <aMp9OtXLfRw7dEwA@ArchLinux>
 <aNJW_z-BD1eDttec@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNJW_z-BD1eDttec@pks.im>

On Tue, Sep 23, 2025 at 10:14:55AM +0200, Patrick Steinhardt wrote:
> On Wed, Sep 17, 2025 at 05:19:54PM +0800, shejialuo wrote:
> > We would return negative index to indicate exact match by converting the
> > original positive index to be "-1 - index" in
> > "string_list_find_insert_index", which requires callers to decode this
> > information. This approach has several limitations:
> > 
> > 1. It prevents us from using the full range of size_t, which is
> >    necessary for large string list.
> 
> I guess this is more of a theoretical concern. We probably wouldn't
> handle it well when our list had 2 billion entries anyway.
> 

That's right. From the discussion, I would update the commit message in
the next version.

> > 2. Using int for indices while other parts of the codebase use size_t
> >    creates signed comparison warnings when these values are compared.
> 
> Yup.
> 
> I think that the required juggling around negative indices is another
> factor here. It's somewhat weird, and while existing callers all handle
> this correct I think that it makes for a suboptimal interface.
> 

That's right, I would improve this in the next version.

Thanks,
Jialuo
