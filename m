Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B522D3756
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123785; cv=none; b=fWLxpD/aHnmwAhKlMvL6+pMSEYpNP+lYKj8MTawVxp8crZT2Rk0NIKIHREYAOawGNMFZ7kMOaMbGHOXYpLH/D6jr599FohhI4auPigdL3Yi4053+pS6pxw/P9NPth462bLSCcU6deAvCqmHEceCTHPT9czz5o0wA7UYpvkzvJJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123785; c=relaxed/simple;
	bh=jt+rRXNDl57i4EyeHbuiDSpX3Mk/SX6Pr+nNk4pENng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5GwmVC/DlZqZVHSfbi+6EMwfJWBoPBtWYqvhzjpemY5Z0SU03OwxA7BpFF0W7PX/ZAcrfBJBzJ/vt+eIHgrzVXc1xZzyx/jZRjk0msfoJ2LguuyQzmyv2Iq5Jp9WgbY8gYoSSz5Z2WFXR0S7Uwi1I6GQ4XQJGKz6qbfzyK/fOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jd4XtjAH; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd4XtjAH"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-757a43dbed1so2598799a34.2
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758123783; x=1758728583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jt+rRXNDl57i4EyeHbuiDSpX3Mk/SX6Pr+nNk4pENng=;
        b=jd4XtjAH4pJKo5oLasSdV/pjrAELh0lpQvXeSWWvyjeRHul6qCDw/rqWST26Ar7C/F
         raf7UF+4ulRuUYq9N8RnIIBe0ABYlfLwKrs7z7tUJZYh9W3mN6w8jCWbZXsLyb1SKMez
         jK5SfsZc9cejyOmhds6zS27v8Fe/XOgl7LEnxVj+329c+AJt8T5P/T9TIyTEOJv/VxD9
         ztkPLEBst7uywyhAe0oCtqQHTJOfxTK1V3ugbbAMnQIft4jVH/NDbM/PNZZHFkHQcnpi
         aLaCormypcBw9U9DnlwWHFu2GfOAyE52mVho6l5g04zp5JQ4GYKcPR1yTD3kLQZsNO5F
         k0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123783; x=1758728583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jt+rRXNDl57i4EyeHbuiDSpX3Mk/SX6Pr+nNk4pENng=;
        b=KBM5HYcp466KiqXlZ+UyJTuwaGSFBz+OlTIKRGTX6vna0z9eJbi6XkPXVnTa3M2Jjo
         jxeCn7nPUInBjnRjYjqg7Ed7BkqKBPPFc4L4RIUzgfkES26ICiTuRTYEcV8k/8iUhpgE
         na9FSvZSS/oKPEsSU7euOgpJag1WM38F47CWqiHSFOUefplr+rSAq8FterNq/N67XJLw
         BM8WypbFlvOsjRNMT6/f91lsKAZwmEM8oFyLVMozC1lTGyOwWZXel0ndfWjULYDmzPPB
         mkqSbm02H8pRJkspEKbP4Y1p0SCvLCtoxTrnyWnURh3OIdggLCV0U9Ueil6aSmc6xKXk
         5TYQ==
X-Gm-Message-State: AOJu0Yx34b0a19OFFLa+ASgWkAl1e9lVH3lC8ubbMojh6WuPTRZwoVAE
	ziP5VFlaRQXZ5HLSedOkYBW7qQFbls/p8iNz2y9ZUidA6/trrFxPGfdL
X-Gm-Gg: ASbGncuUJ+LSaUYcNE+Yq8Z2bT6qDz4Ne3Q91AaLvPZqrVfSNMwrI9pAbxU8kIZ8gxP
	/lfj3+hbBIeN0jZFY9loIfRmckQNVfV7+GMSx8cuL1JDPPZJ7nW9j72J1Q2y3hT4K3zOZy0ihDB
	oLygdVnzc7Tk++jt15A6CUAyTqIbwNJ6cRl3e+W5w99dZMr1pvBCIV6+QQNRlVHbMLUUMuvUhNr
	6Cva+cSrOar2hJQyX23CMwRMeO+2dEp9oTQFF9MCflop9rSlpFj5zjxW8l1pvx/G7//s9K+vOlD
	FDGWUEv/p28sflbavhBRc8lzXuW53AbgXniFq56vV8OhY2xUqSAclkauMiL7MaDSS2rGiZEMMRY
	m5uVZhdST5WfcgQmv
X-Google-Smtp-Source: AGHT+IETQ7j9Eq6i+GwhDBQwMW8X125WCdNrLG6E9f0t+do9d8e4Pt1BzHTPLmjxc31uWEQdjn5mOg==
X-Received: by 2002:a05:6808:189a:b0:43d:28fd:610e with SMTP id 5614622812f47-43d50a94b16mr1120917b6e.9.1758123783290;
        Wed, 17 Sep 2025 08:43:03 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-43b82af7ab1sm4377669b6e.30.2025.09.17.08.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:43:02 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:43:02 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, 
	ps@pks.im, gitster@pobox.com, toon@iotcl.com
Subject: Re: [PATCH v4 0/4] refs/files: fix issues with git-fetch on
 case-insensitive FS
Message-ID: <pjvwiyrcdrtpkeyro2mvmfljj6a32u7bhli7ry2cndjhn4pi22@6hzanr46cyij>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
 <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-0-da3c74a08ed0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-0-da3c74a08ed0@gmail.com>

On 25/09/17 05:25PM, Karthik Nayak wrote:
> Changes in v4:
> - Fixes to typos in commit messages.
> - Use curly braces for if..else clause with inlined comments.
> - Link to v3: https://lore.kernel.org/r/20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com

Looking at the range-diff, this version looks good to me.

Thanks,
-Justin
