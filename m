Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793013791;
	b=q3Sh37+U9Q/Sj1iwwCLaJCecLe7SXGugQKWUiAzwWz5xRbKr6MocPsNhFis3a4usSFl/
	 oqeCK46l83Y+KB45bG/uxz5y6Ts7TpZNxlqJOq8ioI+Q0xWwiKnKXkwvQB/dsEP/pM1La
	 au7D1iOnaqJrN9ughVYrfIzixmhuHEVmZvCSJMpghOtbfa58c3ABtKeSYOYFSsmwWuPB4
	 uuVF3ajKMxDnN1S858bXsVmZm4XTMDTAKRHOXOX5X2hTKOoVjtdkBcD0nmyg5Xuzh2qG9
	 vYi9aEN8IfwkvLjgwV6QAw15kUvxF7f2lA8LRnUW9DJHWiX7YaR+snp2JhucLPDtCPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=5hSn6p37TtMMSI+JZNgrH4skSz1IeU9KA3DbFC64s4I=;
	b=olAhfSJYz061B9+KEUotra4vfOB3/chA7DJi7HEUHPZf4ZvjoqyRR3aiWdlViKNppJ0H
	 REG9FqZvMIUPjNhMhAGitD0h06q8mTDFqCqiqq9GjfIBjuhMXI81JCbouMhhGnW+5xq+j
	 /5eWr700PnNhimTKAQT8NVT/dq7VYD5245jxfwiSG3AhxG14J02hGeP68TC5SJMGNgsIk
	 IuD4kMXBYlQE6MHZFcvf5KFvwhgJZcCcUQBcX0T4WAQddRIvAKdPe9Q99W9Wa7VndUkAW
	 mFyRYZK94hdKNCCLW1zMoLn3JUqHUnwHAHpNzPy5IaGcopY2Hx1AHMNE+KYiWyx/2Yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IxPpzZ1d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC3606A31D
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DEC3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IxPpzZ1d
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b125371596so27234477b3.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:23:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793013790; cv=none;
        d=google.com; s=arc-20260327;
        b=IVGFkkodWiTulax7/rM6h4MgnHwbvDQ/kY5NwBEMCoAoMr4lSqJsRSEQfMDOdMGF9F
         VD80lrEK3L+rSN7Ah8tBorL1g6mY0YC4YUyAv00xRq/g9RsS8M8U0QyiPyLSNweSDh6I
         DgoEv3yKPqMRIh9bDaNTdWFaND6VR3pjDZHU0RZmr9O8WaVEvmFWwH2unMLCMumA+Rek
         2fcXV4U9WOQyzh6DAP0rL6EHVdcsOczJUA9rwAE6ttgp8/muOcXRYNLnpmsqeuDLu6q5
         14hGEGBoVvunUzoZePxV80zUFndGqYiYA3FynzLMujYZblJa/SihmsrIZ6oCFI6+e+rl
         qgHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5hSn6p37TtMMSI+JZNgrH4skSz1IeU9KA3DbFC64s4I=;
        fh=hIzMqH9vtF6hTCMPH1CwC4iasS4kLBtDt9YK+UGWA84=;
        b=X1r8XbZJTeutSIoBZ377e5IodeujmF3xlcMrS/iCKKruSDUf2ofFbPrm61flct+NWP
         1d8y0y/jLOSmZONChjRm17gnDK26qcz2RA5Yyouj9h5PG3DgVjlrpnc/VM2LcHYLzNGq
         vItOHRyFHhlQQwdoCAUjyMhwZOcOZCaRcIPpxLpeuJNshVwA2qFFscnj5c6LEcFgL2SN
         k+skwYC2/fiaxdy8995LzhGzlwKRxsn/VbwNDrx6NOTZwiW+YJLNV9/OfVoB1J8Wdu1a
         45j/ql2Tf4QejT19hXo1dBJxPT053q7npEPls0kp9TTCnfPQiLQ9EQiykXPMzhQJx1Fs
         pQqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013790; x=1793618590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5hSn6p37TtMMSI+JZNgrH4skSz1IeU9KA3DbFC64s4I=;
        b=IxPpzZ1dqC54q5wkZ+KTklgtHtA3jhE1PVWJ0wbe7jrsni5HICuzARWaIpP8aue8Qd
         5aKcz97NFSsDnBPRUnAdkbj+vzTO67cBWo+/muh9ocfhS6Bwj/sjMb9q5IHbnGjbiK7Q
         N9yX2hUgk9vFtKX5nwz/3AqdIxOOOjiEBgPq/TyshNGk6s7x7Y3YS+rRIdBEMTnHIKVc
         oKYvwJMpS+8rx5V4CRwYIPsp/wZ1KN+lLhdGG+Q4YKOql/9wG3zTgcVxZkshp1WFZaWr
         xbNSwOndMubrAZmOwTUv9obYRT8L7KSqUjq/qz22piWHqRsbOhtYpOQY7XVhJWAHwhsM
         E/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013790; x=1793618590;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5hSn6p37TtMMSI+JZNgrH4skSz1IeU9KA3DbFC64s4I=;
        b=ZpomGHCyJq8BJGBUrbU6IfrftMRYMxFkfGzgLUh6NwoUHDL3J+L0auRkGZtN8Ok/O5
         03sB2KQNWGDRfiLJc/KrudVhf7VkuwmOeTeo2SjMmfRlHbV36JON4JnZiCv/yc63OhWF
         ljWKUtIkeYkhgcwR35VCZSM3LS8Zm0OhRFKNXjgIDLP1PIZTPRr+hkz+pfuvDI2TsH5D
         4jX7e0wk7Optfn6wQQSmAMpSn+lHkIfduY3fZneJnH72qw8arjld/RvT5qYN0Xz9az/8
         x3FX0hZOiByRYtfP95qcfm1lJmHZd8EAXrh+GZJIxiaFnnpKkbYuVoh92S1+DSaQj7b+
         wEnw==
