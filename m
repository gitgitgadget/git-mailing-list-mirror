Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4523B205142
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205962; cv=none; b=ajEDRxfiJ+5M+fYODXKfIf0qJQGLXqxTYoHq6VG0R1oThKFEw3KXoI3Dy4Pjnvym/oqgKCdN4KSBdOxz9c4RgUp9W109GUfsYebxX8yFewFkJFWx3/mN9CX9QSJHgibk4f/Glhfxxsc+HX3QmB8vWa3QYQDpXGnzhmUKk3NkIhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205962; c=relaxed/simple;
	bh=OpZazVnQdpYJgtn4vOh7687RAMT4dZl+cE9PAxcEvII=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTwsHvjarX1FZQsjDJc/L3Tf2D6a7jwuebP54oOyjPRAf5603QhDSrRm/55lmxDQ45+LMEqJ+tGImbsUzPVInXwY/mUQx2uW5V2uvWLT+oqKupqBsZaxO8SGPcYT75wXM9QM7rwu5ciEsnIe8XR8m5myAzQfY7lGD7yZRLZDza0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+kwsjmQ; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+kwsjmQ"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4a487a7519fso1807011137.0
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730205959; x=1730810759; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8OiLw+ebFX8JrJtm0iz4jYt7MZxu11Bd+Brc7cziZo=;
        b=b+kwsjmQFYhpRangJQJm5i/pTu0FnjCZPuJmCrsEz2IsmQ84kS8ZBRa8n8sXgUJYXm
         NLOe2wp6gCVdahhYo9NIo3K6MTKXkqL/9TQKvFS9leEye8HbJqtlH6YTDdbBFhzFhlxK
         CW6Dgj8PUeN7jAO/zZA7FoM/ud5FvlfwX4uuQBsNIlA3ISWLqeJ1nDFXaeJEiOirWa2N
         hVUmGpJx1J8PkrkGB08xCxjq8yhnY0DL/zTfAgZVgLB3D6bnAvNhWziJ3Q4vUoeIisGC
         j/B04g8ie2sqiu/1cVEBtE4/8BGqW5A6JmhvFwwnrfJgiTfsc9n8iw9rfcTjK+lPWZHc
         3yFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730205959; x=1730810759;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8OiLw+ebFX8JrJtm0iz4jYt7MZxu11Bd+Brc7cziZo=;
        b=gsl9wPRcGy2RH4PFAIQKk1SOrVfkK1iouWb8yevx4JVDCwBcarTbPAqOb1bujlO7dh
         x6Fx0dPljkTvrenau7b5+6VkzMhy1IY/xAq6EWm/VQzMCIH2fywQb3FI0C8nx5zgvJOv
         UXqgrIR864CelRDIjl3H59t63Hlha+uzFwTfcOhiNa+7qaxwIvphvWDtP6kdX7Fpq5ZP
         NvBta6L382hUQrFLGquNAA+k1zbgjWsqt1caB2+ic+smilSL0f0IjLGAvk3Mu9FPTyFj
         jpoExnXLYmdCBtCc2JTyGHn03gI86cQgbYDid1U1ao0kh6OwsbzWacEdSRoholyL/0/Q
         n/ww==
X-Gm-Message-State: AOJu0YzgjtP9+C7W/mEEPbWnoYy/TdsaAAZL5xXtsDbpZDi7FiqVUzWy
	5EnfLNesa6UU67rcOEBS9rNd/CbrS839owctwxA/nR77vmgh/4QbR0TDK37Tu3my14IXyxAgSSg
	BUJNI1iuo4X350Ydg9hQIISFV/n2q4TuB
X-Google-Smtp-Source: AGHT+IEMybCRTyY/5Aopb8O7JydXInUMXJGOzQaI+xS3lTF76JGMlzAhatG5BDeOoZBhbyAJZjbyf3jFmjBkJve2OQ0=
X-Received: by 2002:a05:6102:f13:b0:4a3:e1de:4fb3 with SMTP id
 ada2fe7eead31-4a8cfd50421mr9577811137.26.1730205958971; Tue, 29 Oct 2024
 05:45:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Oct 2024 05:45:57 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241029055039.GA2886077@coredump.intra.peff.net>
