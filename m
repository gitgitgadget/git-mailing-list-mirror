Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E841CCEE2
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738333346; cv=none; b=KXHPGBWfW28DCVxP4+Ngrxwm0uci/fgxsqAx1SU89Jgr82TSj6nenUHIgHUZRH5sMdvhz8vfGu4xuDB5zDWSfOLGeP40kMvtT4eVaS0QbxiKM2J+EkkMYJXaySccc4XTKnCN2yW6NPdkLKB9p2OSPW1gp6sicGKOjgtRI1xtT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738333346; c=relaxed/simple;
	bh=j+VPbOU1MUF6e+Mc5aIZuMxrLR4sfKTSb3qrlqJrQSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0tq/OBrdAh8EodgAmK2VHpsIf7Sv+PZjpdbaQqbfyb9tkol/+a7ezdZN8900L4xFKg91ZSvLjeC4hVpTWNSqN28QgI6PKxLwTz5TaSPCfZgD8NFPsxPz1q0q0JH3f7UFpiz7t7PvG/yuf0Y4dIMo0kZ5xrempclhKaM5UMtYCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axciv40Z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axciv40Z"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2165cb60719so38871065ad.0
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 06:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738333344; x=1738938144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wLTlag0F0IsOsNHbs0Etty+J1ZgVdd44EinL2Ej/9r4=;
        b=axciv40Zb1O/6r8wjU4ZdGPRxIHnvYY/E8K++MsYFxLs7i/Xa4XRAPfrZuTHJABZfv
         weBqDpKt2VDbo9aeB2rwUKHx6KhvUdTsWhvgFQx7RthCuiy7fCV+iqJTTU+QCIUYeHol
         VMPUezo/zAmRAP6avzVaESn2ssTQ1Pclm8PWAkRVvWKNCxaq3bvrvB2oA6LS4ouUUlqF
         CUJx6PLA4MjXcj64W4ifEkbDELSVYa8IfgPFclRvORlyse7hehuvuV6eCDNfl5dOMPfC
         hyYvEbxC3SiEC4BtfmkEe/bQj/icJMdcyj9CEDq2L4i+YkZU9uC180F/eigfk+qZleHs
         XAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738333344; x=1738938144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLTlag0F0IsOsNHbs0Etty+J1ZgVdd44EinL2Ej/9r4=;
        b=FKgoe2Ez6a+WEVGoCccHewOgt4qLPD91S2N/J52NoVCD0LS3NWGUoih1w5gqvD33Uq
         VXgUGPaKJMWQERoA4hIRKDtKIFm8jqBJf5F0tBU3hx7O3/lAIZ6A659rwYVVFV+BSGYh
         rKxap+x1u2YfGosLDIKXsMiqGNCmo74czTFSxClD/MCp6TSsJtp8PwNb8hn0qTtl6dMC
         byh5z6/YCzZ6tyXW7kjIRlN/N9sUnwUfEoJRQow1sePh872EMwh+j+C0ecfjP0MP6xfI
         extpJpvmCOyVQaTdgzJRQXV/QZHkbNst5+0DiUwGZtII9wksdWR1rdeBubBhO8TmtSYl
         McSw==
X-Gm-Message-State: AOJu0YxPYtPGIcbGlft/DUEvhRVPKDHDPq6CYAuVAcKBrZIDFkGgvkDw
	CgrfHTuXqaTXl1t7JK/qu9qoHst00etA4TrcNRF4aVCIU88AnjxT
X-Gm-Gg: ASbGncsUi1MHf/+vJU7eaTWfGC/S23mnxndJTlhMZ7UvWRmhZ+jbWzHcu4mB4UWHKKc
	e7A+2CP+TLu6OMy/Y/SZx1nZqrOseh1vko9AosAaxoj5awPjcqNznagmSFl8LS5yK1GGBqugy39
	toqsNiFtdw1TF7UsBfwz+5fpwzHXyzz043GraYggszDMoivf185kL/jlWcU88aH8l71SmQZwfeg
	HJ/MPFB4ixv5YzToVOCJ94/6dquQxC1vX8nH7JoTXzOFKzXHCw0BDKrn7e1Woe6obqI9Q==
