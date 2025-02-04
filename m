Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2882227462
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738647025; cv=none; b=SLwBuizZJog25f05bzDd1nuup3rZBYGlZLdy1u2uZaMSMPm2s56x43OV4tUrt/LdU2jGUOcRl/kPtLe6nvjD+K+FwuAmdxLaFlqffytF4GeRtOLNQ2ydSeXZL5ftVDWR/UrLfU7Pf959wpScAgOwpq/41sIpw3Kw6sV86yqu1MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738647025; c=relaxed/simple;
	bh=w5bxOWxqimgJ+qFIaEVO0kn543GxDfvQ1Fl3FHmP3zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8p5DS0q6xs8FTR3lmigh5PC3w6PDuvbyAIn15x65GnGSO2ij1v/I01YS1296zo7QXJxZz9eCY5C1MlA+z4NwYpggF+j4eTXarqNRmdz9fn30HJ1HHb2frhYSoo4RkpDv90LjhXEYRwa1zRAGAC4zGLJmpcd7CRUTy+1U0ouczk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwcY4IoY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwcY4IoY"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so6643930a91.3
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 21:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738647023; x=1739251823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XWGFg1+gm7mHsEhgi0scRJdoOeldf01HiPravuN7Ido=;
        b=SwcY4IoYWrKnGnOaOtsM3+yDmuf9QmBNKvW6i1zRa9jyqNLzpuuXlSgRJGanK6MZoP
         xRPpJo4wUdD7KRE2g+5TMR3ZwOPJ/yBylHNbFYuhUku4oCAu+Mj+EV5/WT6w0DaCkwg9
         ly0CN2bm4w1B+DLsfPAIXL9aUA5GeBtj03u+1Tt6Z8AfFQH1ajnfSdc2UerU4HCGopD/
         HqGiXDGZ/T3FiPWb8MsckwydHdPXarUXuSadtPOjQ2pUGQNC56/h6fteSLLOJbVq7g76
         4vIq5jzLtR5sjfCUiY9DKHPEgBdoyyfRkruaMxOJdGGywQYTgnsPJP30Kai+csnjGyLI
         ibrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738647023; x=1739251823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWGFg1+gm7mHsEhgi0scRJdoOeldf01HiPravuN7Ido=;
        b=BUpe9gNECBQQSWwieQ79g2VKnOS4CHSDGfLlrrOisvoF6XGx50RbyOlVBE90CWluZO
         BmaERaATul1uYqP20lGcbUJIvBQ+nbb5iiW2Uo04m4GqpfkBaDJf6lZiWG2nVbIccWlX
         SJSviqWfdLfirycr/1fKO2JZSYc4I54Lg452hepslMTAGlDjy9ORYJvG6WNqEy1okDIP
         BjX/AU2g/4xLfZU82HCY/MVu0GfQD4MD/BjcS8IeB5s6bpOV1dblTieek6rWY8ptI9XG
         i0U5vaE+NgHRYsL1yAbLOo3Av2xkx4VAkeWy/IivWjc5VSYjct4Ux7cKuQeegbnoofgE
         uADQ==
X-Gm-Message-State: AOJu0Yx9IOnzUsGVvTSnGyznY00zDWDxjP26+5MP99pY5HehNe1E9Bv7
	JLnMBPSyEZOG+ysY5zJ08N8JJO0oT3g++LPYDtcNGOx7OPvivblCiqKx9Dsd
X-Gm-Gg: ASbGncvhoBHzwc2icZxHoSmlL3V2CbUpRb5wCR6xxGnAOUkd8T/Td3wtJy+dBeCTtWr
	8tY+OaEng079bKDROBaM2/lrlu9nWw9Xd6D1cxytBB1QdDu+0VYJdctnPAPujeVG6beW1nJcY+i
	9l5R8dV9A1Wyvtond/5GQNVMHlma/KB6V8t1cGuRjhjLpBBT8E6yQFtVcOW1ojPhmGQjY1uvQ9C
	bKZRRvLuwJsnKErBwjYdUUyXwpfOOUMHVTDnAEr9uUtIKVIDFAoNJ4PS1qHAsihujgx6g==
