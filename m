Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67DB43B487
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019903; cv=pass; b=WPH1BT4+ThboT4y6n7NDZUcAnlBNJJ6L1+6PNSHZsfITZWtl8xE8jzo7YlFWmF4ymoI6ewzYYFDjeEz0+rL+dNfNp02CzXIgPmKXyWg3psnuoo9D6fgRJRVqUKttopVoSHVV5pEaeM69uhtT886dxeGRC0v78L1EubDCa5EzTCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019903; c=relaxed/simple;
	bh=FGz6Yt0eTe2Sk+qccGNxP1WHu7EGUehcJJA+k9tDU4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8oqTMtMEfUh9mR8Ll/jiJ6WnU/p3Eq47eOsMOikG8Hqz03ETSrRvO53dY0eYNoZXfL8FcyardS/xtEKxDUBVTLInLBUyyXvnEuXYqtG+cN5TlyTaay/H/vqUMPvgi9lBk9vSA6/o4vIDi0IRAiPpG4BzZWANRHkCnQg80CsJLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ+ZWrrr; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ+ZWrrr"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69c5eb6dfd3so4667444a12.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 02:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784019900; cv=none;
        d=google.com; s=arc-20260327;
        b=awKi50OmPovpzWPSQjOj5mgftLAqEReoFzoZgXZ4XvgIGCH4I3ZKYYMVurXA3xSs0g
         bot4eP+hEGXtnQ4i+bIT3nXnK6G4x+1AzWDblzjnLXH4lUJ88rksxXJxUEFqnxy0zh8e
         y0wKqzsMeGkb5Z0VHduZKZlfCvAWSO+jmTilCWzgXvsoKeP/UkUEGCNQ8bc+4cQ7w5qI
         fTQZm+0JJRY3kKSWXP2WdSO8ucQB1viFSO3zhTKMHxbT0n0qQegYCUiEWOWQ1qBHN5+c
         TwZbtSaLAMIw7LdOnpuY02bu8nZkwZb8YktBhO887UxQz0EbfvB8hP4iGuaDQMVjaULe
         ZnYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FGz6Yt0eTe2Sk+qccGNxP1WHu7EGUehcJJA+k9tDU4k=;
        fh=bWK+xtpjCyGxAPKJx/gjQ5JwmvgcJkf634oj5/6k1eY=;
        b=Jxr2VwA+UfU28u5Gly3WhFvVd4QvEB10XhTzFEhsn6SkMCRddQ2qrTGokMoQjf4I5g
         7euzq4gfekZAxV5N5lSLerix07FdtvrZT+3XQnOzwtnpF4eCg9YpSj/YVEfXd3BfPzwd
         7zBsHbC7dzUd8+5IYu0KKJuUj9Y+qAolyWsnApLMNxJsba6qFRN80t/E/wNgZmPZPQjU
         mTUJNtX8BVTgpE0UCAWOsjwqwhURztoWAbLsDMlVijP8rssOYlW7E98zLlizPOTSZNVw
         EOnrYioB0i4CM953kZPAZtThRTkTxCX2ew644pXbxCLceVYdILBe3eUUk9fp7iPSeoGU
         D/cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784019900; x=1784624700; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FGz6Yt0eTe2Sk+qccGNxP1WHu7EGUehcJJA+k9tDU4k=;
        b=DZ+ZWrrr4C+UvBXeTkj1ODf0zYweRSkUwEvgt7UyZy31y2UxwqLjNk2NeHKgEdTfoE
         dMp4NuIIov5TkQehuqa1LUfREsMQUSdR6HhM+ohEjJzBSnKUXTJWfsSJGYjoccR/k/7d
         9cDTDL+6KD5rOzb8viVc9Vv5c5baIfQbq74AeRX/5IxYOSZoAI24LP/5iu+MO2b9Q3dp
         P1g9hPNmcEhG4AnLzqWU9RoWjzjBvXJL3aJSpm/44JTroJpv9YpEzcfftGUcPimjw2E9
         gPmFTfa6JF+ERq05Wioas88S0vLAZR2uoyIZZHKNNrKlpBLQPfWgfwTXGzLsD3LaILVL
         bKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784019900; x=1784624700;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FGz6Yt0eTe2Sk+qccGNxP1WHu7EGUehcJJA+k9tDU4k=;
        b=C0s7YNUI6hI3K2Oex0GKl3j5fGxrgGNy2RthZ6MRm3xZrGHJXT8jb+blgI1Qdry5k5
         mQ0yzqzdN+T97Iu4ESnt7RKlUuSO283BII/j8ytxzZueCYKlso6bE+JoaJKuW2gctKSE
         iI3S3l4+16M6Bnltjxh/vn7GV1Bv/RPyj/CRX9LbAG7AwiP6Uya5WXVoN0UnQ7bdJgvD
         +IOwqTejO6Y/rb04w1VvRD9GH8wHu9WDrnMGyaGJNrnNZ3mZ/uuJS3ZRj9kbblPaJ4Mf
         K/rcRTKqDN3VEjVA/fBAMNM01GAiDSxqc1O3YxgojGNF5LAEfRgno/IltHAFI7ZYjFhE
         Z91A==
