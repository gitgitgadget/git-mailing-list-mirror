Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE0D1F583D
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246755; cv=none; b=iXhIZSwjpFqrb6zHy7MsZNVYvIBNG6x/9WpKDUBvTvjAuIsHpJn4KNC/XXiWWDiQUsBJsOyWEnZ7+ZJXa9O2HBX5/ZNG8Y/APJ7isE+/wE8mPd+JDsK15FrwaeW7uaeHWaaWxJsoPHQjtkWSsBBZfhyAf8gLOShMxrsgDtez8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246755; c=relaxed/simple;
	bh=cwl4PB/R8Dk1qDKHHPFBikdgys7FvhZfsPZT3A/4yHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9UHKxJavpXOgXAfzWDgwEFJG6nbxWFPqq3nSGlx71OSXDe1P2E9G3x98tT68JY1VaojGhCYB722FvX1ePxK7rWSkFi1lKsVyk8O9+KC8d6iH2bluRRPyzhCrqSgNQ3uWu8O6U0+tWRy0rPpjL2m5qjF8nUpN1DRD0/kAq5y06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=EKxW7hUX; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EKxW7hUX"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476b89782c3so56343731cf.1
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 14:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742246753; x=1742851553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F3BzTkrdLRRuby2QaWsXP7KzXFMuuPF0kolm3xnASAk=;
        b=EKxW7hUX9DtQ3FTX4um/Uxj8c4LkZuVVIL+KxsI3DTSVOXb9u4+4iP1+ksbZFGA55k
         8fuzHxEsEbVSS/TMmxhc+rtB65/9AW+spdf4IW+RrhT1O3TsUPxl3hELc/8B/qPOU6m0
         MHoYFQI1hrz0xAK2fQy3HjYCcqm9wFYcPV+tnPLbOPAGnQ1TxTKoStebo7R9brCC8S1K
         dzN4C1XI7an8TS+rNUPnPWz7QfHEwGeIb45kNT5Q43cSEmT6DeXr7ulcfBF8f/yxcUVE
         DWFJzbC19AlK4JHAmBnNLRJX2IlwtSmXv+317ZXOoSIl1bvZ9CAm8tzk+uG2oq29SD6+
         IXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742246753; x=1742851553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3BzTkrdLRRuby2QaWsXP7KzXFMuuPF0kolm3xnASAk=;
        b=btCptRDbte7+WJztk2qnKApaJdrdgOZbPabjin19lDQHzgiuIZ38+LKmNKJxJkk5c7
         WDFFjiUB8vbps7FxM2kF8R6ua3nHyihoAxkdkjdDdBM9jAJz8+nD8AgilK1qMj7fV4j1
         2M4wQ9pfdP0d6Y1rOKIp/W/kPD0RUCY8ULsj57o7ywa1aDzEtlUH5sKarmLkFrE1hJA4
         bcvIOiuJNQAMC5R8qOw4HR3Wawoc/X9yTl1tiNITOOZ0Cj50hVtroh8TX1/IuRjM4M06
         0yzal+RVqjrQAf5Dr8A6f4whMKUZ1u6ENZ09yICiHnW6Xp2lHSS9Q0XhdZxhCbv0csCJ
         hD0w==
X-Gm-Message-State: AOJu0YyxA1WnaN3kDc2E7JetTAObKwOYzEFpiOo51jvYbxo3bfu5UziW
	T8IHIqYhsurWxHLRqDmL3wdp6/oMZ3vzrG0dFkgdIjEWNTV+DNCHz8fgpOKSHDQ=
X-Gm-Gg: ASbGnctc9ClekwChGmsrAojU/XfhArc/kGmcvoHQoRY6k32KnYIYzesBnAX3PqeJdPC
	07sp1+Ob3Ihro7cj8jst1xxq0ZkT1X8CZlyYMDjWXkN5SOaI7beE2ppJ/NinnSdQw5i7Kp5Ic5I
	BuojvKf9hEiu6FFETphdfZFeV8shAowELfshaVAsP3x3S1FgKRGjKnAEj3M+GKZS2GWe9y7lvl+
	LJMEaT/4V3c3zSh5z4nQMYlPIvwrONUUsyf9VHroAt+I+rWSK6QQ9PIsRxnpY0yfSkLDx1WO0Ce
	ULaoGDk/kYeQVLYOXsCvw3GXkHlw3h8/7L2zosmcT7zmaIyXGLgWUOzQHWbbGjBImvPh6FN/r/2
	zIC6haSli086rrpx/
X-Google-Smtp-Source: AGHT+IEyQZzu4uwHzyq9lyFArLeZecMg4YcvRrrCa9SaGm9ByFXRmRJAccto7x89TQxHEt+gbJU+NQ==
X-Received: by 2002:a05:622a:587:b0:467:5da6:8096 with SMTP id d75a77b69052e-476c81de4damr220290121cf.44.1742246752791;
        Mon, 17 Mar 2025 14:25:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb6082d1sm58391001cf.12.2025.03.17.14.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 14:25:52 -0700 (PDT)
Date: Mon, 17 Mar 2025 17:25:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/6] Small new merge-ort features, prepping for
 deletion of merge-recursive.[ch]
Message-ID: <Z9iTX5D/eiFcPAhZ@nand.local>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
 <pull.1875.v2.git.1741834001.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1875.v2.git.1741834001.gitgitgadget@gmail.com>

On Thu, Mar 13, 2025 at 02:46:35AM +0000, Elijah Newren via GitGitGadget wrote:
> Range-diff vs v1:

This is already marked as ready to merge to 'next' in the last WC, but I
took a look at the range-diff and everything LGTM:

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
