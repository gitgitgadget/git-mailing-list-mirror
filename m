Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9A1E22F6
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729546157; cv=none; b=Mn4t+LjJ0JbOqwgYsvywtRmiFomdJVC8vSg0xtql7T20C3hbaRZ+NI3W89mY1/uclmtkGIMSQ5ze52m2CWnNLKUqz93RxVuroUdkupawUkNLvcTacjBnMJwhRRxg5cv6+HAIV6/5r7XE0KrqHoLvEy4UrZ+I8BalwB7VSxDJPps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729546157; c=relaxed/simple;
	bh=KEArKMdA7y17wML826ZOsI2f5ySoB5r3FK5soGh4E6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6d+ZO8IsOnVJFnI5hUmAVL5E8p0C5Usuy4xwORGak0pE6ojJfbqSgnTehKJeX2NysFIjAuXSvl6A+e6olMegF6L0cbHtnY5uA00q1dUOJe517C6FGb90cP3zsT2nYXM7yXI/hGYAZPOYp3B/LRX8Y01xnz+tuvntwJMH4YdIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bBAzajpl; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bBAzajpl"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e38fa1f82fso46654867b3.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729546153; x=1730150953; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WISFDU1syvaEWE2KOftWQXEWDQQFlLQKD8+Q3ttw42Q=;
        b=bBAzajpljtejbWmXwYDoIfGt0CRoP3+3Onno0w5jIq3lnq692S/lpGL2uOchQzWeGz
         wC4XmWn6CZUtjEfyb836FujTnrc1LmpSTz7k6zATyhW0pIONjjJXeo7+epaPhKaNcixg
         fXW/e5mm2uxpIYvBIN7YIFMaOIDU0z1mXtII0yBwaFHscJlDVELIHjSL/A3qDqW4G5fb
         /mOCfkHR8m0EH2gV7rv6bSLV0H2A8Y4JfBzLIFkIycvmcBwo8ZHCCcD4Kq4lJ/Z2kkiH
         RM0R1Z+pv+ZgVw24aUFqxp4y87TUv9e3LMbW6sU5wt514CMZCbhP4ZUiGvTX6MzW4wdD
         t9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729546153; x=1730150953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WISFDU1syvaEWE2KOftWQXEWDQQFlLQKD8+Q3ttw42Q=;
        b=KimpWXjkKZrTKfKPMbjHZSB4bwXlaqyw2fpMpijnY38mjSM3BnFCM12FfbROKABKPl
         0XLQGxZdPdZSAcgXPm1/UB6I1L7SmrbsKn0vBBwyfiMDbwZI/9q773+FoRLCQcVAWkZ1
         7hpFyBPzkHBYNDxTRO6Ad+SK7HyGTCYlx4+kP6VhVO+g+V9yTX3Mp6Ua8aA40PD9hI3U
         GlmA93leeAy57i2UIvnyarKn+FfhEcVXNDUaJvRqwWIgJ+s4JuEtBZfze9OV39a9Jdlm
         RzLMU8Sd71gLaS3DHWy3YCHgvlqDLSZE+ZL10VqJRevHVXf4uquCxxIp8+XkjC9vIhal
         rbYg==
X-Gm-Message-State: AOJu0Yx2XmccJdue2Td7rOl8ptZ/e7YdmHgd9I/LDHp8D1MrHjAiFr0v
	SZJRTd3+QIuUJJo5/d+gaO1PBA9YGRYIyUx6TyoKSbvCSw+eV8gaaJVDtrP3/VA=
X-Google-Smtp-Source: AGHT+IHiEgHaelNy7L8/55iuqR1+vAlyDq1/qGUb1eOHZtaKglmDVtqv0GQgLnoY2qZYqwna4uMtXg==
X-Received: by 2002:a05:690c:4c0b:b0:6e3:1869:8983 with SMTP id 00721157ae682-6e5bfd88803mr132367927b3.40.1729546153329;
        Mon, 21 Oct 2024 14:29:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f5bf3sm8475907b3.5.2024.10.21.14.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:29:12 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:29:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v2] t7001: add failure test which triggers assertion
Message-ID: <ZxbHp9ndCIWj14xH@nand.local>
References: <ce1b5ae24ed8356b9beed340fff61e96f7c1d549.1708259215.git.code@khaugsbakk.name>
 <29d71db280c972c91174bd0a501af66be72643af.1729462326.git.code@khaugsbakk.name>
 <ZxbF2xxqh3rTgXvN@nand.local>
 <1f3b62bb-7c3a-4bac-8995-8df417228ed2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f3b62bb-7c3a-4bac-8995-8df417228ed2@app.fastmail.com>

On Mon, Oct 21, 2024 at 11:25:26PM +0200, Kristoffer Haugsbakk wrote:
> On Mon, Oct 21, 2024, at 23:21, Taylor Blau wrote:
> > On Mon, Oct 21, 2024 at 12:14:46AM +0200,
> > kristofferhaugsbakk@fastmail.com wrote:
> >> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> >>
> >> git-mv(1) gets very confused:
> >>
> >>     git: builtin/mv.c:506: cmd_mv: Assertion `pos >= 0' failed.
> >>     Aborted (core dumped)
> >>     test_must_fail: died by signal 6: git mv a/a.txt a b
> >>     fatal: Unable to create '<path>.git/index.lock': File exists.
> >>
> >>     Another git process seems to be running in this repository, e.g.
> >>     an editor opened by 'git commit'. Please make sure all processes
> >>     are terminated then try again. If it still fails, a git process
> >>     may have crashed in this repository earlier:
> >>     remove the file manually to continue.
> >
> > There was some good analysis of what the problem was in the earlier
> > parts of this thread. I think it is probably worth capturing some of
> > those here, too.
>
> I will try to incorporate Junio’s analysis into the commit message
> tomorrow.  :)

Thanks, I look forward to it!

Thanks,
Taylor
