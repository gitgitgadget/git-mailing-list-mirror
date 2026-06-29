Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380971DDC28
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764724; cv=none; b=VYFcTjryJFZ7x2OsV+RZ/DwhvtPnh1N2QJJGKova675Ac4HgQoK61W5xhkeXlqdYud06OG646s3MQhUV8SuLAOPxcK53y/Fqyb1ou8TsO3fG2s0W7Bq2JPVGxFGRmNDIHm2mEnEXEYwvVeBm3ctSuhXIjepbXMxsKe/kYGMfxUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764724; c=relaxed/simple;
	bh=KiZwrYDNR6P4uLOtyjLtuA8SBOYAVPfA6cGDV8xOfyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZaTXt/NeHSIMNspPzC4CRYK/cWGUtBuAXKvVVJgMDm87ieWgrmBxJyNW7PCA2zry8o43ghgleo7G2eeiAPBOU6aJupHjGgBIBjPCnUu2lyGk0/MHdwqtOMn7PY8BN7SZMYiL8KiIBc2i3zifMj6KoOab6ziNE5e1zQeKHnjGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3uO685S; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3uO685S"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e943356247so3019348a34.2
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782764722; x=1783369522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nSphT7hcChwjTQCfWTOwDd+K2NIx4ofldtMLoLi34A8=;
        b=I3uO685SGEksTqvLA5INVZ9Od5cOXL+q6+MpiM6F3M0kjhrg7IbQ7RU7j3njIWo7NW
         +GmXqDbuZixaP6HVrfHkH1svzm+JFLO85H+D/dhX5bFvv3Zc2YtxvCQ0j7zwXY8fo35X
         53jheV/wK7DuQ2v3ZSJN0uUcjBulqPTNy7Fv/l6k8HfnvyHAsaxfH8cJ2aquMD8mmyvl
         9MW6ixLY2ocpe5KPjVSJUihlt7pV9t8hvZGaStTbmwBA62Zp8vE6P++H1Bf8LOWuKiQ5
         8CmGOuGR/O23ntYA3Zyakw53MEIbsaheME5AWJnWMMhEfNBShNEj8xK+NiEaVU51dXOH
         qmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782764722; x=1783369522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSphT7hcChwjTQCfWTOwDd+K2NIx4ofldtMLoLi34A8=;
        b=mkmETlycyJ8EuU2brQfMm9ZTfH3t5Y2jz5OOwQKZWH8wCQUTaeJq/8snOgfiKfYN0E
         PRoRmyvwGeFRTkTVSVvT25eNaYuBaj7DxxO8VyMLoH95quA2Yz6E00HopJdznarCEWVj
         h9g+bLkNOaqzt7u8JXoyxnBgv4DVZRRx8fIXf5kgzxuwl9uXF9YVCW3YSc7AEF0FQjRm
         jiHDphrJlKQjZmtoLYZuiW4TIsv6QUpWFxvlRVbyiPCIzR/gOREaoRnJX2VuICHxh5f0
         RscqKkW5WrsakwXUDOTdAI8a+t8Gk3EIFFmTd25hODDSB3axL1tXzIPTF4oNtRJ9aamo
         gmRw==
X-Gm-Message-State: AOJu0Yw8slN26H1HYKCKAo3EavkY/dIAR/YE0wyL1QSXMnrzEG1FWcEO
	NfCpEq/hiPamdlZNaXvQkCmih7YOwuN6nUwQUxZwol9W99bfxvdIvA9VdNoy7Q==
X-Gm-Gg: AfdE7ck0FGgJRbmw+PVemEpGJ+/ZxQVy4qsemoXINHNOil6wYFcgYfnJr/8r0p73kLm
	60c4YRZPMMXbHUi6tVmrrJv0ah33ogh8vlsGbxyFOKHqU5ftjxDd8G+JbnfCSGyCL7AgdKzaySO
	zXM+scf9s2CKJUyMlHtkP4dfVIOMtGaHIZsrqIvPOErvFcLyMvxMxSNjVG5hnp4fbA/dE/91Cp6
	Ism4VbTeH+uVI6JimzN6rx1oWOE9wA/dAQsNUPFuVBhXZBR3GV0amHz+qWch5jCzMb+gpo3rKun
	LTNI7FTpbDW7rvyxK9+ZN6IIV04skdRgW5RRI8Gh+bsNNU+A3hDY8eDIrEwaG61w2Dv8Q5xnmuP
	tKAgYUv0QWTgmasnfg60Yh+cEo3QmNe93BW/M9Y+dcW+wnWUg7r/cMUhFE0vnPVj61KUlp1h0TQ
	C2cwLlig==