X-Gm-Message-State: AFq9FYIL87tnHvH51owfczEozO94BXX75OiB/3DGsca2i6faCg9mHczd
	gyxHhnD3/KRmpiZ5UDdWCQln/HP/mJsP+cVbhectCXsSMQJiInO2nhfRUJdY2/7Jen27qMqmXqv
	JLP2exvkP/9LRKLBxY1ws270fLa0zEMg=
X-Gm-Gg: AYBFou152dY0fjQgFCNei7dFGK3+zoNH5pJDtAVFxmjWeVZOwCyvZMowLowGkaF7ZSY
	pR+nXzs8vjyVVa+tool7dQ1fdG3DcqVGBgk/tWRhBtj9oa6yTIGP9dRMM2SO26f2mpIKA9aaq30
	Bc6nxHM1JySH0M5fdGXT7Ttt4rt/81rk20IreALaVJy1dbDoDdcIek7IocwezIr3W6ykFCyqqdF
	x6L39QNPTmSGpsZji9xg9usTX4Dw2sE+IboTlnIhTSaLDffQlkGXrTXuX2SJptIHa6KnDVZaVJ8
	28BXtZ7kuGW1B4Eeu1r1uC/M1rh4FCslY7EGSHPIV6DtsQFjWHbayWQMoML85ssL4X/HVJyttmK
	3ZgOLm3bhH2hFuUUEPyfQAyRMjfNxPSnNs2rl4punW2LlSxlfnOBInSexSsO/s5jmWedsTeFJtW
	ym0ekPEXdbkO6rxfyMHFDmPYTloqLSLiGdzXorAMAbThT2sR3MU7w8reniZICatK31TIuQHcjM4
	eHRfxOPSi2JX/64EzJNMERwGbeNixvl8p7/ENIS
X-Received: by 2002:a05:690c:c4e5:b0:8b1:866f:d9a6 with SMTP id
 00721157ae682-8b1866fda93mr17625367b3.12.1793013790004; Mon, 26 Oct 2026
 04:23:10 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024221341.92086-1-okhuomonajayi54@gmail.com> <at8w9u6qA1dhmw3r@pks.im>
In-Reply-To: <at8w9u6qA1dhmw3r@pks.im>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Mon, 26 Oct 2026 12:22:59 +0100
X-Gm-Features: AclHuK-BAMmtK4a7kIZOVpOtDNy_cH8a2rxmcIaBzX4GoSjbI4EpzN7C9IQl6-Y
Message-ID: <CAFpMFfDaVf47QKkNROJAHJB7oJR+iPt5gkkCnj4KdZW_9MRqGQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH] diffcore-rename: stop using the_repository
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review, Patrick!

On Mon, Oct 26, 2026 at 11:52=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Sat, Oct 24, 2026 at 11:13:41PM +0100, Okhuomon Ajayi wrote:
> > diffcore_rename_extended() already has the repository through
> > options. Use its hash algorithm when checking for empty blobs,
> > and pass it to start_delayed_progress().
> >
> > Remove the USE_THE_REPOSITORY_VARIABLE definition.
>
> All of the conversions are trivial, and we already dereference
> `options->repo` unconditionally in this function. So the patch looks
> trivially correct to me, nice!
>
> Patrick
