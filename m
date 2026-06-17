Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CD318EFF
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719667; cv=none; b=pWBI+Q4q0F9WpaQxB13DgyjdvjP/mTTuGKvRVta44g4mSfB722JE0dP6NPIN1/c5MgxPB1/F0v/Dd47r34LBYOfvfCkfl+Z5Wi+ZT+q3mu6DURdKBhW8ldyWAR/M5d0b32BlnDhSZZbVRHMUjkSuL7gzwNyKW/3qPWcKtVJdAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719667; c=relaxed/simple;
	bh=QfA3+oyzcCT+kk75DydvTW1wtQG/YQP34vV1fVqTc/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiIdDDONZPo5w6krVKqltnHOZ5M9i7p5pZQ3xGaKetzuD8nTyeNdkIILsNZnsKZxN5eKBZgaIkrdy6dCQRg8I37OxbaWux5tyODSNOFTGEJV8D8w1o95xE3hfwjdw/uL9+w5qFZq8oFF4MroF+m5QyLtmdi6MJYgpeh9LovoeWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf7qvQ8Z; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf7qvQ8Z"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-69d7e72b052so62926eaf.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781719665; x=1782324465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3hyE+gWPyzSIMSxIc2zVcKlqUpBdYz38DJXN5VmmNU=;
        b=Uf7qvQ8ZzaPWlu5xT8V3V3q/pT3WlWp9SmvZq/ObZg4fjbbJBWL1/IgW9bjv3S4Zob
         kVe8yuLhW+EvyfqLtUAKdGT344FbPRpprnZDoLNC9EmqlYLUG7E+gKhAbaH/iPGFwJGk
         dBH3YB4M+FZzydti6GU812HXJoFqdZTk4I4KEr8WuqTVHwjDsszcrpqb3j4hKljXjtRW
         KSkmlZIHfwgDTmFohxzTDJn0dep33xJrZoUWohobYzmL/QKof+RJb1/OVXdZ37jbTkVe
         B9G6I7mbB+6xxRL/FQZ73Qn6WLXg1ronCgHlvxns1S582VqF4ydXT20theBRvO0RWeJ6
         hs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781719665; x=1782324465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3hyE+gWPyzSIMSxIc2zVcKlqUpBdYz38DJXN5VmmNU=;
        b=GPEq3ynIZGYSmh9+130yz1SqJXNbPueXNuU+HsbqyLUJfh80LotxC2fuzJ37dEv+NC
         zHNRt1tF9usHhegJZfDWpPUToLYQ2DeQa3bsI4FX3cPaKrVab/B2MIO52t4qyudRyH+V
         Fg6xjdMyqOOQ8E7ZXyP3RrWbIAo0hDU10TNgZVLeoOGIh2BhPNAhfvQheBKZpo4+M2fq
         iLS1IcQQsg5iX5GJLMGFKGNzAb3o56RlZdpZORYiVRj0gKfOpMl25dA3o6beP5OaaAtY
         +o8ylb5ws84FMYo/Jg59fR1cNm7OWo+TeagUU7RF7UqdheVQuBxMgoY4MQzjCADhZw4s
         sUHw==
X-Gm-Message-State: AOJu0Yzc/WViiUh7KYyXwik6BBqd+SqmVfsaYxAvF4iv4jiyNlwnMNgO
	mVqpcFO+WrmXlRIM/oWKdSC6Jo8FJUJygWCiRT5d9gpHc7mbwznYLCle
X-Gm-Gg: Acq92OFOuwG0dEW3elJISUfIFJGUZud38qTzVmPC60OiGXUmRl1LUIwhhrZImOjiHDP
	FtLzz7uD/hkWF+DzOl/qhR5GCA/EVl2qhsnWR3iDqHa78ld5i49G+FQBPuH8bjaBvFGyVIa9ghu
	KhEo6IKk8I4zFX8h+BPCkaGyyh8GMnGIQt2QRO7nyXM4219FR0dUEzVl8s8s0DqCFd+PhaNaHPj
	WiNvN5SB2QLIqCPTtVkGN+R4CwFE4oLIRxY+grPGp2ZCpq0rYraS8e209pW1RZ8038WYMSlcmcW
	nakYaThb8FvHXHJsEZC6Puys+zjhHJXxpHRbP15AJMfYwA5GOLg+mPsjiXbCttAHI6Kg3HQcy94
	1lihicirdj+JzelDEKrR4z7mgCXZDCYYvVuopgYpoTuJer6cgxxf/w22JNnwnLXdsfZ2+rQsZlJ
	F5DuRBvw==
X-Received: by 2002:a05:6820:1686:b0:696:6440:9e1d with SMTP id 006d021491bc7-6a0b60c31e1mr3298836eaf.39.1781719665048;
        Wed, 17 Jun 2026 11:07:45 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69f00ce2f24sm6884463eaf.3.2026.06.17.11.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 11:07:43 -0700 (PDT)
Date: Wed, 17 Jun 2026 13:07:42 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/8] refs: unregister reference stores from
 "chdir_notify"
Message-ID: <ajLhlWqkJLqCzp7v@denethor>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
 <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-4-f4854aa99859@pks.im>
 <ajLdIY_fxkKDTBaW@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajLdIY_fxkKDTBaW@denethor>

On 26/06/17 01:02PM, Justin Tobler wrote:
> On 26/06/15 03:56PM, Patrick Steinhardt wrote:
> > Note that this requires us to use `chdir_notify_register()` instead of
> > `chdir_notify_reparent()`, as there is no infrastructure to unregister the
> > latter. It ultimately doesn't matter much though: in a subsequent commit
> > we'll drop this infrastructure completely. We merely require this step
> > here so that we can fix the memory leaks ahead of time.
> 
> Since this version of the series dropped the last patch which stopped
> using `chdir_notify_reparent()`, does the log message here need to be
> updated?

After looking at the next patch, I realized we are referring to just the
`chdir_notify_reparent()` function here which is no longer used. The
current log message makes sense.

-Justin
