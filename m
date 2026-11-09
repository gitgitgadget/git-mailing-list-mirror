Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231752;
	b=rDheqODTvZiPfXnIb+8QCt+v8/7OqtSZtj98U2vIxEJ7KXy/RQIYLGIHxMIvb3jRb/Uu
	 GB7V5yH9v81GMnDL8ufkpWIz5mh9EK0M2DaQcdRlV+N2YqEnDwNry+Q5cFvcO733mmktL
	 Xh4qAsSTdcxOCXkV20fDLWbEv63MIRK5rv3hIUZEQKznh9Enw2UgSu7bCQdlBkXlhoXkr
	 7yjgsafUu1SiE1r1Lhyras/A12nC90w+tRDUBHcicVBVckJQ8+Pj6OKJYgzJeQJ5K+E2z
	 /ZhIsiaNBY+JMzdlqQctIfZ3EdcTNC2YnYy5/nFgkpQL5d6lqXTw1MLoFubccw0bKPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=NBYhbx6VpsyjilowJLbCLfSX7J3D759iDb8eJPWbrv8=;
	b=jJacTfHll3L6Nns1hVRqub/6e1y2TBR0i/drIKdmWIHFf+Ql7JfczESZvOtE2CZT32Ip
	 V8YhPBHJJ4sbV1SJcxazUcRinhCZg8WD9KShwwpL38AHPfwZM/WdrsJ34dlvQ2lzod5Om
	 f6EWXwpEwH/5sJGl+cc673W2CD7Bx374xcX9sp/cU/nWry6JQMGCgZHPpHz+2GhEA/2sW
	 DWx2FMvcWAc49IuVHq+kBJYljM1/1gZUnA5jtddkhAKAYMYH3lMtbNzpE1/j2wx/gOx1u
	 DWCDxr9K3V9cBMQRvcedCDoXoHH3vC6rP39JjPKSBvi8FwyIxdsCXwrPakX7o3C/hyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rKPGMRy+;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5797606A326
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 13:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5797606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rKPGMRy+
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53394bffe0fso9390481cf.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 05:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794231750; x=1794836550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NBYhbx6VpsyjilowJLbCLfSX7J3D759iDb8eJPWbrv8=;
        b=rKPGMRy+AYHtLGPz5zfWeTxtjar8X17Vzcq+Bw8+ZeK+jkCCPTeU1QODAshjJoluBk
         vDGHZ91gqI88ZtCTUsXjhNXVrEisiggV5pzsqiBDTJ7/mMxZ+uAKazXZkzXJTtbTqugW
         MLGBgiBJaQrfYDTtAivQA8N/qlH9A/HOTR6h0Nv5HRUofybR8/LX1KOaifpK2k1Hkcnc
         WL9lf8jaNDiz/YUtj2mNW/QMRt3oRk24Fu+XBR+lpScWan/oasr0uq9vRX7HDw98FkPQ
         KXtxOxSSAtybWDBxA2r234qMWVZcvrndmoyyCn7WYaiJT8SCnZmo9zDLFP5/L7autHFJ
         Zqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231750; x=1794836550;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NBYhbx6VpsyjilowJLbCLfSX7J3D759iDb8eJPWbrv8=;
        b=ze9CmahPW3RXdzJ47sZwC2a135uGnfDZUD/Y8ZKtXdN9J0iWgar+GoFZ5Sa7nNKEps
         b+EVqEGlVlpUJ87FvTsVpo+H39xK/VgFVPmYUF2fzWaXSI08+fGkODtuExVGuwW9B2fo
         mCxDkS+I0l0V7frqZLKqw9RW/NucwaJ2J6yKiyWVknZchDxkZYnbFVSGlSOl/Gw2zSMi
         /BFN/ygGRDKWN3j2d5L8oAq6dAzuumaF2iNCJg7UUuyr6atFI+8Tdbsf4CIGPNGpqkDP
         WL1mpRzUYPMsIKv1T5Y8LNNw400oKam9Id51sZaFWQQVTl/xtJup88fz15nQWauj5FQs
         KJUg==
