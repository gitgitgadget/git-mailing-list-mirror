Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E113AD1C
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754289268; cv=none; b=ndc/8TM/E39/byup4hlWI2tIAXo8BQrDTX1bS2zUEAtqRrvK5iRAqcaQXXSnv6IHGB+/W8LLU6JFKl6dE6ZUuhgbN4sF8K3pR9pdFDrc21bUbNtWBhQj+p15uwlAcxX1d6Vn2nCeWxDZW1xsc60917sSseCElw3Cz0RjXJ7zZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754289268; c=relaxed/simple;
	bh=LVFa241eUYVvB5ETp0H+jSeYl6O2CxOKqeHKI5easXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkztEo7R9MYia7mwdUFf8zz/OE0bW3we111ghhftuf4PNQ7/sVkWs9wH/2TVABgFz8uXLzP086as3K4kdq8NDl69Is70aI7IFGO23qaWYOVACyWXqcuYC/SikRliopXJGIT1LvSWZbbXPX9u/BhVIpKVrYB0kCO+E56IugUcRHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h88SMkCI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h88SMkCI"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31ee880f7d2so4221397a91.0
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 23:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754289266; x=1754894066; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=owgzH3YynmQ11eI9VXLVHtBooyEwzgaNMZW3MuUoUyw=;
        b=h88SMkCITZqzUFGF0qrCip2OPryuSySBl5VBguI0nwGbDhwOPHaxkieu0qKjv0+XcF
         iNwsYZXwwc99N8mkM+H8RhbNVApSov9cr1mbbARY5/5tLA5gccKQWAMj419+mR4VtDeH
         APccrOHPjQUoAoHTBSX8fn/ADfgEMSCH/UgeQE881raFauB4N14Sv6LuvwE+RpiHfwTc
         6xaU0Mq6CAZf6Nd+D92Lw2jClgUGAewNxGuwTO158dyIVgzycmaDUVUW8S8tozQQQVOs
         nsEQpPd3gWlfhSUuSAuMXsuEVC/k9++8OdWzTJV50KeqvfrTwLuB8htgv5J7i1a7R1y2
         yKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754289266; x=1754894066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owgzH3YynmQ11eI9VXLVHtBooyEwzgaNMZW3MuUoUyw=;
        b=i+ucAx0tIJD51rCGOoSbqpjyS9CzgkwT6WRsOpRAXefHvxIy9Tt3tC7Fin1nLL5YgF
         v6EOAFbmF8Mtf+OGfaVywwd7QQMSrBPPbbwQNoeAHNyylRUMjl1f/5QX470LRF2e7QC4
         my9h7trvbFPeMTfCjHSoLXLNBhMBOjoEkkqx0BMuS+ccz3z08PUaaNndzfIuO/h5CVoI
         5vTgdlZzp8KqH4+voYaEcJ7O/R//LqY+s+T2CzYEs7SGVtRmJ+TUFX7JJBDlxLNalm6G
         3dpqo0OPuoVH90/+Sf/M+OHAEbE/+2dn+GKY2Jt94iQ5T6muKmUQ/hWCEAaxFrlmW+xB
         Evzw==
X-Gm-Message-State: AOJu0YydBh89uDKC5+Z+2uYRux1/twCjIEFH/U8aUBgq7r0aoe7W2SR8
	cyzjUH9hBEvDOwggi7me6AOP0TBzLqs0XXqFRzDAF3N9PSi3r3ja+G0ZAve6zVOMXMGFyvLAOtq
	9dd6Fh3foHdH0u0Fq5ZWrwz5PoqeLQ3OTzi6I
X-Gm-Gg: ASbGncusiWTWR3A79cZhJFF5d4t2AJjR2kG7rULBIe4qwlS59/DJorAxansqvzfegG0
	BvLIwmdw6xqqyTiveQ3UKKXqu31OOtI3H581y7CIs1o3Yi8xUDA1zsdV8A42MOWoyw+EXRxNRvH
	DhUm2eku1W4j14ahHDL2YbIpJc2MhtKqu9+ow6cHLWTjwq6o7Fnh9UN2pXPulpDbr14GStltj0g
	/Pp55Ay
X-Google-Smtp-Source: AGHT+IF2iUnErCJKTnvmy9f78rSxN4s5jHrSIeElwwEUvJhq8gcQSCmKpmdHtmn4/jo883NM3VdYG4n7XpzKdB0cSHE=
X-Received: by 2002:a17:90b:3886:b0:31e:f3b7:49d2 with SMTP id
 98e67ed59e1d1-3211611bdf3mr12608740a91.0.1754289265758; Sun, 03 Aug 2025
 23:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723064313.29866-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-1-meetsoni3017@gmail.com> <20250731090040.1625303-3-meetsoni3017@gmail.com>
 <aIxWlX36V6DcxWa0@pks.im>
In-Reply-To: <aIxWlX36V6DcxWa0@pks.im>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Mon, 4 Aug 2025 12:04:14 +0530
X-Gm-Features: Ac12FXy4YAThBlM1vW64Y9rn1XtXeGMM9k6cn6KLQp93D5HhD2iPMTj_ku6r6P4
Message-ID: <CAPhwyn0X1hS89B6p_NQKunrdO1EHMkwtF79RvA1riM6EH4PRJw@mail.gmail.com>
Subject: Re: [GSoC][RFC PATCH v4 2/5] builtin/for-each-ref: factor out core
 logic into a helper
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, shejialuo@gmail.com, karthik.188@gmail.com, 
	gitster@pobox.com, sunshine@sunshineco.com, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Aug 2025 at 11:24, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Thu, Jul 31, 2025 at 02:30:37PM +0530, Meet Soni wrote:
> > diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> > index 3d2207ec77..bbc0e5ad1c 100644
> > --- a/builtin/for-each-ref.c
> > +++ b/builtin/for-each-ref.c
> > @@ -7,19 +7,9 @@
> >  #include "ref-filter.h"
> >  #include "strbuf.h"
> >  #include "strvec.h"
> > +#include "for-each-ref.h"
>
> Let's keep the includes alphabetically sorted.
>
> > diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
> > index 06b469bdee..2c6ecd5fc8 100644
> > --- a/t/t0450/adoc-help-mismatches
> > +++ b/t/t0450/adoc-help-mismatches
> > @@ -17,7 +17,6 @@ fast-export
> >  fast-import
> >  fetch-pack
> >  fmt-merge-msg
> > -for-each-ref
> >  format-patch
> >  fsck-objects
> >  fsmonitor--daemon
>
> Everything else looks sensible, but this change is surprising as it
> wasn't mentioned in the commit message. I see that you changed the usage
> though to match what we have in the man page. That's a good change
> overall, but should probably be moved into a separate commit so that
> this commit here is not changing any behaviour.
>
> Patrick

Makes sense, I'll send the updated version.

Thanks.
