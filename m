Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2114A095
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 04:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643187; cv=none; b=DAHwy0m+XnhtQ/RiCRs6rT4xBXfFW1hK5pO3j/Ad6RMORL51BG3+bHNegclA2ovl0pBrZZSgHJddISYM+gLT6bZORHUYGd+Pr3s2soMIA5mwHupkfuSWTENDPWY0hrnopjj+lGKqxoBrlHLRqcD++ZXoopm+kB+/PDt8ytsYqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643187; c=relaxed/simple;
	bh=bKTDgBrKgD9rE8vrHZMsa/KZT0HFmeWfmSU3RtDlZE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stk7fohDJ56H+J3mYzTrnKT/JCtiAMmhQfPeJVyXxlOPKQlm6Ok24yetMZiQNIFlOhQoDzEjIbE56Ji3gY37xpFBlHv9pqoLDlQ28qwELgX4POyR8EMmv9BdchCRZh06ivk5c/6h+AlgXR0tlEB9VRIh/4q+FDgNRX4BqGGAIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5AmK52W; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5AmK52W"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21634338cfdso27023025ad.2
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 20:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738643184; x=1739247984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8TjspGMlMTActZmOIeA9TEzAQ8MRC8iFlFICfDZudIk=;
        b=T5AmK52WAQjsf+0yNeCsdFcF90hLOTinT2opXinle3zfGWxIszrQrwzPrKJQKOGBci
         Sq3UbXmxvFKltZ6ko18Sx7vN6pjkgkjY/ATIez31zciUGbmmJqz4sJAxAhi5pBmPgOsF
         droyBqdodJcTyJhqLs1ENfRg9PxSM5AA8CTmKjhDHcBpcvP2yQOrS7m2OCTaRp+QX5VM
         +z5f2GZ6js7IulKiiwdPCjkDBartLCOCrc5KggD3n9tEYdK7HrPFUfS8TaZWWT7D+7Qn
         p/MNE1r/XjFJzLR1bXguQ1DnyzE21R/vTwVEiB8cMf5vtIMhk5XZs3p/GUofgLl63UxY
         DygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738643184; x=1739247984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TjspGMlMTActZmOIeA9TEzAQ8MRC8iFlFICfDZudIk=;
        b=noQHjwwiVpYwPbeuWrwzy59w8s1BN4n0gZepAitSZ5yRKXM8os2OXnjdMOG1wnln+9
         LKGBdLtqyuzpH0vzqVJEnTeXRCosojfropkpeRr+3NKWMuKtwawbnUp0/qHcZXoBCHIb
         xe6WzGsSD8hKg3ws61KlWi47AooROJQr9sE9nFfU0J1BjxJxY/t3xz06hBByu3wUL8MZ
         33zQpmDXEzwMmpkyQ1HrYmhWlc5DyiE7M7bqbHf0Q7qrfDbAc19PGt0AcON1U5EQk03N
         pML/ZQVCENjwX3Mwtak6mbvdFq2Xlg2nE12FvcKM4lpTocmKLSVXqU40P0BfgI2H1tgU
         DOpQ==
X-Gm-Message-State: AOJu0Yze5xgQNEQl+aF5F+gaG+yBphAwAySYWTbUC2vKyPZP+P3/f3SH
	2vpjGrQLtG77CvWb3IFgnq2wCR/BQ/LHk5XILqOk+MCx59U2Z+Ly
X-Gm-Gg: ASbGnctVwWgB4NfIhOBpYO2uD/8lRP19ozH8QYQjyOMt+AqJgOHlhzIbcKrQvFfnoTG
	D7pSEIjsx55GvUCK5LxhKKLKJwmhY21GILlliRmb7NkDZqzckMDFJj4ghDl5MyKmGUCynEjP+N3
	/HNzqqb3SOjW5pUz8f2hgJ1Yt6HUv+XhJFdcosQdXi4+jU6o5Gk1TcSUJooGMILsspypCR5az+v
	1SVzZ5el9lYhJp++KVqoT29ZKatTuvU3sfc0AaqevtK6lCwiKFnJWIoegi36LFeHxXkfg==
X-Google-Smtp-Source: AGHT+IHy0xB0WO33eBGqOfW26YwyjghHdALlR705xDs5xV/XxgEciEx5wBFTnSrY3t4xnfipnwoe6Q==
X-Received: by 2002:a05:6a21:202:b0:1ed:a4ae:31d6 with SMTP id adf61e73a8af0-1eda4ae3264mr15570103637.18.1738643184322;
        Mon, 03 Feb 2025 20:26:24 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-acec0477a9dsm8857641a12.50.2025.02.03.20.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:26:23 -0800 (PST)