X-Forwarded-Encrypted: i=1; AHgh+RrZMIuKham3PFbzqfdBCj2CDItFANOk830C2DSzlUd5nXRCTEUokYfOcgPB67OAMovvl0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs13DThPHCz826lkqBo7KzKhTyxDlqKTnzMopZgzxU+YvVdRdq
	kBqiq8A0CoQrgTkECKc8gVvNWWn60b0kHdFvrESQ8Sr0mQ4beHzDNT40vDzbmyOLOxq8xe1F2kI
	Rcz5hDkxXDpGTQif8tEL+fHotSnxBGSQ=
X-Gm-Gg: AfdE7cktr1dtU95oyQuebnirscKRsEp26N0N0fAFqp0MHCTYffs8BHeb9o4yFQ3g1Of
	Ag/6Eu55yG42SIGvtJs6H/QdnN9ku0li23i7Qx1GaZCYWpd4xzoIJxZdcaWs6/ApsSASmVTg6+B
	PwblXh6xRdQrtfrOEkjLwuO8zjDIZRnKd3SZE742um0ZUesQjWvya2i7f2ootG9MMSx7g63dg+y
	zcOV/qFLnVUXrh/v+srtW5AQGAiLlOgGUT9x43pGVGmt0fQLYvrYxrkYFDIhi0XsPIZiOKl
X-Received: by 2002:a05:6402:40ce:b0:698:9ea5:d195 with SMTP id
 4fb4d7f45d1cf-69cd6cbc7admr696099a12.23.1784019900045; Tue, 14 Jul 2026
 02:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
 <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com> <DJY0QSJYNG0J.210HZQH198Y1N@lfurio.us>
 <CAHwyqnVVYMqYTD=Hri1gYW6CvkjKgTMv8AGP59bkOOd+-huwbg@mail.gmail.com>
In-Reply-To: <CAHwyqnVVYMqYTD=Hri1gYW6CvkjKgTMv8AGP59bkOOd+-huwbg@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 14 Jul 2026 11:04:19 +0200
X-Gm-Features: AUfX_mz9fgtm-9IxfvE5vtlipnlHy7BkUVzuVcvXBfN3yLuLCC1227PcGgboVNo
Message-ID: <CAHwyqnVYQ6Sk=4ot6=5AbUdqxCrwS15xt_+wX3DB1h369CSqsA@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] history: add squash subcommand to fold a range
To: Matt Hunter <m@lfurio.us>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

I made a fix for this and also took the opportunity to create test
helpers to clarify the tests.

Same pattern as the ones @Phillip Wood helped me with on my
'delete-merged' topic. I would like to push out a new version before
anyone needs to review the current tests -- the new version would be a
lot easier to look at. Should I?


Harald
