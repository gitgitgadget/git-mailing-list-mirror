Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7EE42AA6
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123713; cv=none; b=nxHm5R9XuAHiWDtSQ183TESPPnEXlPvioJuj79bd85lG/G36QJvF4MpbYqy3rnWg1O97AuS3nLyeMat6FnIeB1Hb6MgaMZDFGkqOVrWG3Wb+S/cPxdVTl4sBhRTqwKtCgE9n5eGEJETY9d8OmoeMIj63IKCf50eSv993SWL+uRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123713; c=relaxed/simple;
	bh=kpfoW1ZdFKYXY91jninktrjRKqmC1EGf3k3YV5QQxvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h37h+xJ7TQ64tvft8bB1h9/etfllTztNoIYY0saxBCUfr/V52DFJXsvrINNFu7FdAHA0wCsBIdWnygtbLCgv7H1+0TnY/CimVtl1yi7HQ6AZAJLrDs32Fu0bRMZNyeja03z448hIsMlET7SB024vm1j2BZLGEHoZIOvImgTRB9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifddm2PT; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifddm2PT"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e2bc5b90fso1177278a34.0
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 06:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737123711; x=1737728511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMHT2v+lbfsgKTrZiJRLpbQUz+yhwVabZxw6iH1ax14=;
        b=ifddm2PTjR3VLumLLtUEnY8EXRhTuPVm6xesC9oURu1qVA7mlSEU11yJIgRsmNoDmr
         MPaPQNYOfUA/vPMSGeYGS7l8UEymyQ9QmRmsbkn91c+GlAWvaVi33aGA7zK5Eoe8DTB1
         m94fX3F4zNwudrFtqmSE05MWKDfWjecRgBgfs2Sk68BpAXqeW6zKlfNvRFM9dp+H668K
         5iygRe9S9mSqp/vxYBrj6Ni3zU/cUgiv9aGe8Nncx2Aw6F8/8/39Wn5pdZp94+DvVBW7
         cAZzYUfom2tHgXxYze0MtvVqT+QswpmvPcZbo9jcWxeQCUXFywUxp8oFf3Y6Hj5hHh9t
         Euuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737123711; x=1737728511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMHT2v+lbfsgKTrZiJRLpbQUz+yhwVabZxw6iH1ax14=;
        b=Hb7toqsWneDWe9klbk8rQbZUNJKowHCgA2CLUSIUNcxo4E3ArmOsoU88uM0pmnQxQF
         umgtdRsZH+ary60HiGctZzL375fg7tqUBVtxJn3Yu6lhecByqqjIVuFEQDhQheRNy9U1
         t+c3u/BmV0xDArR+F4HbDVjho9YL9F1w1xo5xqtH1zDENp4eiLhvaBLt/q05JH+uLOxg
         oJXndip+YNaA38gOFpUwiQKT2O74tuKhGwVFGbTOfAVn331TdYUr75mKtK5/gBZjTSnB
         5CHcPaO4LrbFuq/S5q/N/9eMicIDU5/0boMuB1kBgfofa6LcZKJWY/xa/AKiA/HSbfDL
         mQpQ==
X-Gm-Message-State: AOJu0YxT06lLP+TQ0fVe99b6PHszabe7PogpDHmw+j0QL5byTVbxQ2US
	YMP/aNobFAIMCt1uqiLW+Ph7iAcDMIhT6xe2RmFHWFNqCHSj9wfx+8zr1q1m
X-Gm-Gg: ASbGnctwxD8Tafcp9FjqxC23VuR3VImpXhZZtX/9lauJK+RxDi/SDmbcIoi6mAoUbV3
	76jLJcQ/Tr9CXf7Z7aATXfVbnhkvpyEHZK5fo+F1R2+Mp+tYiHD0ejxX4qpZUZ19uJrz6LXGZi6
	rPyez2nzP5X+JUnf45uogFW0q0Q7iBIOOigy30VRG9qCGL6vXv6uNz6+ee5n0+1h21MIqUYuryH
	CA8kMTW2Cc2jLS+eVUs9Rd6M9UfyvsndEg=
X-Google-Smtp-Source: AGHT+IGSEmpiBTdeOSiaYgKbJ3j3xEHDS0NW2xAqH04UIJZ9v0i3Oo1JoYX7AtsZNEMzUxMYsOx8Iw==
X-Received: by 2002:a05:6871:64c3:b0:29f:ecfc:32df with SMTP id 586e51a60fabf-2b1c0a15a6fmr1773781fac.14.1737123710714;
        Fri, 17 Jan 2025 06:21:50 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2b1b8d4aef2sm1051828fac.26.2025.01.17.06.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 06:21:49 -0800 (PST)
Date: Fri, 17 Jan 2025 22:23:06 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 04/10] packed-backend: add "packed-refs" header
 consistency check
Message-ID: <Z4pnyhF2V2ykuHlg@ArchLinux>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qN8U2VbZBnUSWj@ArchLinux>
 <Z4kQUb7og2Ce1iCo@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4kQUb7og2Ce1iCo@pks.im>

On Thu, Jan 16, 2025 at 02:57:37PM +0100, Patrick Steinhardt wrote:
> On Sun, Jan 05, 2025 at 09:49:37PM +0800, shejialuo wrote:
> > Add a new flag "safe_object_check" in "fsck_options", when there is
> > anything wrong with the parsing process, set this flag to 0 to avoid
> > checking objects in the later checks.
> 
> Okay, I understand the motivation: a corrupted refdb may be completely
> bogus, so checking its objects may not be sensible.
> 
> For one of the preceding commits I made the suggestion to split out the
> object checks into a generic part instead, as they aren't specific to
> the backend. With such a scheme we could adapt the logic to first do the
> backend-specific checks for the format, and only in case the backend
> looks sane to us we'd execute those generic checks for that specific
> backend. That'd allow us to get rid of the "safe object check" flag.
> 

