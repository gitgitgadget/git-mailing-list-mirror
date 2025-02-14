Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EEB263F3B
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536927; cv=none; b=T77mjK9CB1wKq64+cKHjidgtsjJsdddFMWq9cRYpkdOy4N+AKa1QSpReu5VGDl7Cg0ZotPrB1Nh1XK6l8dY0+jkQfF3u/G8CIOkxuT1BxUdhOtMFo4UHZ609BrYDqyfqacBgM3uouKeXlza+LCri6gJ60KzXyOoAetTy8v9+vpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536927; c=relaxed/simple;
	bh=YNtsEd/GwEeb2JqmOwdlsc38Y8awqafyZNBxYvNrR70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDxFLOQYCQgVKRet2xllIJMXe6u3/FMSrW3HNYh9MuuT4/jRI5gDS0PcgqDeK7+SG4zWOQAP+QXkfeirOcRNgbpRGtV5qLmCo6MPeim/GKKJgKsI41pZNpP4a5b99ki7EqfkCEMIoggVFYRVhYJyf65aDhXLlZMnpAhIaGUF+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViSQnE2P; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViSQnE2P"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f7031ea11cso18344177b3.2
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 04:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739536925; x=1740141725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r0F7NeVwtYmuXlPTJgBKX503C9zZ2mi0swFN5aCC7bM=;
        b=ViSQnE2PL3GjUVlKzOzCJsBna5WrUQ0u4gXUhgjM+vX4bO4F2lbeFFiYF139rsi2GI
         2LlfixqBCPr4RN8nat0A75vupPscya2vnJueW9v8VNh3AvJ+/Qx8Fb/BJEp8jGOh9L45
         s/pyRlrFto7UWG39PezXTXfRP0WZ/ZVyWp0+2BGU4XmoATRniWGpWMHQ0NSzEsC+bZeR
         TB701Tnw+suYiGoOD6KJnArmM1HhXdRLlqLjlFMGIIgOcQcuqWUWamxoPvkhqEB9g+MX
         4AVgROCpJQS5puyvOojBr2p4f4el4L2K9ucRfLA7usn67mtqGeFmI8xvvOYtrWXsEUI3
         nj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739536925; x=1740141725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0F7NeVwtYmuXlPTJgBKX503C9zZ2mi0swFN5aCC7bM=;
        b=wCLEUEHYCYLdd3wiDV+kl54mi2qf0uW1QXa0Rs4GwOydPuz1JLX/UPbm7pjv7+vjLQ
         55a4ZCTymeY0HTtCFm1oeGAMeSvW1B7uGDa3cfkvMiRtISE+CZ4yRXGk1qHuzjuA1Phv
         XkUXHbAsG8rJxpT8nAICZW6uQCS6iE42sCPeVcLcDIIU00w6l0ufOvCWM6cG8v6VNmps
         uPu7rmZvnO3w1dXWqhfXM36k+fthAnwFwTKAbc/1+bVs55XpUmLnzqE7EnoSly5hPrFK
         JHN3An3AKgFXy8nYGmt1x5NipqCk55WnAg324b/U3E1xZ6oRMtlwlPasgBh8VxyTv+me
         z5iQ==
X-Gm-Message-State: AOJu0YwDpT08o1lV8ZKN7c9f1lXHWjMnpeN5alM0lhSEkU7p/Oo8mB04
	dQ1+lBAzAsHf46gHwRp654Xl2nOvA/BTLSran9ZCXAbc7whLan+2
X-Gm-Gg: ASbGncvOsL5z7elXWR6quvc1IN/X8Kyr2Gd8LlkdUfzl8uU8efDuig3Pq9IGYfiSnWx
	x/awyP3KumOJJwgSQU3+xp2ObrzT6nmtFJSe4EBCdeOvz705puAq8HfjCjz5+V4uKFnUZ26X0pi
	BHJ7vqngOUSJf8Lr60ZxFcsUYroAqnVH3nTZERsn9jm1dx4/JrrF3jzbnjMEiZBfC+EEQyW9pHt
	1uIGmZFfu2Fa5VRTOM8/WQS76brlqMVDFO7vPJ7kVLnjx33ytgtSALg3GydOO9lbiwrOQ==
