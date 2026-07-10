Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047CE3749E9
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704367; cv=pass; b=Yu9iaQ4BXHLJ3WVeoFWiuVE40ZDc9MBLwaMOzzgaip6/mICx4z2t5Y49o8BE/xZ1FXN/dyXk95X+tyQZjtxIIOdLD//1y4Wxi0qn7TCnu2c4Xs/g3JGOk9rCcBgQSzD9Bss6iPmIrt7HrRvVFfpQ1xf0XneqcGYwJFD64gqRbPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704367; c=relaxed/simple;
	bh=VZPznpiNsJHpucE0AjHwMwDl9UVieelXeHUuL3XatbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bmvod6E5zBpSv1+RCdj2XA6yb61QVPe7+4lbhUwr+PB2uu0JJy1LbwhFUC0MzjYYx0a01ORrzj2Z17KMikHJ/M3hQbVpI05RJbF/256/EYAMXL58faPnWSVX0fZxNOIeLsUuqNDuWN9cNpSznCBAMcQ2zzMfQ/BH8bkQLzUhLyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p38RBs0w; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p38RBs0w"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698acd36d67so2328517a12.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 10:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783704361; cv=none;
        d=google.com; s=arc-20260327;
        b=gzlQSeYdIx2KDk5ZQiGDYeSISfx8n5/d31Cs5gapK/FSxAutiI9wpCZJe1oVpYK4Mq
         lhiUdmSqtW0ahk2elNIOR475juyBGaiHS9zvUjqzVSbW7LvfZOaxUIk5x0cDb67EUrS3
         78f9RB/MArARAE71cL8XRakof79OUY5kK84eZLx5aXDc0WQJtj5wPWZ1pfCsPUZP15PA
         MK/vrNWe6VaJJ1VrPl6fjidyJUo3gu36sut7+8IUXBzwAUqIcrELdKc1iPHFpNR4oo43
         CoPmy/hxF/0qHqesCcLhXdRiOZyxSeHmLEobhhCIxxRQPzbCYUSJvBLsMW8Beo1Z2REn
         5lYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VZPznpiNsJHpucE0AjHwMwDl9UVieelXeHUuL3XatbQ=;
        fh=AAQ8PuHym//0EcWmTZ/1TUkqkrBa2gM0uU8dmypJ9hA=;
        b=ofp6NHUm6O4UHvrYfk0DwXf+jTvP6rUPsU6qcuLWIr5s79+mkFpITZ6WMDkKx3+rdE
         MtojPE2bAc/Q91ZbYT/Ep897Z4Z4K9CO2wNOIn+8cMi71FCcdCoXPdrkw3hZaAXPSJBV
         BXYgpc1QcyPPzsDFo7G0FGLhZ/AHwyScFx01+QfDz7erhuKsoC+HPZGYHbIoH9J/OZWb
         23auDvsb71h4V8u9IaAGVcRdQW2HlyJknSXQagQ415NCW072cmXk2GdvRRsTFtXzHUG4
         RyXxP7h0+Zrq5/rqIwIkDKyte411hejAI3fZgOl6jzb5XgMG8BzZ092+rO33yHnMbNvp
         Mdqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783704361; x=1784309161; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VZPznpiNsJHpucE0AjHwMwDl9UVieelXeHUuL3XatbQ=;
        b=p38RBs0wXaNoDbc6BKHVuA+2TV0uUlq8zHI7QHSTNzbrPFgMn+ZC2fZ7ejHtU7a5nC
         2DUwdm2H5XqLXT8E+XYDXuO3tlic4BcJSY68X4T+ceht2L1VWU5EBkzra+dUqmZp1UFL
         P1eH6kNnkhbqUvQJRoSrqpOxOaq67YtJFCLLaaOlCT12zxMYmIvh7/1AK+Nqn84xOGDn
         bApdbGCwvXbGoh/eTDdODm/409BP+9VKHnrrdMFvwpj6P691sOnYZYu0uLEGWqLgMCI0
         KA9IhcNOOiqIqeUaqxbRmZg1ie7+yWIa7lbZNa+WnfrNAjv/6K2WCzifZ1nbLdFTTDTp
         DyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783704361; x=1784309161;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VZPznpiNsJHpucE0AjHwMwDl9UVieelXeHUuL3XatbQ=;
        b=rYegZJoCPEmrH+6sY+8GBsj4/Amq21/CShwea4k2AM2WkH2kmxPGEdCh3zuK1/4/K3
         ueB9xJ6y/VIZ9gmTWPnpv4/pUR2MR9FGoJp/XEXu5LSHbm1UdbOqBMO4wZSH6WuJQfBH
         iHktgx8CyqYgrEdKV5+NcCR/nX3447kH5jf66dH9qF+5rPF7S9DM8tfls1c7eMifp6Kx
         ilapcqCKxHCqTciwLS0NXQdM7HurcJmPPJ3zBn6/eGa8Iv7zSTXNP1loVTfBMZ6vvlnT
         FdKbDuA+BgFDWAww+4kaEaJdv2OJb9NYvmjNZaBklQFsxThg+B9Gw4GYAuIl4Ompxu1n
         GJ7w==
