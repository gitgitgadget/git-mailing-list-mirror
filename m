Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B352BE043
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379719; cv=none; b=m8f/F+MIz/Z7AiB+TnXZH8TvZG7kEeweZrELnGIAQ8M6Dea+ScaIUIp2RlLjQmcBcleUk940ze8Q5ShN/fOttgV7rc2RqCAaGC1KkKPRzUEzSuRP2ZNK/WG2rocHeUsxvh0lvxhoUtudpjF9QW42lnv8TWei1fKGi0pxbTsMI3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379719; c=relaxed/simple;
	bh=yWHhqXlhcivGwe0R0jXMujHlbIv1Ld5d84iRADR+zRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BavmbWiN3cW2P4e8AypfLCcNyesGzc96OF1/72R0sp7+xX0oFz0Ob02uO0c3ZGVf5Nxmm3kSKQP7UyZAoCG2KZz54+K+Z6wDoRyg9RGETN7XLG4sy/TtQmy18UnnDUGtjortVcDNNO34N8jX/4nZwAx1NtkJykOWbXFaHssQRfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOyqOL5W; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOyqOL5W"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50917e02472so49593871cf.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 12:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774379717; x=1774984517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kreW0ej6Nv0iZK2rp2LAY3yhXA3B9srnYY6Cnjlnlq8=;
        b=eOyqOL5WbFKxDRNMC55C9CQ/GmS3QUIteNIUZtQ2ERinKorlpI0UDhcOAPnJOtzTFQ
         y+cLMflPm7KemWn+bUSBxNJjc8F1gLa9/2uPURqMZ8uR5/Wggt/Xi0XC9QG8rfimW4Um
         OavpnRNJxulyUyorl4a59ISVvvDYIiBbnsy8XgdTMY4t2cRXCSBl8J17LoSQEmOGqjs/
         5Fg+lsiInLF9GUf8XLbOCrS4sMMmG+SKXs+8wkNhQL5Uxnl5+mSyKH04oUOAnO7uuce3
         IC4paLmm+LpfXviOhMWZaek84XzXaF1bx+CTN31/CWAs5teh5hnMeZFtKTyTQjWQvDXq
         Z/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379717; x=1774984517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kreW0ej6Nv0iZK2rp2LAY3yhXA3B9srnYY6Cnjlnlq8=;
        b=ffNc9DDjOnhn7imsKwkUNMlmHO8O2Gsx4KtziSzBsNl98mTV5K55qyzSQnB6/cawS6
         jc0tECUYHctI9JjW8Yz9n4FXpAgYfi6iXd9SmRXXdF5bVtGnrbI+VB9tM31X5zc3b0J9
         N9YQqglNsaxBedNZjJcgtnyvw+0u7CsSjxuv6I2xZlOPSnM3pd+331hovFGRr6WOFH4Z
         BM3KBpxBGf1SXfeM2yoUt5u7wiS+bx7437hzyjIW8jjo+PXtuC3w9NHf2AU/j+J90WS9
         9rQHVa7XFKuf5SBstsz/a3nlNKwREAxZ840HV5e6Ke1CzGOKzSoQAwAk775umQm15HUo
         BZDg==
X-Forwarded-Encrypted: i=1; AJvYcCWslsgDy2pdZXVPdPdNcBG1qPq41J6T6qmEbRo2svPb91elYjWa1CNMjd85TnFGdzFh4ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzkZvDqQQr6Aq+fgRBbp8LAv1AEWGo55iu9Zevoynb/1+h6XXe
	zafF+tpvI7zCsdHKCZn1EAC5+pe4ahwXNOdIweujX5tyq5Cr/uSD6ioH
X-Gm-Gg: ATEYQzyEjEvna/XZgWaDGTBZltzyc+DpKIdkOOCoGoqFj0bYZbb59+F9E0aPthfrCd+
	OGXrt9loAB4pryBSuf67XU7BmN4HqkJuzyS63zzre5VimfbAa4GdSzdC+KgfrFtMBUYVGzr5EYU
	Tk3knhfbP4GAp6IfCqXKsweOZeFg3YuRUNlp0gNGXfyYKJCUoMZP/RXEnR0YCL3q9GIeQoIKCOp
	snPOdsGLYbIY3oiWymva8zsVEnEkoIadMdIYeIVOo182+puLI59IHpYgmtr1nB+zhQacb1bEdmZ
	Vci1MnsopOxYy64aF96lUMZ9Z7cqqHefvf6gZziyfomz8G9QkcsaFgS6FDgneU+k09Kpw1gRD0P
	oHMVDk5Kol8NW3QnkxWUUhIOeR14bqoL67a1focb3dcChRW0lKl/mQ+tC9hV7bwGobZWANzPls+
	6fFAkUv0vTAA/z0nH5OtzXH1Dxzp0Ro/Wx37m88fW0RubOopc0e9dvFJAwPqwTCM4pJY1HZw==
X-Received: by 2002:a05:622a:4d4d:b0:509:23c5:328f with SMTP id d75a77b69052e-50b80e66e14mr12892821cf.54.1774379716601;
        Tue, 24 Mar 2026 12:15:16 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36b50fa8sm145952521cf.0.2026.03.24.12.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 12:15:15 -0700 (PDT)
Message-ID: <017a4371-3b63-456a-9ca8-e36d6e9dc7d3@gmail.com>
Date: Tue, 24 Mar 2026 15:15:14 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] repo: show subcommand-specific help text
To: Mahi Kassa <mahlet.takassa@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, lucasseikioshiro@gmail.com, jltobler@gmail.com
References: <20260323152937.257406-1-mahlet.takassa@gmail.com>
 <20260324184843.299223-1-mahlet.takassa@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260324184843.299223-1-mahlet.takassa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/2026 2:48 PM, Mahi Kassa wrote:
> Use subcommand-specific usage arrays for "git repo info" and
> "git repo structure" so that each command shows only its own
> synopsis in help output.
> 
> Factor the shared usage strings into macros to avoid
> duplicating the same synopsis text in multiple arrays.
> 
> Add tests to cover the subcommand help behavior.

You need a sign-off in your commit message.
 
> The previous reroll mistakenly omitted the requested code
> changes; this version includes them.

This kind of information needs to be below the --- along with
your "V3" changes:
 
> ---
> v3:
> - include the requested code changes that were missing from v2
> - factor shared usage strings into macros to avoid duplication
> - restore blank lines between tests and before test_done

(here)

Outside of these issues with the message, the diff itself
looks good.

Thanks,
-Stolee

