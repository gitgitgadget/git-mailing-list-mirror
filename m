Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C800F221FDF
	for <git@vger.kernel.org>; Fri,  2 May 2025 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228349; cv=none; b=Ovr71a9pzlBSiSjUeWyQ9mHzRZCfzRZnVkBtFR47LlMthuCzwRcs2MwgduvOc2aCDD/FHOFZtD7L/v1O4jTK051W2LFxTY2PhOXIvluSREINnOuIsjFSP/7Fbme4oRfy2VDruG/1g482flkCJBB97nVZvsTqk4J4YlF6qVXEIGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228349; c=relaxed/simple;
	bh=p/rGm60ZYQqXGr2QDI99z9fUQ6kR/5xijoRFCpQa7tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKHEfXkJpIZaUxreavVG5mriYRsiFzH5e94UQQ4Xpmd+AkttActSl6dOMTkWu3+/B0YaLSxmD3lbrQBm2rZe0Hc/rPhXgFQgrYHVE4eIZ4HLuFi+N7IHommWy6tuY4O2Wz/CL0sGmeWlnwtRO6lWP11AHlhveyjb9Pg8IXaefHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BdFVVPsb; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BdFVVPsb"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476b4c9faa2so38848641cf.3
        for <git@vger.kernel.org>; Fri, 02 May 2025 16:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746228346; x=1746833146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FJF7E+Q1caA+u12FTmW94vlxTY3rUisg/JepKRyymLY=;
        b=BdFVVPsbd5d5sEimOeTs79W7GQIEOEcNGofUF21b1cfM4Z0WqMYcjboD7nXPIB0GSh
         AVcGiRi730PCDsN7pkYEXRh08sg9NQ8DHyw/mdNtUT8vkqZsbYAffXoe8LNXMUpWIsVK
         eDuDjR6PYTxEeeTXeEsiHIrBjZ+1kBDWdwO7z5JPFkAiqFKlYw/ZWdP2dNKB3WSAHwFx
         M8OUZCGDbIR9kT5R3YeG+Bne1MKMljjVX82fHOVYDBIp/us8XuYJur+C4qi4nAMB8Eax
         ZxzUa6NEhxsUXgQWSrT5Anfs16FgmUVTjylxmMOb+WkYzjzEutT3CqB4D1kJUKNvrv9N
         yr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228346; x=1746833146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJF7E+Q1caA+u12FTmW94vlxTY3rUisg/JepKRyymLY=;
        b=NFK6q/1WXf6dTFLjv0uXIXJvrVXLYky9oP9j509dLWu5hN4AmQyV/kYygQnfDgNsz9
         1WItvYz624xz7belXj/8Tsupx2gQSTIjmLz3YXstC9JeHgKf31brheUM6KG3GA0YbNR7
         n3yO3xkISQsL8ErwJ432ygMg2wPkNf2hEinO/0TuGGFkvwNew3M+uMyYiha92SIRfCB6
         CKLk2GhZEa7PVgQmYbo3UqtrpTPq9fQgAgxat5o4NXSgrpnYdqwvnZxLVlyxWt5pi7GV
         3k19eOWFYNTRGeAI/ygUZKTyq3WJxgG7nYrSwIeLEbUHnmYTCHq72IMkIW90PIYXJFSs
         tCfA==
X-Gm-Message-State: AOJu0YygzvrxGlkYe882m3K4q4qyPkkIiWxqmII5UAs5HE6H/ygam5o1
	Ci2tmWotF8mFIwRNAASC9CB2mxgfZM5zQUA1uEyh0mB95s5qKJ4FChasFrSmD9Q=
X-Gm-Gg: ASbGnctJYP9YnuGc4gA/y+rcjv1skoNaJCmxYOArOJky06FgC1iwEhkfs3TLC0KCtbF
	Jdk3uva4mKpoL0nU8com7nVhyCW9PXV18JsBZ69yesoGLAbB43rXUYitvJoPC63VGB1GTdybvDV
	9Iv+RzJTfzdOQn7jdrgbP325fAshNALBSZbf+7Rejti+xW7OkFZbiSIQB2oVnUaL+RnBcvZEx/I
	Z+4FLUzGzSmf80M/TZAB2c7HDXB/GQ3dEW9Y7SYW+m9xy6BHlAAONrMIrumSEG6onGfDX25I/fk
	f2MW6/t+5C1QBOe6GmoVeQAPOCRu5pWJ+0GNWVvhIxq24gZV4mzHQ0agH+UjzvbVvzRZONSZ26P
	0nRwgWHiF62Ul
X-Google-Smtp-Source: AGHT+IG7dqi6GkoTbw/rJ3O4+Z5mtvWAr2GQTbySDhXp4W/Wp6T96253o0u1creHNTiIwaSvBGXD1w==
X-Received: by 2002:a05:622a:2b07:b0:476:9dc9:3c2a with SMTP id d75a77b69052e-48c330bb452mr70380151cf.48.1746228346643;
        Fri, 02 May 2025 16:25:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-48b966c7fcfsm25516991cf.20.2025.05.02.16.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:25:46 -0700 (PDT)
Date: Fri, 2 May 2025 19:25:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 04/13] p5313: add performance tests for --path-walk
Message-ID: <aBVUeRFKTaYNDOmc@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <97a0b52ccee8844c1c91232c625c2c6444873d85.1742829770.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97a0b52ccee8844c1c91232c625c2c6444873d85.1742829770.git.gitgitgadget@gmail.com>

On Mon, Mar 24, 2025 at 03:22:40PM +0000, Derrick Stolee via GitGitGadget wrote:
> The cases where the --path-walk option really shines is when the default
> name-hash is overwhelmed with collisions. An open source example can be
> found in the microsoft/fluentui repo [1] at a certain commit [2].
>
> [1] https://github.com/microsoft/fluentui
> [2] e70848ebac1cd720875bccaa3026f4a9ed700e08

A meta-comment that occurred to me at this point while reading through
the series. I typically think of the namehash function here as wanting
to have some amount of collisions so that objects which are related but
have slightly different paths (e.g., due to a rename, or similar) are
delta'd against each other.

In my mind, the problem isn't that the hash function has collisions, but
that it has *bad* collisions between two paths where the content of each
object is completely unrelated to the other, and any effort to find
deltas here would be wasted at best.

I'm not sure I have a concrete suggestion for how to reword this, but I
figured it was worth mentioning since not all collisions are bad or
created equal ;-).

> Running the tests on this repo results in the following comparison table:
>
> Pack Type            Hash v1    Hash v2    Path Walk
> ---------------------------------------------------
> thin pack    (time)    0.36s      0.12s      0.08s
>              (size)    1.2M      22.0K      18.4K
> big pack     (time)    2.00s      2.90s      2.21s
>              (size)   20.4M      25.9M      19.5M
> shallow pack (time)    1.41s      1.80s      1.65s
>              (size)   34.4M      33.7M      33.6M

Thanks for reformatting. As a side-note (unrelated to your series), I do
think it would be nice to have a t/perf-native way of doing this sort of
multi-dimensional comparison.

> ---
>  t/perf/p5313-pack-objects.sh | 37 ++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)

The patch itself makes perfect sense to me.

Thanks,
Taylor
