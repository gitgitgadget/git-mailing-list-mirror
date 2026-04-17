Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49361E1C11
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776385858; cv=none; b=p6t/FiBxfzrqcis2lEfAFllJeKbXTR7nsWIrvyRYugmR0cvCQqRNpXs9All6h29HsM++JQExGhfFvU6uXO0N/KobOhaJQxJgP92ohHIlDjKZLE0znwg+TAdN970MeoDk3EZImsHhHWQiJzV9mhjWgWWTsD+9H+lrPKaptkeTj6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776385858; c=relaxed/simple;
	bh=+qfsrEK6WZIODxMRD0esZomNjEFB6TXU9px/A7ySrv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfFr5k1Cg4k53fJCgPUh020y2Rr4CpSeyDpjEvoviCOcI+oe2G5i24jAAeUgjJCv2CMxDNpal5aqkT1UXSccgIm7JLOBHDp5E82YB0EPHra5rES+L+7XMLAi8Nf9XXWXOatObigVzci1YTSAkUU3z2cJwRJJDA1XKToxAP5Bj40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gft20830; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gft20830"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ad135063so1070375e9.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 17:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776385855; x=1776990655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FKWIkJu70iCsUAky14I7Jm35eluifHVoAxJoELB+OpU=;
        b=Gft20830Iqa8gIGtN+SbAjy8X4OF8Tu9wFdZ+s/h+BH4yBAhlbjzV8nm+54BkQqKUV
         7ZcYXsta8mqeSjjw9tdoMLlpVt8qn+KTEPjecCMCVXPpyYk6iakR2u1L7gnD5Wx0yvkv
         23U5nmdIKYyjM/wP1r1fFzafYwbfFmmKkGyeEoxFpU8dKNWAGeLeS9EeJ68SBYmhtdog
         +zSidM/kJc2lnkxXE7wBHw36t4zpIB+hXl6S/sxnR8Qto0kSfXwAYjmQhtGmsUI5Fc5P
         Y+1l9TUuFcr6k37xfGigd/nzHJJIFDnZ2s7Dj6kmGj9ZrvtcJf+5rYABvhI9/29ZXdVf
         mZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776385855; x=1776990655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKWIkJu70iCsUAky14I7Jm35eluifHVoAxJoELB+OpU=;
        b=cKx0neOakGJjBUlhHGm8rRyK8hdl9y9dCvRPIJsSFujcbovQ5ATaKerOzEcAM9Lxqf
         A6FQubkM1bXpp5JOURXxXvmhTVpV57lcbr9nJ71zAq8vKY41vk6j493PThVo+3ukhpkV
         lDq5rN8+6fWRCYgTtonB6H4su7l8WuOH+sHoGVqHKAQFRyuJRfnsq5nFjkqAFPHGp02c
         nHC4bvWty+JBL0zZh7Q8TuL28deqkUgxBNXHTBYdnSvcCKyYnfp8Hy7WuQlfBr69Iej2
         101DXie9U2uGz1rPSdvb/dYt/iUv1zYWZcVGGS+r30/gTSO4fwqejWTFiLv9TT3ntuwU
         PX2w==
X-Gm-Message-State: AOJu0YwwJneXjdRDWHYEFEkdV0oSuqTyQvtAjkNpmRW4+F1RXJpeQPi0
	z+3Nd2o4xT0PE0CEPFcB0PuYc8SAzxyIjna8cGBzbbTyxrpg9aZaq0Wk
X-Gm-Gg: AeBDievEaUH9m762SwPHWvrI4F0mTROZTemF3ebLqJvSK+XJWU03H9snseWJFUS1F0i
	6K7cW4aFgjuOYiJ4P8fJ/lCkUk8pBQjUovLc7LpZlUKE+wsd+aKDqHdlvrAGhX9JrNi+mqiftjY
	ThCFU2e4SlDxR81HtGTllECNxN8juLsSonwIzT+Yyjjkfjj55d9dxnmfNy4FmvkyO0OMvoCJjwr
	a9BCLVJej1+TiSVRKLaklJ+o3RH1u0QAd14HJBB24nplG9spSHoJA2pwd/16lDqf6KvMBFO7lMU
	mINTAewnR/+l9F4N833YqJleY5MZRaZf0lzHT195Auk1hLnaCUgQXE6H/Z5AqlUt6JAn6fh6FHh
	ZaoOGQLWTT9ajjrhhVdMWRCRlbOxf01sHBqQvWATtB59EoRYub5YRVTkBnmTn83qOOiOgo8xkaP
	EWc1cE7RSyz/CByA9zDe+7Yw8nmlF7Sf7xCzMi11zUMfl1r0vXFa1aqcZtVpIToOoEm6TWvt7Fc
	f7m5+7OylCQuFMVf1g=
