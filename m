Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696821DF974
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744359519; cv=none; b=qpL+5Cs0cVse4PjwHZK45iOLH6NDHHjmgoGAYJwF30Avs5DIv6reS5lY6gOACrP4+2jIsAYo2XzaJF+OMYz8WsQ6Q5iV6LkTwe6CBhS/mdGYl4OPX2uvoPIL70P/9Pr85Czgc8WWcUar/G7iZKb7f5Mc9ph7O97HCotEVRjRQYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744359519; c=relaxed/simple;
	bh=HtInqtoR6urXL11UuS40rVacniuewprxD7Mai5WxHGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKWu4O6hkN6RIgJgB7FEcrIJPoYwg4ym33+qbInao1xw2qFZbQkNgL0qNddQ3j3IiGwyx2ffCWx0NKYOUXC6aDLQvlqVcpf68LTQIadPcQKhbG6pFMbaGfMdLZAel3EICjKbTErBet9OJjgFDd6Wd1dP1IAgUfplRoGDSgVuqlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quadrature.ai; spf=pass smtp.mailfrom=quadrature.ai; dkim=pass (2048-bit key) header.d=quadrature-ai.20230601.gappssmtp.com header.i=@quadrature-ai.20230601.gappssmtp.com header.b=HWqzvBB4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quadrature.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quadrature.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quadrature-ai.20230601.gappssmtp.com header.i=@quadrature-ai.20230601.gappssmtp.com header.b="HWqzvBB4"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso12143345e9.3
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 01:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quadrature-ai.20230601.gappssmtp.com; s=20230601; t=1744359515; x=1744964315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f75jL8322nFhQvTqZmXIIZz5b/ENxFlXYreERFCcYOk=;
        b=HWqzvBB4TIjXVt+DfRWZRQJe6HaWxpPzG+zWhhSAAoZfYYPR/7290LY6dqjOzNj0+b
         9mocEOnoGlwSLdxnHfS3YIQ3d48kiTOwWZpK1yhSRvtOg8fIycbOVi72loLJO9tOgMLY
         4DHWS/WLH0kpkv83OmkWjh1pe9/wruws4ZRXA32zOvLJ0MWqD1DgihwXbSUUJmqozKXu
         L59stG6dLyaS8a+BZg+cdxGLx0VGkiZ19sOcK+07grvFd0H/OIFPvkTvIUp5kJqAStcT
         vJqjYgeqfyoE4CG+O1WyQuzCRTNI76KZ4c+H2KXeULWBJ6tBoB3ZTcOsdHiD5HJAlE3E
         4lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744359515; x=1744964315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f75jL8322nFhQvTqZmXIIZz5b/ENxFlXYreERFCcYOk=;
        b=AJSD9Y+QeIh30jaX72Ai7LLUbosqBuKG/oio1eEgSn3Mhly8ZEiPIbWitCcDSX6stt
         2ZeVesvB2whbXwyJcp3R3Hx2ySDPgnWMiDw2OVNMFmXy22HHQ2n81yIocgJzCYIzS8Zj
         XugqMdotsRYT0mKYlDhfzsmdUAEGPFIBodGegsEKN45PgtYvUzs/D3/+JJ6Ngqko1f7g
         k+VSHSM6L1Wq7kJog+0jVqgL7kmNQCAq6hnaHz7YiWE132yzbSLHaITt99Cgf2o8rOkY
         RWccgRHKGBxyyNo2+jR2sywPjmrGmR9nmeHiauwbrfhmPbvV++3bLPGA9IKQHK5Jqkyw
         4n+A==
X-Gm-Message-State: AOJu0Yz9WVC7HBv8GnkC5AYqH/MlACyQOvyXiHFosaET0kkCIrWXSAqD
	OFK2Ei6OErB8MpzwWaVX90P42mRQq01k5jbKWzZczGKIxOP+vjuMA3ttk/WFg/CmG9SF52TDhHE
	c+fOCE88ZG1p2W7xOa5PCSBA4E2x6k84mIKDIgpvmXfWIknez5w==
