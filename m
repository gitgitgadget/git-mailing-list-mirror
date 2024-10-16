Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8B1097B
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 00:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729039121; cv=none; b=K0A1DghbMs1fI/+rGTtaDr8DUv4todcT/uQ9R6NnC6odGG78ML8faxrzkngD0L6PMdj9h4eKkyR/znrG1o3xBV09KtIegd1zs0LpMdhLoX8YUPQXE5bccW5C9o8j6nrn7JJ9szK8NvW57NLaz0J6yJJnOBJU4Zid5aIHIYvOOCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729039121; c=relaxed/simple;
	bh=2jNfQrpPXvKVJye6FEGwk4ep7/zTScHcr7g20x3I69k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaLhesKayHMwXl9BBttrSUoqGpr7kBgM7Fv2YEC4saWLcdpN6u4Nl9AT7YQJ+WMBYa+XT2j8+vPf9fnu1AiAcBJpCOstVrB1rnl6f8PacxvTrIO02E1MNS0uFFUL6GGih17BE3u/2sNvqYKCCyUGNAe9QI+GKv7p4UU12mUSbCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=SHR1YSOW; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="SHR1YSOW"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e2975deea98so974256276.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 17:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729039118; x=1729643918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOdIjXz0h4d4GgupWfGUrEzvgbFLlPglkhG9qYswaJY=;
        b=SHR1YSOWQj74liolBc+BeGjrNmdYix5Pl9QfZBl5ys4YnEpC9/VnyV+n2EV9RpddYJ
         uVA26IRhV0r0WuAy5vYqt7vyd7FQAU53ZdQlLJSVJtYSFKuEVSsBJiQXzvWII1YK99N7
         SH0w1yxx+DQeS2chYQqtN1HIGFBjE9XOMaeafE+OfqtU3h4L+zdSUWGYAU4rZHRxkE1R
         eqD6DLZPLN3PIaeM9rrWE0w16pHEWJyKqUt+7xP4gli+e8llFRBuLIObwmRikn8Sfzfg
         DKrRBv/f7GLguLQCJy5J5gbd78nReQl0+JDk7WeJp7pwfApxl2nL2FGwi15sffHpE78j
         kJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729039118; x=1729643918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOdIjXz0h4d4GgupWfGUrEzvgbFLlPglkhG9qYswaJY=;
        b=KlDpRrpYmDRe6t15XnrVs1D+MgX3AkfJCnza+zyWxc0OKfEDyTVQDgO0HeuLJpqnJi
         J64t7BbTckTImBww0jOr1vU8wsTRKx3gdTlk8bWzfukmBh/sm4ECUqFHqKSll8Wz874u
         Dob5eLFOSiCNNb4F/uUstfQ62lXeaoT/Yqgd/857pFBbY6UZlsdLCh7PLC8rqMELkdjp
         XIInrzLkhbhdWuZGyDB3rdeUwsiJIsfltc2wTHKveKu8+1ZsEpH2az7a7rf7k1yud5Mj
         M57Es4WHyhYHkAVCv8dkeu9PeHhr1geTSI0qek3g0jpVk07sCa61cEFTFSp8d+8AOMLU
         9uCA==
X-Gm-Message-State: AOJu0YwtcpjrospKBu0lB40xWVOfyPpz8AMAEnWdRMzv6u+4t1k2zxlR
	ZGd0m/14FVO1vZ02g4GQOB/KgHzPWDHRn/gycqI3V4ZAu3x/4YICmGQg9vKiPEI/Dcr+HNuBdDK
	l
X-Google-Smtp-Source: AGHT+IF0UAFsAwvK2CGi2PLaM8/FhB4FBe3t8+UPASnZ8pQrwf86nZ8NdT5mKrx1XwNPpG0T9Ap+1w==
X-Received: by 2002:a25:6814:0:b0:e28:eb16:dd5e with SMTP id 3f1490d57ef6-e2931ddc012mr9168839276.52.1729039118583;
        Tue, 15 Oct 2024 17:38:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296d050c19sm411032276.41.2024.10.15.17.38.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 17:38:38 -0700 (PDT)
Date: Tue, 15 Oct 2024 20:38:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2024, #08; Tue, 15)
Message-ID: <Zw8LDSIqYtJTuGVE@nand.local>
References: <Zw8JFB/SUN0WlwNk@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zw8JFB/SUN0WlwNk@nand.local>

On Tue, Oct 15, 2024 at 08:30:12PM -0400, Taylor Blau wrote:
> Copies of the source code to Git live in many repositories, and the
> following is a list of the ones I push into or their mirrors.  Some
> repositories have only a subset of branches.

Oops. I should note that only https://github.com/git/git is currently
up-to-date, and that the topic branches are broken out in my tree at:

    https://github.com/ttaylorr/git.

I'll update it for the next WC report.

Thanks,
Taylor
