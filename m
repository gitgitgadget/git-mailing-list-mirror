Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E63F42DA4D
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657523; cv=none; b=LbbOjLSGgVfpS6sor0/768n93gtBhWVLJbZ4APF9goxoa2lhoxQqx/duzMbxrpBmvrWPtoO/k81Tpc+Th9uKE57yVQ+vITTwXh/cVwuiH2sdyTjn4FHUxBwvXOILwRUEU2BSF2BPcCL161NDZotrex4I5x57FTClh9V/zbQTDaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657523; c=relaxed/simple;
	bh=2da04Le62efRgGdhFgXBvxcsO1CbyI/LLjyyg0RE95o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBM5ptr3UbM+5nUwD7Eucrki5iwVXIjGCgRoOOMs0Le2NCGluXwiJoDzSkzvdFhcvaGqGDaLYUYyR1HXE/zAyaY8mg3i2VSBINb133WF8M3Ci6V0SjG4E/dTnKBq2HeQ85h3EbhDkSkk3O2Tn2jH+lyM0irGxp/c9blJGzvte1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Afj2LOGQ; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Afj2LOGQ"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-451a49abd8aso227891fac.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786657520; x=1787262320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bqn6bCCt7CRhR8MZpuTpvASp/O3WLIWtMxliAIBmGwY=;
        b=Afj2LOGQUq+YcqC1AQoMcUDGz5/k57hXVQMNIm9o1pDBcILkdZD2lMDk/Ob/MPJtll
         MWOuccnM0en2+z9dSKZVYPoTkKQeaHkip4Bhh8mBVi5EbFLjvEGngYFq6gwFGvQPGZjR
         0rlEZxNMfl3MTFpv9RYJjBBJ5HwIoIYg6OzORlgvSB5z2ztBfnr86wuqKZjrP2MNMDmD
         CAYmnG6A/h7MI/aY3JnNTozvB76AZpxkAzBUkE+RVDHVfoKoq114iiVwfMkN4k+xCTq3
         m8gNzni4iwACAQkqrgrz1inSXL60sdEF+ulTXXfcHuXR9Mapo3yCvnM4XjedtFAo3SBZ
         6nyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786657520; x=1787262320;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqn6bCCt7CRhR8MZpuTpvASp/O3WLIWtMxliAIBmGwY=;
        b=RtgTGZLtast/c1+f/3GxHeEcJFnjVElVc4ibwssanQoblVaEelxZSDWQIE7xrzkwOz
         RP0oigTKfP0Bnes/nAcklzTZnekGgLPvGugUICaRV0ekq81/P8LUmg1J7Snb+zmeBXPu
         CX7MWdeplLN008EHgcGpPlhr/HjNbhlbZOgcQubN//t0lcMuZvzVlNw7LjS6M399zroG
         vCiGgU2nxB8ks8N49gH3k09AE67ZGFmgwhLLGCa4UxBrvzaDk6JVSXpTaxhqG5inoWZY
         AlOWfNVxzU6cBbEa7qnt/iCTZG9+jFdDbLaW5PWV2605gp0wQjuNPoZwyiKi7pbOrPxe
         Uwpw==
X-Gm-Message-State: AOJu0YxniaxuzN+VB9PV4VlkTinyzkheSh0rCZUWaO2DWSHBwx0B4srZ
	mjVX5CjXk6NYFTpC9HAcemOkpcxWzjnamEZmA12tLloimxzV/BgEc1pu
X-Gm-Gg: AR+sD13nhCwu8c5YU6S37UkxDVlzaOE3mpVxsdpeMaDPR1If/BcE2oQDTRrUIL6O55N
	6NlEK2nF01FA/1JWBOUrB0ZqA+JJ4BZr1Nh4iOPEuIT/xAwM3SvUJbgTBM1fWIZQwlyvhQC/mcT
	s52Rj0OlD/lee3iHtauPIzYS0I/Ee5lEAfS/81HIHdykYhfapRwnJ/JEtqYZ0jT0GmMUjLUd5i7
	XDnOwZZS2NztXPaPEXFjYNqtCuCEIeNlzrSqyeiC4sj+1EsHqZ+NJOt/MyDk9jHJ40XV3f3VoIF
	HCmCY1BhwHlcVca+DCTojuJaWhhitDCcEEGyZf7QXFe0V9yUWbjgOv74p0uznbAoSOl1/y08YeQ
	tK+xOBm1/lsSFOLjjvBDzfSbNOHvEw6YWfxDzhD/9XGQM85BUfh53BVWCx5JSXw4fWvcKpW3PfP
	YX8WLU18wy1fhj1oQOXiL7zDO5GbqSywna/s9rh4CFqS4MUW4aRX66IQ==
