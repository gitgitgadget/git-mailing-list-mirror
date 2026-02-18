Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98652342160
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771445610; cv=none; b=g5mT96d6ogRQwVvdNY85omkAf2NL+vi75sQv8GLT970t+3opOf0X8cjhh4zlLG7pQbp05E9rEdAhayyWVzANfqt0e0Sbt3FY6quopdKbDz34oDi4Cxiet+bQQ1PL6TJ4/DIv9givYUQg8ibd921esjoBRwLtbvBs1Q04zNLOyMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771445610; c=relaxed/simple;
	bh=cNKR3lZOujWxZ9h/Ab/qyO9I2RGlAnIVdhpjksQcM/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na9zaH4xn5tpW/BZZzYuVf+ZmLcqvrSRkkZjQeuszox3iKcV6WjSa0b0NnN++TzRdXmiMGQbxJ8Ev2lxbumNcax74PkVY54oLZALjEnceuo+1sCcj4g87vN5WjouQGPaAo/aRKW4sMc46wYZuPVG7Bf/FrRj14CaABH/K7G6a1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzLC1LWa; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzLC1LWa"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-67997ce9e1cso139835eaf.2
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 12:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771445607; x=1772050407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d/CxUKqPsOkvckcwe+5UqUzNjLhwjS2lUP9sJBJ96XY=;
        b=IzLC1LWaINeGmA0gEgI2q7pkjOEOKmmvMnSG+gSFGxX8qi5lAXPhYhdc3bon5bp6A8
         nWj/InoujPzaEfn92fjFMzNq0JfxYUUU0CGexKO4ZC2papUyL1BRGsJYsq2L34krYvHg
         tHmC5OWlV+yr2jfm0hauifHEEm9Lxe5fwum9WvWCdR9H1TWTwn1l+d9Q0kGjO4om3o2G
         HmiPNiUIq8V/r2bXjcZDF6HaGDWV2QkJJJnL3NDELNKwD9fBgywkq4iL+AfN+lDBEqsi
         my/oT53XFgVjV1wAsRa4y0P1W+4WJmNhR6vrLGKtbhg4T8zZkZmZbQ1k5/+P6EHvWRY6
         u28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771445607; x=1772050407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/CxUKqPsOkvckcwe+5UqUzNjLhwjS2lUP9sJBJ96XY=;
        b=lSr4bttklp9BqGSetEA+O7Qh35SHQ1p/eoJzfa5wvY2s+v3NYWhcSyQpV76l9Srcdh
         bsVGq9oqB88bEHre01hnfEbDGoUbMzwAu6Up0CkdRbsHBnwTsIOrS+wBUNUCXaYKrxgu
         kdjjlB2VY5tfg3fXey0dAI3wy4WkrAaimVaJHlWZZfLwEJznwyKXccNEWCrNdaetZpRF
         URfAKIcvJuHNzn4wowptVkpWvqgjO4BmJc/RGl8ICgPHD6B/MVHCHKU91aubkgQVn815
         /SbUo52mHQSt3+FRkLDH2lnlb4CXmlpssRcVKeCQxit2lrM+zX7mTp7f4NpQwmgy761H
         Qnqg==
X-Gm-Message-State: AOJu0Yyn68amtvqmiVoViz34oF4XlA7HOy4d4vZpKVsj6ML+nxZ0J7FE
	fVMthbKZATcOx9xm5l66Uj03iFWD/23TqKRPmMe29D9UGjz3p2xTemcu
