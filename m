Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4C1DEFE8
	for <git@vger.kernel.org>; Thu, 29 May 2025 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748553712; cv=none; b=u8woKYi6EaIr/1K/zeckfjC7J11ly+vLojSnMFiYgm/VjPZvJMKz2RsnoXKayzKsbmR7CuoobHmSSkBTiKllbTqtRm9Lljj9JkL7KWRbUdBc9jbFIz6QzfasHknlfADBERD1Pb9c7fEmUahdlM6yo4fGVBCgiDqqwPenKijrqeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748553712; c=relaxed/simple;
	bh=BkIYmg3Sfn76yFP4GalbS9UmI6Mga3ZPf5/vjrzhBQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brEwHwU9SDBnm87PmjMQPWtaH0H2wGkB54SWeLigRUfu7rokK8+G6E8OIraDfTPaSe36V15xnQaEnH2A1m/XetSAOkBuU3vsUKwfESaVwu1DZd7K8DJCIMaR6VEJIuD3fXjNwU6bWHa7+IOYCizwgBzBs3YD62SBEWSLsUNcmq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=f0BpYh1b; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="f0BpYh1b"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e767ce72eso14871947b3.1
        for <git@vger.kernel.org>; Thu, 29 May 2025 14:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1748553710; x=1749158510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c5an69gEexMGRNE14bPQ4MNwqi59AuY7OUNNEygGC7M=;
        b=f0BpYh1br4wDxK/fGhmAI/lRFyiem41JNs7IOYQBgXYmFP06VTCUeyguFGcJahHpxZ
         84ihY9NKLKE3f7s7ECIRXeb/StoPgm+nvcj0G+MqIPH3O1Y5uQgLzOIp9VDhNO3PL4gS
         TWXk6U51MHkKdPsLQmdTgNiRg8+Yz0pqfIathchZTt6jHXyBJqzuCnlqFXsasUgWiYTt
         rlaRuJX+6+PDKj1mHUF7UDFH9uB9ZYizZVINovbzORKwIUZ6b6E9LiLO32Qp8X9xykgc
         hpVuV0BmK1P+WVkQANmyel5ITEyWcVFZyObgD+UYQH6h8i0OkBwILwyIxIzaBvhrGE1n
         kv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748553710; x=1749158510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5an69gEexMGRNE14bPQ4MNwqi59AuY7OUNNEygGC7M=;
        b=Q7QIudl9rU4aXNWpOvF/j5p6Ug9sstCO2ozn97+ygv/6vj+mp7+c8XMzxXoKNf7ONh
         yPo8eDjT2wXbj+ed8/GMlysL712jxNmncMUO1lInFte3dmV5r0FIUQ8n9An71eoQVYqC
         yEDN38VnRpqrKWlgOK7I22V7YhFZ4pS2+6e+2r4lKjs5DlDhgP6qQI8HW34vIhyKFwEZ
         FB5wgXQx82T8GnAiKTQExfue9E0+UN8k2qzy6xSOg5ggk8aEeK1AC51M0y0cZtdVWgCS
         l/CURqeoBTv4tj9iGHQyP8nVoRk9LatTQMSrML/b86xIQOBOJIuvyDG68kZseh6//Plj
         G7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUrEqncz868w5j2c+odK+mvcnqd/aLJPjKxmfDwJdhDhqo8Gc0/qWDE52Gz2oxpkTv/foE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpXRid1b6nVSLtSsAESNReCkeci+F45CYWMXSWjWYffAQe8MoC
	ip3rlI3Bb2qXAlux0Awx450f2iB/s88vc2EppJ31GC+rqYKXOYJv3+2oOntUZb8jqg8=
X-Gm-Gg: ASbGncuhLCocK8enMse/NRgpFfHsvn3aDiOh/EO9Gsp4IPq6FS2g7wGfTswrD7UidyG
	lZ+JYqQJb9NFBuY0RFPdWC9PrZwO7ep1KSblnHeKOzIFFabXgldCGAm79I4EDbFp74L9CkDbnh8
	x4oJ46L4Y3gNGpn2iixUg+ZCp6zzp2vtiJHWKIR8MmSmrzy82pB7QwAHWN88z6KeQ4m+OmVcubR
	yVSeL44y/iFut1kJ46xzFArCojOz5zdHBqb3U+yWxPEZ1L8epZlVRo9USTxnhOlaVDf9d/h7DtE
	v3JFQ8E9DY8ICzVGXvA07Y7jbzsar46H8Xv/CMTWCS6NMmt7iwp76YJeYsip3BjPhThsxTa2F7k
	X9WxiFYY5iAeViIQgZZHK0NI=
X-Google-Smtp-Source: AGHT+IHOHs6BtqhUA4MslecjvtMohKUbTK7xyEv3wNSP/zUBHeNGgsh9Cku8RYTH0SJQuEkmbkppTQ==
X-Received: by 2002:a05:6902:124b:b0:e7d:a290:952b with SMTP id 3f1490d57ef6-e7f81ee3761mr1773429276.36.1748553710180;
        Thu, 29 May 2025 14:21:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e7f73500ce9sm486575276.41.2025.05.29.14.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 14:21:49 -0700 (PDT)
Date: Thu, 29 May 2025 17:21:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v4 2/2] pack-bitmap: add load corrupt bitmap test
Message-ID: <aDjP7GiNvflWepAL@nand.local>
References: <pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
 <pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
 <7876d9a9014ea6a0657f440f7fa1efd496a4a15a.1748140983.git.gitgitgadget@gmail.com>
 <xmqqbjrbmndn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbjrbmndn.fsf@gitster.g>

On Thu, May 29, 2025 at 08:45:40AM -0700, Junio C Hamano wrote:
> > Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
> > ---
> >  pack-bitmap.c           | 73 +++++++++++++++++++++++++++++++++++++----
> >  pack-bitmap.h           |  1 +
> >  t/helper/test-bitmap.c  |  8 +++++
> >  t/t5310-pack-bitmaps.sh | 27 +++++++++++++++
> >  4 files changed, 103 insertions(+), 6 deletions(-)
>
> After the second round of the series, no review comments seem to
> have been sent to the list.  Is everybody happy with the latest
> iteration?

Sorry for missing this one from earlier this week. I left a few comments
on the latest round. I think we are getting there, but I do not feel
comfortable merging down the series just yet.

Thanks,
Taylor
