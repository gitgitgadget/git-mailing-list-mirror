Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7812E3EBF25
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771689553; cv=none; b=kSCzvcYDQujsR2XTod4OYQTQaQaGDORHSmon+aeKnJFw4Ld6hlNamdXA4XWoVIvZxjRuIKxG+rI1YGViZH80jAVCLCt0OQU5VkIYyMrp5FKn+f0/6ECVAIdZo9EsED2l5dKwzODX3vZCzkfCPQYrRZzkglHI/Q2St5tq8h01GW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771689553; c=relaxed/simple;
	bh=Vo+lXD3nymrZ4cmH69aUx9Wn/tgaE5dZQ/HEZ+eywY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fc9at2j7qVA3nsYXcSP+rsFeupSoZTQj04g5WUtm/VcWouIo3GU6GibwMazGUV31R7JKge4WLnxwUoe0dYVXZNi/PC3noAJ3WMeiBmdf4VFQzNwhDSEhCAoD7eDQMT43HGmcZ85JfjSolCzV7xMUISZh4FQxgep7Jo+T5q4ZdYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=RrQL4ke/; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="RrQL4ke/"
Date: Sat, 21 Feb 2026 16:59:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771689548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YE+X1MVkrttfzzbkmVaTVDST2IlWbALXocAtBVuf/84=;
	b=RrQL4ke/JVRSNSihKciXofkpB6JxVElkyk6hEpT8C9Ka+zErR/L5Q4xuc2yw0kLhAL+cT6
	Iz86K7MkmQRsFdxudKVlxF5S7DvqGsvreXLbKHwgIFek/F2zmlKFI+/YGuUcL2soUBlom2
	zpu9Sgm9+Dwc4gjj4bjRdQkpW46IK9+eDLHL2J5IxOsz/gRvpU96h/XdLwURVoTgd/TC35
	fEFhDklwkajXJXN+QkJ4PczKdRpElUXsoEMiCfVpkDdbjlYgwwD0hjjEjMpUYytfTgR1Ft
	lvafkCbNpDrYfdt3sWyFkscEq/AL5D9dfTw/r2c8CByNaa4NvvhYhSRzJLkfQg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: [RFC PATCH] format-patch: better commit list for cover letter
Message-ID: <aZnOyYGzOByayPFK@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=mroik@delayed.space;
 h=from:subject:message-id; bh=Vo+lXD3nymrZ4cmH69aUx9Wn/tgaE5dZQ/HEZ+eywY4=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpmdYufTAU8Xo3hoU58Rj7NASygLwSyKi4x13o5
 22J/2csDyaJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZnWLgAKCRBIeX6hnBm+
 0beSD/0YSZguVi8Sr0MUn0RnE5tHc6KK6R4d87ZHLE8NbCHBxFt0mGpN4Jdrv0WQi0VD/43oQ7o
 lVXebjTiRFpflNN/x/wPKpQvTeWM3W/qZrx/LOE3OsqDY6lywYg75uYtFsgWvrsAxVnGjBEABRp
 aYDh6X03674++R+AvOClebjtuTQia9ACJZFwgNuNnfuPoxffMOGGY31TTruMYavTPa/pizHss6z
 EpGTtWY8jBkHonKC6FTCay/DjkHtqsi88ELzOBvJswDpz5kudt6okuMM5u0OnCx13LTpUz16Qmv
 2kxISW1x9sLVzyM4BgOH3/KLll8EkkpDvsHTf5AkQDN0UEDNY3nUdArb4Bf+0AyEM9m2zAtB6Bh
 BAMZZECeuOIUxUgvUdmviIvzDCBJNI0ML0UrYm3a+J/IUSNWbNXxdwczbeLMGPBd3K0qTdjYYwM
 couAtvn9bZm+HDmBcD1lmwMiMJufWYVNifs9qreMe/js+Mbr/mwv11KclF3we/Y6mPQMySUMXd9
 fxxZdtaqkVZ2h1gReI1zHmMR0ieo0QqBc34MnBrqmayTcBPmYa0RQ09n9EI3wT1Zzbw+/9Q2DOr
 W/eF/QUJmr7D88IH4lCKHcOf8fy+fnu0RA12a09WzCiE9IN+tE0VPpNK4yrrzRvUs4KKcoCK6J3
 UDF1aXSvYUBpqMw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260220230633.132213-1-mroik@delayed.space>
 <xmqqldgmu25h.fsf@gitster.g>
 <aZk9QlH2PDugXKrh@exploit>
 <xmqqh5ratzc6.fsf@gitster.g>
 <xmqqcy1ytz0y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcy1ytz0y.fsf@gitster.g>
X-Spamd-Bar: --

On Fri, Feb 20, 2026 at 10:02:21PM -0800, Junio C Hamano wrote:
>
> Just off the top of my head...
>
> Perhaps with
>
>     [format]
> 	commitListFormat ;# true
>
> we use
>
> 	[1/1] format-patch: better commit list for cover letter
>
> and with
>
>     [format]
> 	commitListFormat="%s (%an)"
>
> we use
>
> 	[1/1] format-patch: better commit list for cover letter	(Mirko Faina)
>
> instead.  IOW, the value of the configuration variable is used as
> the format argument "log --format=...", and appended to the fixed
> [n/m] that gives the numbers.
>
> Without format.commitListFormat defined, or when it is defined to
> false, we'd use the traditional "shortlog" format.
>
> Hmm?

Yes, sounds good.

> And the corresponding command line option can look like
> 
> 	--cover-letter=(shortlog | log:<log format spec>)
> 
> e.g.,
> 
> 	--cover-letter=log:"%s (%an)"
> 
> to override configured value per invocation basis.

Not too sure about this one. The point was to have a useful default for
the cover letter template. If users have to pass a format spec through
the command line it kinda defeates the purpose.

Since we're close to having Git 3.0, maybe the change in default
behaviour can be scheduled for 3.0?
