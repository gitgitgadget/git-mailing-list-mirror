Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FE41E500C
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739355491; cv=none; b=P+b7krj9EAQwhbgYi1XtSpsqrhB8nYdVGXR2Uz0gA/IcG6IOmyzCHqNZAFZ2kIMFHKvWvANh27rd22bl8iZwNqKTrFk5uk9RTMmlLarBO4JOLe2A0mIwZcnuMLbq6yB2bkfqQuoaljgsOipVmhx9/e+RmMqurtExCVfbiXJVQ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739355491; c=relaxed/simple;
	bh=In7bBaINsPk9SyQrAlcVdtMZsdOGSHRQQz+qdZ0B/Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UloC1wRPsh0Wk27pCgqbO1zbebeXkg3SKFmFmM498szqpiWqz9XjU43jJio/GQETvYbJGyarfd/m2H86K1wLt8sw8e/mPOc/ZbUXY7rEOjj9lVu4EC7QRQPbXM2NQ7mJG+mSxu8b0bkrw9Ah3UPfDCSk2priv+SMGgQ4dPhuCVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N46iQtdQ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N46iQtdQ"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c05c2dc5ddso340732685a.1
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 02:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739355488; x=1739960288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xke1YmNsfUASvO/MPIMJQ2dkArNEseAldt0wZGmByQg=;
        b=N46iQtdQ3ygbmjYM0Nfu509w1/FziEV3I/TelkiF9+gz3ncLFp1cP5v7IxsEz21Ch6
         RxpINU8cY2jTJZp5VKyoA2Elg2JOdl+9loOFHGllLAlq594ynydKGSp28K1VmEtTYmF9
         9nTWaSRD7KxPjFCTAGuHh+BwRxWCm9pyRgUJDQSuYzj93pH+AtvBte2Qf6cKm0XAlp71
         oSQkIwPCZba5ERq+/qOR07CIf4316/meOKrjoH/BTlWEuS3oLMHJDAtKnpCXzuBCTrS8
         H8nEut71GymNxowNj6LfnpMAy4yAwuezdFDlu/Rg86YWaTL12WlFlVDssF6rEaHDZOfb
         1cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739355488; x=1739960288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xke1YmNsfUASvO/MPIMJQ2dkArNEseAldt0wZGmByQg=;
        b=HeXmKAL7CxvskVUKqoGoOOY1zf6QRSG/W1Ak1UdUAlKXNSA6+71r+mFnH5mbh37Qa7
         KwLqumiI78yM0eEAPatiL/tRSNGRMgMW3qjTEt39MSAQfrwk4vX34O5d82l/JZoI7ZGp
         OUWR1UCH/Cr65UZg7X15mfuzMxsajbcEUmMpOp+vSLSujvZgEUlMpq0ifcv4fMfynhpV
         pGV+4S/mnpQasqnSDdMPW/hjg4WNS7T0cFnWrVp4grQ6TRuREo1Es7yRdV5K00ADzU6G
         t5VVurquThiAFvP4aYTpsPf8tEjIimHTIIJ/pcDTkB26lIVAx7cj/GB3toJzfyauZ6MV
         mldQ==
X-Gm-Message-State: AOJu0Yz4H0HQWIWNz0dcJwLHSuTQe98Td9+Il3C4xvCSJQ7Zcawgo5Fz
	tykNhYrLQokYTj43S6Qe6R7q8rfWwelixl98OWj/CNVucukEcEPB
X-Gm-Gg: ASbGncsUak2A7OWp70HWYUhjIYQrVhEwIZ48N91BQAXNAz7AzteyhmktSk34ARa7J07
	SL4j2H3YVKPz6BrHTmNkbST+ZHvU9vqkSx8FlfQQYDZbAncOHPqhNuRqahyR8fAHs7NWxZfxMd6
	5SvlME2sNT4DW1QoFw2bU+tYaSNBHW7UlBJS2p2ixl4ii1isOeTJg3ZWXHysLjLOZ7IA9J0tqx0
	EqN1e/1Os7XGf6HLptHs/1cb2VQ809HigFTjQksR30vrimxw6JacQ4EQtvHp4P+7gP6pQ==
X-Google-Smtp-Source: AGHT+IHXCVylRmhREx+YLtR/CcPSdPXb+Yb2ZzC1IWrNS6Sy835iZc2Z6NkEOcxcLtzDIIoTf8Mh0A==
X-Received: by 2002:a05:620a:480e:b0:7bf:ff64:336e with SMTP id af79cd13be357-7c0707986b9mr413505785a.51.1739355488378;
        Wed, 12 Feb 2025 02:18:08 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c041dec31dsm827808485a.1.2025.02.12.02.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:18:07 -0800 (PST)
