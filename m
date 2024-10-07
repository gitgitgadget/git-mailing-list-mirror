Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B532622087
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290538; cv=none; b=iWMlqECdRgO0qqSQi+GFyiSWCxXKPYsZP6TxSXP+r9dXorwEBKYzfxd7ef+JsV21rKrh1WTXQv5n81jYYP+3rGRxAHmlnE3Mv8kmw2r1npsvB7QMrvxC+MUS0ji/qaGg2Hc+IMMP0I/VyKSHjzaBCPoD2wiamlP0sF/45ymnF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290538; c=relaxed/simple;
	bh=+z93bOEXpHDnGViUBmPV1EYI3+HWq16pOCr0O64+utk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yt2wndUIVkI3MpmthoA+4EVkprK030fXSd308hha/MqsI1dYOH8w7Ux+XlgfnYjG+DWxwebDYghy1XDHrIXGBzhMt6QkjEpN/RIf4BmOO99xdsuFzbe/bz+Z2hXSsQpZahYsGPViixAidmupE5JAj+xZLV6OF48LOxiXxO7NC+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crqHH/Cb; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crqHH/Cb"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71dfc1124cdso828498b3a.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290536; x=1728895336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dgVbZJ185evlap+j/RzmR1oINa+lUp6A5hmvCIGoU/E=;
        b=crqHH/CbNtmm72+7GCHt63dlQM5lPxw/2+f7CVpaYh5nAJnfONkxLXDBx8SBACAdos
         fhmPkIb9XK7pIqkrRideNfoPKoe2m91xP/S8ojFyo8bkF/TE/maiuflWLW57kcObLXhw
         ZTk5IMIV0ONx59J9Edl4avXemqI/rCNvkreq5du7hnPrx1WJSuffOgzRJL8PWx6d7nGw
         UM5HgsS7MTrx18oGiXvLQyfV51yF8FSWg7I3pHpdZawzIMEgnQWLCM0FG1yzgiCOe55x
         2VHxNWoowBZsbkIhmvSaOEY9r02OFLcMRIMF+cGeiVVRuN5Y7C7ULvt4JxRCPcecc+tC
         3iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290536; x=1728895336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgVbZJ185evlap+j/RzmR1oINa+lUp6A5hmvCIGoU/E=;
        b=CgnYLVANl893x1RtZS5kH2ZzST8QYAXv2dtWY5GAtVXJYiBPUYzPEVgoij2HrWCtkW
         Cwp/ePM42Gp9SKv4PEb5iO2jM3ZrpjiVgqpqcaCKL2AiDDniX8RKKlLYa1S/J7TlhECO
         MnZYvs84RP2XAtOAnb/Hpt+1zWG6D/DXMWLtd6ukVxGW572oXQ8qOmgIYp634HAK5Rgx
         XM83FZ4P5U/dCxZ8HlvRJ412wSoVces/Eq7v+bzoRoYJ6X7abe5RceToKCVE3yugwEo/
         Q6KdIPMd7o4LgR9mmwaAj/8WkLXi+adXy6PAjPxHpPlRW+4KmUpPzfvjJQhphlfVz0X9
         vDbg==
X-Gm-Message-State: AOJu0YwSWAMXyld1UI4FEOXp/bFw59lMQa3Az0P/0xbXkJngoHU3tYSw
	zCEp6swXtj8U2myT+TGrUzAvqgkD7AZ99Sr4MOv0UtYfAVFmX0Rp
X-Google-Smtp-Source: AGHT+IGpTEfRLZ4KoEAXScCgZTB98t7a1TpJ15SasKqPekB4yQOIX7Xpv8aC8RVIpEoUr36xXJzDaQ==
X-Received: by 2002:a05:6a00:91c5:b0:71d:eefd:e3de with SMTP id d2e1a72fcca58-71deefdedf3mr14040688b3a.4.1728290535827;
        Mon, 07 Oct 2024 01:42:15 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4a278sm4027324b3a.140.2024.10.07.01.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:42:15 -0700 (PDT)
Date: Mon, 7 Oct 2024 16:42:21 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/9] builtin/refs: support multiple worktrees check
 for refs.
Message-ID: <ZwOe7YVWmhshRhI9@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-jkFE9NN30uDl@ArchLinux>
 <ZwOBwxiSZpxJlsfT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwOBwxiSZpxJlsfT@pks.im>

