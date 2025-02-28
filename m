Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB93B322E
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740701672; cv=none; b=tQnAMJkytWiWKEY0FDRBYjjfNvw6xugoqx3N4gKE+cFcJfeXTk1m09i8L1ZqtHjj8QDJwAlSPPSE+QSPsiGvX2yiFgssfp2OL10BfigATzMerEg5gUIJYKp6+MQuZpm/LRTZTkMpK6bIiZOpYBQ6fMKR1jXegZzXXWlqHYoBTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740701672; c=relaxed/simple;
	bh=/H1gu7/SzWHJM0GdLvLc1vEEbvfcU93WGmUb4DwyKgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqkbW1YCzuChFF3yMZ6/8y8jbmfn/gfdrM+YehDLaYVfLuO9sH0O+POjqBq/qOd70JhIN88bFsnvxY7VPMPkGcZ29tn/CAdqIf1y06yipaW0nAvGJz5+n3uKuQJh71koYBZJMkAu7fdBdai6Eqf6V2I9iLmndgpZ1cXKsQEX/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=amerpmNX; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="amerpmNX"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f754678c29so15083937b3.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740701670; x=1741306470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/H1gu7/SzWHJM0GdLvLc1vEEbvfcU93WGmUb4DwyKgE=;
        b=amerpmNXskH9rPvVaDGK6EkflJHKGQgwNA6KQQOicnQEm17pdKS6VO9yyu48bVovVe
         Mjps2RMloBzU2tQWWpVjza4sRTU9E9Ex0yT6KuRkFXTOLgU4IoAzMXa9CSwB2OHdMR1c
         VIa3SrEpFqNQUKu0VAmFyh8aNJJCSjVlt/mAXlrRgFykojnl9DvF3NGtvZDkHC6d5QBY
         mHTjSG/EQ1wVhxoyxMScdzdUT4pPlZNzHMG8gMjQjqWU9U8I7YtUjy48eOpUA5gRq6Ty
         pSWHoL461qAkg5lJvmbKN/lWGRkQn+mtL5XB3TDj4o4SVC2jj3gmz4IJGc6WTPWrD5/L
         ckQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740701670; x=1741306470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/H1gu7/SzWHJM0GdLvLc1vEEbvfcU93WGmUb4DwyKgE=;
        b=es/Kh/At7rTuhsvhMaJZSpBnaYUG9mvVXH8sE771lhggYaWWa0k+Aw7X+h9z8nSV6V
         dfHPiVPN/FCK1vmqIObl6M2FYSIpOXFUNs1SEmWbt5Zriith7BTOKfCTDdl06VWyvEv+
         I3++4niNLD7dAA7WVxhvFyBWIVr8k2tanQGgJ2bgsJP3pTUU/MQLQoGjIgdSvjwTzJ2e
         lLe1nZFEKcvp32gstt9ytUe7E6a1hcu6CWagRWtVn9e/b/ColQ/GJIKMxRj3UYVyhnp5
         V11ab/Dms4++QFLkwVSWF/+9Smm74WcU6DOIQ/iMUnisZdgt/iyt/Fc6+Rp3Jn2cg3gm
         BMXw==
X-Gm-Message-State: AOJu0YwqI9m/LHATqLyEhohQEX0Dsr8f318qPci0p2Aln6fZQPyMPY9x
	aZGPml48i7Laz3fqUDeixVqK08HtLv3w1VJnFSE/bs0UgKDjcLvAlefxW/oRSlZLafyv3S4R5rW
	Z
X-Gm-Gg: ASbGncsSMkrSIyuU3maKQIs+Rsv/okhLDIOZChULkvbw+m3ctt4jzvIhbA9fIz7HHPZ
	3xL4CsCazMtrX6wKLNrodetiRyeeD303OAuZe1Aw24HgHan0MrTrx5vF8PheSpa51kl26SG8PfO
	GHib6AGuMIIs/tavAQZi0Ct+TsAp0lz7oFXe8FtgCEh1CqpX8QEtLbYZxNtKzIFCciASAEvj2Te
	46gTvw00elm3DAmmFOxOmjr7n6TIeDMRgS+SU1OOEphwDe9xAVEUt4M4bdAVTEgu4hFkVE9YPwD
	KQjWMBqKFovoIokf6J3QV8wzQAvdaLKj/iDiVjHORxyJEve3O/d8B+2n31l/F2f+/UGzurpOfA=
	=
X-Google-Smtp-Source: AGHT+IGVnPGgrnT28k9IfMAd+qvs6DNlTE/FHwYcqGpFJ5DFhSI8TajVn4XDRrlMsNA/6xdEaVVErw==
X-Received: by 2002:a05:690c:6301:b0:6fd:4485:9255 with SMTP id 00721157ae682-6fd4a122c2amr18969457b3.24.1740701669727;
        Thu, 27 Feb 2025 16:14:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca680bfsm5149347b3.60.2025.02.27.16.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:14:29 -0800 (PST)
Date: Thu, 27 Feb 2025 19:14:28 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/10] loose_object_info(): BUG() on inflating content
 with unknown type
Message-ID: <Z8D/5Kmsn6XqXgaZ@nand.local>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
 <20250225062824.GA1293961@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225062824.GA1293961@coredump.intra.peff.net>

On Tue, Feb 25, 2025 at 01:28:24AM -0500, Jeff King wrote:
> It really makes me wonder if this "unknown type" stuff has any value
> at all. You can create an object with any type using "hash-object
> --literally -t". And you can ask about its type and size. But you can
> never retrieve the object content! Nor can you pack it or transfer it,
> since packs use a numeric type field.
>
> This code was added ~2015, but I don't think anybody built more on top
> of it. I wonder if we should just consider it a failed experiment and
> rip out the support.

Yeah, I was wondering the same thing. I think 10 years seems like a long
enough time to declare that it was a failed experiment ;-).

Thanks,
Taylor