References: <cover.1730122499.git.karthik.188@gmail.com> <73ba9945a7b7ec69e4ea29116c473b88e5c2a916.1730122499.git.karthik.188@gmail.com>
 <20241029055039.GA2886077@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Oct 2024 05:45:57 -0700
Message-ID: <CAOLa=ZS_75M+1ujTfW3MpV8km+G8sFB3Rn6p7zEXnK9qVycg=A@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] packfile: pass down repository to `odb_pack_name`
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, me@ttaylorr.com
Content-Type: multipart/mixed; boundary="00000000000092c93806259cf7ef"

--00000000000092c93806259cf7ef
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Mon, Oct 28, 2024 at 02:43:42PM +0100, Karthik Nayak wrote:
>
>> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
>> index ffee7d3abd..f4892d7f37 100644
>> --- a/builtin/fast-import.c
>> +++ b/builtin/fast-import.c
>> @@ -806,7 +806,7 @@ static char *keep_pack(const char *curr_index_name)
>>  	struct strbuf name = STRBUF_INIT;
>>  	int keep_fd;
>>
>> -	odb_pack_name(&name, pack_data->hash, "keep");
>> +	odb_pack_name(the_repository, &name, pack_data->hash, "keep");
>
> Why not pack_data->repo here? It's always going to be set to
> the_repository in this program, but I think minimizing the number of
> references to it still has value.
>

I tried to swap out 'the_repository' with local variables in most places
I could. Here, I totally missed 'pack_data', although it was right
there. Thanks will swap out.

