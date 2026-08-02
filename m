Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28D31F2380
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785681968; cv=none; b=Uw8JVBc3Svmf88a4R8Zp6/ORlAoUZkiirp5ElnjLDt/wMnXvBh3wkO2pOnxQBk8XT10BLJlofCkHvltV986qsvq1yAGaQ0y4rw13EmNE3TLUi1/2I8H0pIren9MBAN4faL5lbAlBJhNtJVcxTkKAOB/69NXB/ipW+S47ey4ggHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785681968; c=relaxed/simple;
	bh=n/D/fd/I2Q2ohHVv3jZ9A7o6sib+vo+4VF99N3T7t80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiK7uIeySl5NCklhAZDFIH/1W1TYoyoTNiDnyMC3evn/qRAxODv16q2eErEsXVr5/pVBZwyCyAbBsMvVPJrM9lh9XuWWDBNcEiifGMB7VXJdd1fag8uYVqsmkXsw2KR2/7wf62Dnt1nIxf9zwK6YRK6I8CsFo1ZJ/iO2K/5tcw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW4sMMLY; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW4sMMLY"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1823196a91.1
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 07:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785681966; x=1786286766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BtayseU8hyabeJFmM9NTVVDJar3Oe9g8igkL6mHecCY=;
        b=NW4sMMLYP7RSNGHNZVyuBOz6ZlmfneFx1umCCxNdTFnymfLRCUtLd0FiMIQTwSUQ6U
         z6Bj7Eb4VBpZA7uPNTNiQ/esAzQzlbbYHYZXu7iXaJ6fzRwkgBw1HCG+2Gey94CRj+fs
         2FFIdDoGvr6rA6JIZJ5svSej62DiIXUJBfaJLdfccgWhM4b4k9hkWDDRaD5LOit528Hx
         3kLZILjYw67xK2r/XL/u5yf3I4NEzyg3U6DuFoiOMG9oqVh14+9jQWljdURBmfRncOYm
         8nf73tJJJ081qvMkNGA0HV8g1LHafHEjElEwDAM6Eb9UPDPU3WSWSGvKjGcmvS+7av76
         mErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785681966; x=1786286766;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BtayseU8hyabeJFmM9NTVVDJar3Oe9g8igkL6mHecCY=;
        b=ZhV1DvIj98HYd3dETynk8x2tjEMHDVt5cLXkY9+1byWd6kqkg/7H205eqe3BPCn4CW
         XZWOARkC//mUa42o1ZlL+WwQusAiHGmtNFYMO2/JFGrRJAK7URxZJhBrgaMzg4nw6+o0
         ZAjly8452MCZQdz0fhSDFWFapTcB4tDmsHc3m+3ciK/86HUSQj7kSqQWbvGm7gx/s7H9
         Ox7UJdxKey4gsLMhbIItnq1eSdpeWSmBxMhmLHtDWcZu8t4VHN7zyoJi76MUEXM3IUZX
         lUX69oyvxqV6V0+r/MxH83kImrfYvfaK9+c5/2HwBUM9hffdYpAvCgh9cOf3/0i0IVFy
         kvBA==
X-Gm-Message-State: AOJu0YyK0p80er3xWRD0ho7QuIjwEe9CBaWPuCjrBh57tyzYI4XjbhmI
	FMUI0IZzULxeIJUSp8+PAmdUz4hiDTDmSpHiwuW6PUyllpHeYOAxmvj3
X-Gm-Gg: AR+sD10zxzeMuB2wGRp/qCmsFSdakBd76RdnJsfdVC+8kJdGvpeeSUdA1I8tAWGTm2c
	xj8Y5LlItAeJgKB6e3KeNAMvv11rauJOFDfoO7YN8gO8A9XAZYFRrKEZSTb4heTpxr/Hmmwjo8z
	x+Vj3tutLhadgRfSE8kTtqF9D/GmCkzWp+3+RZXEr4S4YW0hQxtwgFZcM1rFLzw7UOlosIYpbgR
	6KRUX5kCO89sbquZfIZBchuF+j5N/lyJeqw1jNw5Wex2X76ccK+cOOC6GfXZtVFUczNwxO+pUHv
	JD6u/nwTV68XWG7UYsgnc/w0irdEhOFN7yBWLMlAN7mLR3uXTmk+Tu1jWld0Nmr0KAb+G3Amcbe
	Rn41h6DjjeB+iQYeXoZMojOFwIQM0NZK6K4WEoHUMOZ+3SjkNuIBC82utvfDWBMeeDR/CUpa2aL
	9oTJQU1JKro3OB8W+p3t9fI7NaIoC5K1jxop07mK/gWGWoY9K2wmeVohbEVjnr2I50VCi9SOO3R
	YE4B2eBNwWRcc8h0IJzyUfk/cFk9OQM89ePGO98SXhykbEPf4zHynl8CVcIDjwH2TO9KbSMQu07
	R3X1UlcxugeDjy4gtiaoCE69+P5D9hQ7zBKwdIOrd+oS7142Zx42Ma2a
X-Received: by 2002:a17:90b:2810:b0:37f:fd1f:d30f with SMTP id 98e67ed59e1d1-38fbc435edamr6114836a91.12.1785681966143;
        Sun, 02 Aug 2026 07:46:06 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab13255esm20191240c88.3.2026.08.02.07.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 07:46:05 -0700 (PDT)
Date: Sun, 2 Aug 2026 07:46:04 -0700
From: Michael Montalbo <mmontalbo@gmail.com>
To: shrimech <eddinen77@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] interactive: add interactive command helper
Message-ID: <am9Vy9vMsixhaR9E@nixos>
References: <20260802032549.50389-1-eddinen77@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802032549.50389-1-eddinen77@gmail.com>

On Sat, Aug 01, 2026 at 11:25:48PM -0400, shrimech wrote:
> Git does not provide a simple interactive entry point for common working-tree and history operations.
> 
> Add a new git interactive command that presents a terminal menu for common operations, including status, adding changed files, log, graph output, branch listing, and help.
> 

Git comes with built-in GUI tools in git-gui and gitk. Also there are
several third-party frontends[1] available for Git. Why add another
built-in interactive interface instead of modify or adding to what
already exists?

[1] https://git-scm.com/tools/guis

> diff --git a/git-interactive b/git-interactive
> new file mode 100755
> index 0000000000000000000000000000000000000000..980a21c967d02ab121a54ee586cc9de4a98aa725
> GIT binary patch
>

I think including this binary patch was a mistake?

