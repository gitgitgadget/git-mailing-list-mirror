Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493511DE4E1
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752793151; cv=none; b=UhhabaJo+kOxx6CykhF+o3iIvWq1EsPtuFaLJF8GUw6S731eX6kl2MYkH3L8TPX5sXoh68XTUDqmEHmad+GVOP5+bZRzydFTVTNtf4tOMvjfYdG5k9QIdFxedLHdh31VcGf2v4wyAValf9xVfXv7KdZQysfvigay7qB3Bd3fzVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752793151; c=relaxed/simple;
	bh=4/c6YzM94OSFbhqJKMOdRHtnDjuG+tivIL0WUd2lnaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqDe6jHj6Rl/sEyr9AyN67BAWzaaObwHxhoZNs6pxPoOm4uOybzaNzR1WUODOnvjyaTa3jdVEpG6vlpsd2Tyg9Icjje+xbWctGh+luCOpus/IH5sR9annBj9QOdMDMMMQrBS42haqIYMWiC6/ov5B7SK9YT2QVhkOjw5U+xFjO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=JB1JEAvx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="JB1JEAvx"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ab6b3e8386so15321291cf.3
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 15:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752793149; x=1753397949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VWQjEXCcyZRuiqY3l5gxDuejsCERnoBxDtpQgvme1xo=;
        b=JB1JEAvxRLRxWhbsKB44Rfb28CmZNCRELB+xnjs2jMflVZ+sYwk6y/w/BpnOotdHBg
         2NdJWKXku2tDdBC9LObJ+4EyF4/f405BtR/lbryT5p0G4+P4oETuex+ERYamra0YrvyO
         xyIR2Dk6lZJKedBC2NGR9ynpz/9WVctKUzRiYi1Ngf19S7+6YbY/O8CRecV9XE5Z/Drb
         9IoiBRSpO2z4dt+BjJ66dSovg+knRML7gvjfLuronkxIAmBN2sO7F96eLEZQafonYqr/
         +IxWQPgZjXj8itkK/VDhdjCfXBFigYEthwmybkme1bKJ6CDAezCFzn8cpq2DPcKk1vHO
         oBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752793149; x=1753397949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWQjEXCcyZRuiqY3l5gxDuejsCERnoBxDtpQgvme1xo=;
        b=JnSdrGVtVZmOIqPjfIwHygIOH/i/hoc0oFb0u/I5vG9CDETotvk9I2VKcXfyZaVWmx
         5U8Vw30j3JW9BVRMnZu1FWDLn1GwKOOH7alEp7b9dTSKM6e8yIFazhz6B9KSkxLtBYtf
         SWBcrpW7AVGo55rEZvChrWWhy5fJp9W+IZzXVrt7y8yXrwBI+DuaDRpWFag4OHOnkcMh
         Zl89676gb20tlABwQJVA+Jo6KckicPuv9RmCzj+xTkFI/r85jeOZGCMSJ7CFNAGBbqZ/
         x2DrXsQ21Czc/969gyVuKpXbUGWrRh6L0P8sK2OLQuncC0I+hi+gBDC154xztXYl8TyY
         GBRg==
X-Gm-Message-State: AOJu0Yy0ynDXSc7FfRswCAToKkV5GUufZnyw4CRESzMUDw0bgWuhZFvU
	Ic9HzcaUwb6OCebWhXaJfhq1qDzDMnXru48CzmakbqePY1EulTI5lgIPO9Csf/+vESU=
X-Gm-Gg: ASbGnctAGxFsd3b5Zx8y9II2Bwxvzyb+pbF7/w/5rpeVJj/F86Rie0hrTbUYGU6RBgM
	FumZAbv44cdXcSZId8h4q3RmhSIf2MbenPkZydSRBdx3+MGNVhCM2S73WYlOAlQ0A72pUKML1kc
	CPqN41Pl7V2qa8Pvk4BH8TbujR1MqzSPKzX93a/OatntzA6fASUVdYqmoCD1vTmLHlJVgE9Pn3H
	QhRbSL8362OvoCLrRYyo1DpzVmpZ/T744yGKYE6bhp/FY9GA9JXrZPz16ZSkbAk/g3zHHeP+/k5
	QoJCnh5KHZe0YIuMRdct5k3MSqihUApgxEU8/Gv/g/4f1+oB+E4s5XAg6EpFyjMNxXhtu9uZzX2
	yqNpBqpsYqLyQETxZIY4vUBkddSzItX/MrY+4MAOCU3xHpm/B1fP0JYkwy37fel1zJfHejw==
X-Google-Smtp-Source: AGHT+IHAd1j6rWtlWgwAYI0saxNzBlDu2JcGNp0BEuGiRBuhINx9Crtv1sn9NKO6VrjMmksffpbTUQ==
X-Received: by 2002:a05:622a:5a8c:b0:4ab:9586:bdd7 with SMTP id d75a77b69052e-4ab9586c4b7mr118341741cf.54.1752793149129;
        Thu, 17 Jul 2025 15:59:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4abb4b46b27sm669791cf.64.2025.07.17.15.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 15:59:08 -0700 (PDT)
Date: Thu, 17 Jul 2025 18:59:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 5/7] xdiff: separate parsing lines from hashing them
Message-ID: <aHmAO0J7Ptr4OiCk@nand.local>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <2db30cc739efadf8383bd9dc1b7825ce863e8f5a.1752784344.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2db30cc739efadf8383bd9dc1b7825ce863e8f5a.1752784344.git.gitgitgadget@gmail.com>

On Thu, Jul 17, 2025 at 08:32:22PM +0000, Ezekiel Newren via GitGitGadget wrote:
> ---
>  xdiff/xprepare.c | 75 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 44 insertions(+), 31 deletions(-)

Not being all that familiar with the xdiff code, this patch took me a
little while longer to read and understand, but the transformation looks
correct to me.

Thanks,
Taylor
