Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B78F5C
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="eVKQ6gpo"
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAC71B1
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 23:34:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-28001f8079cso1049639a91.2
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 23:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698388455; x=1698993255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=juTOwP0Z5sYvEIjJXs4dndxfMuYi35eqDIlZ0HNMuTs=;
        b=eVKQ6gpoDvD9cTGKrUp6JQSZxd37Q3EHoijFnXnR6c0GHW6MB1Mwv+QiE/LmEvP9eh
         Ka/1K1xG3vSLgFJTyBf0Tk5xPb1x/F8iKtd051NQkalbdSoM1TPlN9hKYEdFTn1Ac0SD
         iv3PNdcw77SIVQ8wlJgpH0XEIw9kOtouaXlaSDsgQQae5IufFPwFe0R/C6QJnp9uJNOU
         WJI66uAeJPgTe7oetQP2AAH9hiRUeZd4P3YlsFWM+iyG+lM6zyEW80Mzsi6negXUEAkC
         tPII7vcHbRmrg2ySIcY3Kr1DCtF+L4hVv+6zbPiuyKxqY63HCcA5cgWUz2tJql+UAUaY
         PY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698388455; x=1698993255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juTOwP0Z5sYvEIjJXs4dndxfMuYi35eqDIlZ0HNMuTs=;
        b=NpVS3GGEThpbyLrX9VMHbZKHnC5wNRtxvfBKyX2ZX/gCgA79IjhHucXtfB0VzVaBIf
         Jmj4AsHtY/QJWbe4p//9QJK8XZDdTr/cHENBMWjNj7eMLldZXDU/XbNh7Zh6cgOp5bgQ
         mLORZFIEf6EfZ2tjR+gjH1Fkhvx3nn0ef4qsiGZhDEPOyEjsnoPKQROpfUr72Ohwtea7
         KnsVpPUPgS1nt0icN3dMl2lE2h7X+AFwOiAvI3+J4bmzegB1A+hEvkb2V7/PskEQ/8Ox
         ScsmG2OZKw2TaX6CkRE7+MwEIwKyf7c+1ElCmZKlOFyciGPt2GulqDpWedE9wItNip3o
         4uTw==
X-Gm-Message-State: AOJu0Yye4pVNyTcpcZP+8xxcVeqYM0Mazy1/3tnPEXTS2dQGSsC+QB6C
	0LWs0SGNoOe32WaM6z4aPW4+tcZ8lM6Hvj4vW7Y=
X-Google-Smtp-Source: AGHT+IGUVCVoXr43GtVuzOu6pqI0iiEjUOIMlwN7WfTtobHBk7xsbV8AigVFp0oR1tUGF5hT+7r9Vg==
X-Received: by 2002:a17:90a:f015:b0:27d:114e:d4a3 with SMTP id bt21-20020a17090af01500b0027d114ed4a3mr1682466pjb.14.1698388455437;
        Thu, 26 Oct 2023 23:34:15 -0700 (PDT)
Received: from initialcommit.io (mobile-166-171-123-53.mycingular.net. [166.171.123.53])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090a750500b00277246e857esm2895252pjk.23.2023.10.26.23.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 23:34:14 -0700 (PDT)
Date: Thu, 26 Oct 2023 23:34:12 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] bugreport: include +i in outfile suffix as needed
Message-ID: <ZTtZ5CbIGETy1ucV.jacob@initialcommit.io>
References: <20231015034238.100675-2-jacob@initialcommit.io>
 <20231016214045.146862-1-jacob@initialcommit.io>
 <20231016214045.146862-2-jacob@initialcommit.io>
 <ZTrX4PMYtbVT-tUu@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTrX4PMYtbVT-tUu@google.com>