X-Forwarded-Encrypted: i=1; AL+hErEVc8gc38YQNes5lUwmUN9CBig7doS/Xmb3G+UsRVzVjjVVwEQS4wRJ/oR16toInH5vGxw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9kA3STGZyea7PfLMQDZ90HP54Ap2MSt3JSEOOzh7Y9eCqPDnNf
	uqZ8xViVkwxjDQ3a4oCSrGZIh59HW8FhLLOmKczWGLrt81DYfwAeNaMu
X-Gm-Gg: AYBFou25xIRepTF2S9QzLl0rB8vfQYRohzQybsIsCs7vbK0zXWNZXd/lEHbHlxH93xw
	aDhQWqs4KiLYsy69BLr494kwaGxFGoI0W2xXu48NIy4mTdPBQ0shf3szDqdVNM+VCSe7ggzNp/0
	ynmJzkTegIkCntOUXhB1aNa5UHTtRWaFgfpwkZVTSX2Jt71XqdBeQmW24hu64aBYMo60Q2mxzmD
	Gi05lOMLsimQSlACrK/pj53QkADOYLbs8bpDVEsRLoKLA8ecn/5LDSvHa9EP3HMogzp8LSsOvYT
	XwrRru10mn9c1OU4XCJ8jeQtFsnR7uhPlBzEf7+Yg4sgV7E6iGCahZJavWU7mWpGhyVtabQU/kT
	KijZUFraj0n3nVy9UT8j32BCwvIX4MeOd1Em3tGHvBreT+8P/esSQ5QZCauHt6WxLy67g5uiZWN
	4oK5rhDf8fP+oYVlrL3LIVXdvR1qCNEZOibkhVBURtq/bT/quKmy+kRzHLt0gzZEQROsK3xqrHB
	S0czGZ8lIMeEaBbnTpZTzwtP1NJlOuTguzeYP+zmzexInPLLI3F/aBh4gy3fEEkk7+b1rsJPL3j
	Yy+HX2wwkf0TUklYbaAJegpdh3v9XVbj3qBn/3eER7dZOwOcJScxmKvwPKH5hyLyBfJDqGn499B
	jOoabIdjfgxCylwq/VmJTX/sPuZJK/WN3+neUh2ylR2XFxUIB0Fv7KNvmiOQNGd0Am5yHMufcJn
	LusI8jgzccHQ+rFpdeiPH6GrRcL6O1L4Q9VEO6Cdo5WvInoT1sESvDQqg=
X-Received: by 2002:a05:622a:244b:b0:547:d087:543d with SMTP id d75a77b69052e-54fa25e9d8amr102101101cf.3.1794231750264;
        Mon, 09 Nov 2026 05:42:30 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55264b242b7sm40703211cf.28.2026.11.09.05.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 05:42:29 -0800 (PST)
Message-ID: <8c3480f5-1f34-4af5-bf68-60469dd83cfd@gmail.com>
Date: Mon, 9 Nov 2026 08:42:28 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Fix segfaults on settings given without a value
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Jeff King <peff@peff.net>,
 Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
 Colin Hinton <colinlewishinton@gmail.com>, Matt Hunter <m@lfurio.us>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Miklos Vajna <vmiklos@collabora.com>, Junio C Hamano <gitster@pobox.com>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/2026 3:42 AM, Thomas Bachem via GitGitGadget wrote:
> A setting given without a value, as in "git -c foo.bar" or a bare "bar"
> under "[foo]", is passed as NULL to the code that reads it. In these places
> git does not check for that and segfaults:

I read each patch, but commented (positively) on the ones where I was
involved in creating the bug in the first place. Thank you for including
a test in each case to prevent this from happening again.

The only suggestion I had for improving your patches is to include a
more helpful error message when the bad data comes from a server-
provided bundle list, but that isn't necessary for the bugfix. Also,
such a custom response would look out of place with the rest of your
patches. We can make that improvement later, if so desired.

Thanks,
-Stolee


