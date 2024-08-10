Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CFB38FA3
	for <git@vger.kernel.org>; Sat, 10 Aug 2024 05:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723269036; cv=none; b=gkSPmVuKVywqtTfGkf4IFmv+i8i6WI0Vrd7f/fvYhEaO0IJeKIqGAmxRsfIQa93S2SA/Af8EAfv0QrknSr6Wj89izrAp2ZdFaeMyA0BnvEiFq8yCHckIrGDUMxDu7ti4EXYh7DJokaLrvR2heRVViBcEhj3TGEIjb8aStvmJmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723269036; c=relaxed/simple;
	bh=MHaXT0xfxVk9D6fR2zk1YJqCkADhvXriZgCSRmV2cHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9tBHQqv3oiZfwnAfFoags0XloW8z1nK5SFp+7cPYLdADEUEEjW+PZhWag+5kzM0zAZlZwqL4PAsaj85//eyJfS0d6DlCE3wAfKF+SRYAFQ0eyGs1yubvO5fCgP6rYBRGRcgL3IBsml0trlgvTy9pcngU9MnQcqHUZtgD3Jga6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1QDiS9M; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1QDiS9M"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so303909366b.3
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 22:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723269033; x=1723873833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F32BuVGAgXEnPPE7/YwGqIQ4AFTNfRReFu3L7ITGG9M=;
        b=U1QDiS9MJv8NwqODLlot7Je/KalguW7h8yeFsH/dgmD2FMpfA5X/PFWeqVsZXr1MPg
         ieeCttS75xnrNq4vYPqJ0OSaheoy6CkF2K2DlQaAwkHWnBZBhYiY8McOea/SEXYkO6XE
         DwO9WNZtpRnCLY4yYcvey4im9Gv0UOmclVX7Bh7e4Nv9clY9AapA2Sy0c5pIbYd+fy8k
         42RCL6dUBeAVo4YCHNf6sjUN77xW/V2ww4TPoDgQq62YvnYmmWabHsvdad81R3E5CR3M
         nCExSf4uMlwi6FWQzR1LTupfbb7vMdAF1tkop01oVEi6UYjvLgVdiK0QJza64ol7J7W0
         4LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723269033; x=1723873833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F32BuVGAgXEnPPE7/YwGqIQ4AFTNfRReFu3L7ITGG9M=;
        b=PMw7e1N/iVKpkOZJ+5rLxMQF4LmelRzwz3YZS4y6iPc/mDQkljcBD8/wac4KhijCfF
         /sAXSi+Wn2zhmD7FAt082xF4coDNmpc8FUO1mK0KZb2fjPiKSQJctQGvhYPGIar4xWC9
         lQDT+jvQ22uvYAxpuSNL1jA4gfWizBE8C/TSqHWK+dtxzvUXWcd3M9RfyLnh4dQm/fBM
         Sec972fI1LeraST9Wef+k9Xt9by5BP98kn/K2C4fqFA4WO7/qtmrRvCtxK+z1hNQ3fqr
         ciByUG/OIeW//bfehrgpONyboUdh0ZfvdhRAZkclUeBeKvkOEhCN2xDhL6NJeunbvMeo
         Vz6g==
X-Gm-Message-State: AOJu0YyA+2iDRr7PhSrVDeQzWa4ioRaD9tg/A0MED97pj4VuJQONlCcY
	yrLAY8FFneglLMZVss0kkInrDbrANGl8mdzynBh4DSeMoBxxlpolffS4/PYN4rEiJ6O/7drk60+
	HFpTrT8oS1SVJx3C2EXo605H1wNQ=
X-Google-Smtp-Source: AGHT+IEyEOFxXuO00znRiq/Qck8t4HRCOpCjUhujzb6SMRBLkp7rTBoKrCT792DF/h8E1Ondu47NQVv4gLJVPkgdt/s=
X-Received: by 2002:a17:907:f724:b0:a7a:b895:656f with SMTP id
 a640c23a62f3a-a80aa5df664mr265409166b.38.1723269032829; Fri, 09 Aug 2024
 22:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
 <20240809111312.4401-1-chandrapratap3519@gmail.com> <20240809111312.4401-3-chandrapratap3519@gmail.com>
 <xmqqjzgpcymq.fsf@gitster.g>
In-Reply-To: <xmqqjzgpcymq.fsf@gitster.g>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sat, 10 Aug 2024 11:20:07 +0530
Message-ID: <CA+J6zkSHX892NoNOyTDc-38_giBR=Q-Hf7+7nymU9GnPu1V-5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] t-reftable-readwrite: use free_names() instead of
 a for loop
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Aug 2024 at 00:27, Junio C Hamano <gitster@pobox.com> wrote:
>
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>
> > free_names() as defined by reftable/basics.{c,h} frees a NULL
> > terminated array of malloced strings along with the array itself.
> > Use this function instead of a for loop to free such an array.
>
> Going back to [1/4], the headers included in this test looked like this:
>
>     -#include "system.h"
>     -
>     -#include "basics.h"
>     -#include "block.h"
>     -#include "blocksource.h"
>     -#include "reader.h"
>     -#include "record.h"
>     -#include "test_framework.h"
>     -#include "reftable-tests.h"
>     -#include "reftable-writer.h"
>     +#include "test-lib.h"
>     +#include "reftable/reader.h"
>     +#include "reftable/blocksource.h"
>     +#include "reftable/reftable-error.h"
>     +#include "reftable/reftable-writer.h"
>
> I found this part a bit curious, perhaps because I was not involved
> in either reftable/ or unit-tests/ development.  So I may be asking
> a stupid question, but is it intended that some headers like
> "block.h" and "record.h" are no longer included?
>
> It is understandable that inclusion of "test-lib.h" is new (and
> needs to be there to work as part of t/unit-tests/), and the leading
> directory name "reftable/" added to header files are also justified,
> of course.  But if you depend on "basics.h" and do not include it,
> that does not sound like the most hygenic thing to do, at least to
> me.

I think 'basics.{c,h}' in reftable/ is equivalent to 'stdio.h' in a generic
C program, it holds fundamental functionalities to be used by other
reftable structures and hence, is always (implicitly or explicitly)
#included in almost all of the files in reftable/.

This test is supposed to focus on reftable's read-write functionalities
so it makes sense to explicitly #include only those headers that
are directly responsible for those functionalities, namely 'reader.h',
'blocksource.h' and 'reftable-writer.h'. 'reftable-error.h' is thrown in
there as well because some tests need to explicitly mention the
various error codes and it doesn't make sense to rely on it being
#included by others.

> The code changes themselves look good; I can see that the
> implementation of free_names() in reftable/basics.c safely replaces
> these loops.  There is a slight behaviour difference that names[]
> that was fed to reftable_iterator_seek_ref() earlier goes away
> before the iterator is destroyed, but _seek_ref() does not retain
> the names[0] argument in the iterator object, so that is OK.
>
> Thanks.
