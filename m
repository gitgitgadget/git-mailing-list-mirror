Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA4029AB1A
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791408; cv=none; b=kMn/XrIl91TkruyceKO8diVM2rk+iXgvqdZEfaX5Y7qYJJMfInEHRdntgiL7nAEp/GQQW9P6qBpJ7RfLkt6lg/iO261zFdRbXo7cnCJA6GDm6/queTQHmn+ezeXuctcI+gIMSKbbpu4k43bzfu5mYD0/1ssUy6+0nx/kSx7pXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791408; c=relaxed/simple;
	bh=3zJNtr7UG2Tk/MccFh9lvxX9lRnvZttfxYCnVh2ofbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKbeATOk2/bvWUt64lalTd6IH4l53kHpa+l0uz13ZUiW8BMUbAoNFNGG7nd3k/WHkTXBCTtHm85Yh7CMrMitYlGNvcO314pAIXOeRrNtEP3jiNu1DQMkBfsek4hmPdL6AJfiGKS5OhpbQdY4Sq3uX7qbwXYPIK5GAPn8UIfMrF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpgBMLL6; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpgBMLL6"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6a0c604b9cfso892723eaf.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 07:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781791406; x=1782396206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7azovMoJOjvNICbDVMdci55j/SpcjOlD8wIlchYWrtw=;
        b=jpgBMLL6esYMNmveHDvRqebYSB+YT16KsiT/pLFxk682v51LjjeNicTfR6Ej/W590i
         9IZeT9lvI9ZaoAqvv+5o+Y4Zy/kKxhw4qvfCMltX2aJw30S3DDZ5+6dLk/fwC3VgmzXE
         7WqMfRDOxAgZWdbFFAKbVz4tI/7ZFw7jGVb3uuVfyyaI11rERatxQjIglnR9nBnFLjDr
         ZrKKj0Egajs4E5uIwcW+O2sUx26sgSPUTEnEqjHcoaFWwhBvCzNVKgAUpNAVIKs6I7It
         gAkvlfBBf6KJ2cnj9v7QOCflxLn9D2e18u+r6WznSBf3ND5hKVBhDdVdVzhOU51qgszR
         KYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781791406; x=1782396206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7azovMoJOjvNICbDVMdci55j/SpcjOlD8wIlchYWrtw=;
        b=bWNHURl9DTX35khEmIY7dHUvc+WLDv9YLE5MyAhN4ncCQ+Shn54NzMUAKipQD2DLEE
         0HWjFhONdYam9aQzK16f7nNOq2H+6dZ36Yk36zcVfG4rqH7jtkTXUDVX59WpwuSImzEP
         CeBR7FIM26IpW6/6BBQO/Dzr3NQBWf6BNG160xPiYNvxHGj/4YxxuPHzFWseeRZlOOVx
         cXJzbgk7MafebYW76wELfRtE/oOqwQB1RDtJTRnI+SGXpBs022Nd5BymEwn3qb81ifG9
         UfyQXCTnYYu9LgFELckRSLetTJTDvsCo/ouSncg3tKj9iLKF7lXqU2HJZhWm2svQpa2R
         A3Rg==
X-Gm-Message-State: AOJu0Yz26XpoQ/RCg56NB+h+zGi7nqebyY1F1fCupIV3+cOr0H7CFg+t
	4k9oXl1SQQxNuT6HJ7DEME5bi4ocKqs5S8Z5vRgw2BrHraL8kMxAu41JOETN2g==
X-Gm-Gg: AfdE7clbcHrt4UPSwp8a4BTqTe/3VA2VBkhoDPaAFkVlwNv4w4G327PRk+vwUiCCScH
	vd3+FC1XCTf4Do+AQjS2D6ffZa/2LPEKqyoYfQShL86LBXx68tfuH/dd6+/0kv3JRvq1N2yvdlh
	WWPm7NZ9EJbYHlJhNgPFxas6V/jo4wDIQgh6YwR+Fk5f619+PNw1tlv+Xu5WiOrCY5db+3RetUi
	3vkorXrb6ThQkBnJSQFFH/bSUfXNOKuxGL05saBfGEoAjeyBxj7CAvHZRF3KWCil1YQQqBh6In+
	fKfl+SfLdrXKk9oxsEsAIzXTSh4v6a4yAGZqrM+AquZhHwFVrEu9DLDGi8tXRuUyebXaXVe0xSq
	ESu9Zca/DqAgUiKJX043Kzh4Ja94/6+VpPB1ayX5lkSjnFtmfBe05blfMZVMFBmwN0D1UMqDIlv
	GzX/P2zw==
X-Received: by 2002:a05:6820:198c:b0:69e:3062:4b77 with SMTP id 006d021491bc7-6a0cd9c84d3mr1848145eaf.13.1781791405291;
        Thu, 18 Jun 2026 07:03:25 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69f00d232e1sm9122633eaf.6.2026.06.18.07.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 07:03:24 -0700 (PDT)
Date: Thu, 18 Jun 2026 09:03:24 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gitlab-ci: migrate Windows builds away from Chocolatey
Message-ID: <ajP5owy3r_GyuLqk@denethor>
References: <20260615-b4-pks-gitlab-ci-drop-chocolatey-v1-1-51a6e7d5e388@pks.im>
 <ajL1677NQShTO6tD@denethor>
 <ajOE2XMBzgrXxbH8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajOE2XMBzgrXxbH8@pks.im>

On 26/06/18 07:40AM, Patrick Steinhardt wrote:
> On Wed, Jun 17, 2026 at 03:03:39PM -0500, Justin Tobler wrote:
> > On 26/06/15 02:21PM, Patrick Steinhardt wrote:
> > >    before_script:
> > >      - *windows_before_script
> > > -    - choco install -y git meson ninja rust-ms
> > > -    - Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
> > > -    - refreshenv
> > > +    - ./ci/install-dependencies.ps1
> > > +    - $env:Path = "C:\Meson;C:\Rust\bin;$env:Path"
> > 
> > I assume Git is already discoverable on the path?
> 
> Good question -- in fact it's not, but in Meson we know to use the
> well-known path of "C:\Program Files\Git" automatically and that's why
> we don't have to add it here. That certainly is a bit hacky, but I'm not
> sure whether we need to change it.
> 
> Just let me know if you think so.

If it's only Meson that needs to locate Git and it is already capable of
doing that without updating the path here, this is probably fine as-is.
We could maybe explain this to future reader in a comment? But I'm not
sure it matters too much and is likely not worth a reroll IMO.

Overall this patch looks good to me.

-Justin
