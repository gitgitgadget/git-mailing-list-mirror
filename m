Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C50B21216E
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889799; cv=none; b=kayrPG0CrWEGHOII5l3vacxi3w0k1Pz2KpRM2K//DqTTZWOsfULvnms1WPJEKkznCyq1JF5hBkRG2PQJ83asQPcHJZNfb8wtt2yexclKeMjTPupsr94WAsfckBoL2QwEl4k//e2cfPlLDDmCynTMFqdWdwAtfxEpTo/UjoTlmgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889799; c=relaxed/simple;
	bh=VeUbrdZsc2pDNBEaRKHjjwKzYdp6KhV49z/1quCmV/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sF1+e/qqZPNkk6Po+n8Glqxm9cbUoIcMhA1gQnAVQ+0Q5SUcpC5QxUf4Is6Kta/umd2m/4A24Qkr8tdgc7GNmbRES0fQQFN/IhAw9sNfyeoiOfhPW++COKi1Au97UFWUI5FZJ9545mzCBLkOb1jPq1oalu6Zjx1du6Q0g+KeVqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ab+MsuWJ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ab+MsuWJ"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e35bf59cf6so35558757b3.0
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 13:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729889796; x=1730494596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8aTy1WWMFl2d06fPwvmT04r7JhZ3qfEovrvbfBiSBV8=;
        b=ab+MsuWJWOJxfROT/jWe6PxmrwEeD7tHb3ba/ZLTYH2cUS37OmG2s1mLzS2sSApvbg
         ajor9QcEoYSDdSCWAASZnNRImTr37e/YCPUy64ZHTN9124QvMfLrWIwSy/cvU8Z90yrH
         7OlGwXNisdhjdJmBBeT8+3NtBI4Xrm2mFyM4ujut+/3KhdtK45Wt9k2ZGgcpoLgYIwue
         lVpbXZ3w1AdPepVucXaUGCxgFHIn4mOq8jCP/3GryCoArc96SQFVKayK9LelK5J85pIP
         04M2qRhzIC31b8MsMtOXGm0MSGGHKQNposnWG2BRbSwrnVINY3XrYs3KIDteQkZvPSGm
         OFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729889796; x=1730494596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aTy1WWMFl2d06fPwvmT04r7JhZ3qfEovrvbfBiSBV8=;
        b=DQ8zP+7NPONJLMuDMofLF+Tz+pR4kV97b4SHaU0XbD/19K8h9lXD2tapUSh1C6VGTI
         PQs4kemy55n9hzOQFFfAJyxT2c5QayRCrhDdPbC8JfqGBezb+d4MKwfutoX4kwvpvv+p
         QAXnUi80imjys4JhlbIvQSI1cb+zp1ulBAHG/hwpD9BYDBN4R6B6Xm89BfeZ9/Y04AKt
         jGgZNlBwvTaIg3D6Z2XfcNXqXZ1AaT9NwbpmklzaXdZ3KldZ7OjEYaOtBqLY0dEJzu9M
         IuKn11wJV2L06xEU0pm2QldhIZm6yMIy+lbfqn3pAtHe7Tow6K5qc11bxbtXu4a08ZbA
         3Y0Q==
X-Gm-Message-State: AOJu0Yz/OghOvmgsNQCBVN4Wj8yEvUlgS0bfOddBTPD2QWlzEmlDMgAZ
	L3d1WDMCFFWoVE01dznAveUBwrSziH5IiEToqmeTtcSkv5LI+KfdbEW6aE3WixI=
X-Google-Smtp-Source: AGHT+IHi+cb0UvobjSUeC6K1GkWgmcmxEoqpQNUfn/Fcy0g411u40yOqz7WvNiMPoontfpKcpZiWkQ==
X-Received: by 2002:a05:690c:6483:b0:6e3:23d9:ccd4 with SMTP id 00721157ae682-6e9d8ad5a22mr9462317b3.21.1729889796076;
        Fri, 25 Oct 2024 13:56:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c987dasm4318007b3.129.2024.10.25.13.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 13:56:35 -0700 (PDT)
Date: Fri, 25 Oct 2024 16:56:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com,
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com,
	jltobler@gmail.com
Subject: Re: [PATCH v4 0/6] cat-file: add remote-object-info to batch-command
Message-ID: <ZxwGAhWYm0tASMI3@nand.local>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241024205359.16376-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024205359.16376-1-eric.peijian@gmail.com>

On Thu, Oct 24, 2024 at 04:53:53PM -0400, Eric Ju wrote:
> Calvin Wan (5):
>   fetch-pack: refactor packet writing
>   fetch-pack: move fetch initialization
>   serve: advertise object-info feature
>   transport: add client support for object-info
>   cat-file: add remote-object-info to batch-command
>
> Eric Ju (1):
>   cat-file: add declaration of variable i inside its for loop

Thanks. I just want to make sure that I have the right base here... this
was previously based on 3857aae53f (Git 2.47-rc0, 2024-09-25), but
applying the new round did not cleanly apply on top of that commit as
its merge base.

I applied the new round on top of the current tip of 'master', which is
6a11438f43 (The fifth batch, 2024-10-25) at the time of writing.

Please let me know if that was the right choice to make ;-).

Thanks,
Taylor