On Mon, Oct 07, 2024 at 08:58:30AM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 29, 2024 at 03:15:26PM +0800, shejialuo wrote:
> > We have already set up the infrastructure to check the consistency for
> > refs, but we do not support multiple worktrees. As we decide to add more
> > checks for ref content, we need to set up support for multiple
> > worktrees. Use "get_worktrees" and "get_worktree_ref_store" to check
> > refs under the worktrees.
> 
> Makes sense.
> 
> > Because we should only check once for "packed-refs", let's call the fsck
> > function for packed-backend when in the main worktree. In order to know
> > which directory we check, we should default print this information
> > instead of specifying "--verbose".
> 
> This change should likely be evicted into its own commit with a bit more
> explanation.
> 
> > It's not suitable to print these information to the stderr. So, change
> > to stdout.
> 
> This one, too. Why exactly is in not suitable to print to stderr?
> 

I am sorry for the confusion. We should not print which directory we
check here into stderr. Because I think this will make test script
contain many unrelated info when using "git refs verify 2>err".

The reason here is when checking the consistency of refs in multiple
worktrees. The ref name could be repeat. For example, worktree A
has its own ref called "test" under ".git/worktrees/A/refs/worktree/test"
and worktree B has its own ref still called "test" under
".git/worktrees/B/refs/worktree/test".

However, the refname would be printed to "refs/worktree/test". It will
make the user confused which "refs/worktree/test" is checked. So, we
should print this information like:

    Checking references consistency in .git
    ...
    checking references consistency in .git/worktrees/A
    ...
    checking references consistency in .git/worktrees/B

However, when writing this, I feel a ".git" is a bad usage. It will make
the user think it will check everything here. This should be improved in
the next version.

> > @@ -75,7 +77,7 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
> >  		OPT_BOOL(0, "strict", &fsck_refs_options.strict, N_("enable strict checking")),
> >  		OPT_END(),
> >  	};
> > -	int ret;
> > +	int ret = 0;
> >  
> >  	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
> >  	if (argc)
> > @@ -84,9 +86,14 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
> >  	git_config(git_fsck_config, &fsck_refs_options);
> >  	prepare_repo_settings(the_repository);
> >  
> > -	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
> > +	worktrees = get_worktrees();
> > +	for (p = worktrees; *p; p++) {
> > +		struct worktree *wt = *p;
> > +		ret += refs_fsck(get_worktree_ref_store(wt), &fsck_refs_options);
> > +	}
> 
> I think it is more customary to say `ret |=` instead of `ref +=`.
> Otherwise we could at least in theory wrap around and even land at `ret
> == 0`, even though this is quite unlikely.
> 

I agree here. I will improve this in the next version.

[snip]

> > @@ -3600,8 +3600,16 @@ static int files_fsck(struct ref_store *ref_store,
> >  	struct files_ref_store *refs =
> >  		files_downcast(ref_store, REF_STORE_READ, "fsck");
> >  
> > -	return files_fsck_refs(ref_store, o) |
> > -	       refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
> > +	int ret = files_fsck_refs(ref_store, o);
> > +
> > +	/*
> > +	 * packed-refs should only be checked once because it is shared
> > +	 * between all worktrees.
> > +	 */
> > +	if (!strcmp(ref_store->gitdir, ref_store->repo->gitdir))
> > +		ret += refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
> > +
> > +	return ret;
> >  }
> >  
> >  struct ref_storage_be refs_be_files = {
> 
> What is the current behaviour? Is it that we verify the packed-refs file
> multiple times, or rather that we call `packed_ref_store->be->fsck()`
> many times even though we know it won't do anything for anything except
> for the main worktree?
> 

That's a good question. I think the second is the current behaviour. We
will call `packed_ref_store->be->fsck()` many times. I understand what
you mean here, we just put the check into `packed_ref_store->be->fsck()`
function.

> If it is the former I very much agree that we should make this
> conditional. If it's the latter I'm more in the camp of letting it be
> such that if worktrees were to ever gain support for "packed-refs" we
> wouldn't have to change anything.
> 

I agree.

> In any case, as proposed I think it would make sense to evict this into
> a standalone commit such that these details can be explained in the
> commit message.
> 

Yes, the current commit message lacks of details.

> Patrick

Thanks,
Jialuo