> > +static void build_path(struct strbuf *buf, const char *dir_path,
> > +		       const char *prefix, const char *suffix,
> > +		       time_t t, int *i, const char *ext)
> > +{
> > +	struct tm tm;
> > +
> > +	strbuf_reset(buf);
> > +	strbuf_addstr(buf, dir_path);
> > +	strbuf_complete(buf, '/');
> > +
> > +	strbuf_addstr(buf, prefix);
> > +	strbuf_addftime(buf, suffix, localtime_r(&t, &tm), 0, 0);
> > +
> > +	if (*i > 0)
> > +		strbuf_addf(buf, "+%d", *i);
> > +
> > +	strbuf_addstr(buf, ext);
> > +
> > +	(*i)++;
> > +}
> 
> I commented on the weirdness of having to decrement i for --diagnose
> below, but I think I generally just wish that instead of build_path()
> this function did create_file_with_optional_suffix() and returned the
> final modified option_suffix(). Better still would be if this function
> created (or at least tested) all the necessary output paths so you don't
> end up succeeding in creating a bugreport.txt but failing in creating
> the diagnostics.zip in some edge case, something like....

So the funny thing is that the existing behavior of the diagnostics file
just overwrites any existing diagnostics file with the same name, which
is at odds with how the bugreport throws an error in the case of a
conflict. I wasn't sure whether it made sense to touch that here since it
seemed possibly out of the scope of this change, given that there is
a separate "git diagnose" command to take into account.

But if we keep this behavior it basically means there's no need to test
the necessary diagnostics output paths when determining the path of the
bugreport itself, since whatever we pick for the bugreport will just
overwrite anything for the diagnotics zip if it already exists. The one
caveat is that any future files created should behave the same way...

But I get that this is perhaps inconsistent and it might be worth it to
make "git diagnose" work the same way as bugreport so it makes more sense
to do the kind of validations you mentioned.

