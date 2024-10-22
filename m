Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7B66EB7C
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618181; cv=none; b=MdS2KEYPAEW4nymWR1VA1N3GckX/pRWvGaghecnalobMioT82ZsN4LnE2qB0kCl0l4BujNoVnqUAl8DnXZHLaS+aRkvQwy+tldzW6Dy67toOUtHAIptwUIjBM+L0seQkF65Kvf9hsxuO/wFQDkoXpAULRG+P+pukl1vjhs/tEhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618181; c=relaxed/simple;
	bh=EyUHdT8KrAiYRhtBXvJvj6ZnCHHix24d4R3TmSuvvwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6ySLUd0sutq0F+veVze0Mf8Fw8b5VjgReuQoIThc4MBeGEcNg4XJSqUCvt7t3a+qR3vWUtV2aqwJ8TJkRl4YOZbFU8uEhVRG8wQZn2kXEhjHb68oRpslmPh+TwZXJDreU6YwElZftJH1Ql4U9bJQCp012PWi4Y3RCYlL9ZGOrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=i3tGK+nx; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="i3tGK+nx"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e390d9ad1dso54318407b3.3
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729618178; x=1730222978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPKry9Umb6ztjrWIwNa5jBjglFgxV+Gm086dKYq5AEU=;
        b=i3tGK+nx8WF9jJK0h0IvGsHB2L4zdErr8XXD1o4CVLutlZCww9+DYQFX5KBGeFCcOZ
         zVngSHwY6zzrY+T7fqMhXXBFmMku2+1Ya+twJjn2Xuc/AGUrdsHJMFrd+VRvqW2BFKwQ
         DLHpfpm+RREIgkSIKafb/3hIW9Umjc7qvxl3UhhWG6XK4Pj3J31lBOACe/oxXZoAdiL7
         ozb+eQ45jg5AAtLqDc+4QHC0xu9gMBz699m3EuXCKrZChEh+kTEBvaGqwirAnBzkFdZD
         hFW1+/dSq88m+g26nTR3P4axwp02t/Z0h2zSmM44mf9R08qXq3qax7OSft3j2IiCx37p
         OkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618178; x=1730222978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPKry9Umb6ztjrWIwNa5jBjglFgxV+Gm086dKYq5AEU=;
        b=MkPRnzdT2kqhEcbPXzaV7b14yAunrL+nWnYSSznKg9D5G+l/ilx2v7aYw7cJX1eufD
         PjDSUDRYbfzoNl8oYasBzK1oQB/r/lKldQ6XaQbbWc/kQI+dJrZfryzrEsalZc2ECxVe
         YGFFduq9Lf44ZMTMfIZPlnS21VPibx9JXKciajPVlhi90im3ZdSqHK5XW94NGnhObQAr
         DUdTeUX4w5+iSwDsFdooKmVd8Ad6stXWrk+5KR/KW0zprNWM0n5wQFxuTxFNa/WlARQB
         hUb0ZsnskhK2f2BqnjIDqv4MKAKo6bnGg6Rt+O1OzyXqIxsW9t3urAQAQl01YpAwgngE
         9xog==
X-Gm-Message-State: AOJu0Yyoatsqs6tOKO4AhgtpzixscjnzqCpuQOV1MwhW2S5ksGDRxMXC
	aj59rA/pJ9keYnJ5Vip670YQmlitLRjjP7hq1tDsGYYhsHY4OFMAuHNGaDQ4ePcPIvqY5ZmAuc3
	3N00Whw==
X-Google-Smtp-Source: AGHT+IEM2xONr4D+AoQsVVSC+Y1tXrkVx3wlMowG9dGPlgEiV7X2yGQwoPMNzvdcFJQUMT5ksDI6pg==
X-Received: by 2002:a05:690c:91:b0:6e2:f61e:c53 with SMTP id 00721157ae682-6e7d82af29cmr34848107b3.29.1729618178378;
        Tue, 22 Oct 2024 10:29:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d1317esm11544957b3.127.2024.10.22.10.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 10:29:38 -0700 (PDT)
Date: Tue, 22 Oct 2024 13:29:36 -0400
From: Taylor Blau <me@ttaylorr.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com
Subject: Re: [PATCH 0/4] Documentation/git-bundle.txt: promote --all for full
 backup
Message-ID: <ZxfhAAgNlbEq60VB@nand.local>
References: <cover.1729451376.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1729451376.git.code@khaugsbakk.name>

On Sun, Oct 20, 2024 at 09:14:58PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> The documentation for git-bundle(1) now properly covers `--all`, the
> option that can be used to package all refs.  A "Discussions" section
> has also been added to address the naive backup strategy of copying a
> Git repository manually.

When applying to 'seen' last night, it looks like this topic caused some
breakage here:

    https://github.com/git/git/actions/runs/11449483611/job/31855169149#step:4:144

Would you mind taking a look, Kristoffer?

Thanks,
Taylor
