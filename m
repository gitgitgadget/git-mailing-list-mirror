Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC7A4C91
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740703006; cv=none; b=cY+SZHXjtPD91cFGwz9IiPjMhg8qRUvc9F6FD5WvIj3cUbv1o3lOz443O06kHiifsOVgZ1M3r4myMW5Y+XrZabgtoTTCIS+4hbctUNLm/iFf8SLifrP26YVAdtBlkF8MdwDmcH11mADyz11ILvmbSqMeyTfO28NxKOWuV9u0pwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740703006; c=relaxed/simple;
	bh=SYzQVpzKQb9JktPRmpByice+L+umRiYLBnn5q8B/U8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8OTWQUi1ICF6g6biCPB1OGENWoQv/po96kZelXBGWC0I6sJY7TK9WGkTxQuOqJa6YKzO1Nc+G7rLC4Krhm/vGbTPyzZFV9gRvNlUPGlMBdhPlxJoeH2k4nOA+QvSr85pC9qREZo+tUMuHGegVLlz4BJw/Z1hGw3I4zX67OXPek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Muv/8TUh; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Muv/8TUh"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6fb6c36ba25so14586537b3.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740703003; x=1741307803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SYzQVpzKQb9JktPRmpByice+L+umRiYLBnn5q8B/U8Q=;
        b=Muv/8TUh1G24hJ3q9BxGi0WpTn1MeAN2MJ8FEZ4646/3IrqLawrJtHxm0L0pXjIfRG
         YCLaVMblqmUZomA4qwPyclIn4xO63is8NlWmXxrPajNff3iL9DKNpCxMbaOG111dLOCh
         SQdToePZ8wTc2i7k74KywoFRxLrn5f1sW3JVuAvqdqxu/Y9p7jLlRCv1hjSeeHwO/Q0n
         i8skQl3OBN+EFX7N4LKGX/MzRgS+UUmAp2ObS06XfZ0dJd8NgkIL/mebbRBckewZXnmP
         fdsZJ5rkAl82Yc7F9aX0nIpbdHX/16i57xZ+gBZk32uLUDwB0co4r8k+/FFwx4ExVqxV
         zYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740703003; x=1741307803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYzQVpzKQb9JktPRmpByice+L+umRiYLBnn5q8B/U8Q=;
        b=YZPc6eJz65b5EWYSix6SK+k9ScJ2YnliHz9MdQC1JuvRN+qgi6rBoep7I7T5et3qqB
         1srrVrnklY1guObVyNVyYhjXe1pWjv5QwsooEI9fHsXg+m+t+Vrh9DOhyQRU9DnpcJuH
         jJm6um0ug43GdugPuJA4PUUPTZzssZ1V8y5m0NsHakxDZOeyDdeFZOjM5ykRjWmecqij
         36rAdr9GBcATF5yyO/+rczqucpbMcI5N/QAInTUaN0KR9D9SrDVZP9w9nCWGHCrsMXDp
         QA4kkb5mQIOuTd15e8q3AbwmlWZ70jW6sQfY0VFJnL43jVGV8J0WlN2jl0ybt1b0bZSG
         TnUA==
X-Gm-Message-State: AOJu0YxGXnMP4PCXZyq2nP7pgB+MM5IwbA7th14EUVX5BpQJ6vz9VKlw
	wZPfXNHpt+JmAl3t97mbfD6FhWl+Ly9dgALk9HemftYjSAb7YmUzAhsWdONl0cUP1/31eW4CbD3
	D
X-Gm-Gg: ASbGnctHMR4jot9GuGRjvtQ6K6HaiF9+6KzU/6q7DdOjAUwvfuJGm50gZ6Eul9zrQMr
	D/RohJeAcvk4ueilchMvagex6yZAhu7lIgynW8XltBIL5Aq38iOcDUffowlS78R+qxh1+jBX8rU
	V8nJ5bV5/2Q/wQPLE3Y7t+Of1xj5MMrNlZYgIIry367hDkgviVQZhdiGyybk7jZ2jN2vOrOVfIi
	okW1pPK+RO/XEG0OPcW7s+ra4Th/j8PSlkN5WllaiJd7EeWv1Thw0WZzpXxSFB6c7nuQSA5fmKU
	Rk2oLK5MH50fEuKdxGnY5lxNwyQ4QmYhV6aBzD3pnWp19sk4cQPPY4DeuoOTMNKy0rgGd+a2jA=
	=
X-Google-Smtp-Source: AGHT+IH3JfzcGoIw8JMSgsH3ccwRN6KthzfJT6gFTN+aU7VFqlWkLvZ+IkHLiGsCp3dWlCsvR9PrAQ==
X-Received: by 2002:a05:690c:30e:b0:6fb:a251:2450 with SMTP id 00721157ae682-6fd4a0af48bmr21668137b3.1.1740703003683;
        Thu, 27 Feb 2025 16:36:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3cb7e5a6sm5132207b3.87.2025.02.27.16.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:36:43 -0800 (PST)
Date: Thu, 27 Feb 2025 19:36:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/10] unpack_loose_rest(): rewrite return handling for
 clarity
Message-ID: <Z8EFGnUmyAAJ6DUY@nand.local>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
 <20250225063421.GJ1293961@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225063421.GJ1293961@coredump.intra.peff.net>

On Tue, Feb 25, 2025 at 01:34:21AM -0500, Jeff King wrote:
> This should make the logic a bit easier to follow. It does mean
> duplicating the buf cleanup for errors, but it's a single line.

At least to my eyes, I actually prefer the state after 9/10 and would
probably be OK to see this patch get dropped. I wish I had a compelling
reason *why* I felt that way, but I think it may too subjective.

I don't feel strongly about it either way, though.

Thanks,
Taylor