X-Received: by 2002:a05:600c:1da1:b0:488:d376:42cd with SMTP id 5b1f17b1804b1-488fb785901mr9747955e9.22.1776385854614;
        Thu, 16 Apr 2026 17:30:54 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb78becdsm6688395e9.5.2026.04.16.17.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 17:30:54 -0700 (PDT)
Date: Fri, 17 Apr 2026 02:30:52 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC PATCH v5 2/6] repack-promisor add helper to fill promisor
 file after repack
Message-ID: <aeF_PL5qYS-7Ogvd@lorenzo-VM>
References: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <3558bb38956b522c91057598db645eb42ffb48b2.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <xmqqo6jolmla.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6jolmla.fsf@gitster.g>

On Sat, Apr 11, 2026 at 11:27:45PM -0700, Junio C Hamano wrote:
> LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:
> 
> > +/*
> > + * Go through all .promisor files contained in repo (excluding those whose name
> > + * appears in not_repacked_basenames, which acts as a ignorelist), and copies
> > + * their content inside the destination file "<packtmp>-<dest_hex>.promisor".
> > + * Each line of a never repacked .promisor file is: "<oid> <ref>" (as described
> > + * in the write_promisor_file() function).
> > + * After a repack, the copied lines will be: "<oid> <ref> <time>", where <time>
> > + * is the time (in Unix time) at which the .promisor file was last modified.
> > + * Only the lines whose <oid> is present inside "<packtmp>-<dest_hex>.idx" will
> > + * be copied.
> > + * The contents of all .promisor files are assumed to be correctly formed.
> > + */
> > +static void copy_promisor_content(struct repository *repo,
> > +					      const char *dest_hex,
> > +					      const char *packtmp,
> > +					      struct strset *not_repacked_basenames)
> > +{
> > +	char *dest_idx_name;
> > +	char *dest_promisor_name;
> > +	FILE *dest;
> > +	struct strset dest_content = STRSET_INIT;
> > +	struct strbuf dest_to_write = STRBUF_INIT;
> > +	struct strbuf source_promisor_name = STRBUF_INIT;
> > +	struct strbuf line = STRBUF_INIT;
> > +	struct object_id dest_oid;
> > +	struct packed_git *dest_pack, *p;
> > +	int err;
> > +
> > +	dest_idx_name = mkpathdup("%s-%s.idx", packtmp, dest_hex);
> > +	get_oid_hex_algop(dest_hex, &dest_oid, repo->hash_algo);
> 
> This needs to prepare for a corrupt input in dest_hex, which would
> result in garbage dest_oid.  The helper function should signal a
> failure with its return value, right?

Ack. I think the best way is to signal a `warning()`, and then simply
exit the helper function leaving the ".promisor" file empty.

> > +	dest_pack = parse_pack_index(repo, dest_oid.hash, dest_idx_name);
> 
> As you earlier mentioned, this use of parse_pack_index() is
> perfectly fine.  The call chains that reach here are both from
> cmd_repack() that calls either repack_promisor_objects() or
> pack_geometry_repack_promisors(), and both ran "pack-objects" to
> create a new pack and called finish_repacking_promisor_objects(),
> which in turn calls us, so the dest_hex/packtmp we are dealing with
> point newly created packfile that is about to become but not yet
> completed as a part of this repository.  We know we created it, and
> we know "pack-objects" did not fail, so parse_pack_index() being
> loose in validation does not pose a practical problem.

Exactly. I couldn't quite explain it as good as you right now. :)

> This still needs to prepare for parse_pack_index() to return NULL,
> though.

Ack.

> In the above two cases, we should make sure that dest_idx_name gets
> freed before we return control to the caller (possibly signaling an
> error by returning -1, but the current caller is not expecting to
> hear a failure from us and that may be OK).

Again, I think this should be treated the same as when `dest_hex` is
garbage.

> > +	/* Open the .promisor dest file, and fill dest_content with its content */
> > +	dest_promisor_name = mkpathdup("%s-%s.promisor", packtmp, dest_hex);
> > +	dest = xfopen(dest_promisor_name, "r+");
> > +	while (strbuf_getline(&line, dest) != EOF)
> > +		strset_add(&dest_content, line.buf);
> > +
> > +	repo_for_each_pack(repo, p) {
> > +		FILE *source;
> > +		struct stat source_stat;
> > +
> > +		if (!p->pack_promisor)
> > +			continue;
> > +
> > +		if (not_repacked_basenames &&
> > +			strset_contains(not_repacked_basenames, pack_basename(p)))
> > +			continue;
> > +
> > +		strbuf_reset(&source_promisor_name);
> > +		strbuf_addstr(&source_promisor_name, p->pack_name);
> > +		strbuf_strip_suffix(&source_promisor_name, ".pack");
> > +		strbuf_addstr(&source_promisor_name, ".promisor");
> > +
> > +		if (stat(source_promisor_name.buf, &source_stat))
> > +			die(_("File not found: %s"), source_promisor_name.buf);
> > +
> > +		source = xfopen(source_promisor_name.buf, "r");
> > +
> > +		while (strbuf_getline(&line, source) != EOF) {
> > +			struct string_list line_sections = STRING_LIST_INIT_DUP;
> > +			struct object_id oid;
> > +
> > +			/* Split line into <oid>, <ref> and <time> (if <time> exists) */
> > +			string_list_split(&line_sections, line.buf, " ", 3);
> 
> The strbuf's contents line.buf[] is read/write, so we could use
> line_sections that is initialized with NODUP and call
> split_in_place() to avoid unnecessary small allocations and
> deallocations, no?

I don't think so, because we still need the complete `line` when we
append the <time> to it (if we do so), and when we print it to the
`dest` file. This means that we can't use `split_in_place()` and
initialize it with `NODUP`, because then we would have the complete
`line`.

> More importantly, we say "split into up to 3 pieces".  What happens
> if this is totally malformed and there is only one word?  Should we
> still trust this line and try to carry it forward?  I doubt it.

I think we should discard the line if it can't be split up into 2 or 3
pieces.

> > +			/* Ignore the lines where <oid> doesn't appear in the dest_pack */
> > +			get_oid_hex_algop(line_sections.items[0].string, &oid, repo->hash_algo);
> 
> Or the first word split is not a sane hexadecimal string that
> get_oid_hex() fails?

Same, we should just discard it.

> It would be the simplest to ignore/skip the line, just like what you
> do to a correctly formated line about an irrelevant <oid> (iow, the
> if() statement immediately below).

Agreed.

> > +			if (!find_pack_entry_one(&oid, dest_pack)) {
> 
> Assuming that the object name was read correctly, if the pack we
> just created does not have the <oid> we read from the existing
> .promisor file, this line we just read has nothing to do with the
> repacked result, so we ignore it, which sounds fine.
> 
> > +				string_list_clear(&line_sections, 0);
> > +				continue;
> > +			}
> > +
> > +			/* If <time> doesn't exist, retrieve it and add it to line */
> > +			if (line_sections.nr < 3)
> > +				strbuf_addf(&line, " %" PRItime, (timestamp_t)source_stat.st_mtime);
> 
> Should we also validate line_sections[1] in some way?  I am not sure
> if we want to call check_ref_format() on it.
>
> If we insist that .nr is at least 2 immediately after we split the
> string, and make sure the line begins with <oid> (i.e., parsable as
> hex object name) that might be sufficient.  I dunno.

I think we should check <ref>. Found some success using:
        `check_refname_format(<ref>, REFNAME_ALLOW_ONELEVEL)`

> > +			/*
> > +			 * Add the finalized line to dest_to_write and dest_content if it
> > +			 * wasn't already present inside dest_content
> > +			 */
> > +			if (strset_add(&dest_content, line.buf)) {
> > +				strbuf_addbuf(&dest_to_write, &line);
> > +				strbuf_addch(&dest_to_write, '\n');
> > +			}
> > +
> > +			string_list_clear(&line_sections, 0);
> > +		}
> > +
> > +		err = ferror(source);
> > +		err |= fclose(source);
> > +		if (err)
> > +			die(_("Could not read '%s' promisor file"), source_promisor_name.buf);
> > +	}
> > +
> > +	/* If dest_to_write is not empty, then there are new lines to append */
> > +	if (dest_to_write.len) {
> > +		if (fseek(dest, 0L, SEEK_END))
> > +			die_errno(_("fseek failed"));
> > +		fprintf(dest, "%s", dest_to_write.buf);
> > +	}
> > +
> > +	err = ferror(dest);
> > +	err |= fclose(dest);
> > +	if (err)
> > +		die(_("Could not write '%s' promisor file"), dest_promisor_name);
> > +
> > +	close_pack_index(dest_pack);
> 
> As we discussed, 
> 
> 	free(dest_pack);
> 
> is missing.

Ack.

> > +	free(dest_idx_name);
> > +	free(dest_promisor_name);
> > +	strset_clear(&dest_content);
> > +	strbuf_release(&dest_to_write);
> > +	strbuf_release(&source_promisor_name);
> > +	strbuf_release(&line);
> > +}
> > +
> >  static void finish_repacking_promisor_objects(struct repository *repo,
> >  					      struct child_process *cmd,
> >  					      struct string_list *names,
