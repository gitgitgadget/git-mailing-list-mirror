Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ABE14A0A4
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665382; cv=none; b=Tq5QmPhvKxbGEnaq7Egb/vFRiqj51y7sralkT81vbI7IURwoNqg4GoB+rb77J45+Z2T22MWLT+8lQMt987497gsRTzKeNL5gfWpKRxEB6xhHJKfI0+zzvSAMYiqhiAk62JnHiwocpAY/bFsjToPepwIITXMcHl74La3fqJxQ1Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665382; c=relaxed/simple;
	bh=fzbs5l+za6xkzzkRoYLjOrlTAy4JkP/xmwBPkHKRiqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSNFrwB86qzpAcAj8sKlKPqmMq80OG+v03diWJu+4IShO3/KO0EYjsNOoF5MbMVmZrS7UR6qiyLsMEE4a8idCnY5d3qBUazaxZLF61PpWarToKri9bqH5RDQMLo0bUy0Lfy1AlhZ4o0j3AbEHlxcbG6Az3c2LjjpD94yzSZTP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qA3ZaSoj; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qA3ZaSoj"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6c3f1939d12so52295707b3.2
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726665379; x=1727270179; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=spgklZOduSl+RFBhf0bWJ7AZkJrk41fpxhosmoBSgw4=;
        b=qA3ZaSojCmqdp6+KfJ/ZUgJ+L457KYTco0aMHJKMxEsww2tfgri5yoGJSIEpNqoJFs
         7GXaggBfaXYaDuY7QAMAe+EY9H1cFD0iazfykEt2HbdIHgtsatOr1bhl3NApDgaLnhbd
         n/++U5R9j+V+nT7m3NeZbdt/WekLZpVgt0teW/HkOjw5yR8PJkAjeJJFAhBDiY5n3VaC
         bK/4eVpX36RzSaK+B1RXZ0VSlMgClq/EwpMMIvzlRLmIWAh6pcB9EqkZR08wNcDJ23P2
         4e7/gkS+IJ7UVgejpqJ6KqLhirxu84V6y7o4UFcsJmCXX+IoQOQ6hlZvq+4iPyxUkqEs
         +/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726665379; x=1727270179;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spgklZOduSl+RFBhf0bWJ7AZkJrk41fpxhosmoBSgw4=;
        b=clxUTv4C/KlkddtBcEzeslQIH9oOCbKKdenBSEen0ovxmn3/7ZdG1D4vWcXgj4fI2g
         qmOEnL47dfVoiyKCTcUNH+uqlvlb7cCL1tGbKwgX55PbHMm5P2sCx+oKmWyhYzMj/C+U
         bKuO6lGR5MjcvkPbBrT9bCzMhyXENobRUWi1lexoVEgX2O0+ljV7QW6YaoeFo6InPjRn
         6V5ayuA59IpU1Te51wkrW52Nez4fJybApN3Jk2CGZ+CQTLGwa7IcFXIJWhk2gExWheu9
         TNz2wkw6C1qfp2xfy75k8FYHkZzX7iD0G5HvMu9JBvVx/J7igWBrc++fX/wbD0eTsUZO
         CbGg==
X-Gm-Message-State: AOJu0Yx/FInWJ4oMZr6+pIVovxoAn6pufP2tfLnKPIhIB5yjaP+Fjab9
	U9kJpI1N5xHbTScAHDMVhpKNQNk60vM8sqQswC8DkLCH6fVirKouVTRkVvH2SUa9TL6rwJtv0wX
	e27eKZw==
X-Google-Smtp-Source: AGHT+IHK/iC2umgVFJs6wiRLZObWpimAQ7/OQi/mUV33NxnBk4VZzoK/4EUlCugEyw1xWsH5uiq3bw==
X-Received: by 2002:a05:690c:2e02:b0:62f:f535:f38 with SMTP id 00721157ae682-6dbb6ad7351mr130572487b3.8.1726665379422;
        Wed, 18 Sep 2024 06:16:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6dbe2ee70d6sm17461077b3.108.2024.09.18.06.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 06:16:19 -0700 (PDT)
Date: Wed, 18 Sep 2024 09:16:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: Git / Software Freedom Conservancy status report (2024)
Message-ID: <ZurSnxWRByacTUCW@nand.local>
References: <ZurNce+1IZ68WT+/@nand.local>
 <CAP8UFD3K6BvWs0iriG3RQP_2yY7+bc59wdwdwz9S_VLOkmU7sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3K6BvWs0iriG3RQP_2yY7+bc59wdwdwz9S_VLOkmU7sg@mail.gmail.com>

On Wed, Sep 18, 2024 at 03:07:54PM +0200, Christian Couder wrote:
> On Wed, Sep 18, 2024 at 2:54 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> > Last year we spent money ($675.96 USD) sponsoring Christian Couder to
> > attend the Google Summer of Code (GSoC) 2024 Mentor Summit. According to
> > my mails, Karthik Nayak also attended, but I haven't seen their expenses
> > reflected in Conservancy's bookkeeping, so they may have not yet
> > submitted their expenses for reimbursement.
>
> Karthik didn't attend the GSoC Mentor Summit last year, but will
> attend this year (October 4 to 6). Hariom Verma wanted to attend last
> year but unfortunately he couldn't get a visa.

Got it!

> Also please note that the money spent to attend it is more than
> covered by Google, as Google gives $500 for each mentored contributor
> and also gives a generous amount for the mentors to travel to the
> Mentor Summit ($1200 for me last year). It looks like those amounts
> are not in the same accounting bucket though.

I imagine that they have either not sent that money to us yet or
Conservnacy hasn't recorded it quite yet.

> Anyway thanks for your great work on this report!

Apologies for this one not making it to the list, but I was able to send
a copy via a link to a Gist containing the contents of the report here:

    https://lore.kernel.org/git/ZurR5HGfhktqZPa+@nand.local/T/#u

Thanks,
Taylor
