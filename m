Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7417135A53
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361032; cv=none; b=pC1Dhs8022Pap6wYNddlrX0JBbshjXxXQZv8onWLjvTF4BscunMK8Surs6fcpi8tu52H1QBVrEZpwnqvFu0SSpPBdOraarDXDCHsFnKde/bIOsn20DC0ggfqXVm9g4ledsEzVD5fOZI7UN3IsCDupgHEr2hymBDjFA/747HAFHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361032; c=relaxed/simple;
	bh=UeQFfM2sngm1Ux4ZnWqpEPys8mUfTcEHNc02INI22Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHEKDt3Jsul1F9pQXOol+ghjtXnP9qDnzmBFL0ycH3x09a3UTYNxWbX0HyZ/ZXfGljIR85ppVlU3a9H7RCXKQI8ABWl+yfWAXrCg2KN/3b81jb3J6HrNQ0BJn89IGNfRgAk6gTy9Gpp9aYOxsvBHtodCVesgH0seypIJnnT4GcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kevX7FeG; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kevX7FeG"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4645dde00a7so2299943b6e.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 17:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773361030; x=1773965830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CfJrxv71JQIMXFkGW5SfB1EhM5Tlmi9x0GvfIPnNGBQ=;
        b=kevX7FeGk/57Mod4JaihaLl4SUVmQgILv2eZFwpfqM8TF+FP+bA0cti3sf32fQ8wad
         vZiCL1g9vdfUvcAfyc+10dt02uKfYHjFpIf5UTfHezjUD90VK8Q3khFitDZXdnlVuNan
         hiFi/gAV1lTwdfRRLTkipjU4pQwa3rAADGUFLceVzfjZrE0jguR4M+GmJZaEqxAqwgw8
         yaeRRlnIDK8lynE2OndkdSJFM0/4nG8R4jE9u3+VglS5Y8lcyOCu9+5kCi9p5uk143RY
         /qppexHujNKRv4mjd7XlJ0XqrtK0OWrcRu5EOPFmKveKlX1CXFOhYHj9Y1KV329MaaPA
         DsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773361030; x=1773965830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfJrxv71JQIMXFkGW5SfB1EhM5Tlmi9x0GvfIPnNGBQ=;
        b=ZkZj/A/ZMpeRL9cOpbrlzOUEDdkhLWKc+MK6RLoPoZ0pBfu4ij3rs2L+U8UaS7hkWO
         x4pLpEDCYnHlrve0u7UFfhEvwlud5/ryBemkyg3T4D2osIIdTykLGuEmPNwYgKHzvxRZ
         NKc0PZBjt1XiYRFIf0bE1BcQLEw7Sgq2f8MmzW6x8ogqZ/DqdwYCusRomAy7kCZW7cW0
         y6azl6iYpGbMVRkYaV0n2fC27gWvId4oTjQDWjXepna8PSuZH8wqW59UxlPkt+8sVvmj
         6t6Jnp0n4v7yDTBPDU8UbLY5qwT9tbS5AJzdlh6lG04IHY96+YkbPL6/og/28x2bpilx
         MXKg==
X-Gm-Message-State: AOJu0YzUmfuBXSrM3ZL6VosrOOMbvfVSkoblXG5DIsBN+xEUC6rdYffx
	3s88NOYKUricIhvH5PIAbjU2wKSLZac3tFM6PAvrhWYTEuMWToIrbSOH
X-Gm-Gg: ATEYQzwWpR8qw9EuzueN3H2lyUEx6rOzvYRPtRyzjT8PZBZDP3YH9UtQdvbhDnhk3bH
	Din5Jxr8VM5ZRx/F0Z2cDqxaz2Pa7JfdejqYO2wmTBxVT9adJc/oiq0sL2BZ+oAv4kG33ZC37Sm
	hVNtMfagwWC0lUvDAk22KHRZ9ECFvv7PapQvrU/1PROm51FHg94ojM5WIeUqwu+VLd+JfxHvJss
	JCzMGNjjT3Qfi5RB76c96b3+bJG07RPXMH0u6dQGdTv31H4bpHEwKsPCz+UJZSQZCAM8dOLUta4
	uZCvi60oK8f8469Jp52fK6WUoeXyQe2o3/tEW3Ja2HL/TNlFLhhArbij/5+xRIF6Hr0CMNSTD7U
	zb4F2lMpYqtJ8W4CoidBTrYfvFrqmc+Fo9g96/3vcmPuBwvWndVD/eTVlLBESlYmO9Mz9bQRvk/
	Qz7YXl/HA9x+ocuIPM
X-Received: by 2002:a05:6808:1a17:b0:45f:318:adb8 with SMTP id 5614622812f47-46743283468mr2953441b6e.28.1773361029765;
        Thu, 12 Mar 2026 17:17:09 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm6973908fac.16.2026.03.12.17.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:17:09 -0700 (PDT)
Date: Thu, 12 Mar 2026 19:17:08 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, 
	christian.couder@gmail.com, ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v5 3/3] fast-import: add mode to sign commits with
 invalid signatures
Message-ID: <abNXLWadH-nUQRpS@denethor>
References: <20260311173147.2336432-1-jltobler@gmail.com>
 <20260312192228.481134-1-jltobler@gmail.com>
 <20260312192228.481134-4-jltobler@gmail.com>
 <20260312235828.GA3193385@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312235828.GA3193385@coredump.intra.peff.net>

On 26/03/12 07:58PM, Jeff King wrote:
> On Thu, Mar 12, 2026 at 02:22:28PM -0500, Justin Tobler wrote:
> 
> > +test_expect_success GPGSSH "sign invalid commit with explicit keyid" '
> >  	rm -rf new &&
> >  	git init new &&
> 
> This test is failing on Windows in GitHub's CI.
> 
> You can't see it from the context, but the next line of this test is:
> 
> 	git fast-export --signed-commits=verbatim openpgp-signing >output &&
> 
> But the openpgp-signing branch will only have been created if the GPG
> prereq is set. Should this be referencing ssh-signing instead? Or should
> it be using GPG,GPGSSH as prereqs?

Ahh, it look like this should be referencing ssh-signing. I'll include
this fix in my next version. Thanks! :)

-Justin