Date: Tue, 4 Feb 2025 12:28:02 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 6/8] packed-backend: add "packed-refs" entry
 consistency check
Message-ID: <Z6GXUisyfjvp1Dpn@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r7Hlk_VS0jYU74@ArchLinux>
 <Z6CA-aj7cgAxLTUI@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6CA-aj7cgAxLTUI@pks.im>

On Mon, Feb 03, 2025 at 09:40:25AM +0100, Patrick Steinhardt wrote:
> On Thu, Jan 30, 2025 at 12:07:58PM +0800, shejialuo wrote:
> > "packed-backend.c::next_record" will parse the ref entry to check the
> > consistency. This function has already checked the following things:
> > 
> > 1. Parse the main line of the ref entry, if the oid is not correct. It
> >    will die the program. And then it will check whether the next
> >    character of the oid is space. Then it will check whether the refname
> >    is correct.
> > 2. If the next line starts with '^', it will continue to parse the oid
> >    of the peeled oid content and check whether the last character is
> >    '\n'.
> > 
> > We can iterate each line by using the "packed_fsck_ref_next_line"
> > function. Then, create a new fsck message "badPackedRefEntry(ERROR)" to
> > report to the user when something is wrong.
> > 
> > Create two new functions "packed_fsck_ref_main_line" and
> > "packed_fsck_ref_peeled_line" for case 1 and case 2 respectively. Last,
> > update the unit test to exercise the code.
> 
> I think this message is going into too much detail about _how_ you are
> doing things compared to _what_ you are doing and what the intent is.
> 

I think I have caused some confusion here. The reason why I mention what
"next_record" does is that I want to port these two checks. Let me
improve this in the next version. I will highlight more about the
motivation.

> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index 870c8e7aaa..271c740728 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -1819,10 +1819,86 @@ static int packed_fsck_ref_header(struct fsck_options *o, const char *start, con
> >  	return 0;
> >  }
> >  
> > +static int packed_fsck_ref_peeled_line(struct fsck_options *o,
> > +				       struct ref_store *ref_store,
> > +				       struct strbuf *packed_entry,
> > +				       const char *start, const char *eol)
> > +{
> > +	struct fsck_ref_report report = { 0 };
> > +	struct object_id peeled;
> > +	const char *p;
> > +
> > +	report.path = packed_entry->buf;
> > +
> > +	start++;
> 
> It's a bit weird that we increment `start` here, as it is very intimate
> with how the caller calls us. Might be easier to reason about when the
> caller did this for us.
> 

For each ref entry, we have two pointers, one is the `start` which is
used to indicate the start of the line and `eol` is the end of the line.

Let's see how we call this function:

		if (start < eof && *start == '^') {
			strbuf_reset(&packed_entry);
			strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
			ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
			ret |= packed_fsck_ref_peeled_line(o, ref_store, &packed_entry,
							   start, eol);
			start = eol + 1;
			line_number++;
		}

The reason why we do this is that we need to skip the '^' character. I
don't do this in the `if` statement. This is because I want to make the
semantics of the `start` variable unchanged.

I would add a comment here to explain why we need to execute "start++".

> > +	if (parse_oid_hex_algop(start, &peeled, &p, ref_store->repo->hash_algo)) {
> > +		return fsck_report_ref(o, &report,
> > +				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
> > +				       "'%.*s' has invalid peeled oid",
> > +				       (int)(eol - start), start);
> > +	}
> 
> All the braces around those single-line return statements can go away.
> 

I see. So, I have misunderstanding here. I have thought that we should
add braces because we have split this single statement into multiple
lines. Let me update this in the next version.

> > @@ -1843,6 +1919,26 @@ static int packed_fsck_ref_content(struct fsck_options *o,
> >  				       "missing header line");
> >  	}
> >  
> > +	while (start < eof) {
> > +		strbuf_reset(&packed_entry);
> > +		strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
> > +		ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
> > +		ret |= packed_fsck_ref_main_line(o, ref_store, &packed_entry, &refname, start, eol);
> 
> Don't we have to stop in case `next_line()` returns an error?
> 

No, we don't have to stop. We will continue to check the last ref entry,
this is intentional, we still need to check the last ref entry even
though there is no newline. I don't think we should ignore this part.

Thanks,
Jialuo