X-Gm-Gg: ASbGncvpRNFVl2uCZ4xcvZmBZpJH5G60CKi8eONwKWVm7gE5iPPGU8znCBJIBJsUE03
	aMB+IfmRIWQiqRF16arkkOuF9R2BuGIuCWt/8R6+aGxChjQqlv6DXY8RVvvk8hGab1uuPoLySFM
	XWCVCL9RgYR8F4GvnIk6Y=
X-Google-Smtp-Source: AGHT+IHdsfYVSwSYjBeYblz8BsdXWaLxhJTyt1N+Cz49SWJV+/cGAHGQcv+jurKkM0yJ/Mv+JthS134WPndAIcyAk4Q=
X-Received: by 2002:a05:6000:381:b0:38d:d9bd:18a6 with SMTP id
 ffacd0b85a97d-39eaaebc773mr1209314f8f.42.1744359515416; Fri, 11 Apr 2025
 01:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPzgaL2Q4v0LMSek=osugTDCDww9D-Tg+tDsFhFvRSVXFR8g6Q@mail.gmail.com>
 <CAPzgaL1NH_GofMko6f2Auz4e1TjTJNH0w4-ph8np04QRfT_R7A@mail.gmail.com> <20250410213542.GA3168175@coredump.intra.peff.net>
In-Reply-To: <20250410213542.GA3168175@coredump.intra.peff.net>
From: Nikolaus Rath <nikolaus@quadrature.ai>
Date: Fri, 11 Apr 2025 09:17:59 +0100
X-Gm-Features: ATxdqUEDqYoTvQRjQO2MtP96mfn7AL95VrwZ8Q7SlLDse358taAacSPj1yJ9VaU
Message-ID: <CAPzgaL3tYJay9P_VvuqSKRuta8FFgn=xc7P=2t3MFukbobiFOw@mail.gmail.com>
Subject: Re: 'safe.directory' setting ignored for some operations?
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Apr 2025 at 22:35, Jeff King <peff@peff.net> wrote:
>
> On Thu, Apr 10, 2025 at 02:21:01PM +0100, Nikolaus Rath wrote:
>
> > It seems to me that the 'safe.directory = *' option is ignored for
> > some operations:
> >
> > ---snip--
> > $ git --version
> > git version 2.43.0
> >
> > $ git config --get-all --show-scope safe.directory
> > command *
>
> You're getting "command" here, but I don't see any "-c". Presumably
> you're setting GIT_CONFIG_* in the environment yourself?


Yes.

>
> > $ git status -v --untracked=all --ignored
> > HEAD detached at e116555
> > [...]
> > nothing to commit, working tree clean
>
> You don't show us the repo here, but presumably this is one you don't
> own, and the config is working as expected to allow the operation to
> proceed.


Exactly.

>
> > $ git clone -v --no-checkout --
> > /builds/coreinfra/grafana_terraform/.git
> > /builds/coreinfra/grafana_terraform/tmpus18hzbs
> > Cloning into '/builds/coreinfra/grafana_terraform/tmpus18hzbs'...
> > fatal: detected dubious ownership in repository at
> > '/builds/coreinfra/grafana_terraform/.git'
> > To add an exception for this directory, call:
> >
> > git config --global --add safe.directory
> > /builds/coreinfra/grafana_terraform/.git
> > fatal: Could not read from remote repository.
> >
> > Please make sure you have the correct access rights
> > and the repository exists.
>
> Here you are running afoul of the environment-clearing that happens when
> Git internally "switches" to another repo. The "clone" command is run in
> your newly-made repo (which is "safe"), but it would then run
> "git-upload-pack" in the remote repo to act as the server side. We clear
> out many Git-related environment variables when switching between
> variables, including GIT_CONFIG_*.


Ah, that explains it indeed. Thank you very much! And apologies for
not being fully clear about the context.

Best,
-Nikolaus

-- 
nikolaus@quadrature.ai

https://quadrature.ai
Dir: +44-20-8145-4726 Main: +44-20-3743-0400
The Leadenhall Building, 122 Leadenhall Street, London, EC3V 4AB
