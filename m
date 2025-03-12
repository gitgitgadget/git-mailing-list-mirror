Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4BA1EEA3B
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741816835; cv=none; b=b4LWciEcSS4TR08SgdC+6Bt16iSOMY58nFWaTN8qYynZB4AhloykYEt81fCDTCpl/bhupJu0x+fIVtV179CErvfE5h0kWlQ1w/RXtVNNUyBqfqI31/XSZ5lOdu9ztxoLEs19CwKjzWT85n69XU7fp5tSGEb3L0ID9slLQtWKgq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741816835; c=relaxed/simple;
	bh=pASNwMO2NZ0QdW7+lxkqISC7PT8Po7C4a4h9zQz4o3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0RANDCSz/2iTJQWHs+Q3Dw4RZwrYuVk0RwAewfdVspJBueVcCmta0Cc3HZPLaIn2N0d+T8j95Od50BuePcDYSAOh6edXaGmMYunc72bH/thzTiTLy46S+J5XkboltSxXt0QHiBxnYDa2Ap0WwnT3I4HVXoeGjsqwrNEDEkbpc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LHioWzaH; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LHioWzaH"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fead015247so2471677b3.2
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741816833; x=1742421633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VpjJ0jK4KHsSggjDzCmQqdAWbzQcHY0n+ZyLZCLcRJE=;
        b=LHioWzaHg8eaxexes6LKTZZlUhCGktp9coQ5j5IyGRb+cSaTNfOV0cZaQWzBVjlMC5
         cwhAVjgkHxo8uqyy8ZpMPINRlHN3Bb1ofy77aZP8XKY1AGjCcfmAH9oJtjeBo1hi9N9h
         4xOyr1zzXJoRb6xm0E1YSGLggfDRQL5qOIv/mZtoSJ3CNQTFE/7qUvjrfau78Jn6Izvv
         pMYSFFv8GT+baoEn9wPLdVJpoyzASdncwwJx/VQ5EzCC5CLQSepOP1iXur6cDQYnjP3+
         RWBHZ8CsteXxxRE+gPLEWy89cZRpBrBHq/3RQ8VjYxoyu4EuDZF5F1HhayXbVM7vglzz
         +zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741816833; x=1742421633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpjJ0jK4KHsSggjDzCmQqdAWbzQcHY0n+ZyLZCLcRJE=;
        b=BXDnFZeHAfv8hGDK2OIdkhGVKp2Mn61zcC6ZQwBsJojXRZJY+cZZohu/2hK6N/uboa
         9wVSV9DOFLACQjfEZkrrYfPbs+CtQ0TE/qfbI5FfQBicPe1aIiR7XdYbya+8BIz2LtvK
         ZEpcJ0l8CL4GdJeGBVgqrYwEzHXt6CQ9Pj7xAdy88VbREasJuRrreap8EGG1j19N44hr
         8Ml1N6tXGjNO7Hl1pjcv1XcFKOesWL4S39XB5/K/rvHfFYc8wn1cSNHSo2xer/D11kfd
         wGtFmsgmvCKB5fMjyQWsbSxzh9YCV9up2BCuPEYoi0yDSmjinCr4jvFRRq/+yQA+QJwo
         zNog==
X-Gm-Message-State: AOJu0Yw6VEw2VjlKEgKNwxNUgJMwywfXSfPXD6Axr7lXaHCg2Jm3ZbpU
	a3Av3c9lSNOVEsg6ONpYHzP7og+DygFbbiI153yKSpCc1P0hFV07iwZdSn7tRT8=
X-Gm-Gg: ASbGncvbtgKxnufPedfj4FyotrGhu7Bi7rqMdzy0J+xe4T9B+fU5x/Jk/gzK8hGJ2JI
	JPmxdW112Q7gjgCoMl4uN6eM6NIkBZ12L+hQsJGJnrSVbBnJQ32MUgqUIe+ubjIekyVMDGo4psI
	wxLkx9BI92y2vBR/fe4LE7XhysbNuRweFBn6AI+bS3YcdkwuTk8fL6AqjLzIQRtj/7zElYxF3O3
	cVq2iwyORNcK4HZ8DXBSV+ehKgsc9V3yTfvi/wH5SIJRmYRspMu9poqZCS94MfkAA4SugDZhuXs
	b7EgvHAAg6QcHYB8B/74Ou+sq1N9APh9IeX+hNVVRT5N2hkYvGm3BmqT6GqbWd8H1xbHO9BbrCn
	qgXnyar6N4+aa7Z1NyI749E8TaYg=
X-Google-Smtp-Source: AGHT+IGM4AAg1ByJhvmVqKnhIDls592YugHz/NlloUAmclyietRfBeH4AXn86nqX54p359b9nui33Q==
X-Received: by 2002:a05:690c:25c4:b0:6fb:9429:83c5 with SMTP id 00721157ae682-6febf307356mr313422617b3.19.1741816832975;
        Wed, 12 Mar 2025 15:00:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2c64b57sm34024257b3.119.2025.03.12.15.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 15:00:32 -0700 (PDT)
Date: Wed, 12 Mar 2025 18:00:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Dmitry Goncharov <dgoncharov@users.sf.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] merge-ort: fix slightly overzealous assertion for
 rename-to-self
Message-ID: <Z9ID/2zx25qesuJs@nand.local>
References: <pull.1873.git.1741275027.gitgitgadget@gmail.com>
 <f48b3310d4ae8d05780fd25e467083c4dc9852cc.1741275027.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f48b3310d4ae8d05780fd25e467083c4dc9852cc.1741275027.git.gitgitgadget@gmail.com>

On Thu, Mar 06, 2025 at 03:30:27PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> merge-ort has a number of sanity checks on the file it is processing in
> process_renames().  One of these sanity checks was slightly overzealous
> because it indirectly assumed that a renamed file always ended up at a
> different path than where it started.  That is normally an entirely fair
> assumption, but directory rename detection can make things interesting.
>
> As a quick refresher, if one side of history renames directory A/ -> B/,
> and the other side of history adds new files to A/, then directory
> rename detection notices and suggests moving those new files to B/.  A
> similar thing is done for paths renamed into A/, causing them to be
> transitively renamed into B/.  But, if the file originally came from B/,
> then this can end up causing a file to be renamed back to itself.
>
> It turns out the rest of the code following this assertion handled the
> case fine; the assertion was just an extra sanity check, not a rigid
> precondition.  Therefore, simply adjust the assertion to pass under this
> special case as well.

Wow, that is a very interesting edge case from Dmitry. The explanation
and fix makes sense, and yeah, looks like just an over-zealous
assertion.

As a meta-comment, I vaguely remember past discussions on the list about
when to assert() versus when to BUG(). I recall that where we landed was
that:

    if (foo)
        BUG("something");

was preferable to:

    assert(foo);

I know that we don't usually define NDEBUG, but I think there are a
couple of cases where we do, like for nedmalloc stuff when building with
USE_NED_ALLOCATOR, and in Windows builds if DEBUG is undefined.

So I don't think it makes a huge practical difference, but it might be
nice to put in CodingGuidelines or similar.

Thanks,
Taylor