X-Google-Smtp-Source: AGHT+IH/rstNfe0U2ufnC9D0NR4ppYbw9c6viSM8WIY895E8dCVVdSVbLQEP5xQlUHj0Ia9gXi6PDA==
X-Received: by 2002:a05:6a00:b4b:b0:729:1b8f:9645 with SMTP id d2e1a72fcca58-72fd0c7f7camr17512597b3a.24.1738333343822;
        Fri, 31 Jan 2025 06:22:23 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe6a1ab2fsm3383785b3a.170.2025.01.31.06.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 06:22:23 -0800 (PST)
Date: Fri, 31 Jan 2025 22:23:57 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 4/8] packed-backend: add "packed-refs" header
 consistency check
Message-ID: <Z5zc_QAqYP-Dg4-K@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r7BuEJvjwQ9f4G@ArchLinux>
 <xmqq1pwkdt7r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pwkdt7r.fsf@gitster.g>

On Thu, Jan 30, 2025 at 10:58:32AM -0800, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > In "packed-backend.c::create_snapshot", if there is a header (the line
> > which starts with '#'), we will check whether the line starts with "#
> > pack-refs with:". As we are going to implement the header consistency
> > check, we should port this check into "packed_fsck".
> >
> > However, the above check is not enough, this is because "git pack-refs"
> > will always write "PACKED_REFS_HEADER" which is a constant string to the
> > "packed-refs" file. So, we should check the following things for the
> > header.
> 
> I haven't done history digging in this area for a while, but we
> should make sure we are not flagging a file that was written in
> ancient version of Git whose repository is still supported.
> 

Understood.

> > 1. If the header does not exist, we may report an error to the user
> >    because it should exist, but we do allow no header in "packed-refs"
> >    file. So, create a new fsck message "packedRefMissingHeader(INFO)" to
> >    warn the user and also keep compatibility.
> 
> Are we sure "it should exist"?  I think the header did not exist
> before "Git v1.5.0".  I didn't check with other reimplementations of
> Git (like jgit or libgit2), but as long as our reading side of the
> runtime allows a packed-refs file without the header without
> complaint, I do not think it is a good idea to treat it as a
> report-worthy event from "git fsck".
> 

OK, let me improve this in the next version.

> > 2. If the header content does not start with "# packed-ref with:", we
> >    should report an error just like what "create_snapshot" does. So,
> >    create a new fsck message "badPackedRefHeader(ERROR)" for this.
> 
> This I can agree with.  If the first line begins with "#" but not
> with that string (with a trailing SP), that is a sign that it may
> not even be a valid packed-refs file, which is a report-worthy
> event.
> 
> > 3. If the header content is not the same as the constant string
> >    "PACKED_REFS_HEADER", ideally, we should report an error to the user.
> 
> NO.  THAT IS NOT IDEAL AT ALL.
> 
> The header was written like this:
> 
>         /* perhaps other traits later as well */
>         fprintf(cbdata.refs_file, "# pack-refs with: peeled \n");
> 
> in the older versions of Git before it was made into a separate
> preprocessor macro and lost the comment (the above excerpt is from
> "git show v1.5.0:builtin-pack-refs.c").
> 
> Notice "other traits later" in the comment?
> 
> The thing is _designed_ to be extensible.  In fact, these days we
> support a few more traits
> 
>         static const char PACKED_REFS_HEADER[] =
>                 "# pack-refs with: peeled fully-peeled sorted \n";
> 
> (an excerpt from the current refs/packed-backend.c).
> 
> Reporting an error when you see something written by an older
> version of Git is far from ideal.
> 

Understood, I think we should be consistency with the runtime check.

