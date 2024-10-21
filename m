Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E0419E968
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541123; cv=none; b=Y47EJfHa+Z/0gLQb1/Z7vm6Q7f8XX6ADiHH5hA8lE5fahsppKoU60T9Fj/OkMst0jpUh4rmdlf66ZotGuON9fFnfHzH6jNro4fOHtZiAWHWmDVBef51a2tSwcz25ok6mkPKx84WpND0qyCPKC46D4nK+ZVyEI5/+UeqAN7gs+8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541123; c=relaxed/simple;
	bh=ffzi8292gHeAYSFrNYlNVGw0QrbJVJwxEMH4WXstCe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rllnu+/aFoPDQERRzkoQwIpQ9Apu8/Jo60xQCjtS1eIPS33gmjJZxALJ45QMbb6WfV+mnRksKIrRy55z0jeZDSC4TmhdhPcoe8KIr3yq3rLewmVvGVTh9GtjHStXILgOXzDKOqokrkuNz+59V+9g9wypOtoe7iTn5u2M9AlcAZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=CPJPOAnu; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CPJPOAnu"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e5fcf464ecso2562237b6e.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729541121; x=1730145921; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9C+NfEumAsmDekkZ62V2k/TWwPlr/j7RW4wi4OUqOZI=;
        b=CPJPOAnu0wV1Rll5MvAJ+TSOQ4UCxryxbd/1Fj/pbdC8TSdNoedlqoP+TNP9SskbcN
         YgfTGduT6cwttK5EZymtQJteiKadNHgU34LXrZoOrMHaCCsQvRs5ys0ZonN63T5Mw30c
         OKWeIcFNCtquPdgNl0jLK8ph2XUbz0oK3SDdCl+VHZnVFpTDQDWoJnKRz0iI7y5S30+n
         REu6zmy6d7cO82kG+vQIK/K/zDxRQzlpjmw60Rhq6x88GzIJ6jdwpVgJBAFg7rEK+JO+
         xhrQrP7WEuihI6jRST46aN5q3RYcSRPuH7enm1rikxnpWLcvmxOlb6oRW0e8GS2Ov9eq
         eZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729541121; x=1730145921;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9C+NfEumAsmDekkZ62V2k/TWwPlr/j7RW4wi4OUqOZI=;
        b=oUq9LlbfawW9F17ByW48y0MnU0Q6+OFmpTO8/9d2aRsw5gvGFM7ynm3mmOcClxarsj
         xooZbSvD/H6zROss9ZuFpmc67WTk5l7lNE9zkGTVqHHXyv7WeB0048JH+TiRnbYp0PIh
         r9g+45+NIi6W2g8k9+HuyncRZKCuqjxxGRm4Ke84v2el7jnQwEBDXkI0t8BZJOiBM4kI
         XIeLOo1uzkSGxYCXXf6mb2LFn86TiGtCFpyne0eOv918qfgZJ9RJSe27hCFkQvmiLJlX
         7QsWGpd34YDm/eUWQRlSFrpEhkXEv231tIysy1coZO4jo2OZFFk8wydQscb833xkkLNH
         Kilw==
X-Forwarded-Encrypted: i=1; AJvYcCXBggxvg7ww4zo5X2toKm2MJSYCSKrOdxOIas+LpU4tB5UgOQrh0FTI5wF63Ugq5gv9SQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1wGYBc8KmB/+rpCl+s+e3GzhMg5qNwIBG+gBA7JmB/BH903dP
	gziFWjYjL1ofLiGjujiFqH4s+CDYx7+zhzCFOEoDGAPIi3CwubIfTbNXDkz3mI0=
X-Google-Smtp-Source: AGHT+IGxmPq8Yj5RjGGjy2SffrdVEQdqiSAkLr7diMm+CTmjC1LronUGcxGv3usIXdjhQZJK0b0C2A==
X-Received: by 2002:a05:6870:71d2:b0:287:29a0:cfe4 with SMTP id 586e51a60fabf-2892c4f191dmr10085769fac.32.1729541120846;
        Mon, 21 Oct 2024 13:05:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d085d4sm8013767b3.121.2024.10.21.13.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:05:20 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:05:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Sven Strickroth <email@cs-ware.de>, git@vger.kernel.org
Subject: Re: [PATCH] Fix duplicate word typos
Message-ID: <Zxaz//QiYvOpRvZY@nand.local>
References: <b50f9706-bb45-4bf0-8d32-59149615301b@mrtux-pc.local>
 <e1ee980d-d8d2-4c9c-9a73-ba6af9009ba2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1ee980d-d8d2-4c9c-9a73-ba6af9009ba2@app.fastmail.com>

On Sat, Oct 19, 2024 at 12:06:54PM +0200, Kristoffer Haugsbakk wrote:
> I can confirm that this patch only does that.  Except:
>
> > ---
> > […]
> > -Suppose that that central repository has this history:
> > +Suppose that the central repository has this history:
>
> Here the doubled “that” is replaced with “the” which makes the sentence
> correct.  Good.
>
> There are also no grammatically correct “that that” constructs that have
> been removed.

Thanks for a careful review.

Thanks,
Taylor
