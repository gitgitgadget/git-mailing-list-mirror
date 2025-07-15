Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0943BBF2
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585373; cv=none; b=c8nAPlrkRz5+A8N7VvU3Y3zIsJiR1KNRlM980qFlljH/ePvkzO5V9xVwOcDA7vJm6xCcOYWpSnydZOZ+2QVaj1vjYmduTKwwzxqMMWzuOR2zyv8FrL6QU392/QVWBkr8pNEcxz7l0VzIwQtVZjlMQ9277e648Lx7haIHtomEicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585373; c=relaxed/simple;
	bh=ifeOb+rprcbPVbikj9g2nVb3uY+bK25tnxExxSJCeHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou1dSE/x6bIL9u2Rs/2juXm0aa6JdaCuwqNZeLCMJvSU0OC3PeUnUMMSCgRuTIdIZNSNCnPQLXqrpTzpncqNgjrfnTkBmsS0avaVy+Xd6dmpRHZx1G5LJ/phb0ex9HN97gYXistrdZdgbvhRXJM8sw8VVvG527FSv4qHk791GJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5qvH4ov; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5qvH4ov"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748e63d4b05so3208503b3a.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 06:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752585371; x=1753190171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q8UBMWRmR3JmDES+70K8YhwBj/rEktopchcnK+s9mgU=;
        b=F5qvH4ovo9bplgngDdMoARAgHunnNTBXVXh4RuzkLgDp9dQhMmaXBzTlKiX7mjRjJ5
         +nHkg3M7dc1RMIFYrAt4moeDqNTBFosEWsO8hxZTmyi96f5D//mut1flrOfEk1kMZQkd
         8FCNKAdutpvSmpXh0WsptQSL/1wCEmt68ohH7p5AZG2Teq9p/Lwz+2o0mSnBBruqIY6n
         UBca0Or5uK6fraZq3Cp+jXRRk/Jny3iM88jChuBjI4AM3/QYKDOyNZjqJnKcQSmkfYI5
         XVffQ2h9iJ3CSxba6woM0R6aeN1+St+AZ8K729legqzZ+vQ2DehUdZbvn0UY5HMRvwGV
         bvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752585371; x=1753190171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8UBMWRmR3JmDES+70K8YhwBj/rEktopchcnK+s9mgU=;
        b=UYlrmZuVNHx6GXiJ5RXkpRH2h8nLusIjGVbv871Zep/YQQZKJaVk6epX5WLzkiqmIe
         VhhO2p7G/6jUVSSenWI3M2PiMHZKtdedl/mnFn5US4rLwygOWRjNcfNFOP8qXJGL/GbZ
         QpM3KNHevTnU+m5tdLz3InakGZAG2TszGYsP++rFNUq4KYt9pey7bHUjLkaq/WUqp5UO
         c8/gZMYYmM75/m7vD+8ttRexGpMivjFJFMncQZU3hkNwLovVvGlLomHpHXQNbFUkClsR
         7GATiacaADaZAhKwPfvUuXclwYB/c0HSjgIkV38KE/g3UYYV0aiuIZw3hn8BwpvOF2WQ
         svrg==
X-Gm-Message-State: AOJu0Yy0cDB/D3TBOlzSKaHz6L531r3Tp3i59552YvAjnCvKHJghV+BC
	uq+kEDo+Vgnv9YiY0agIGgoK7uvWyB58fR5WGQ2oFAoE832rVDgsdP58mI5svA==
X-Gm-Gg: ASbGncs2eBcw3JU5IoOzgmsxd7Hb35+Y/sM7iwU1rFiO4SHGDssPAbdPWc4WfteS2N6
	0AFGNnlHXauyGF5fPYBERS3mMsrWyy7y502z4TJQslIr23RC5x6TSbH6QUJfcHAzE3D1jNuJ7hj
	UBdCv048HM3poopWFfk0eD2JMVo4nb1VZu8aBaLRxEL7B1STMSVDnqk3FFSoedEZSnauzzW0A1w
	sfJvZpB6w3Tc+QuqmisYWlMScx7xJfIHTICd4EBfvfPSEoTI61JBxtMFMPi0SvPHQCbhjM5L2mn
	9hbWIyTj1jr4FmFBB1PCwbRe6yx280JLWQo25RP2LAdc40qSQApnjF7+9QPQmXGv5y2Exr8SCt0
	xaIgPwJgZtPNI8c+WsyEJL/a9bdqdiNYUIg5KslS2lNs5HS7y+OIL9rj/vg==
X-Google-Smtp-Source: AGHT+IHtQvd2senua+bXqX98Yhij8sqAYkNU2BXah1xaGJMl+Wvtb8RI1xIWf3g3g0J2vybnOgVe3w==
X-Received: by 2002:a05:6a00:138b:b0:748:e9e4:d970 with SMTP id d2e1a72fcca58-74ee03a2206mr23793967b3a.1.1752585371343;
        Tue, 15 Jul 2025 06:16:11 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:dc6b:d98:8094:2281])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5a94sm12388971b3a.21.2025.07.15.06.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 06:16:10 -0700 (PDT)
Date: Tue, 15 Jul 2025 06:16:09 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #04; Mon, 14)
Message-ID: <hm5m7i3vyzimr7afq47uitxl2la2obgetg6arks2mvgafekjfw@ppfqnb5ercsn>
References: <xmqqa556sddb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa556sddb.fsf@gitster.g>

On Mon, Jul 14, 2025 at 01:53:36PM -0800, Junio C Hamano wrote:
> 
> * bs/config-mak-freebsd (2025-07-02) 2 commits
>   (merged to 'next' on 2025-07-07 at d6761aa225)
>  + build: retire NO_UINTMAX_T
>  + config.mak.uname: set NO_MEMMEM only for functional version
> 
>  Drop FreeBSD 4 support and assume we are at least at FreeBSD 6 with
>  memmem() supported.
>  
>  source: <20250702093736.36074-1-carenas@gmail.com>

Apologies for not mentioning earlier, but the minimum version of
FreeBSD supported with memmem() by this patch is 12, not 6.

> * cb/meson-avoid-broken-macos-pcre2 (2025-07-13) 1 commit
>  - meson: disable PCRE2 dependency by default in macOS
> 
>  Build fix for macOS.
> 
>  Will merge to 'next'.
>  source: <20250713174807.32444-1-carenas@gmail.com>

Better hold, as there is a better option posted with a v4 in
20250715114407.37955-1-carenas@gmail.com but more importantly
the discussion is still open and might require further changes.

Carlo
