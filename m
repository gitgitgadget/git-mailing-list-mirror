Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFAB35E956
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782756719; cv=none; b=qKnhcfDORxbgth28fG9sXqPjYJxNWJaPZzwARV3HWRkmDSryJA2oY/70EG64mUkrSv+LN/INN1pSTgluwRdavDyxTrcc9oFc4JzodghIiz3qfB5QV7i5YSIBUnneubLwSMz0W35VDD9rs0eq0L0terOy2Fpr+SsedLjLvVLP/MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782756719; c=relaxed/simple;
	bh=vKb3Ae8Z51lV+3VgGw2g3OsgqWQZfabkGPcYEuqUR14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVJI2AsSIVrwpXI6jE7TbsE+bg6B7u4n41qzqY+YO+Rl/vnNaEFJMCiRqjpjO4hHb2gW5MsTmKtgSBncxluv0I75uGwmSCQg7Xdq1Xw87M1aD8N2VuOHJIhwoyqQCJ8BEOUgECJk8cfAmI5FGRNWIO9hNt2p2B6wccaRfsx9g+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzX5R02N; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzX5R02N"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4488e958486so808310fac.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782756717; x=1783361517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dZuu6dFUA2G3k2bdTEAXAoRy0QiGCjfGSun3WreY1V4=;
        b=CzX5R02NwYOcRlkuldV2dNYxMmIk9MRozOfpEMRKkAD8XZt2hdOiJXjmz1UAdznsPV
         g6v8H4VN7pWomfgr087fDvxqfmUzXq/wXYncG8wWIY/FflsRg1OtS0mvB28QmvdL1xh5
         CQeS7tZuH62zVP7k+JhWLEfdxKXAk0aV8LwS4MtciudFl7zGqN0elQvTUhFVhgbaOG7f
         iMr9qHTp23V8iu9oIOouf0kyHT4k4uP6SvxIQ+M9R5Y8bLnkOTHOCeamA7KyYR9+Baap
         zsDAPsab9PRYZFT0WrxZLTneoeTiA5KEoexu66timHqfVZe8jEsTvG3Wcb3SEJVNp1bl
         vl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782756717; x=1783361517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZuu6dFUA2G3k2bdTEAXAoRy0QiGCjfGSun3WreY1V4=;
        b=JM7S8J+q4jJ8hYT3KkkpmQNlFySA0jHTXE+AYmQP+mqYpAJZxG4BdOsHIcuCNjYW3u
         NaKILlccl/IrkkutFh+lruVPRluD9BCqp/YETJZYlzu29YGyxQEjY9h5Scq4Nv9Wrqd+
         o/FZSlmMaSXWMv+Av85Dt3Qngc22GTJP1TDKN3h/iQaROvlcmMhC4KwQ4Q0DSiVv3RUi
         inGHOymDs6vCFBmOk2eCnmjx2zWHreUqUR0jp68pr+hbIm9ELjsWaqSe7OzdNnqPogxv
         XY7q6US0taVYFHer4TvzXJdOjcAaJ69SIBA8f4Tlp2V9LOrEuRh3BthiaDxCErnN+uJt
         zdnA==
X-Gm-Message-State: AOJu0Yy9Njnk3boPd81gVX6cakuYjgTNVdgOWqDhPZfeveyuwxQbGE6s
	KsiDaeTTgQq+lyvNsyBMq6UtCuxICKxtUv38QruzTQ94me9fGSYICGw1xiT6IQ==
X-Gm-Gg: AfdE7cl7EjF8m1wXhD87xFb6bWB8qMYN0TziUlm8OIDcOOunBowttAtRGGHRFHfbvfG
	hVOrQke6q1HLA9CPFdOOPTYbnGNN8CfInGukYBsuYmcAMdZdPKRjKwLJjwsTcfZWF43xc9vmzTa
	V3fxkmTb+XZNn5yBOKVbj21x6R4pTBjXyxn33ln4cCyFAVkWKT5KbpiZRvJ3fg12lw/vzY1xItu
	84BhizaNqzY/ViBIGyPFniDWL+5m5yctI/niFHHTQyGlj0F1fb/f9XX+MVB5uAjZ4sI0fwxQyYP
	4TU3KNDmWvr4kplIPduNKTNQpBeWc04dQs3i+UwUpvPT/Avi9PXvoF+17X9mqPwnxtTKzXKZSet
	Ga6Lb3BVMPgsDxNQhcCZHpCF0hdKrTNQ4sNFKwQeOELnqoYg0iGO61Um/XnrQ/dY4H/bp+CtEpJ
	b26bvJDwxyoLdKFP7Y
X-Received: by 2002:a05:6808:1522:b0:493:6cfe:88f3 with SMTP id 5614622812f47-495eadf239dmr409841b6e.18.1782756717390;
        Mon, 29 Jun 2026 11:11:57 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-49352505004sm7290252b6e.2.2026.06.29.11.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:11:56 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:11:53 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 1/6] object-file: rename files transaction prepare
 function
Message-ID: <akK05yZ6843K8Vdd@denethor>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-2-jltobler@gmail.com>
 <xmqqse6biyma.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqse6biyma.fsf@gitster.g>

On 26/06/24 11:26AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > The "files" ODB transaction backend lazily creates a temporary object
> > directory when the first loose object is written to the transaction via
> > `prepare_loose_object_transaction()`. In a subsequent commit, the
> > temporary directory is used to also write packfiles to.
> >
> > Rename the function to `odb_transaction_files_prepare()` accordingly.
> 
> Taken by itself this renaming does make sense, but there are many
> other function that follow the historical naming convention, like
> {fsync,flush}_loose_object_transaction().  Should we rename them for
> consistency with the new naming scheme, not necessarily as part of
> this series but with a todo comment to do so once the dust settles,
> or something?

Ya, both {fsync,flush}_loose_object_transaction() are probably good
candidates to be renamed to odb_transaction_files_{flush,flush} also. In
the next version, I'll probably add another patch to do so accordingly. 

-Justin