> build_suffix(..., &option_suffix) {
>   ... build timestamp ...
>   while (...)
>     for (final_path in eventual_paths) {
>     	err = select(final_path);
> 	if (err)
> 	  final_path = strcat(most_of_path, i)
> 	else
> 	  break
> (Yeah, that's very handwavey, but I hope you see what I'm getting at.)
> 
> Really, though, I mostly don't think I like leaving the control variable i raw
> to the calling scope and making it be manipulated later. Fancy
> pre-guessing-path-availability aside, I think you could achieve a more
> pleasant solution even by letting build_path() become
> create_file_with_optional_suffix() (that reports the optional suffix
> eventually settled on).


Hmm... so when you say "create_file_with_optional_suffix", do you mean
a function that tests a set of paths to find the minimum incremented
suffix that will work for all the paths? Would it use the current method
the patch uses of trying to create the files and if creation fails we
know the file exists -> increment -> try again? Repeat until all the
files are able to be created and make sure to clean up any extras?
(And maybe just clean up everything since the actual files with content
will be created later on, now that the suffix is known).

An alternative could be to wrap `build_path()` in a function that does
this work, locally scope `i` in it, call build_path on each needed path,
and test creation until all paths are valid, clean up all the paths,
then return the suffix.

> > +	if (!strlen(option_suffix))
> > +		option_suffix = "%Y-%m-%d-%H%M";
> > +	else
> > +		option_suffix_is_from_user = 1;
> 
> Looking at where this is used, it looks like you're saying "if the user
> specified the suffix manually and has this problem, then that sucks for
> them, they put their own foot in it".
>
> But I don't know if I necessarily
> follow that logic - I'd just as soon drop the exception, append an int
> to the user-provided suffix, and document that we'll do that in the
> manpage.

Haha - it's interesting how we each interpreted the user's experience here,
and I was a bit torn about this too. But here are my thoughts on it:

If the user specifies their own suffix, it seems more natural and even
expected for them to just get an error if a file with that name already
exists. To me it's not that they put their foot in anything, it's that
they asked for a specific thing that we can't deliver since it's already
taken, so just let them know so they can either delete the existing one
or alter the custom suffix. Incremeting the filename without telling them
in this case might not be what they actually want, we're kindof guessing.

However, in the default case where no suffix is specified, the user likely
has no assumption or awareness about the suffix at all, which is why it
felt odd to throw an error out of the blue if the default suffix happens
to conflict with an existing file that was also created by default. The
user didn't ask for anything specific in this case, so would likely be
confused as to why they are getting an error when it just worked a second
ago. So I was thinking we can just handle it gracefully and give them the
incremented report.

> (This isn't something I feel strongly about, except that I think it
> makes the code harder to follow for not very notable user benefit. I
> also didn't look through the reviews up until now, so if this was
> already hashed back and forth, just go ahead and ignore me.)

Setting up the default variables like this was discussed, but not the
difference in behavior based on whether the user specifies a suffix.
Altho I do agree that we sacrifice some consistency here and it does add
an extra pathway to the code, imo there is a good enough reason to do it
as described above - to me it makes things more intuitive to the user.

> > +		/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
> > +		report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
> > +		if (report < 0 && errno == EEXIST && !option_suffix_is_from_user) {
> > +			build_path(&report_path, prefixed_filename,
> > +				   "git-bugreport-", option_suffix, now, &i,
> > +				   ".txt");
> > +			goto again;
> > +		} else if (report < 0) {
> Nit, but the double-checking of (report < 0) bothers me a little. Is it
> nicer if it's nested?
> 
> 	if (report < 0) {
> 		if (errno == EEXIST) {
> 			build_path(...);
> 			goto again;
> 		}
> 
> 		die_errno(_(...));
> 	}
> 
> I like it a little more, but that's up to taste, I suppose.

I like yours better too :)

> > +			die_errno(_("unable to open '%s'"), report_path.buf);
> > +		}
> >  
> >  	if (write_in_full(report, buffer.buf, buffer.len) < 0)
> >  		die_errno(_("unable to write to %s"), report_path.buf);
> >  
> >  	close(report);
> >  
> > +	/* Prepare diagnostics, if requested */
> > +	if (diagnose != DIAGNOSE_NONE) {
> > +		struct strbuf zip_path = STRBUF_INIT;
> > +		i--; /* Undo last increment to match zipfile suffix to bugreport */
> I understand why you're doing this, but I'd rather see it decremented
> (or more care taken in the increment logic elsewhere) closer to where it
> is being increment-and-checked. If someone wants to add another
> associated file besides the report and the diagnostics, then the logic
> for the decrement becomes complicated (what happens if I run `git
> bugreport --diagnostics --desktop_screencap`? what if I run only `git
> bugreport --desktop_screencap`?). Even without that potential pain,
> reading this comment here means I have to say "oh wait, what did I read
> above? hold on, let me page it back in".
> 

Yeah these are great points and I completely agree! Even if we stick with
this method of doing things, the `i` decrement should be moved out of the
conditional and up closer to where the value of `i` is set.

> > +		build_path(&zip_path, prefixed_filename, "git-diagnostics-",
> > +			   option_suffix, now, &i, ".zip");
> > +
> > +		if (create_diagnostics_archive(&zip_path, diagnose))
> > +			die_errno(_("unable to create diagnostics archive %s"),
> > +				  zip_path.buf);
> > +
> > +		strbuf_release(&zip_path);
> > +	}
> > +
> >  	/*
> >  	 * We want to print the path relative to the user, but we still need the
> >  	 * path relative to us to give to the editor.
> > -- 
> > 2.42.0.297.g36452639b8
> 
> Last thing: it probably makes sense to mention this new behavior in the
> manpage, especially if you'll apply that behavior to user-provided
> suffixes too.

Sure I can add some docs to the manpage, altho as described above I
prefer throwing an error instead of adding the increment to the
user-provided suffixes :D

> Thanks for your effort on the patch so far and again, sorry for the late
> reply.
>  - Emily

No worries at all and thanks a lot for your review! I'll start working
on a v3 - it would be great to get your thoughts on the unresolved items.