Yes, I agree with you here. And I won't touch this topic in the next
version. Let me make this patch concentrate on the "packed-ref" format.

> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index d9eb2f8b71..3b11abe5f8 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -1748,12 +1748,100 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
> >  	return empty_ref_iterator_begin();
> >  }
> >  
> > +static int packed_fsck_ref_next_line(struct fsck_options *o,
> > +				     int line_number, const char *start,
> > +				     const char *eof, const char **eol)
> > +{
> > +	int ret = 0;
> > +
> > +	*eol = memchr(start, '\n', eof - start);
> > +	if (!*eol) {
> > +		struct strbuf packed_entry = STRBUF_INIT;
> > +		struct fsck_ref_report report = { 0 };
> > +
> > +		strbuf_addf(&packed_entry, "packed-refs line %d", line_number);
> > +		report.path = packed_entry.buf;
> > +		ret = fsck_report_ref(o, &report,
> > +				      FSCK_MSG_PACKED_REF_ENTRY_NOT_TERMINATED,
> > +				      "'%.*s' is not terminated with a newline",
> > +				      (int)(eof - start), start);
> > +
> > +		/*
> > +		 * There is no newline but we still want to parse it to the end of
> > +		 * the buffer.
> > +		 */
> > +		*eol = eof;
> 
> I don't quite understand. We've figured out that there isn't a newline,
> so wouldn't that mean that we _are_ at the end of the buffer already?
> 

In the "packed-refs" file, the last line should end with a newline. If
not, this is a fatal error. The motivation why I do this is that for
each line, we could pass the "line_start" and "eol" to check. But if
there is no newline, the "eol" will be NULL. So, I change it to "eof" to
make sure that we could follow the same logic when "eol" is not NULL.

I guess I should not handle this in this function which may cause
confusion here. I will improve this in the next version.

> > +		strbuf_release(&packed_entry);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int packed_fsck_ref_header(struct fsck_options *o, const char *start, const char *eol)
> > +{
> > +	const char *err_fmt = NULL;
> > +	int fsck_msg_id = -1;
> > +
> > +	if (!starts_with(start, "# pack-refs with:")) {
> > +		err_fmt = "'%.*s' does not start with '# pack-refs with:'";
> > +		fsck_msg_id = FSCK_MSG_BAD_PACKED_REF_HEADER;
> > +	} else if (strncmp(start, PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER))) {
> > +		err_fmt = "'%.*s' is not the official packed-refs header";
> 
> I wouldn't say "official", because it could totally be that whatever is
> official changes in the future, e.g. when a new format is introduced.
> Unlikely to happen, but saying "unknown packed-refs header" might be a
> bit more future proof.
> 

I will improve this in the next version.

> > +		fsck_msg_id = FSCK_MSG_UNKNOWN_PACKED_REF_HEADER;
> > +	}
> > +
> > +	if (err_fmt && fsck_msg_id >= 0) {
> > +		struct fsck_ref_report report = { 0 };
> > +		report.path = "packed-refs.header";
> > +
> > +		return fsck_report_ref(o, &report, fsck_msg_id, err_fmt,
> > +				       (int)(eol - start), start);
> > +
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int packed_fsck_ref_content(struct fsck_options *o,
> > +				   const char *start, const char *eof)
> > +{
> > +	int line_number = 1;
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
> The header can only appear at the beginning of the file, can't it? But
> we accept it in every line here. We should likely verify that it's
> actually a header and not a line at some random place.
> 

Yes. But we don't accept it in every line. Because in here, we are
getting the first line "start" and "eol" by using
"packed_fsck_ref_next_line". Only it starts with "#", we will check the
header consistency.

> > +	} else {
> > +		struct fsck_ref_report report = { 0 };
> > +		report.path = "packed-refs";
> > +
> > +		ret |= fsck_report_ref(o, &report,
> > +				       FSCK_MSG_PACKED_REF_MISSING_HEADER,
> > +				       "missing header line");
> > +	}
> > +
> > +	/*
> > +	 * If there is anything wrong during the parsing of the "packed-refs"
> > +	 * file, we should not check the object of the refs.
> > +	 */
> > +	if (ret)
> > +		o->safe_object_check = 0;
> > +
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
> >  	struct stat st;
> >  	int ret = 0;
> >  
> > @@ -1779,7 +1867,24 @@ static int packed_fsck(struct ref_store *ref_store,
> >  		goto cleanup;
> >  	}
> >  
> > +	if (strbuf_read_file(&packed_ref_content, refs->path, 0) < 0) {
> > +		/*
> > +		 * Although we have checked that the file exists, there is a possibility
> > +		 * that it has been removed between the lstat() and the read attempt by
> > +		 * another process. In that case, we should not report an error.
> > +		 */
> > +		if (errno == ENOENT)
> > +			goto cleanup;
> 
> Unlikely, but good to guard us against that condition regardless. It's
> still not entirely race-free though because the file could meanwhile
> have changed into a symlink, and we wouldn't notice now. We could fix
> that by using open(O_NOFOLLOW), fstat the returne file descriptor and
> then use `strbuf_read()` to slurp in the file.
> 

Would this be too complicated for us to avoid race condition and we will
introduce a lot of code to handle above logic. Because there is a
possibility that when finishing reading the file content to the memory,
the file could be changed into a symlink and we cannot notice. So, I
wanna say we can't avoid race condition totally. It would be good if we
avoid race, but what I am concern about here is that we would make the
logic too complicated. So, could we make it unchanged?

