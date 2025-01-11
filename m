Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEE682899
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736615678; cv=none; b=o18kVwdSOmTbx+kJjizPNDqbD4BUvgSvaeRpVi50/qIR00glpwRr+Y6mS0k+J6yYn+/I0X9+pf+dwGEu5gMAocGfqbUg3vLNCcLN5MZLRXZLeLHKqkuokDu9HdFaY7PpDP8PMcIG/I0bKxgsr23BmJ2iolk7Jby4t+IFn14Aw8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736615678; c=relaxed/simple;
	bh=EkZ+YW9nZjwV5STULb0gk9n+iNxQwKayahI0Pr56wTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0i6Nn4YoFl1923S1cSga61uw+xkQwr2FNXsiSRPCHzD05QtzgREsHfM+rlYVeXo194Jbsba6h0stXLk7YJiuyUauLIsDYvxkkQyYUE140fO+0+C6IdzOQAhZH/rLs2jwiUd7H8xiN6Zj4UK+vlSyVNwb6WaffVh4Hdrdqs/56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NrKNt98p; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NrKNt98p"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e545c1e8a15so4605318276.1
        for <git@vger.kernel.org>; Sat, 11 Jan 2025 09:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736615675; x=1737220475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cz/COPaIqYbXyHl+I2nwuF66BWp5KAiOaJGC5b/rnD4=;
        b=NrKNt98p0ueLV49c35kZ63QuVs+h4sY8yRG9i5UvEYicXnheXC7z7DfnyIwH+q4ng6
         lK91F8EVNS9ROsTkTPbd6NV/Y6JDoDhQqzyZYiCJaBVD7oODGgABmqsL5ZfqcDy/+hIs
         /GTuNdKWONh5Oq+MmhjdDuzjo5EnWJbF6HACABu0MbBYBHinH4cwQj+1wROf066qolgn
         AxdLh9qpDfTaTB0UDuxAE0ZgoyMGNqWtRTlo519k+xTCYcYxGYDtEQqX3XzpdL96d7tz
         wpt77ze9889In4H7K2WzO76YZvoHEHLb0mrWf1cHOd5A3n8JEdqCh9COzLqtSLUzXd5n
         QINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736615675; x=1737220475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cz/COPaIqYbXyHl+I2nwuF66BWp5KAiOaJGC5b/rnD4=;
        b=e2KAv1Vz0KjA2ofl1TDsEqjIWB7/012Ot6Z1yku3sumb9ugUooHznoolg2S1SF6Pwq
         XXiA7TV3ojnJVo6a0sXyKi5w2vlTlVNxVMEfOQsUUWkaTXcwgLLKd6ZYf05t0n8QpClz
         8lJ8gUrH3TU0ByZYGRSz/gy9539T6dRn9+AF8IxTR7LjkLL3v2vUSxzcuVTBO5sVO8wj
         WIG+4IB6xDOKET1CDq7/FmAvB6SKwxvpXtRN1fccmXya9MrW7ktccZZn+LPFFXq2uGAi
         fmHCdAtEN3z+HakRvfT6ZYoeGHdi/1MmPkB+WXgFp6IMCoBEKhk8I9+x3+/ChKitsYyh
         c0IQ==
X-Gm-Message-State: AOJu0Yx1FXWO53kvyC/1svXCohoufiHTWXNxqWa8PqUsMDSWtJ9ZcuOI
	mIYUlJfIkanUFi+IVrMZ6O2ZxiRei90U+oZdQVBNq3Uc35V2UX6QIMAEM2F32hE=
X-Gm-Gg: ASbGncvgWbphkRAMRZ4BXnKKvruFSKy91+2aRXO7uqmwFAh+aDB10/BE3JqfZ4VPtZx
	oH+Ld6vGHOg/0UADVJOREa2d/tZDDqtGVa94yr9K+k8wjASwbo1POPaR/XkF2hNhXlwK8qRJAm1
	4mzng/V+Zii0k2bH463dToTX33a1/yPJNsFMJzP3QmX/EAS98YQuChAE1d7vDdoY58vz9kbcSfR
	3n8M28DiOHscCFiiCQNeoVvnqM2A2bHU5QDdWi0A1L5OEUlOk39bPmf5nDSLcLxe1UUKhv6pPBB
	YLvOFJH+6dHefUjc6EKpcSZTogkL
X-Google-Smtp-Source: AGHT+IExOLs6hEmJDa4MxjBl+ESZDaE5WFV7KKnhbLKzkY2nHGjqmAF0Hd/h67KbM3hgjff1yH67DQ==
X-Received: by 2002:a05:690c:6005:b0:6ef:6a91:4971 with SMTP id 00721157ae682-6f5312d18fbmr115626817b3.36.1736615675587;
        Sat, 11 Jan 2025 09:14:35 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c432fbsm10925547b3.42.2025.01.11.09.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 09:14:34 -0800 (PST)
Date: Sat, 11 Jan 2025 12:14:29 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/8] hash: introduce unsafe_hash_algo(), drop unsafe_
 variants
Message-ID: <Z4Km9QaGflwAI7tA@nand.local>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
 <xmqq4j26cikd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4j26cikd.fsf@gitster.g>

On Fri, Jan 10, 2025 at 04:14:58PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > (This series is rebased on 'master', which is 14650065b7
> > (RelNotes/2.48.0: fix typos etc., 2025-01-07) at the time of writing).
>
> The previous round was based on
> <cover.1730833506.git.me@ttaylorr.com> which became
> 'tb/unsafe-hash-test', but this round is based on a recent 'master'
> that does not yet contain it?  Does it mean that the 2-patch series
> the previous round of this series was based on is no longer needed?

Those two patches got squashed together and became the first patch of
this series, so 'tb/unsafe-hash-test' is safe to discard. Thank you for
shuffling the patches around as always :-).

Thanks,
Taylor