X-Received: by 2002:a05:6830:640a:b0:7e6:fa1b:d99d with SMTP id 46e09a7af769-7e9ec717d0bmr817718a34.17.1782764722011;
        Mon, 29 Jun 2026 13:25:22 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec307edesm610551a34.21.2026.06.29.13.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 13:25:21 -0700 (PDT)
Date: Mon, 29 Jun 2026 15:25:18 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] builtin/receive-pack: stage incoming objects via ODB
 transactions
Message-ID: <akLLB_J-pvJ7iR7c@denethor>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-7-jltobler@gmail.com>
 <aju_AmlKVi5UZaiQ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aju_AmlKVi5UZaiQ@pks.im>

On 26/06/24 01:26PM, Patrick Steinhardt wrote:
> On Tue, Jun 23, 2026 at 11:19:20PM -0500, Justin Tobler wrote:
> > Objects received by git-receive-pack(1) are quarantined in a temporary
> > "incoming" directory and migrated into the object database prior to the
> > reference updates. The quarantine is currently managed through
> > `tmp_objdir` directly. In a pluggable ODB future, how exactly an object
> > gets written to a transaction may vary for a given ODB source. Refactor
> > git-receive-pack(1) to use the ODB transaction interfaces to manage the
> > object staging area in a more agnostic manner accordingly.
> > 
> > Note that the temporary directory created for git-receive-pack(1) is
> > eagerly created and uses a different prefix name. This behavior is
> 
> A different prefix name compared to what?

Currently the temporary directories created for ODB transactions all use
the prefix "bulk-fsync". The temp dir created by git-receive-pack(1) is
expected to have the prefix "incoming".

> > special cased in the "files" backend by having `odb_transaction_begin()`
> > callers that require this behavior provide an `ODB_TRANSACTION_RECEIVE`
> > flag.
> 
> Okay. I guess this is to retain existing behaviour where the temporary
> directory is created lazily everywhere else. Makes me wonder whether we
> should eventually change this to just unconditionally create the
> directory in all cases so that we can drop this new flag.

It would be nice to not have to have a flag here, but if we want to also
keep the existing temp dir prefixes, we would also need to keep the
flags.

> It might've also made sense to split this commit up into two: one to
> introduce the flag parameter, and then one to do the changes to
> git-receive-pack(1).

Ya, I think you are right. I actually originally had it this way but
squashed these two commits together for some reason. I'll split them
back up in the next version.

> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index 19eb6a1b61..ee8e03e2ab 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -112,8 +112,6 @@ static enum {
> >  } use_keepalive;
> >  static int keepalive_in_sec = 5;
> >  
> > -static struct tmp_objdir *tmp_objdir;
> > -
> >  static struct proc_receive_ref {
> >  	unsigned int want_add:1,
> >  		     want_delete:1,
> 
> I assume the goal is that we convert all other users of the tmp-objdir
> subsystem to also use transactions eventually, so that this becomes an
> implementation detail fo the files transaction?

Yes, that is exactly my plan :)