>> @@ -814,11 +814,11 @@ static char *keep_pack(const char *curr_index_name)
>>  	if (close(keep_fd))
>>  		die_errno("failed to write keep file");
>>
>> -	odb_pack_name(&name, pack_data->hash, "pack");
>> +	odb_pack_name(the_repository, &name, pack_data->hash, "pack");
>>  	if (finalize_object_file(pack_data->pack_name, name.buf))
>>  		die("cannot store pack file");
>>
>> -	odb_pack_name(&name, pack_data->hash, "idx");
>> +	odb_pack_name(the_repository, &name, pack_data->hash, "idx");
>
> Likewise in both of these spots.
>
>>  	if (finalize_object_file(curr_index_name, name.buf))
>>  		die("cannot store index file");
>>  	free((void *)curr_index_name);
>> @@ -832,7 +832,7 @@ static void unkeep_all_packs(void)
>>
>>  	for (k = 0; k < pack_id; k++) {
>>  		struct packed_git *p = all_packs[k];
>> -		odb_pack_name(&name, p->hash, "keep");
>> +		odb_pack_name(p->repo, &name, p->hash, "keep");
>
> This one does use p->repo. Good.
>
>> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
>> index be2f99625e..eaefb41761 100644
>> --- a/builtin/index-pack.c
>> +++ b/builtin/index-pack.c
>> @@ -1479,7 +1479,7 @@ static void write_special_file(const char *suffix, const char *msg,
>>  	if (pack_name)
>>  		filename = derive_filename(pack_name, "pack", suffix, &name_buf);
>>  	else
>> -		filename = odb_pack_name(&name_buf, hash, suffix);
>> +		filename = odb_pack_name(the_repository, &name_buf, hash, suffix);
>>
>>  	fd = odb_pack_keep(filename);
>>  	if (fd < 0) {
>> @@ -1507,7 +1507,7 @@ static void rename_tmp_packfile(const char **final_name,
>>  {
>>  	if (!*final_name || strcmp(*final_name, curr_name)) {
>>  		if (!*final_name)
>> -			*final_name = odb_pack_name(name, hash, ext);
>> +			*final_name = odb_pack_name(the_repository, name, hash, ext);
>
> These two don't have a packed_git, so they use their own repo. Makes
> sense.
>
>> -int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED) {
>> +int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo) {
>>  	int i; int i_still_use_this = 0; struct pack_list *min = NULL, *red, *pl;
>>  	struct llist *ignore;
>>  	struct strbuf idx_name = STRBUF_INIT;
>> @@ -690,7 +690,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
>>  	pl = red = pack_list_difference(local_packs, min);
>>  	while (pl) {
>>  		printf("%s\n%s\n",
>> -		       odb_pack_name(&idx_name, pl->pack->hash, "idx"),
>> +		       odb_pack_name(repo, &idx_name, pl->pack->hash, "idx"),
>>  		       pl->pack->pack_name);
>>  		pl = pl->next;
>>  	}
>
> This one is using the "repo" variable passed to the main function. That
> seems a little sketchy to me philosophically, though, because these
> packs all came from a call to get_all_packs(the_repository). I think
> the two will always be the same, but it feels like we should be using
> pl->pack->repo here for consistency.
>

Yeah, this seems more appropriate indeed. I will swap out.

>> diff --git a/http.c b/http.c
>> index 7e5be05207..50d8811cea 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -2579,7 +2579,7 @@ struct http_pack_request *new_direct_http_pack_request(
>>
>>  	preq->url = url;
>>
>> -	odb_pack_name(&preq->tmpfile, packed_git_hash, "pack");
>> +	odb_pack_name(the_repository, &preq->tmpfile, packed_git_hash, "pack");
>>  	strbuf_addstr(&preq->tmpfile, ".temp");
>>  	preq->packfile = fopen(preq->tmpfile.buf, "a");
>>  	if (!preq->packfile) {
>
> This one really ought to be using the packed_git we set up for the
> matching idx file, but we won't have passed it through. And it's not
> worth heavy refactoring just to get access to it, IMHO.
>
>
> Earlier I mentioned that another helper could simplify many of these
> sites a little. What I meant was this (on top of what's in your series):
>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 9056447bd0..976cb1d77b 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -806,19 +806,19 @@ static char *keep_pack(const char *curr_index_name)
>  	struct strbuf name = STRBUF_INIT;
>  	int keep_fd;
>
> -	odb_pack_name(the_repository, &name, pack_data->hash, "keep");
> +	pack_hashfile(pack_data, &name, "keep");
>  	keep_fd = odb_pack_keep(name.buf);
>  	if (keep_fd < 0)
>  		die_errno("cannot create keep file");
>  	write_or_die(keep_fd, keep_msg, strlen(keep_msg));
>  	if (close(keep_fd))
>  		die_errno("failed to write keep file");
>
> -	odb_pack_name(the_repository, &name, pack_data->hash, "pack");
> +	pack_hashfile(pack_data, &name, "pack");
>  	if (finalize_object_file(pack_data->pack_name, name.buf))
>  		die("cannot store pack file");
>
> -	odb_pack_name(the_repository, &name, pack_data->hash, "idx");
> +	pack_hashfile(pack_data, &name, "idx");
>  	if (finalize_object_file(curr_index_name, name.buf))
>  		die("cannot store index file");
>  	free((void *)curr_index_name);
> @@ -832,7 +832,7 @@ static void unkeep_all_packs(void)
>
>  	for (k = 0; k < pack_id; k++) {
>  		struct packed_git *p = all_packs[k];
> -		odb_pack_name(p->repo, &name, p->hash, "keep");
> +		pack_hashfile(p, &name, "keep");
>  		unlink_or_warn(name.buf);
>  	}
>  	strbuf_release(&name);
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> index 7d6c47ffd9..d3b5e7e112 100644
> --- a/builtin/pack-redundant.c
> +++ b/builtin/pack-redundant.c
> @@ -690,7 +690,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
>  	pl = red = pack_list_difference(local_packs, min);
>  	while (pl) {
>  		printf("%s\n%s\n",
> -		       odb_pack_name(repo, &idx_name, pl->pack->hash, "idx"),
> +		       pack_hashfile(pl->pack, &idx_name, "idx"),
>  		       pl->pack->pack_name);
>  		pl = pl->next;
> G 	}
> diff --git a/packfile.c b/packfile.c
> index cfbfcdc2b8..d81a62eb84 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -46,6 +46,11 @@ char *odb_pack_name(struct repository *repo, struct strbuf *buf,
>  	return buf->buf;
>  }
>
> +char *pack_hashfile(struct packed_git *p, struct strbuf *out, const char *ext)
> +{
> +	return odb_pack_name(p->repo, out, p->hash, ext);
> +}
> +
>  static unsigned int pack_used_ctr;
>  static unsigned int pack_mmap_calls;
>  static unsigned int peak_pack_open_windows;
> diff --git a/packfile.h b/packfile.h
> index 3409aef35d..43c19d7bba 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -32,6 +32,9 @@ struct pack_entry {
>  char *odb_pack_name(struct repository *repo, struct strbuf *buf,
>  		    const unsigned char *hash, const char *ext);
>
> +/* Like odb_pack_name(), but pull repo and hash from existing packed_git. */
> +char *pack_hashfile(struct packed_git *p, struct strbuf *out, const char *ext);
> +
>  /*
>   * Return the basename of the packfile, omitting any containing directory
>   * (e.g., "pack-1234abcd[...].pack").
>
>
> While coming up with the name, though, I had some second thoughts. The
> interface implies that its the way you should derive a pack-related
> filename from a packed_git. But it really is mis-designed for that
> purpose! The packed_git struct has "foo.pack" or similar in its
> pack_name field, and the correct way to derive the .idx, .bitmap, .keep,
> etc, is by string substitution. While we do tend to name packs
> pack-$hash.pack, most of the code will happily work on
> "some-arbitrary-name.pack". And that's why we have so few
> odb_pack_name() calls in the first place.
>
> IMHO the ones in fast-import should probably be doing that suffix
> replacement instead (and probably we should have a decent helper to
> facilitate that; you can grep for strip_suffix.*pack to see places that
> could potentially use it).
>
> All that said, I don't think it's worth derailing your series to deal
> with that cleanup. That can come later if we want. And if we do that,
> then the pack_hashfile() I suggested above would have no callers,
> because it's the wrong approach.

Thanks for the detailed explanation. Maybe we should mark this as
#leftoverbits for a future cleanup.

>
> I do think it's probably worth changing your series to use the
> packed_git repo pointers we already have available, though (i.e., the
> cases I pointed out inline above).
>

Yes, this I've incorporated into the next version. Thanks.

> -Peff

--00000000000092c93806259cf7ef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d19ec8baa2d3d431_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jZzJQOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2lyQy85VTI5dXU5cXFwR3RqREhPV25UeUt1Nm9BaQp6R3hqaGlWWUJM
eXN0bm82eWd4Z1F5QUJiU1ExdjJpVGRXNDRoSmFjdG5EL1dSMTlPTnJSSkx5U002RHBkVG1LCnRM
K2kySnBYekMyaWdUSFFIYkE5ZHRTOWRmT3VySjFENHJSMFp6c2ZCY1FvdmR4cmFoQW5SbGRlcDRP
Z01JTC8KSXpiSUxJNzFRQVNrQmJ6OWtVa1NIa3FpUUwwVGdnRDRKZDROQU1qU2VkQm16bW5SVTZK
aXlhVUpsbXZWRSs5MgpEUDVYb01nbE5QUlB2enlnbmJaUU53NVFxVTBqeVkzeWJtM2hyVkRIOTJ3
bytoL3k1aWtoa3hkTUV3MXF3UkcrCmRlZ2FJVmJvWHVjbE93WTFTWldCMEtJL1BhSXpCV0hodEZz
d3BZeGVVOEZ3b2lSWitSL2YxZkVwSW8vWkFsMXQKdUlyemFqeXpzMmswK0VkVjdocS9VdjA4VEs2
MVhzZHpKcXYzOW9sMHNIZzlpOUZOOU13L0VpT1hNaFBkUU02MApqWGNPM1lxZDJBL3ZzUHZTVUVP
RUVreTkrWkF2Q05LRDE0R09BT0t6ajM0dElnNldxditoa1hESFpxSTlRRjh0Cmt1UEMwU0NEeFZj
emg3NHBleXRtbXltQTNQRDZleHVQaE5sN091cz0KPUxEWXoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000092c93806259cf7ef--
