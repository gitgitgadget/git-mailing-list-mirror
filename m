Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B592571B8
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311272; cv=pass; b=skMst73mPbxNLPi2t9GOiPawmnsw2Dipi38T2XRanGAmTJnDfRAN3zOydVQFxk7W1CXelIUlkPdMbAdUy7VD67ORKRrcPMbq90PLuTi7JxIZc/Az+MfxAW5eRk+1OlqmexOdfkb76CBN0yCHAxtJv27vf+LJBKfPx1KkFG5g3fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311272; c=relaxed/simple;
	bh=OyC8WAV8S4L9WDtQRtXkFPp9iVDKe13cGzAgbtDZJtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKu102PkojHUKJ74L/h676jwGwg/aLbQGXrJLKGVtXFY9SoJutBTwdTdFJ/ep/ucTfMPGc6PlI/Cl5oaVu02yIUA0PV/AY0jOdgBfYL3eukxg5Ko6Non8FLSn666PBxH1uDjwHfMdteaNB2uth7FZjXGHBP5wGeEBuUGai8Sbnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sq1qsXyY; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sq1qsXyY"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso9064119b3a.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 11:01:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784311270; cv=none;
        d=google.com; s=arc-20260327;
        b=rpwF+U+Me3/4DTimKdgWLXobmmYV+zcS0DOWX7x2QIjOkvcLga4iFUH0azjaf0iB70
         gyQmhrEaVymqo9ePQRc/+brHCvXtWv7n4FWULxeVH2ERxOE2mYXkfcjjLW9EiDLvL37F
         fwatmm22kJlYIB/2RwlFZEukdieRbqRgYAhTdBYcE4xI7vK8IXUlfBuR3S+AR0bP6LA+
         94XiGMUTBLco1Q8bIhN9qdQJDn4yrZeb4LzHVcCLYOjf4JN8WG42V4qr43NH68Ksn8dG
         KE2ATJmmEn1n0pvHxyv/kYUGsp36A5nUFLC0+si5HrtdJCZM/RCZk1aYU8kHWr1+h7xg
         9fPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ndEbxg+j8P3ttrv4naa5A95J1msl1eex6AfLVzjMbUg=;
        fh=WM+iLvAB8FFVL6BQKOxZFMPWUEMOk5/psDz8j7k9PEQ=;
        b=ghmND6JP+DS00FpjV4y7fUn8oHmSMp3tBvt3OAYnBibHWhqracu3DKlKSRp74mhFba
         lwqpMBco54ckf/Lpx2XNH4R5Mg/LEsB+8I44vy3EJt4wbUoOqfrGYiM7brfB5zBMe2zj
         nY9mMdW5Ip3Pjitl3xZGl0voBuauHmDLNf7hO6hpRqLVa6Ndl+kk+DZW2dMJ4edsEnX4
         8K1W9ecLHzLBrC/BL90uzgBHrvLqRiCzP2ZRdIM7GQLKW182SOdedAU415+9f/6xJeLo
         y/4cabCbaWyEKC+5vGbO/UK53Om3w61YNpJ5JYqZMb0Wprfk2iBQk8RYbEE0pmVE/6im
         NBvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784311270; x=1784916070; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ndEbxg+j8P3ttrv4naa5A95J1msl1eex6AfLVzjMbUg=;
        b=sq1qsXyY+Lb2YY/EP0T2s9ajgxzF3f9YH2T5tMcnw9lM4GEp0P0OOQ/M3OCYzli1YI
         kDl5bsLapUCs8inDtpRsAh9PR4vtrfMe2eaoHrUjrbPCv4P7KDGkmdJJp4F/XPU9jy+H
         bwAvQOSoBDzmZAlq0KtJNEZtVlCZVZZoH3J4uJPKSbrfz0qHCEAUG0JS1PTd/lX1u/gE
         XMj+34RLdQSgImve99ngwFPjvnFt8w96y4VA8wrpj/bnlzEXbTdhND6fRDMwoCFKpNxn
         mTrve8qpc6J8T9H1zw0vTWL85kyaRd629Ed/jI7CaLfKOyPQA3la45p6snF/gW1OqAk7
         FZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784311270; x=1784916070;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ndEbxg+j8P3ttrv4naa5A95J1msl1eex6AfLVzjMbUg=;
        b=PyqVjS/2/Y0PIc0xzg0X9rVqwD/5nkVJkB/hA/iS7Lk9rW76EqRu7SIJlSExuWbZho
         eCmAHXbfQ/800xO7e9K2zWPlU4XAwzBTq1vKpbpROrceh3cT89aF6khYJRrLKDbNMQR6
         O7AEOYJFwx5+m0slDT2Wl5xX7qf1tBlxfVaVs3SyE0qHArHqGESpQCmUtKg0OwCu9k4s
         9u6VU86UXbsQTRyl6krlaWktdxiwDr5by50xMxwmy/IT/goZmNuqZrhIumnGLo1tWwAb
         l7Mf7mdJReqHmRtqfXJhUUCohxMAax20NmphujdtKKpME1aMUgNbc+Ovxt5BJTLG4kvt
         J8FA==
