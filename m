Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763C158DD8
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009198; cv=none; b=UNUffhUZCTdzR2cQenJS52vslBN/Ng5+YWNfx/CBgZupn/SAoEwqgiZ44pMYKhUKdkfW56R4290Y9RiWc/fdi6g125Mv6mslaJHaWa6M5mbnLojFkJBqkC9RGNLk0fswzsQO+BMjN8GBM8T8+lM2PY+xwOPy19mzKbiXtx9+s+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009198; c=relaxed/simple;
	bh=KNoEkqR+NKEhOcKtY9E7aZcsnZLuUGww3iP2WDB1yMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq7ssYnAxNsqzhX5EOEnxynLyuxHJRd6BBLZ8gijqRYsO9MkfU7YqNzohngo/2JhVOtMe7evDD733FN0UPeKR828kPU/2ctXMNZbu186xxCnDmxth2f7474Y3Dmi36xpWdt0KVYO8JFzX3HHEMMaVtzsKQbpY7N7v6VvMaPgIN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2vNN6fhl; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2vNN6fhl"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e232e260c2so45577727b3.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 09:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729009196; x=1729613996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kl8bw4CcKEyBZxfB8qqNA0V7ojcs1xyCz3ZIgHI3icw=;
        b=2vNN6fhlMb5EMDx8qCXqg+lnbd6sbVrNswKIU2BKZCF2mvMFkNXB+I+P8orFQ2syj/
         2UsAmcFpR1dfy8EwtiaV0wuHsGU5ooGaJSwDo7HKoA0KeAtKJWUftiBygOAlbfM0Heo7
         ifG1f+rAGx2xdvN00hxQcNF+k9eSW5anfOIsSAoq9bj0Bq+STNHtAhfJfDJi5BRXTR02
         c2iTNU6h3BawiBf0I5VexqxVCsTB4bDaqTQbr2yJPGIHlMztSh0fjFYIUrTO/8F91Ylo
         DAAQ4lmZhGYAG9rDNwNSaCu3Rbc+/DZuxkdTvp/JAI+atfzCpnPoaFDxEHR87E+KRx6I
         rhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729009196; x=1729613996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kl8bw4CcKEyBZxfB8qqNA0V7ojcs1xyCz3ZIgHI3icw=;
        b=mJtrGgCni+ZxR7cU2AwWMi7D02/MpYl+hBzvmlcHFtEws2p1ZLJberIENoi+E8byqT
         eGmw4eAHv3fwkeadpAcDobZTIZNcvgyVykvFqKqGoci+Y1pWUUf6DSXSWguHKL6hiwlh
         SQ80+cgCWiQJ50Nvffbhfzmsc2yDre5hcrMyyzE7lXjLcZCqG9wKgS+8Bc6BEnOSXo7l
         nOeQ3ABJRGHpGgYnD+Yczc2jnID7ztr9gLCPmwMSBxG4+93xE+EUanILlMHbnirUgKqy
         uh+ZhCyTCgv6VIQ11Lr6s6ysuAFAJaCbxudssYe2DnsvH4lTzhK93DmCEheLYiwaXPMT
         G85w==
X-Forwarded-Encrypted: i=1; AJvYcCUMRbAoUx3T7R51w2G65Qi8QBVFHP8ZgTNKWXTLkWYL0n45T05GtHMZMRpKXpMDFPWwm/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNbo4IUeWd4zHzZ1Bz412sx7ip/5y+cueWDSJFR5/12Yyu0JQ1
	LVj3tgg/rt+8I/yWT1qBEinJXH0n7ZuQNunaHkDic48g+h32L4fe3AJJKQipx6g=
X-Google-Smtp-Source: AGHT+IFgRuGdoLvyJ/v+X7+kaGQB44fiwL5SpjRdIypXdQmmOLKKXakRILiKAcTzEAG1pp4pzdS1RA==
X-Received: by 2002:a05:690c:4b13:b0:6e3:16da:e74 with SMTP id 00721157ae682-6e36414075emr100842287b3.16.1729009195750;
        Tue, 15 Oct 2024 09:19:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5cbdc3esm3344127b3.78.2024.10.15.09.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:19:55 -0700 (PDT)
Date: Tue, 15 Oct 2024 12:19:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>,
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
Message-ID: <Zw6WKuhUufWeSipU@nand.local>
References: <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
 <Zwz4B4osJnYJw6pd@pks.im>
 <2a937b6f-a3fb-4f2a-997b-5508f0e20e65@gmail.com>
 <Zw0kGLZ-mcYjb6Je@pks.im>
 <2160f8ea-5f00-49d9-8e02-d71d4d827d39@gmail.com>
 <CAPSxiM9ncwaZ3HF72wsRwmen7joWk3mjipsu78WxKEzLX607sw@mail.gmail.com>
 <CAPSxiM-aptyjesMX1H-P5QJjA-6CUonA01Bo84cq2_t==TqFgw@mail.gmail.com>
 <84dbe9f1-976d-45f8-a49a-d0f942906686@gmail.com>
 <CAPSxiM8-C6DAE3nYqMUCs+UgHN1R41grwVE+S-cSi6gZGvCpYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPSxiM8-C6DAE3nYqMUCs+UgHN1R41grwVE+S-cSi6gZGvCpYw@mail.gmail.com>

On Tue, Oct 15, 2024 at 03:17:05PM +0000, Usman Akinyemi wrote:
> Also, for the daemon.c I am finding
> it hard to get the exact test file to add the new test.

t5570-git-daemon.sh is the test file I usually think of for adding the
most direct tests exercising git-daemon.

If you're ever unsure, I find it useful to grep through the filenames of
scripts in t, like so:

    $ ls t/t????-*.sh | grep daemon
    t/t5570-git-daemon.sh

Thanks,
Taylor