X-Received: by 2002:a05:6870:c273:b0:448:89e3:4c58 with SMTP id 586e51a60fabf-45e9233b0aamr1217901fac.18.1786657520262;
        Thu, 13 Aug 2026 14:45:20 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e8f4e6bbesm736199fac.0.2026.08.13.14.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 14:45:19 -0700 (PDT)
Date: Thu, 13 Aug 2026 16:45:16 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 1/9] builtin/receive-pack: properly clean up keep files
Message-ID: <an41gSCa7EFGkB1r@denethor>
References: <20260809190106.1565882-1-jltobler@gmail.com>
 <20260811175415.2044235-1-jltobler@gmail.com>
 <20260811175415.2044235-2-jltobler@gmail.com>
 <anwNonpw5SZuHADv@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anwNonpw5SZuHADv@pks.im>

On 26/08/12 08:07AM, Patrick Steinhardt wrote:
> On Tue, Aug 11, 2026 at 12:54:07PM -0500, Justin Tobler wrote:
> > When git-receive-pack(1) stores an incoming packfile with
> > git-index-pack(1), a ".keep" file is written alongside it to hold the
> > pack in place until the references have been updated, and is removed
> > afterwards. The path used to remove it is derived via
> > `index_pack_lockfile()` from the repository's primary object directory.
> > 
> > In bdee7b3013 (builtin/receive-pack: stage incoming objects via ODB
> > transactions, 2026-07-10), git-receive-pack(1) started using the ODB
> > transaction interfaces instead of managing a temporary directory
> > directly. When starting an ODB transaction, the sources list is
> > reordered to insert the newly created transaction source first as the
> > primary to ensure writes are routed to it accordingly.
> > 
> > Prior to using ODB transactions, git-receive-pack(1) would only set the
> > temporary directory as the primary source for the child
> > git-index-pack(1) and git-unpack-objects(1) processes it spawned and the
> > parent process would set the temporary directory set as an alternate
> > only. By using ODB transactions, the ODB source list is also reordered
> > for the parent process which results in `index_pack_lockfile()` deriving
> > the ".keep" path relative to the temporary directory instead the actual
> 
> Nit: s/instead/& of/

Will fix.

> > main ODB source path. Consequently, this prevents the ".keep" file from
> > being properly removed after being migrated into the main ODB source
> > post-commit.
> 
> Hm. Are the temporary packs written into the transaction-managed tempdir
> now, or do they still end up in the main object directory?

The packfile and associated ".keep" lockfiles are both initially written
into the temporary directory managed by the ODB transaction. On
transaction commit, they are then both migrated to the main ODB.

When registering the keep tempfile, we need to record the future
post-commit location of the keep file that way it can be removed when
`odb_transaction_finalize()` is invoked. This matches the original
behavior prior to ODB transaction being introduced in
git-receive-pack(1).

> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > index 86933d8d7e..d74b787148 100644
> > --- a/builtin/receive-pack.c
> > +++ b/builtin/receive-pack.c
> > @@ -2412,7 +2412,13 @@ static const char *unpack(int err_fd, struct shallow_info *si,
> >  		if (status)
> >  			return "index-pack fork failed";
> >  
> > -		lockfile = index_pack_lockfile(the_repository, child.out, NULL);
> > +		/*
> > +		 * The lockfile filepath is expected to be the final location of
> > +		 * the ".keep" file after being migrated to the main ODB source.
> > +		 * This ensures the lockfile can be found and removed later
> > +		 * after the ODB transaction has been committed.
> > +		 */
> > +		lockfile = index_pack_lockfile(transaction->source, child.out, NULL);
> >  		if (lockfile) {
> >  			pack_lockfile = register_tempfile(lockfile);
> >  			free(lockfile);
> 
> Okay. So previously, we wrote the ".keep" file into the main repository,
> whereas now we write it into the temporary object directory? Is the
> packfile itself also written in there?

Not quite, both the packfile and keep file were written to the temporary
directory and continue to do so.

Prior to bdee7b3013 (builtin/receive-pack: stage incoming objects via
ODB transactions, 2026-07-10), the ".keep" files were also being written
to the quarantine directory and migrated alongside the packfiles. The
main git-receive-pack(1) process always kept the primary ODB as the
first entry in the source list though ensuring that the "filename"
registered for keep tempfile was the final location. With ODB
transactions though, the source list order _does_ get changed and
resulted in the keep tempfile not knowing about its final location.
Consequently, it is no longer cleaned up.

> What I'm wondering is why we even need a ".keep" file at all anymore if
> we're not storing it in the main object directory. It wouldn't help us
> to avoid the race, because after committing the transaction the ".keep"
> file would remain in the temporary directory, whereas the packfile would
> have been migrated to the main object directory. So it doesn't have a
> ".keep" file at that point, and neither have references been updated to
> point to the new objects yet.

The ".keep" file does end up in the main ODB alongside the packfile when
the transaction is committed. The main problem here is that it is not
being cleaned up because the post-migration path does not match what the
registered tempfile tracks.

> So I wonder whether instead, we'd have to:
> 
>   1. Start the transaction, creating the temporary object directory.
>   
>   2. Write the packfile into the temporary object directory, but don't
>      create a ".keep" file.
> 
>   3. At commit time, first write a ".keep" file in the main object
>      directory and then migrate the packfile over.
> 
>   4. At finalization time, prune the ".keep" file from the main object
>      directory.
> 
> That would retain the current properties of the system, but as far as I
> can see this is not what we're doing here.

With this patch, this is effectly what we are doing already. The main
difference is that we are creating the ".keep" file alongside the
packfile via git-index-pack(1) and migrating both when
`odb_transaction_commit()` is invoked.

We could stop relying on git-index-pack(1) to generate the ".keep" file
and instead generate it ourselves during the commit phase as you
suggested, but I'm not sure that would really buy us anything right now.
For now, I think it would be fine to keep the changes more minimal.

I'll try to clarify the commit message a bit in the next version to
better explain what is happening.

> > diff --git a/pack.h b/pack.h
> > index 1cde92082b..68dcf08cf3 100644
> > --- a/pack.h
> > +++ b/pack.h
> > @@ -3,6 +3,7 @@
> >  
> >  #include "object.h"
> >  #include "csum-file.h"
> > +#include "odb/source.h"
> >  
> >  struct packed_git;
> >  struct pack_window;
> 
> Let's add a forward declaration instead of including this header.

Will do.

> > diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
> > index 0798ddab02..400a597606 100755
> > --- a/t/t5547-push-quarantine.sh
> > +++ b/t/t5547-push-quarantine.sh
> > @@ -70,4 +70,18 @@ test_expect_success 'updating a ref from quarantine is forbidden' '
> >  	git -C update.git fsck
> >  '
> >  
> > +test_expect_success '.keep file is removed after push' '
> > +	test_when_finished rm -rf keep.git &&
> > +	git init --bare keep.git &&
> > +
> > +	git -C keep.git config set receive.unpackLimit 0 &&
> > +	test_commit foo &&
> > +	git push keep.git HEAD &&
> > +	pack="$(ls keep.git/objects/pack/pack-*.pack)" &&
> > +	keep="${pack%.pack}.keep" &&
> > +
> > +	test_path_is_file "$pack" &&
> > +	test_path_is_missing "$keep"
> > +'
> 
> This would feel a bit safer if we had a hook that verifies that we
> indeed have the ".keep" file in the right spot before committing
> everything.

I'll try to set something up in the next version. Thanks.

-Justin
