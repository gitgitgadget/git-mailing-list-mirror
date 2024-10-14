Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E5143722
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943939; cv=none; b=cIODQvogv89wrlB1RrDYWOIFdV8pTZ5/qWM2B8dXAyOaHeC6yQoDgb4Wf7bIX7nTGih/Zt4KovC2oJIq2y1AwxkPRZWjhFHX05haySL/okQ3VgmkVHzbj52yY8oODqVUruy1lmh6VotBlgA7lufiJIVAO6orJlMqS9Rp4stAtYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943939; c=relaxed/simple;
	bh=Z3FkfSkNMf6zpu3pBnmVtT3kOhvVNxpXw1b23ThNkbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+Mu8Xx/U9oha1yL5RsqlZL9Bb89Hv1vmF61RJMa4+0zhJ3F6fLBHAJPzOug5cGbTsBdVdukmt+U2+ROB6ur92Bb34fESlFZIHO4srd3xREA9iq3jjJ3bbhldZ+Y6bFs6PuZ6tRYpw89ZHgQo7oX8gJS1AMO11egOmoXHW9RdrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=c7WvV7ol; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="c7WvV7ol"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e39bf12830so9392047b3.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728943936; x=1729548736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxZKS/Fj+pVyy4BY4+MwQENloXCTP+7WQ0fddBxw+o8=;
        b=c7WvV7ol+2TkqyZOAJTMKa0MML+BlOk4xIMIzpSD11AmNgRt/q/eLjtfyiQfL4X1On
         nN8R2JTh/cnKk+sMtLB25W5VzJZafyEkomwg0Xowy0KprahPkXvUnk6lSolv9EeveE3F
         HdLocYD+2zdFyqJH0C3K6idFqZtpPuynkwhwbm6k5gvM0PUZkw4svdqH30Nlbt6mkt8d
         gCVm+fWrjO7IWd7kUemZwAZZfkjpuRFAPZ9MfaojTevEw6yJsp4igTZyXspmwA0+tSqj
         ZbNoxVx7oyCI5qDmMHylSmhUNiKPhWHmhnSr0+aaqyZfv74QucX0kB6IWiBPPWivGzif
         V6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728943936; x=1729548736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxZKS/Fj+pVyy4BY4+MwQENloXCTP+7WQ0fddBxw+o8=;
        b=VfSOVRNL8lAkO4IwP1Dkt82llY0xDiamrme+8fo/z+myxtyow1ICsKzOjVVGRKtU6H
         jy0+5tIYmDm/H7nfZfNdN3QGS+cD2G2Mbpiie5My2TM/9IxaDAU7pmuhoy+mHb9c60gO
         jYPXE5ectoS/MT3TRRhmQpcNABrdj/FjvwjvPTmWJaK7J44md73YSt/IW/agrjftWFZm
         bXPYEfZYfak0U2NGHEKhVxiaaj79qXl4wbwcnpCMgxgvAJjUzT5FLJsgQlGSgnd15DB0
         FKgHWYSsFbxGtR9vG++5Z6YHeFnFi4o6z9bIZfvGomupMq57fu8g/J1v0CmZ70qgXtyk
         YpvA==
X-Gm-Message-State: AOJu0YwT0sM3CDjE5h+K/Vfx5C2kIVXFQwwPs4lvIqN/Xlwa5qCxAA4G
	8kQn2klk/jzg3Jk5Br+evHURIFxnonlT5G82+ZhnqO+/z/xWqXFcw1eZjn5b+74=
X-Google-Smtp-Source: AGHT+IF5bMY+wnAbFLubK6dGeXLjLtqKD70ZqFJ3ajQecAEAaKygTTUCdsghXy4fCC9gM+x7tj/+cg==
X-Received: by 2002:a05:690c:6e0d:b0:6d6:afe9:d818 with SMTP id 00721157ae682-6e32f13b262mr121548157b3.6.1728943936646;
        Mon, 14 Oct 2024 15:12:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5b3cf90sm74217b3.39.2024.10.14.15.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:12:16 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:12:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/10] builtin/credential-cache: fix missing parameter
 for stub function
Message-ID: <Zw2XP2Zps/nAFwRy@nand.local>
References: <cover.1728906490.git.ps@pks.im>
 <8cce69e5ba63d02ef4eb1e8cf56f47443b5bb1dd.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8cce69e5ba63d02ef4eb1e8cf56f47443b5bb1dd.1728906490.git.ps@pks.im>

On Mon, Oct 14, 2024 at 02:21:37PM +0200, Patrick Steinhardt wrote:
> When not compiling the credential cache we may use a stub function for
> `cmd_credential_cache()`. With commit 9b1cb5070f (builtin: add a
> repository parameter for builtin functions, 2024-09-13), we have added a
> new parameter to all of those top-level `cmd_*()` functions, and did
> indeed adapt the non-stubbed-out `cmd_credential_cache()`. But we didn't
> adapt the stubbed-out variant, so the code does not compile.
>
> Fix this by adding the missing parameter.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/credential-cache.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
> index 5de8b9123bf..c51f7fc2ade 100644
> --- a/builtin/credential-cache.c
> +++ b/builtin/credential-cache.c
> @@ -189,7 +189,8 @@ int cmd_credential_cache(int argc,
>
>  #else
>
> -int cmd_credential_cache(int argc, const char **argv, const char *prefix)
> +int cmd_credential_cache(int argc, const char **argv, const char *prefix,
> +			 struct repository *repo UNUSED)

Oops. Very good catch, thanks.

Thanks,
Taylor