X-Gm-Gg: AZuq6aKEeOZPwJHGOYoGtiHlZOmQGhaAuRMSLPK2HsQWGc5/83894MGfEROP9BhcXLW
	O6rHdscIaHK0qIkednacTZojzxDmbEv5XgKrDVB4W/IHO+v1LWFoS9Y1eSRf+wNG4iagthQwSLp
	4uVcVU5onivRRTMENi3DAL3R69pzK0TLA20innL68AggH8Ifk2paKLemyAZc8tPG4myWxL1yTPe
	FzatPkt8SlhOxwTp2eRLLfLrCRjvz9rWFutakfd2wwmy5/jHnC12YMbFeq7LxChrgukzR2ZYTaS
	1a08ehLkY4TgCLpXoYUJWadoozRMKahh8wmqJLDew3lr0a2EyaynrEJghBQB/N4HszC/etSoQ8p
	P9Pbu1Bmh4joczih2/nGMPx+DSe9isnVGf9KoPEWg6ykUqkazO9cDxpFDa4JtygdJ4V4h6/qyMw
	rtzZnzik1iqqxyOruR
X-Received: by 2002:a05:6820:220e:b0:656:9e05:31d4 with SMTP id 006d021491bc7-67858fea7demr8245138eaf.2.1771445607454;
        Wed, 18 Feb 2026 12:13:27 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6779bbee3dcsm10733123eaf.6.2026.02.18.12.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 12:13:27 -0800 (PST)
Date: Wed, 18 Feb 2026 14:13:26 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] builtin/repo: add OID annotations to table output
Message-ID: <aZYb9BBBjlviZsnR@denethor>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260203221758.1164434-4-jltobler@gmail.com>
 <aY8jt_8LoN1LdboG@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY8jt_8LoN1LdboG@pks.im>

