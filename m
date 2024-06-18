Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4CA1BE86E
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701763; cv=none; b=n9P0zWY+vsHS3qZlB1YhCDfCFypGqX1vUNOCUshnvkh1ck6XbpOPw9axfZJvzW3K4oFLOOC4NIhmYrsGnvXtpbWlZbxWOOhA6S8QNefuzRvjtyQQw2Esfb3sVWWOKq1T2gGlXD0QZAwfxH7AZjYiz8mVlfEM3LGaSdEFrwFURLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701763; c=relaxed/simple;
	bh=MwsGi3PN0zCSk4P/A6LqguIibGbtBB7J/iXZYJB4LQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsEMDCoQbFs66NR+vDN4Jm/NI8jQ9QzFC/KIULOpDFCIg4Q8QxwDwY5Y6QBPStZqv+kg2zuTvNLOpsG6h61GDEE4txtkFOzTaZ9tHbRjA9+tYuw6vm2TiLZ4DuxHKfXTcgEadtFFvxNlRFb+Uh+BbcSYbWeLHi38WtXhVA8BgAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6Toq/V6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6Toq/V6"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f44b441b08so38548735ad.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 02:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718701761; x=1719306561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HgbSpn4E5peGIuOakdWNdfWimd131QYYCnmk/DOZjnI=;
        b=b6Toq/V6kzGOLUU/kLuo3vb2eR27wTpfrzEnXL1RdQw5R96mlFR958875ttVAC8Eta
         tPixyWKBeYlvhxZwYxPPZrUhwO6yps4MrgEO0VDxmNc1OcTONwkshvBXxd92kMdPJ5Sj
         CCRobFpgtxkMObidq2jB7eWdQlmeYk5Dmkk724id9bUaNBuqZvWbnkDHah57hjMjvetf
         Uq3LTytArejRloqgg7bDHCAZB5WC7BHhhhq63jeaOC3ENgdLZPTIjDNJyVW3ak2WP86V
         l5dgt0apqiVOefDMhE5yvRk8nvIR9b15Flcuibhva2eLUPXT0T5aTcCy6WfCsH2VDHLm
         TPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718701761; x=1719306561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgbSpn4E5peGIuOakdWNdfWimd131QYYCnmk/DOZjnI=;
        b=Wj06gXRBPA3KGGguNA1nQNcL89CW5lJma3Bh3KtnRGl2/Rv8mI6LYs4Afau3IGv4BX
         /1VExt6VBXpAc4Etx6N1LR1SKXAnBBhv2jggahGj85EBT6txdpIRy1+VGY2AIqMWc1Su
         EHllmvctfVL0coQIwAh6ATOniMS3VdaHe6aunGAgJhaN2jcOrBCzSLpYUhY40XZIileT
         vWNUMdrlk0E/2x+LrKnIu0VVuVCZdN9Vb4MHeSFegUC0NP0Q+VoxpHBqAX09ikbA6os7
         x4nOHUVaHntrl/bgyhC0QmzMdUz7akeO4iBfohHASg8xKYMUWiAXc+MFOJ/8c6mPhmHE
         1cwg==
X-Gm-Message-State: AOJu0Yx9aTdZFk3xntO2UxO1oEMfNptYcpWTmRVg6Cz5Q5qMrEaYcsoi
	kcsv7ZIRNfkSS0MiURK6YE7ySErN6u3y04qKNoSoVOdzL3bv4YE6
X-Google-Smtp-Source: AGHT+IGXP9dsO5/LiI7YmACj3/rR82YvulUVQu4R7OoJxaiCaTRSrPaxww3V1mpDLAn8k1FutVONoQ==
X-Received: by 2002:a17:902:e542:b0:1f7:26f:9185 with SMTP id d9443c01a7336-1f8625c65a0mr119216015ad.10.1718701760648;
        Tue, 18 Jun 2024 02:09:20 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f5c039sm92773635ad.306.2024.06.18.02.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 02:09:20 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:09:17 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v2 5/7] files-backend: add unified interface for
 refs scanning
Message-ID: <ZnFOvagjx6fRxJbw@ArchLinux>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
 <20240612085349.710785-1-shejialuo@gmail.com>
 <20240612085349.710785-6-shejialuo@gmail.com>
 <CAOLa=ZQ5msKTHwDou2RmCrUCdfDuYdFwJQx3Q9gK6aAJvGw-pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ5msKTHwDou2RmCrUCdfDuYdFwJQx3Q9gK6aAJvGw-pg@mail.gmail.com>