X-Forwarded-Encrypted: i=1; AHgh+Ro9Ih59R2vl3+vdW6EcY0mFtl0qbAnZ6YOlMzGBqK/WybnvyTXi6VaidJtyYdWODi3pjSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnRy9DKnSgQQ8Yl8SNkqITOKdnt3xpCzwZLvpOoasxWbIQ1f4
	+TJeGaEdpoRNU8VZB6x+ptDDKJHO2KHXphB8iKTjcFOLkkvZUwnDuIs5qFpHidIgHc+WmuolpyJ
	SOcdoB+jPx6+mqSajc1K2HUcu3IiRmRI=
X-Gm-Gg: AfdE7ckWptE2C6Oh10lwMLvnacUaK7T0zlApkgM0uUEFk+2J1zr8OmTqkSF4jI3lfIB
	8/86Oon4396tRaYrtHRnYfI8BPJ84Lg2z9Gw45FJWbRj+ayE72zcsQ4oHX63WrqAoraj3boBatO
	EZRkrOcJt5tn3txsiUAiwX1WXv9uZ5+kbav/S6hVYBEavId1g0TIZ1TLnh9FbO0wcrargG7Ioob
	gTgbPTZbysLD0ggcX47xCUW0Wj2BL1pQsPu+DPKzJss3jEipSanTxP+Q8/f30lwx1M6GhRm
X-Received: by 2002:a05:6402:c43:b0:69a:9355:d1c0 with SMTP id
 4fb4d7f45d1cf-69c5f251b7fmr86630a12.42.1783704361267; Fri, 10 Jul 2026
 10:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com> <cdd4fea4a73e39a1f88127037d806c9b6182d01e.1782338106.git.gitgitgadget@gmail.com>
 <ed72dd31-5d68-4e78-9123-7061b388ecaa@gmail.com>
In-Reply-To: <ed72dd31-5d68-4e78-9123-7061b388ecaa@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 10 Jul 2026 19:25:24 +0200
X-Gm-Features: AUfX_mwt-um9EUFI0KTPkaiAWt1bfk3wF0fTB3RPh9PxHMni-aqR4dAIfeHLjew
Message-ID: <CAHwyqnV6kS8ZmfXm+9JttoJ=kWP4kYdLGX2giASVMSRXVKL-Pw@mail.gmail.com>
Subject: Re: [PATCH v18 2/7] branch: convert delete_branches() to a flags argument
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

> This means we have two sources of truth because we modify "flags" later.
> The idea of replacing the old function parameters with local variables
> only works if we're not passing the flags variable on to another
> function so I think we should replace all instances of "force" and
> "quiet" with flags & DELETE_BRANCH_FORCE/QUIET. That way we have a
> single source of truth and should avoid any future regressions like the
> one we saw in an earlier iteration.

Yes, it makes sense.

I just hope we remember this discussion, so another reviewer doesn't
push in the other direction later because it seems like low-hanging
fruit.


Harald