> > @@ -2106,14 +2104,13 @@ static void execute_commands(struct command *commands,
> >  	 * Now we'll start writing out refs, which means the objects need
> >  	 * to be in their final positions so that other processes can see them.
> >  	 */
> > -	if (tmp_objdir_migrate(tmp_objdir) < 0) {
> > +	if (odb_transaction_commit(the_repository->objects->transaction)) {
> >  		for (cmd = commands; cmd; cmd = cmd->next) {
> >  			if (!cmd->error_string)
> >  				cmd->error_string = "unable to migrate objects to permanent storage";
> >  		}
> >  		return;
> >  	}
> > -	tmp_objdir = NULL;
> 
> We don't need to unset the transaction because that's what
> `odb_transaction_commit()` already does for us, I assume?

That is correct. The tmp_objdir global is actually removed and now
competely managed by the ODB transaction. We can probably actuall remove
the "tmp-objdir" include now too. I'll do that in the next version.

> > @@ -2326,7 +2323,8 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
> >  		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
> >  }
> >  
> > -static const char *unpack(int err_fd, struct shallow_info *si)
> > +static const char *unpack(int err_fd, struct shallow_info *si,
> > +			  struct odb_transaction *transaction)
> >  {
> >  	struct pack_header hdr;
> >  	const char *hdr_err;
> 
> It feels a bit weird that we sometimes pass the transaction as
> parameter, whereas othertimes we access it via `the_repository`.

That's fair. I was trying to avoid the churn of wiring to all its
callsites, but it's probably best to be consistent. Maybe it would be
fine to just create a transaction global like we do for the reference
transaction?

> > @@ -2351,20 +2349,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
> >  		strvec_push(&child.args, alt_shallow_file);
> >  	}
> >  
> > -	tmp_objdir = tmp_objdir_create(the_repository, "incoming");
> > -	if (!tmp_objdir) {
> > -		if (err_fd > 0)
> > -			close(err_fd);
> > -		return "unable to create temporary object directory";
> > -	}
> > -	strvec_pushv(&child.env, tmp_objdir_env(tmp_objdir));
> > -
> > -	/*
> > -	 * Normally we just pass the tmp_objdir environment to the child
> > -	 * processes that do the heavy lifting, but we may need to see these
> > -	 * objects ourselves to set up shallow information.
> > -	 */
> > -	tmp_objdir_add_as_alternate(tmp_objdir);
> > +	strvec_pushv(&child.env, odb_transaction_env(transaction));
> 
> Interesting, this here seems like a change in behaviour. Previously we
> added the transactions as an alternate, but now we only propagate it via
> the environment. I didn't see this mentioned in the commit message.

That's not quite correct. By using the ODB transaction interface, the
underlying tmp_objdir is managed transparently. When we begin the ODB
transaction, the temp directory that gets created is automatically
created and applied as the primary ODB. This ultimately produces an
equivalent result, its just now set up when the transaction is started
(which happens a little bit earlier).

The only behavior change here is that the temp directory is being
applied as the primary instead of an alternate in the main
git-receive-pack(1) process. Since all writes though are handled by the
child processes that get spawned, this shouldn't really matter though.

This is certainly rather confusing though, and should be mentioned in
the commit message. I'll do this in the next version.

> > @@ -2707,7 +2694,10 @@ int cmd_receive_pack(int argc,
> >  		if (!si.nr_ours && !si.nr_theirs)
> >  			shallow_update = 0;
> >  		if (!delete_only(commands)) {
> > -			unpack_status = unpack_with_sideband(&si);
> > +			if (odb_transaction_begin(the_repository->objects, &transaction, ODB_TRANSACTION_RECEIVE))
> > +				unpack_status = "unable to start ODB transaction";
> 
> s/ODB/object/
> 
> This may be visible to the user, and "ODB" may mean nothing to them.

Will change in the next version.

> > diff --git a/object-file.c b/object-file.c
> > index 14064d188a..e7958753ec 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1702,7 +1703,8 @@ static const char **odb_transaction_files_env(struct odb_transaction *base)
> >  }
> >  
> >  int odb_transaction_files_begin(struct odb_source *source,
> > -				struct odb_transaction **out)
> > +				struct odb_transaction **out,
> > +				enum odb_transaction_flags flags)
> >  {
> >  	struct odb_transaction_files *transaction;
> >  	struct object_database *odb = source->odb;
> > @@ -1717,6 +1719,20 @@ int odb_transaction_files_begin(struct odb_source *source,
> >  	transaction->base.commit = odb_transaction_files_commit;
> >  	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
> >  	transaction->base.env = odb_transaction_files_env;
> > +
> > +	transaction->prefix = "bulk-fsync";
> > +	if (flags & ODB_TRANSACTION_RECEIVE) {
> > +		/*
> > +		 * ODB transactions for git-receive-pack(1) eagerly create a
> > +		 * temporary directory and use a different prefix.
> > +		 */
> > +		transaction->prefix = "incoming";
> > +		if (odb_transaction_files_prepare(&transaction->base)) {
> > +			free(transaction);
> > +			return -1;
> > +		}
> > +	}
> > +
> 
> Okay, makes sense. I really wonder whether we need to insist this much
> on the exact name used by this, but better be safe than sorry for now I
> guess.
> 
> And as mentioned before, I also wonder whether it really makes sense to
> have the lazy creation of the tmp-objdir. Maybe add a NEEDSWORK item
> here that mentions we want to investigate whether this is even needed at
> all?

Ya, I was worried that there would be some reason the temp dir prefix
should remain the same or there would be some performance reason to
lazily create directories. I didn't investigate too deeply though. I'll
add a NEEDSWORK comment to make note of this.

> > diff --git a/odb/transaction.h b/odb/transaction.h
> > index 536458297b..78392ff13d 100644
> > --- a/odb/transaction.h
> > +++ b/odb/transaction.h
> > @@ -44,6 +43,10 @@ struct odb_transaction {
> >  	const char **(*env)(struct odb_transaction *transaction);
> >  };
> >  
> > +enum odb_transaction_flags {
> > +	ODB_TRANSACTION_RECEIVE = (1 << 0),
> > +};
> 
> It's not clear at all what this flag does based on its name, so we
> should have documentation for it.

Will update.

Thanks,
-Justin
