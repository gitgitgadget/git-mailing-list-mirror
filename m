Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BABE35976
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344210; cv=none; b=dD+pBJLP5a/d76OwTgpVX4Rre0GvDB8CzX1t5P3X+VB5ucY7+7b4lrKSYRQAJr1IdTExbFQtxD2i8bKfQ1gBR99NdFo/iVcA8cj++llqE+uexrsAiUR686gnzg7iVA1n3xXg/nn+GVAA48XtsoATVquTd6eYo33KGM6irpon40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344210; c=relaxed/simple;
	bh=XGiek6Z/ej7wTPWRygoozg1Tp5MvW6nvdOxCL5lruQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7v5FDjcPiu+x9/319VGUiO1dWUVURQdu3AIt9hJ1gQyoD39+gvVejW7ErY4u0WC9bCmbmcq+bj/0sCoSb9UpbhLSv+fiZWj4JNRCJiWd0dd0wn8u7iuG4jcJGwGb96M3vvH3Aj/dYB+Ao2BlpMbZdmu2Wg0a0l/6RS0naY9kQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BIHaUcvr; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BIHaUcvr"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c56321b22cso20358385a.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742344207; x=1742949007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AcMVcnr9lIW2cbYw/mnYqF7MBJs9luByKMcw91/iI9I=;
        b=BIHaUcvrOpkR+uWOAbtqcN5sPaGq/fgeUkr/YAs0Vvi3gsKW6YWpZ0eg3K6/KILpef
         ZGtBwDvAIYdZDf0qO+m5+CED6qK9T3PQKrwSbGzg9gStQag5NBNUI4Xp6Z6Q02rDj0Cy
         KVfMcup59j63b9TmVdAWaoBMtc20A/ESl1vR4sRxFu96UbwOmoImVCiaF9xSWmhf+Npw
         UnEdxh3cG9MO24iTC6Ys+Git/V9/BBBLPzzhWHrOk0jQgHePtD5NHd0sDBxUckopq0s5
         XqfnIFloknplI+zYurI2jiLVpUD8mEr1fo1sm7aBfsziMvK50EKT96XdPoPQ7XJJ1mBa
         tAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742344207; x=1742949007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcMVcnr9lIW2cbYw/mnYqF7MBJs9luByKMcw91/iI9I=;
        b=xGhsDzfXamnO144KWINXjtYuvXP8WJTeZusxDF/QF1+bZ/041VEu/41hDlIk6xCsdH
         hW44IyMyX4wWGhYcUjaWtHzWLkZqeQVVv+BFedf8xQVRHIfOn1tFc7axY/vdRsa21Kl7
         OLCnXzxhn75QPgUkliXUMYzhBiCZfWbe5sm1rWZoOXexGS1ZyBs1Q97REvo2VT/jHjD0
         g53J7Vcz7lmbbhIeH+4OK1Tt60ofG1neEfWlbPDjJturet0tKiYOXJanIxoXOpFStSxy
         Hsbm3d2xh6CDFYLScj5emz+g0C8YNIrc4WnnxSGU+el+OAgsBzUeO0rNWhvidAh7ArT8
         rkDg==
X-Gm-Message-State: AOJu0Yy62VqoYjK6/WMmuzQrGxolpTn3CjLOiWE5ve5GFOVS/E9bLsBr
	J6TkCRsLSDu/8aRAzZTFYUucjhkEqccKZi5vxN/rBgphit98lY5ajslOHJCdu+w=
X-Gm-Gg: ASbGnct0u/l7JCteI93YLswjfGMZ3Sbx6XsyRPwSzgxeFJiSLTL8HdMhlCHGN27aje/
	L4qGZKusHM2WtFMQqjs6eNMEeRTJaFNWMcf6gVDn+aOcq0qDHyjek7xOAGtKgi5z8yAh7uA0B5d
	NJAcs0NoK5hBWmRNw7ogspyVBzilPMx52slbzmLN6PLCDAlAyP18T93rvEXJguPoX4KNiSP+4u7
	+fqYffoksZGCgL0DiF2ZBe+zuWuNN4x97ps/N/A057tGI6bKOSyCsI1V9bwsMizukgA1Qzlhvp1
	ivBPmZBTiWt5QKbzbVVhZglX7Vlc5lMsABeRQmsDVkhKETQ2d3sjboGbfYCEjFf9zrMHFSY4KPR
	Giww/ZrynbQvBK96z
X-Google-Smtp-Source: AGHT+IFMqd041Nzy1gBfdczenTZKGXlS+6qiH++sUOHGs7SYjlKSWbij+6PDXvBQUaN3JJSyZhUtkg==
X-Received: by 2002:a05:620a:4507:b0:7c3:dd2d:c0e2 with SMTP id af79cd13be357-7c59b715f58mr753671785a.13.1742344207243;
        Tue, 18 Mar 2025 17:30:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c5201fsm785975385a.23.2025.03.18.17.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:30:06 -0700 (PDT)
Date: Tue, 18 Mar 2025 20:30:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 07/13] pack-bitmap.c: teach `rev-list --test-bitmap`
 about incremental MIDXs
Message-ID: <Z9oQDbPpieD0JfHS@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <b45a9ccbc20180e3358e314b4fd5e46bfa566241.1741983492.git.me@ttaylorr.com>
 <CABPp-BEyKkbVMs=7AgSf1P9CTXqA5CY5epG-piuSzppAWfPe4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEyKkbVMs=7AgSf1P9CTXqA5CY5epG-piuSzppAWfPe4g@mail.gmail.com>

On Mon, Mar 17, 2025 at 10:31:06PM -0700, Elijah Newren wrote:
> > +static void bitmap_test_data_prepare(struct bitmap_test_data *tdata,
> > +                                    struct bitmap_index *bitmap_git)
> > +{
> > +       memset(tdata, 0, sizeof(struct bitmap_test_data));
>
> So, the first thing this function does is 0 out tdata.
>
> > +
> > +       tdata->bitmap_git = bitmap_git;
> > +       tdata->base = bitmap_new();
> > +       tdata->commits = ewah_to_bitmap(bitmap_git->commits);
> > +       tdata->trees = ewah_to_bitmap(bitmap_git->trees);
> > +       tdata->blobs = ewah_to_bitmap(bitmap_git->blobs);
> > +       tdata->tags = ewah_to_bitmap(bitmap_git->tags);
> > +
> > +       if (bitmap_git->base) {
> > +               CALLOC_ARRAY(tdata->base_tdata, 1);
>
> We use CALLOC to both allocate the array and set it all to 0...
>
> > +               bitmap_test_data_prepare(tdata->base_tdata, bitmap_git->base);
>
> and then call bitmap_test_data_prepare() which will re-zero it all out.
>
> Should we either ditch the zeroing at the beginning of the function,
> or use xmalloc instead of CALLOC_ARRAY, to avoid duplicate zeroing?

Ah... good point. I think between the two we should drop the
CALLOC_ARRAY() and just xmalloc() it.

Thanks,
Taylor