X-Gm-Message-State: AOJu0YxV5vkTXLpooCAoPiWA6015BUY3tQtZhiugJSIeb1DsFgeHW1dC
	2fgLJCz/Tfmk5b300H5oKZHjH3fFDHy9PJINvDq54/TpVHTiUEALxzIjUlTOBUwsZrWcmt6RSJA
	Om28SSHwCyz9GudWa5Clt+MCAdtVhayFn++YAig4=
X-Gm-Gg: AfdE7clwSpF4eFEWOgrMiYWMu4BXB+Iq/vBhcIDoY8GP1EbepBUdjLHQDNlprU46NIE
	g+b2SC7KcHf5wXDtJ91gDqD5C9RmnwcPqdfhjT8/30vg9jumUekI/PO/HnGD5ieyP8mIjvPYCoF
	IfNr7VveJjK5MXjostZhHCWe+8JB84xlPUtW1Vo7dq8E3e0TKYDQj3M1wOv/9SyMoj5YNisWI0O
	vzpHVpDYIVwWxwFmOvYCUOGNnGRMP8vsYbkbkI5C2al4O/vgJid/Flr2uqYtqV2YkFWhzuofnND
	zLRmMlRx5pZc+x0kqY5OGcuHC015c/cFnvsrysYOmkxNeCSBfSMRqm207KMPrHt3sUhtiMznpEY
	WHTg=
X-Received: by 2002:a05:6a00:4c92:b0:847:980b:f299 with SMTP id
 d2e1a72fcca58-84c292a0f0bmr3919792b3a.4.1784311269948; Fri, 17 Jul 2026
 11:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260716132848.95982-2-r.siddharth.shrimali@gmail.com> <xmqqh5lyej6f.fsf@gitster.g>
In-Reply-To: <xmqqh5lyej6f.fsf@gitster.g>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Fri, 17 Jul 2026 23:30:33 +0530
X-Gm-Features: AUfX_mwEQGSWpo-inoYY92mUZQVMAh3CtlE40iANfcuCay2v5JwxbemW7N5uKeU
Message-ID: <CAGWgyh8qFiyrQtQDOH17jnkbDrZCVGX3ETjKLZ1dV4xkofRU0w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] builtin/repack.c: add --drop-filtered and
 --dry-run options
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, me@ttaylorr.com, ps@pks.im, 
	johannes.schindelin@gmx.de, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jul 2026 at 02:38, Junio C Hamano <gitster@pobox.com> wrote:
>
> > +     die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
> > +             !!filter_to, "--filter-to");
> > +
> > +     die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
> > +             write_bitmaps > 0, "--write-bitmap-index");
>
> Hmph.  Since this step does not change the parsing or configuration
> for write_bitmaps, we cannot tell if (write_bitmaps == 1) at this
> point in the execution came from the command line (e.g., an earlier
> call to parse_options() around line 247 of builtin/repack.c) or from
> the configuration files (e.g., a call to repo_config() around
> line 245).  In other words, wouldn't it be ...
>
> > +             write_bitmaps = 0;
>
> ... way too late to drop the flag here?
>

right, thanks! The commit message claims I distinguish an explicit
-b/--write-bitmap-index from a config-provided default, but the code
only tests write_bitmaps > 0, which cannot tell the two apart at this point

For v2, alongside other changes, i'll distinguish the two, so that an explicit
-b on the command line errors out, while a config-provided default is
silently disabled for the duration of the command..

Thanks!
Siddharth Shrimali