X-Google-Smtp-Source: AGHT+IEupj/WWlq/20jFPP3VeZeraaZUnRp35RckjIbAIPfF+J4C+cb6UL7hUFeCUa63NH7PNrokUQ==
X-Received: by 2002:a05:6a00:2d8e:b0:725:cfa3:bc76 with SMTP id d2e1a72fcca58-72fd0bce05cmr36755921b3a.4.1738647023101;
        Mon, 03 Feb 2025 21:30:23 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe6426d3asm9508832b3a.48.2025.02.03.21.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 21:30:22 -0800 (PST)
Date: Tue, 4 Feb 2025 13:32:01 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 8/8] builtin/fsck: add `git refs verify` child process
Message-ID: <Z6GmUSgkZF1rWQgP@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r7NnzvirWEljwV@ArchLinux>
 <Z6CBC5kyvIhBuLk6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6CBC5kyvIhBuLk6@pks.im>

On Mon, Feb 03, 2025 at 09:40:43AM +0100, Patrick Steinhardt wrote:
> On Thu, Jan 30, 2025 at 12:08:22PM +0800, shejialuo wrote:
> > diff --git a/builtin/fsck.c b/builtin/fsck.c
> > index 7a4dcb0716..9a8613d07f 100644
> > --- a/builtin/fsck.c
> > +++ b/builtin/fsck.c
> > @@ -905,6 +905,34 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
> >  	return res;
> >  }
> >  
> > +static void fsck_refs(struct repository *r)
> > +{
> > +	struct child_process refs_verify = CHILD_PROCESS_INIT;
> > +	struct progress *progress = NULL;
> > +	uint64_t progress_num = 1;
> > +
> > +	if (show_progress)
> > +		progress = start_progress(r, _("Checking ref database"),
> > +					  progress_num);
> 
> Hm. I don't really think that this progress meter adds anything right
> now. It only shows either 0 or 1, so it basically only tells you when
> you're done. And that is something that the user can tell without a
> progress meter.
> 

You are correct in the functionality part. Actually, my very initial
implementation is what you have said. I simply used the following way to
indicate the user that we are going to check ref database.

    fprintf_ln(stderr, _("Checking ref database"));

However, it will break a test in "t/t1050-large.sh::fsck large blobs". I
cite the shell script below:

	test_expect_success 'fsck large blobs' '
		git fsck 2>err &&
		test_must_be_empty err
	'

> > +
> > +	if (verbose)
> > +		fprintf_ln(stderr, _("Checking ref database"));
> > +

That's the reason why we need to use `verbose` to control the behavior
here. Put it futhermore, We either use `process` or `verbose` to print
the message to the user. This is a pattern widely used in "git-fsck(1)".
For example "builtin/fsck.c::fsck_object_dir", we have the following
code:

	if (verbose)
		fprintf_ln(stderr, _("Checking object directory"));

	if (show_progress)
		progress = start_progress(the_repository,
					  _("Checking object directories"), 256);

So, that's why I use progress here. We need this to print the
information to the user. I have also tried to print to the stdout like
the following

	fprintf_ln(stdout, _("Checking ref database"));

It will also break the test.

> > +	child_process_init(&refs_verify);
> > +	refs_verify.git_cmd = 1;
> > +	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
> > +	if (verbose)
> > +		strvec_push(&refs_verify.args, "--verbose");
> > +	if (check_strict)
> > +		strvec_push(&refs_verify.args, "--strict");
> > +
> > +	if (run_command(&refs_verify))
> > +		errors_found |= ERROR_REFS;
> > +
> > +	display_progress(progress, 1);
> > +	stop_progress(&progress);
> > +}
> > +
> >  static char const * const fsck_usage[] = {
> >  	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
> >  	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
> > @@ -970,6 +998,8 @@ int cmd_fsck(int argc,
> >  	git_config(git_fsck_config, &fsck_obj_options);
> >  	prepare_repo_settings(the_repository);
> >  
> > +	fsck_refs(the_repository);
> 
> I think there needs to be a way to disable this. How about we add an
> option `--[no-]references` to do so? I was briefly wondering whether we
> also want to have `--only-references`, but if a user wants to do that
> they can simply execute `git refs verify` directly.
> 

Good idea, let me improve this in the next version.

Thanks,
Jialuo

> Patrick
