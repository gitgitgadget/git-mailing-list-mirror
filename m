Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E910A3E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729546385; cv=none; b=mj9N87A39JygfbFiHM5hWdWrrhwy7F35/R1b4N6n+7TxaXqSttF7L9ikXAgbsP6hZX171FKr3Z6MYskwDUlMN4JMi8ZRBOWlkd1fk5faZuGfF3uOCRF/HrS1noEqf1b5Ko027laQKscwtWoKey28bAQvnR7MwO4oSwoWWYZa5FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729546385; c=relaxed/simple;
	bh=JKkPl0dzAykUZspZfefwt9NZEhvMfKzRmTsbNgFEJjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/mi0+r7leONcjGdMERsJFL1UNKaIKh7LHXTghHa+LSiJXr3LCsDsp9+dtJRtKA4AVHuY1zhcdiHYBkyAJbLG/9UlzTBlLnc0w4YTzNRRsVh/Cn2vw+OBwqpV8DiuMw0YNaAknM7jSeRGXimftZ9J3Qajjj1xHHePLL5Gf6w+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=oydLQHET; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oydLQHET"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e29756dc019so4642413276.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729546383; x=1730151183; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bfVHwYKdJoDXlu3DaLXF+hiawHKtaRQvUrwskQU3rPY=;
        b=oydLQHETQdCbSY/DDg7+14fyl4YkjB/zw6VDW30WeqFYlddd2OWVvuqehSxCxs5sGW
         uaah/uBCQxPtCO1LEJ9z/ldz7WgVkordgo7OVrt/enmyproaTVBo0r91CTogRakOPUlD
         7LFAP4I22Ru9zz2QBUMUsc1YxURWadTSTuOJiagsciK69WzMlEHKTrXzsJEavflMTib0
         LMh3O/bp/76r2g+BWOXefQFJEzKKCInUtSApxF3HetRHwjVqMB5m2vviIbirAQ1qrY1+
         LuIoJwlMuYmH9LJzBM2uJUa5ZkWpW82Vn84/BayZfwWY0mpJX+xYK5e6R6xBa29HnVG8
         ZvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729546383; x=1730151183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfVHwYKdJoDXlu3DaLXF+hiawHKtaRQvUrwskQU3rPY=;
        b=QDxOW7xYKrG1BH1SKgBLI8SGuhGtnLZ95waFViLtpmLn2wZhK7lcQ2ng9xLlvGuARw
         UYtO2kVWDNUxlgUrAvZnW+1q+SLffh2Vjbx87FGc55aLrnePVQOOBqeWpuMIeUwUfwVR
         B9TClEpW2zvwbHMNlIeWto5NAwDoxZ4MsSPZdkY+MO37LDyXbp0R33TCVZr3rg3/aIte
         fiO58f7KdpCAtrth0wadW6Zr13XADhk9xfWVKyp7+/Ex22Av0V7ZaYIHhyBV5bDO6eXR
         UCAAsgl5nbnz1mtoXlncIMZYXIBIUz9Q3hb88RXCzJ1jEsWco7cmE5SfzZ0I2Jle4DNM
         8QNg==
X-Gm-Message-State: AOJu0YwgwayxrnwfZorDRzVYnNI73EyegpRBDBmJe5vOcgdwZ0mMqqan
	tWFDTNsOPWlQxGUwPXwR1J9xsSwRxMsmalstmeV0jMlNqkydxzTlN3vOYszJrxQ=
X-Google-Smtp-Source: AGHT+IGgCnt9j0o1JGn9TAwikH0iyhkLOt+FF7MrndCrEx5jJDyPgwGbcsqHBsxUM3xjplIQSWeNcA==
X-Received: by 2002:a05:690c:1e:b0:6b1:8834:1588 with SMTP id 00721157ae682-6e5bfd4f779mr126694207b3.35.1729546383085;
        Mon, 21 Oct 2024 14:33:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ceee3asm8313557b3.111.2024.10.21.14.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:33:02 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:33:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com
Subject: Re: [PATCH 3/4] Documentation/git-bundle.txt: mention --all in spec.
 refs
Message-ID: <ZxbIjcJnWYOPbcKt@nand.local>
References: <cover.1729451376.git.code@khaugsbakk.name>
 <33980a47d132c9ea56238641031e72c5c7e2565a.1729451376.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33980a47d132c9ea56238641031e72c5c7e2565a.1729451376.git.code@khaugsbakk.name>

On Sun, Oct 20, 2024 at 09:15:01PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Mention `--all` as an alternative in “Specifying References”.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-bundle.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Good.

Thanks,
Taylor
