Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CBE176AB6
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110835; cv=none; b=M0BsQTXFzpr1kZmCKI23vyxt8qZ+rP3ZeOe2rdFxPOOj8NXPr0dhs1QL7x1R9p86ndj1pXZZjxS+Ig3SFnyF2QVEyYKhTMpJQ+qfW9/dwQ1HkHe1zj2PolVXXZk8+t9Jyx6Hc3LkdKRnr8EWqEP937QM9BYl7g3CnRRdvD971hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110835; c=relaxed/simple;
	bh=CTFySIQMvg5ERp2LohyMwcWdicR7NTMOfBORzyYVM1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maumI7VDqkbdwaa9NOizGCh3FygE2GAwjl60YDP3hcrlSEGkrcoOV86xZ3RHD/dUbreYheCozVAWjGaQO6PhTklgr1Xs3S8OhMoHen2BJGw0MCPQ34BWe5Bi/QgshrwaAsOvB064WKMR3mCl62bwkQMduLyS2/V2OML7OveP2Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=QA0qSZsf; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="QA0qSZsf"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e28833f1c31so1198969276.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 13:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729110833; x=1729715633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RZWKt+jMI8E1o7L6qFwv74B8ZHhJMW9R7cmJLjWt3iQ=;
        b=QA0qSZsfH24rDeTkpNdh/UUlOpybfvheH4olTM0Eexvwasrd/wCQefCNrmrXmMYEBb
         koG2l0rFb3YDtGU6Ysb0TSNWWn3myxZ2lbOiwg2Rnu4ar++mPLURlvhemTuxIZeCisem
         JmL6zzbyS1Foj6K3D/kZFysDJp58gJIbgLld+MRCxlLclXvSmnXbilKn6LnoQwdcETgd
         /0VMu0Y8XuZG897XThrNOr1aGaONLAqLF91Z3pNTGoP7oTn7faSqmJKGcbhO7juNH3sk
         /7cYdS+FyqmcKgw9x2V4+ek7FoFMrilB6U4KTNxVJKUKxTPvjtmM0ovCAXtTb8djXz5x
         dWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110833; x=1729715633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZWKt+jMI8E1o7L6qFwv74B8ZHhJMW9R7cmJLjWt3iQ=;
        b=QVJvWxPcrXanOWTkdU8Kp8PzkQbpWzpyJaXwPrsP0GNnKWHCcQfbZeNdX24fgejVWv
         YJX3KRgXi7fQWFPKbVl4bHc8gwLnFi87NquDGNjNBas2gZXqHydZmRDHZFSxGb58vCXl
         udRcYH39LdYW2yKTwWBNqVkmpSOYutt0bJoxOSrB/0CQo6wH61F6gUwaH5iabKOr7a5J
         4+TYv2/VxIebDLnXaIXFLWmdfB9jdrG5PB7Nj0hU9vlvO38ovYKf0rteQTT2maqt9uNh
         LTq4WIq90LtkZ5qXYAbHKT3xqlDQL8xSZw9FQQTQWJzkXxjDXZYFBm1ehC8RKrCL0SlI
         TJEg==
X-Forwarded-Encrypted: i=1; AJvYcCXlZ2UCeWqrgWs/dqjH+21ZzSnHmKccbZxPzZw+mPOwz90TqdSJNU2wnA6XaqLUE44vpas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyRMDHuEB1sCBXUNnkiJevC4LRuUD725Zu7/xBzFZ+j4L12vPz
	6WiSA5k+QT+SjPGUzJ4C9uBYedHiQhku7tzFImNQyMo+u2zIcjb6d7xXowQEo1Cy4XeGpI7Gb2K
	O
X-Google-Smtp-Source: AGHT+IGoN6iVqf1H6qa0fsKJyLsYhm1x3VlZdc/gdk+XYRfluYKBrzbwJbU+MbEVVVxcn+n2QlyE8w==
X-Received: by 2002:a05:6902:f05:b0:e28:e6a8:d05e with SMTP id 3f1490d57ef6-e2b9cde22demr977198276.2.1729110833212;
        Wed, 16 Oct 2024 13:33:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296cc220a6sm697329276.38.2024.10.16.13.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:33:52 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:33:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: phillip.wood@dunelm.org.uk
Cc: Sam Newbold <sam@rwsh.org>, git@vger.kernel.org
Subject: Re: core.hooksPath cannot revert to the default locally
Message-ID: <ZxAjLrrqM5i2kdBz@nand.local>
References: <20241016022613.37813826@scaldcrow>
 <dea863c3-7b54-4f8d-b6b0-6087b4cb1abe@gmail.com>
 <932d1aab-26e8-4c27-a3dd-a7191e8e71dd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <932d1aab-26e8-4c27-a3dd-a7191e8e71dd@gmail.com>

On Wed, Oct 16, 2024 at 02:42:57PM +0100, Phillip Wood wrote:
> On 16/10/2024 10:03, Phillip Wood wrote:
> > I'm pretty sure I've used "git -c core.hookspath=/dev/null ..."
>
> Looking at the code that will unfortunately disable all hooks including
> the ones in .git/hooks. It would make sense to allow an empty
> core.hooksPath mean "use .git/hooks". If you're interested in working
> on this then I think doing something like

Thanks for providing a helpful suggestion.

I agree that the behavior you suggested here when specifying an empty
value for 'core.hooksPath' would be an improvement here as a means to
override system/global-level configuration.

> diff --git a/config.c b/config.c
> index a11bb85da30..91f190a1ce1 100644
> --- a/config.c
> +++ b/config.c
> @@ -1437,7 +1437,10 @@ static int git_default_core_config(const char *var, const char *value,
>          if (!strcmp(var, "core.hookspath")) {
>                  FREE_AND_NULL(git_hooks_path);
> -                return git_config_pathname(&git_hooks_path, var, value);
> +                if (value)

I think this should read "if (value && *value)" instead, to ensure that
things like:

    git -c core.hooksPath= ...

work as expected.

Thanks,
Taylor