On Sat, Jun 15, 2024 at 04:51:14PM -0400, Karthik Nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > For refs and reflogs, we need to scan its corresponding directories to
> > check every regular file or symbolic link which shares the same pattern.
> > Introduce a unified interface for scanning directories for
> > files-backend.
> >
> 
> Here we talk about reflogs, but we only add a iterator for
> "$GIT_DIR/refs". Should we add something for reflogs too?
> 

Here, we simply set up the basic structure. For both refs and reflogs,
we will traverse the file system. What we concern about is the regular
file and symlink file. The "refs_check_dir" parameter is used to
indicate what we will check. Actually, we do not add any actual check
operations for refs in this commit.

> > Mentored-by: Patrick Steinhardt <ps@pks.im>
> > Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> > Signed-off-by: shejialuo <shejialuo@gmail.com>
> > ---
> >  refs/files-backend.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index e965345ad8..b26cfb8ba6 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -4,6 +4,7 @@
> >  #include "../gettext.h"
> >  #include "../hash.h"
> >  #include "../hex.h"
> > +#include "../fsck.h"
> >  #include "../refs.h"
> >  #include "refs-internal.h"
> >  #include "ref-cache.h"
> > @@ -3402,6 +3403,78 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
> >  	return ret;
> >  }
> >
> > +/*
> > + * For refs and reflogs, they share a unified interface when scanning
> > + * the whole directory. This function is used as the callback for each
> > + * regular file or symlink in the directory.
> > + */
> > +typedef int (*files_fsck_refs_fn)(struct fsck_refs_options *o,
> > +				  const char *gitdir,
> > +				  const char *refs_check_dir,
> > +				  struct dir_iterator *iter);
> > +
> > +static int files_fsck_refs_dir(struct ref_store *ref_store,
> > +			       struct fsck_refs_options *o,
> > +			       const char *refs_check_dir,
> > +			       files_fsck_refs_fn *fsck_refs_fns)
> > +{
> > +	const char *gitdir = ref_store->gitdir;
> > +	struct strbuf sb = STRBUF_INIT;
> > +	struct dir_iterator *iter;
> > +	int iter_status;
> > +	int ret = 0;
> > +
> > +	strbuf_addf(&sb, "%s/%s", gitdir, refs_check_dir);
> > +
> > +	iter = dir_iterator_begin(sb.buf, 0);
> > +
> > +	if (!iter) {
> > +		ret = error_errno("cannot open directory %s", sb.buf);
> > +		goto out;
> > +	}
> > +
> > +	while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
> > +		if (S_ISDIR(iter->st.st_mode)) {
> > +			continue;
> > +		} else if (S_ISREG(iter->st.st_mode) ||
> > +			   S_ISLNK(iter->st.st_mode)) {
> > +			if (o->verbose)
> > +				fprintf_ln(stderr, "Checking %s/%s",
> > +					   refs_check_dir, iter->relative_path);
> > +			for (size_t i = 0; fsck_refs_fns[i]; i++) {
> > +				if (fsck_refs_fns[i](o, gitdir, refs_check_dir, iter))
> > +					ret = -1;
> > +			}
> > +		} else {
> > +			ret = error(_("unexpected file type for '%s'"),
> > +				    iter->basename);
> > +		}
> > +	}
> > +
> > +	if (iter_status != ITER_DONE)
> > +		ret = error(_("failed to iterate over '%s'"), sb.buf);
> > +
> > +out:
> > +	strbuf_release(&sb);
> > +	return ret;
> > +}
> > +
> > +static int files_fsck_refs(struct ref_store *ref_store,
> > +			   struct fsck_refs_options *o)
> > +{
> > +	int ret;
> > +	files_fsck_refs_fn fsck_refs_fns[]= {
> > +		NULL
> > +	};
> > +
> > +	if (o->verbose)
> > +		fprintf_ln(stderr, "Checking references consistency");
> > +
> > +	ret = files_fsck_refs_dir(ref_store, o, "refs", fsck_refs_fns);
> > +
> > +	return ret;
> > +}
> 
> I'm not fully sure why this needs to be separate from `files_fsck`. Is
> that because we plan to also introduce `files_fsck_reflogs`?
> 

Yes, exactly. Later we need to introduce "files_fsck_reflogs" which
should define the different `files_fsck_refs_fn` here. So just introduce
a function here.

> > +
> >  static int files_fsck(struct ref_store *ref_store,
> >  		      struct fsck_refs_options *o)
> >  {
> > @@ -3410,6 +3483,8 @@ static int files_fsck(struct ref_store *ref_store,
> >  		files_downcast(ref_store, REF_STORE_READ, "fsck");
> >
> >  	ret = refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
> > +	ret = files_fsck_refs(ref_store, o);
> > +
> >  	return ret;
> >  }
> >
> > --
> > 2.45.2