> >    However, we allow other contents as long as the header content starts
> >    with "# packed-ref with:". To keep compatibility, create a new fsck
> >    message "unknownPackedRefHeader(INFO)" to warn about this. We may
> >    tighten this rule in the future.
> 
> Whatever we do, what we do with an unknown trait should be in line
> with what the runtime does.  If the runtime failed (we do not, but
> this is to illustrate the principle [*]) on a packed-refs file
> without "sorted" trait, noticing that "sorted" is not there and
> flagging as an error is a good thing to do.  But if the runtime
> gracefully degrades and sorts the list of refs read from such a
> packed-refs file before continuing, then a packed-refs file that
> lack "sorted" trait is not a report-worthy event.
> 

Actually, the runtime won't complain about this. I agree with you here.

> I do not offhand recall if we introduced the concept of mandatory vs
> optional traits in the packed-refs part of the system (like we have
> in the index extension subsystem, where a version of Git that
> encounters an unknown *and* mandatory index extension must refuse to
> touch the repository), but if there is a mandatory trait declared in
> the header that our version of Git does not understand, it is a
> report-worthy event that must be flagged with "git refs verify".
> 

I don't think any trait in "packed-refs" is mandatory. Because I have
done some experiments before implementing the code. We should only check
case 2 here.

> > +static int packed_fsck_ref_header(struct fsck_options *o, const char *start, const char *eol)
> > +{
> > +	const char *err_fmt = NULL;
> > +	int fsck_msg_id = -1;
> > +
> > +	if (!starts_with(start, "# pack-refs with:")) {
> > +		err_fmt = "'%.*s' does not start with '# pack-refs with:'";
> > +		fsck_msg_id = FSCK_MSG_BAD_PACKED_REF_HEADER;
> > +	} else if (strncmp(start, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER))) {
> > +		err_fmt = "'%.*s' is an unknown packed-refs header";
> > +		fsck_msg_id = FSCK_MSG_UNKNOWN_PACKED_REF_HEADER;
> > +	}
> 
> As I outlined above, this is totally unacceptable.  
> 
> Inspecting the header is good, but if this code claims to be a
> checker, it should do at least what the runtime does, i.e. parse the
> header to tell what traits the packed-file declares, not just
> assuming that it is a fixed string.  And error on unknown trait(s)
> if they are mandatory (if such a concept is implemented in the
> runtime reading side).  Informing on an unknown and optional
> trait(s) I can live with, but personally I wouldn't recommend it.
> 

Got it, I don't want to report unknown trait(s) either.

> In other words, report loudly if it is an error, but otherwise stay
> silent if we know we tolerate it well. 
> 

Thanks for this suggestion.

> > +static int packed_fsck_ref_content(struct fsck_options *o,
> > +				   const char *start, const char *eof)
> > +{
> > +	struct strbuf packed_entry = STRBUF_INIT;
> > +	int line_number = 1;
> 
> We limit ourselves with about 1 billion refs in the packed-refs
> file, which may be plenty,

Let me change this to `size_t`. This would be better.

> but I do not quite understand the use of
> this variable.  There is no loop inside this so ...
> 

The reason why I define this variable is that I am going to use loop to
check each entry in the next patch.

> > +	const char *eol;
> > +	int ret = 0;
> > +
> > +	strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
> 
> ... this is always line #1, and then
> 
> > +	ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
> > +	if (*start == '#') {
> > +		ret |= packed_fsck_ref_header(o, start, eol);
> > +
> > +		start = eol + 1;
> > +		line_number++;
> 
> ... it may be incremented, but upon returning from the funcition, it
> is lost.
> 
> Perhaps you wanted to make it a function-scope static, but then you
> are allowed to read one single packed-refs file during the life of
> your process before you exit, which I am not sure is what you want?
> 

Actually, what I want is use this variable for looping the each ref
entry in the "packed-refs" file.

> > +	} else {
> > +		struct fsck_ref_report report = { 0 };
> > +		report.path = "packed-refs";
> > +
> > +		ret |= fsck_report_ref(o, &report,
> > +				       FSCK_MSG_PACKED_REF_MISSING_HEADER,
> > +				       "missing header line");
> > +	}
> > +
> > +	strbuf_release(&packed_entry);
> > +	return ret;
> > +}

Thanks,
Jialuo