On 26/02/13 02:14PM, Patrick Steinhardt wrote:
> On Tue, Feb 03, 2026 at 04:17:56PM -0600, Justin Tobler wrote:
> > diff --git a/builtin/repo.c b/builtin/repo.c
> > index 51a4359685..6fc2d9db12 100644
> > --- a/builtin/repo.c
> > +++ b/builtin/repo.c
> > @@ -272,6 +275,12 @@ static void stats_table_vaddf(struct stats_table *table,
> >  		table->name_col_width = name_width;
> >  	if (!entry)
> >  		return;
> > +	if (entry->oid) {
> > +		entry->index = table->annotations.nr + 1;
> > +		strbuf_addf(&buf, "[%" PRIuMAX "] %s", (uintmax_t)entry->index,
> > +			    oid_to_hex(entry->oid));
> > +		string_list_append(&table->annotations, buf.buf);
> 
> Can't we hand over ownership here to avoid the extra string copy?
> 
>     string_list_append_nodup(&table->rows, strbuf_detach(&buf, NULL));

Good suggestion. Will adapt in the next version.

> > @@ -321,6 +332,27 @@ static void stats_table_size_addf(struct stats_table *table, size_t value,
> >  	va_end(ap);
> >  }
> >  
> > +static void stats_table_object_size_addf(struct stats_table *table,
> > +					 struct object_id *oid, size_t value,
> > +					 const char *format, ...)
> > +{
> > +	struct stats_table_entry *entry;
> > +	va_list ap;
> > +
> > +	CALLOC_ARRAY(entry, 1);
> > +	humanise_bytes(value, &entry->value, &entry->unit, HUMANISE_COMPACT);
> > +
> > +	/*
> > +	 * A NULL OID should not have a table annotation.
> > +	 */
> > +	if (!is_null_oid(oid))
> > +		entry->oid = oid;
> 
> I guess this case could be hit if a certain object type didn't have any
> objects at all?

Yup. An example here would be running this command on an empty
repository.

> > diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> > index 1999f325d0..918af7269f 100755
> > --- a/t/t1901-repo-structure.sh
> > +++ b/t/t1901-repo-structure.sh
> > @@ -89,41 +89,46 @@ test_expect_success SHA1 'repository with references and objects' '
> >  		# git-rev-list(1) --disk-usage=human option printing the full
> >  		# "byte/bytes" unit string instead of just "B".
> >  		cat >expect <<-EOF &&
> > -		| Repository structure | Value      |
> > -		| -------------------- | ---------- |
> > -		| * References         |            |
> > -		|   * Count            |      4     |
> > -		|     * Branches       |      1     |
> > -		|     * Tags           |      1     |
> > -		|     * Remotes        |      1     |
> > -		|     * Others         |      1     |
> > -		|                      |            |
> > -		| * Reachable objects  |            |
> > -		|   * Count            |   3.02 k   |
> > -		|     * Commits        |   1.01 k   |
> > -		|     * Trees          |   1.01 k   |
> > -		|     * Blobs          |   1.01 k   |
> > -		|     * Tags           |      1     |
> > -		|   * Inflated size    |  16.03 MiB |
> > -		|     * Commits        | 217.92 KiB |
> > -		|     * Trees          |  15.81 MiB |
> > -		|     * Blobs          |  11.68 KiB |
> > -		|     * Tags           |    132 B   |
> > -		|   * Disk size        | $(object_type_disk_usage all true) |
> > -		|     * Commits        | $(object_type_disk_usage commit true) |
> > -		|     * Trees          | $(object_type_disk_usage tree true) |
> > -		|     * Blobs          |  $(object_type_disk_usage blob true) |
> > -		|     * Tags           |    $(object_type_disk_usage tag) B   |
> > -		|                      |            |
> > -		| * Largest objects    |            |
> > -		|   * Commits          |            |
> > -		|     * Maximum size   |    223 B   |
> > -		|   * Trees            |            |
> > -		|     * Maximum size   |  32.29 KiB |
> > -		|   * Blobs            |            |
> > -		|     * Maximum size   |     13 B   |
> > -		|   * Tags             |            |
> > -		|     * Maximum size   |    132 B   |
> > +		| Repository structure     | Value      |
> > +		| ------------------------ | ---------- |
> > +		| * References             |            |
> > +		|   * Count                |      4     |
> > +		|     * Branches           |      1     |
> > +		|     * Tags               |      1     |
> > +		|     * Remotes            |      1     |
> > +		|     * Others             |      1     |
> > +		|                          |            |
> > +		| * Reachable objects      |            |
> > +		|   * Count                |   3.02 k   |
> > +		|     * Commits            |   1.01 k   |
> > +		|     * Trees              |   1.01 k   |
> > +		|     * Blobs              |   1.01 k   |
> > +		|     * Tags               |      1     |
> > +		|   * Inflated size        |  16.03 MiB |
> > +		|     * Commits            | 217.92 KiB |
> > +		|     * Trees              |  15.81 MiB |
> > +		|     * Blobs              |  11.68 KiB |
> > +		|     * Tags               |    132 B   |
> > +		|   * Disk size            | $(object_type_disk_usage all true) |
> > +		|     * Commits            | $(object_type_disk_usage commit true) |
> > +		|     * Trees              | $(object_type_disk_usage tree true) |
> > +		|     * Blobs              |  $(object_type_disk_usage blob true) |
> > +		|     * Tags               |    $(object_type_disk_usage tag) B   |
> > +		|                          |            |
> > +		| * Largest objects        |            |
> > +		|   * Commits              |            |
> > +		|     * Maximum size   [1] |    223 B   |
> > +		|   * Trees                |            |
> > +		|     * Maximum size   [2] |  32.29 KiB |
> > +		|   * Blobs                |            |
> > +		|     * Maximum size   [3] |     13 B   |
> > +		|   * Tags                 |            |
> > +		|     * Maximum size   [4] |    132 B   |
> > +
> > +		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
> > +		[2] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
> > +		[3] 97d808e45116bf02103490294d3d46dad7a2ac62
> > +		[4] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
> >  		EOF
> 
> I was briefly wondering whether we can do better here and for example
> output something like this:
> 
> 	| * Largest objects              |            |
> 	|   * Commits                    |            |
> 	|     * Maximum size   [commits] |    223 B   |
> 
> 	[commits] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
> 
> But I think that becomes quite unwieldy as the column's size is extended
> quite a bit, so numbers it probably the better interface.

In later commits we also add more annotations. One example is max commit
size and max commit parents may be diffent commit OIDs. I think numbers
may be the simplest for now.

Thanks,
-Justin