Date: Wed, 12 Feb 2025 18:20:01 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 7/8] packed-backend: check whether the "packed-refs"
 is sorted
Message-ID: <Z6x10U4HUwMYKUDh@ArchLinux>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
 <Z6RP2_wL1gjsWpkR@ArchLinux>
 <Z6xwaMIUx_x6QVrU@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6xwaMIUx_x6QVrU@pks.im>

On Wed, Feb 12, 2025 at 10:56:56AM +0100, Patrick Steinhardt wrote:
> On Thu, Feb 06, 2025 at 01:59:55PM +0800, shejialuo wrote:
> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index 658f6bc7da..0fbdc5c3fa 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -1767,6 +1773,28 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
> >  	return empty_ref_iterator_begin();
> >  }
> >  
> > +struct fsck_packed_ref_entry {
> > +	unsigned long line_number;
> > +
> > +	struct snapshot_record record;
> > +};
> > +
> > +static struct fsck_packed_ref_entry *create_fsck_packed_ref_entry(unsigned long line_number,
> > +								  const char *start)
> > +{
> > +	struct fsck_packed_ref_entry *entry = xcalloc(1, sizeof(*entry));
> > +	entry->line_number = line_number;
> > +	entry->record.start = start;
> > +	return entry;
> > +}
> > +
> > +static void free_fsck_packed_ref_entries(struct fsck_packed_ref_entry **entries, size_t nr)
> > +{
> > +	for (size_t i = 0; i < nr; i++)
> > +		free(entries[i]);
> > +	free(entries);
> > +}
> > +
> >  static int packed_fsck_ref_next_line(struct fsck_options *o,
> >  				     struct strbuf *packed_entry, const char *start,
> >  				     const char *eof, const char **eol)
> > @@ -1794,19 +1822,33 @@ static int packed_fsck_ref_next_line(struct fsck_options *o,
> >  }
> >  
> >  static int packed_fsck_ref_header(struct fsck_options *o,
> > -				  const char *start, const char *eol)
> > +				  const char *start, const char *eol,
> > +				  unsigned int *sorted)
> >  {
> > -	if (!starts_with(start, "# pack-refs with:")) {
> > +	struct string_list traits = STRING_LIST_INIT_NODUP;
> > +	char *tmp_line;
> > +	int ret = 0;
> > +	char *p;
> > +
> > +	tmp_line = xmemdupz(start, eol - start);
> > +	if (!skip_prefix(tmp_line, "# pack-refs with:", (const char **)&p)) {
> >  		struct fsck_ref_report report = { 0 };
> >  		report.path = "packed-refs.header";
> >  
> > -		return fsck_report_ref(o, &report,
> > -				       FSCK_MSG_BAD_PACKED_REF_HEADER,
> > -				       "'%.*s' does not start with '# pack-refs with:'",
> > -				       (int)(eol - start), start);
> > +		ret = fsck_report_ref(o, &report,
> > +				      FSCK_MSG_BAD_PACKED_REF_HEADER,
> > +				      "'%.*s' does not start with '# pack-refs with:'",
> > +				      (int)(eol - start), start);
> > +		goto cleanup;
> >  	}
> >  
> > -	return 0;
> > +	string_list_split_in_place(&traits, p, " ", -1);
> > +	*sorted = unsorted_string_list_has_string(&traits, "sorted");
> 
> I think we call them capabilities, not traits.
> 

Yes, capabilities will be more semantic. But the original code in
"packed-backend.c" uses "traits". Let us follow the original style to
make sure consistency.

> [snip]
> >  static int packed_fsck_ref_content(struct fsck_options *o,
> >  				   struct ref_store *ref_store,
> >  				   const char *start, const char *eof)
> >  {
> >  	struct strbuf packed_entry = STRBUF_INIT;
> > +	struct fsck_packed_ref_entry **entries;
> >  	struct strbuf refname = STRBUF_INIT;
> >  	unsigned long line_number = 1;
> > +	unsigned int sorted = 0;
> > +	size_t entry_alloc = 20;
> > +	size_t entry_nr = 0;
> >  	const char *eol;
> >  	int ret = 0;
> >  
> >  	strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
> >  	ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
> >  	if (*start == '#') {
> > -		ret |= packed_fsck_ref_header(o, start, eol);
> > +		ret |= packed_fsck_ref_header(o, start, eol, &sorted);
> >  
> >  		start = eol + 1;
> >  		line_number++;
> >  	}
> >  
> > +	ALLOC_ARRAY(entries, entry_alloc);
> >  	while (start < eof) {
> > +		struct fsck_packed_ref_entry *entry
> > +			= create_fsck_packed_ref_entry(line_number, start);
> 
> Instead of slurping in all entries and allocating them in an array, can
> we instead remember the last one and just compare that the last record
> is smaller than the current record?
> 
> > @@ -1915,11 +2011,16 @@ static int packed_fsck_ref_content(struct fsck_options *o,
> >  			start = eol + 1;
> >  			line_number++;
> >  		}
> > +		entry->record.len = start - entry->record.start;
> >  	}
> >  
> > +	if (!ret && sorted)
> > +		ret |= packed_fsck_ref_sorted(o, ref_store, entries, entry_nr);
> 
> Okay, we now conditionally check whether the refs are sorted based on
> whether or not we found the "sorted" capability.
> 
> > diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> > index 3ab6b5bba5..adcb5c1bda 100755
> > --- a/t/t0602-reffiles-fsck.sh
> > +++ b/t/t0602-reffiles-fsck.sh
> > @@ -706,4 +706,67 @@ test_expect_success 'packed-refs content should be checked' '
> >  	)
> >  '
> >  
> > +test_expect_success 'packed-ref with sorted trait should be checked' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit default &&
> > +		git branch branch-1 &&
> > +		git branch branch-2 &&
> > +		git tag -a annotated-tag-1 -m tag-1 &&
> > +		branch_1_oid=$(git rev-parse branch-1) &&
> > +		branch_2_oid=$(git rev-parse branch-2) &&
> > +		tag_1_oid=$(git rev-parse annotated-tag-1) &&
> > +		tag_1_peeled_oid=$(git rev-parse annotated-tag-1^{}) &&
> > +		refname1="refs/heads/main" &&
> > +		refname2="refs/heads/foo" &&
> > +		refname3="refs/tags/foo" &&
> > +		printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
> > +		printf "%s %s\n" "$branch_2_oid" "$refname1" >>.git/packed-refs &&
> > +		printf "%s %s\n" "$branch_1_oid" "$refname2" >>.git/packed-refs &&
> 
> Same comment here as in the previous patch, this can be simplified with
> HERE docs.
> 
> > +		test_must_fail git refs verify 2>err &&
> > +		cat >expect <<-EOF &&
> > +		error: packed-refs line 2: packedRefUnsorted: refname '\''$refname1'\'' is not less than next refname '\''$refname2'\''
> > +		EOF
> > +		rm .git/packed-refs &&
> > +		test_cmp expect err &&
> > +
> > +		printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
> > +		printf "%s %s\n" "$tag_1_oid" "$refname3" >>.git/packed-refs &&
> > +		printf "^%s\n" "$tag_1_peeled_oid" >>.git/packed-refs &&
> > +		printf "%s %s\n" "$branch_2_oid" "$refname2" >>.git/packed-refs &&
> > +		test_must_fail git refs verify 2>err &&
> > +		cat >expect <<-EOF &&
> > +		error: packed-refs line 2: packedRefUnsorted: refname '\''$refname3'\'' is not less than next refname '\''$refname2'\''
> > +		EOF
> > +		rm .git/packed-refs &&
> > +		test_cmp expect err
> > +	)
> > +'
> > +
> > +test_expect_success 'packed-ref without sorted trait should not be checked' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit default &&
> > +		git branch branch-1 &&
> > +		git branch branch-2 &&
> > +		git tag -a annotated-tag-1 -m tag-1 &&
> > +		branch_1_oid=$(git rev-parse branch-1) &&
> > +		branch_2_oid=$(git rev-parse branch-2) &&
> > +		tag_1_oid=$(git rev-parse annotated-tag-1) &&
> > +		tag_1_peeled_oid=$(git rev-parse annotated-tag-1^{}) &&
> > +		refname1="refs/heads/main" &&
> > +		refname2="refs/heads/foo" &&
> > +		refname3="refs/tags/foo" &&
> > +		printf "# pack-refs with: peeled fully-peeled \n"  >.git/packed-refs &&
> > +		printf "%s %s\n" "$branch_2_oid" "$refname1" >>.git/packed-refs &&
> > +		printf "%s %s\n" "$branch_1_oid" "$refname2" >>.git/packed-refs &&
> 
> And here.
> 

Thanks, I will improve this in the next version.

> Patrick
