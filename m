Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4E91BD00C
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612402; cv=none; b=LcY0lOma14QzMTP9rnnuOybVechocryFqlYg7lqX50n6Yzwf+M6yx1DcqSxVfn+UD/3Bf+Bwf8QfT5/8wQma6r6mmYAF1G9n+fArg9ej8yH2IJIslRJhDA63xjlChgfjGBsuKFmvNToahL1iFV1+1b8ue+BSCTNoNxOmCJdYG8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612402; c=relaxed/simple;
	bh=M9GwAEzBIbzy53dLWJkIdsiE5hoa08E06st8ID3YWFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qb34idktXBo6zWv5p93ISMsyLo+0jk+OHLRj/2WEPg1b/BwWXOk4H8ZXu8THQzvMQjO8qRx5XVYPjqz/iZv4hqbdn6Y/6yyUjanUurLfP4eam99mY16c4+tT6GhRJ6PxWFU31J5uBk178JZFvIndxE29l1ACFSUSx9G2/FiPe+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=D8F6DTFa; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="D8F6DTFa"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e3881042dcso51779257b3.0
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729612400; x=1730217200; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M9GwAEzBIbzy53dLWJkIdsiE5hoa08E06st8ID3YWFc=;
        b=D8F6DTFaJ6f79OqCqf7dVkGnHKAFqQBcv0yXKR0ti7+WIpUGUAISY4GlTd8RFGoY77
         99vpUU4ku3HX/GTub/UJMY9L6nYMiNTv1cXmDIcaEzHhw+OwU8JwgiSAaLRyAB1V+UpF
         eBzkPrZBVNMJKSwP0iTFnHHxrNarTulQRQ9UJNYKKFVrtouqrpfg2ejnZhkdy6FF6fEJ
         D2tb9dnHgFrbHoxWE1hYzkyhkPm/jK2/6etZHSCbmixEkTI+Nt01wHcmN6JlqzVJ7/5K
         UjBNajVBlwJSlQfLf0TX9ddcgzeCujJBCn6DCwVum6RISf0cqoJHzqNs6JlNYpRwtxY8
         /+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729612400; x=1730217200;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9GwAEzBIbzy53dLWJkIdsiE5hoa08E06st8ID3YWFc=;
        b=nIPVmzgSz7OP+8885atSXn6e8yxeuHhrnGJnu/jLDTtVQ57Wthg1pT5Dee+DUqL7EC
         xfV9niEUfnAPpQ4i7p1WjjfR4SQByQAao2icJlW9gBIjOlhe3dVBXdFxpvV+9wuOAzi0
         i3mgGPeJ/7+KjAkqGBzgTKDmgAligr0l334VsvlTtQMyHU806r1WReLhvbysFr/FdE8q
         +UCLDbT9aVRce8Cb6ZEd/dwuxVru9xrIbMhZONhXHTctG9YzU6I81R6pV0XJMphJ7+HB
         fQXFuQ2E7cP8QCLFB//R2Yp6beTVth7GWcplptc8ZbCOS8VR6kfVrQDPuNG/FJtfWWC3
         TtPA==
X-Forwarded-Encrypted: i=1; AJvYcCVg+Orn+eWsDrzV4vyOOvuKdtKJMuFD/QLyxwnjUhW/2iVOxI4YSa3jYDLOrkB0KIClsMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6GHMuYsm5tuq27m7sp4GqwPdMhNRf5+GkbyBZ6mi/Jx05e0/A
	GOZl5peJAiFXAVTB5FtId0TAvOGo6edHriC35YV0yt/YcwdgWxkbDig52t7iANU=
X-Google-Smtp-Source: AGHT+IFbc/6nCfAG1bLbT8NABjS0NFyFc0baYCe4cp6f4YwnsBpy1R3tWxuyWCas2A90o2R5OjS9Ag==
X-Received: by 2002:a05:690c:64c3:b0:6e3:13c6:7fc3 with SMTP id 00721157ae682-6e5bfe959b4mr150769267b3.28.1729612400050;
        Tue, 22 Oct 2024 08:53:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a4d2absm11231977b3.39.2024.10.22.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:53:19 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:53:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: =?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Avi Halachmi <avihpit@yahoo.com>, git@vger.kernel.org
Subject: Re: bash prompt evaporates in subdirectories
Message-ID: <ZxfKbsapf3MAUmcy@nand.local>
References: <D52FCQ2F409N.1S5Q8XRAX5YU7@cepl.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D52FCQ2F409N.1S5Q8XRAX5YU7@cepl.eu>

On Tue, Oct 22, 2024 at 05:02:55PM +0200, Matěj Cepl wrote:
> What did you expect to happen? (Expected behavior)
>
> bash prompt would be still active and showing the status of my
> checkout (possibly even limited to the current subdirectory, but it is
> not necessary)

Are you using the prompt from contrib/completion/git-prompt.sh? If so, I
CC'd a couple of folks who have worked recently on that script.

I assume they may find it helpful to know a little more about your
setup, including possibly if you have a bisection where the prompt
stopped working for you when in sub-directories.

Thanks,
Taylor