X-Google-Smtp-Source: AGHT+IEkqglslqivzn2z9aLJVZsWMKGnup9ccqE9x0pGfiELyDlqkSSiwN/xoqr4w4LpFtyHSODpdQ==
X-Received: by 2002:a05:690c:5983:b0:6fb:24e1:2d03 with SMTP id 00721157ae682-6fb24e132bemr65746697b3.10.1739536925264;
        Fri, 14 Feb 2025 04:42:05 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fb5359d663sm385577b3.96.2025.02.14.04.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:42:04 -0800 (PST)
Date: Fri, 14 Feb 2025 20:43:59 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 4/8] packed-backend: add "packed-refs" header
 consistency check
Message-ID: <Z686jytnvdzdG6HJ@ArchLinux>
References: <Z67LkxAFIAeaYr0U@ArchLinux>
 <Z67MG8utrQfUrakz@ArchLinux>
 <CAOLa=ZQTJhs+s+4y1DUpGDn7CnM5qwAgicgkcjA6ngmkbhwZyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQTJhs+s+4y1DUpGDn7CnM5qwAgicgkcjA6ngmkbhwZyA@mail.gmail.com>

On Fri, Feb 14, 2025 at 02:30:45AM -0800, Karthik Nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:

[snip]

> > 2. If the header content does not start with "# packed-ref with: ", we
> >    should report an error just like what "create_snapshot" does. So,
> >    create a new fsck message "badPackedRefHeader(ERROR)" for this.
> > 3. If the header content is not the same as the constant string
> >    "PACKED_REFS_HEADER". This is expected because we make it extensible
> >    intentionally. So, there is no need to report.
> 
> Do you think it's worthwhile adding a warning/info here? This would
> allow users to re-run 'git pack-refs' to ensure that they have a more
> up-to date version of 'packed-refs'.
> 

I somehow agree with you here. But Junio worries about the
compatibility. You could see [1] about this discussion:

[1] https://lore.kernel.org/git/xmqq1pwkdt7r.fsf@gitster.g/

[snip]

> > +static int packed_fsck_ref_content(struct fsck_options *o,
> > +				   const char *start, const char *eof)
> > +{
> > +	unsigned long line_number = 1;
> > +	const char *eol;
> > +	int ret = 0;
> > +
> > +	ret |= packed_fsck_ref_next_line(o, line_number, start, eof, &eol);
> > +	if (*start == '#') {
> > +		ret |= packed_fsck_ref_header(o, start, eol);
> > +
> > +		start = eol + 1;
> > +		line_number++;
> 
> Why do we increment `line_number` here? There is no usage beyond this.
> 

We will use this variable when iterating the next line (ref entries). It
will be used in next patch.

> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static int packed_fsck(struct ref_store *ref_store,
> >  		       struct fsck_options *o,
> >  		       struct worktree *wt)
> >  {
> >  	struct packed_ref_store *refs = packed_downcast(ref_store,
> >  							REF_STORE_READ, "fsck");
> > +	struct strbuf packed_ref_content = STRBUF_INIT;
> >  	int ret = 0;
> >  	int fd;
> >
> > @@ -1786,7 +1850,16 @@ static int packed_fsck(struct ref_store *ref_store,
> >  		goto cleanup;
> >  	}
> >
> > +	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
> > +		ret = error_errno(_("unable to read %s"), refs->path);
> > +		goto cleanup;
> > +	}
> > +
> 
> So we want to parse the whole ref content to a buffer, wonder if it
> makes more sense to use `strbuf_read_line()` here instead. But let's
> carry on.
> 

We may use `strbuf_read_line`. But I don't want to do this. My check
logic is the same as the parse logic ("create_snapshot" and "next_record").
I want to keep the logic nearly the same. So maybe one day, we may
refactor the code to make the parse and check use the same code. But at
now, this is difficult.

Thanks,
Jialuo
