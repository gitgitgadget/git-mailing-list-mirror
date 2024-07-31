Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8D01B3725
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445272; cv=none; b=QxQWG3G3RROWEW4A+ol4FAvIKWBO0EV+LBzgl7R12Pc41Bg7P8fAE/lFJ1kJxp2Duen0PaKmD9Cjm0Y4tL/J6plSJ2nqVWpQQ3UiboYGWKXWZOhA4GLnJn21MYEZiXv8J9yYHSd314TMPnl0ngYtTJQNo9w2QD5R2fGt+5O2ea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445272; c=relaxed/simple;
	bh=QL58rpEGdFm1Fg+WT1C9+OSQOzfBEWl+LeGAcOGO7UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHb5R/z/xOP3Uc5mGcf4qktAX+hNAMuozcxKMtTRQdd60WhEgbOAF6KObDbzLWDLt5c16usKKDCfaWkr5iB1vt9FiMgQMFUWKgr/C6SrebEnddWygHqRhxQJJuRoRCu3gTwSwuU88kQ7/ZepgAr2iJt/k0t0ESmKxVpEH6hC+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MqvXqHAk; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MqvXqHAk"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b797a2384cso31169676d6.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722445270; x=1723050070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vAlV9bpEvvi5R6Z2azECN0QyOnwtq7byOxo7eRFH8HA=;
        b=MqvXqHAkK9jQZoEpdJu1P/PsEABcPScc/lj+Rc3QA/J9IJ0epmlBx0dUh8gulITJQC
         Cy9sxnlFh+bH0HjkX7jSaSOvLaEg4d8dDznZBRJNnT8D2OT5I4L1q4+gIrarJ0420pd6
         nGVXxjZhKzRcC1IrPM7psAHF7ErrOu7AKbDz8patf9xvKjY0uuyTTlufEkRBeHNEU5Zq
         naM4PowCpkLdFCaWwvbLAO/Ru9tM1AaTHlEEbh7SDNSZusdm0+5WqiQqyh1btSpU+T7o
         8HfzXjExZ6PRfpFVoDM/qzmi4kR+r9mK2//nIdVR/K4ovffX3vN2HUQ11zESTZlbvG1D
         XBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445270; x=1723050070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAlV9bpEvvi5R6Z2azECN0QyOnwtq7byOxo7eRFH8HA=;
        b=ttuxEDGxfwV6KR0kJskrkv3Ta9x6cdmUOanyRVnLRDRP+SiyBeXIHUYD58AHYvV6hV
         dPhRc6pTQXPW+kUoMgY2wmJQ9mfkFyXiNKiy+GubPCIWBZZNDSFCp2dHpsGGac9XnPco
         jYiUvTWZ0nDajSmWtTxjA8xgDNz8Fsw1Vi4Ecolqte9fC+FjBQWNqVLay6KqxM9BDDPE
         4FA3FFnbiwgdrdvT4LRCksA+Xdd1Ooh/khY3igfSo9WCpzipKcmf83iF08Rb8lR8f0p8
         aG3KIhlmXVBGyp0QGGNCE34+bmJj/0dXCMZbu3r7S96wWkNRspa3JFg3jiMtdfniXtss
         jNrQ==
X-Gm-Message-State: AOJu0YwtTrM9O/XiklGdji5CI9ANUhGz4jRkPTY0uK+96uK/+mBbPJiu
	+Uqv2Dhkrqi6Sr4RqeUoI9m0vIl+nHnqZAqtTQ8VdcYKGplrn3iBiPJgD9qH8kg=
X-Google-Smtp-Source: AGHT+IEC/pzgkuKMxgEMht1BavatqxWaNbSEMy1s4ud3zd7w3OIZVSW5ARMzkwzRwA2KmcOAczpszQ==
X-Received: by 2002:a05:6214:27ef:b0:6b5:752e:a33a with SMTP id 6a1803df08f44-6bb55acfeccmr135240446d6.57.1722445269613;
        Wed, 31 Jul 2024 10:01:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa94e63sm76129796d6.76.2024.07.31.10.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:01:09 -0700 (PDT)
Date: Wed, 31 Jul 2024 13:01:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/23] Memory leak fixes (pt.3)
Message-ID: <Zqpt0/6zBOpYh4aj@nand.local>
References: <cover.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721995576.git.ps@pks.im>

On Fri, Jul 26, 2024 at 02:13:43PM +0200, Patrick Steinhardt wrote:
>  57 files changed, 251 insertions(+), 73 deletions(-)

I took a careful read through these patches, and found most of them easy
to review. I was admittedly a little lost with the "fix various leak"
patches, and having slightly more context in the commit descriptions
there would have been helpful.

I think most of these patches look all good to me, but there is one
where I think using a strvec would be a better fit than allocating our
own array.

Otherwise, these are looking in good shape. Thanks for working on this!

Thanks,
Taylor
