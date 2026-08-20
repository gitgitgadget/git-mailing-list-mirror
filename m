Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078963F7882
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221454; cv=pass; b=paWBYeDge5P2KSp32bZ9ig8LlM6eLPo3A7DHMO8bfaQLk4YCoCUi4JihaqRS/0v4/PPTJ5EF8tnVcGWnVd2z4e6/VYqEQjMOjeykOIdSQUZe7s8QBqSFID9owZD2fNcDyX1PXSzWmrGgcDXhWu1Vzvphn8+CtfaoUusDoFkqWcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221454; c=relaxed/simple;
	bh=N5dpkQOKRAgbaDkR2B8U4dY3BGNJ3QETKxO/d/I/vYY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VV3hpIu6Lz5M5IizCQCWoh2NjoNknDfm9H95HQ/ppfJccEcJsRsspCUlUObLNOfCApcB5Ef4KA3YKJDOgZFqzuUHR3Qy22uAsIMAWR2BmPfqE7vmkTX97dB7chhkIuTyK6+fe9CXr/ZvaFHNR7Lh1xTpVRdSd2aq12T85LYCJtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW0yv+B2; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW0yv+B2"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c3163a88a1so834620e0c.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 03:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787221452; cv=none;
        d=google.com; s=arc-20260327;
        b=n0lGL/MrYNzkvjSf9P7++NBvZh166XREf3Z/B/4e/3Lh2rP1BSEJtR3vXnm9uh98k5
         4bIuCPmULJiUIcexJdtOYsbIHi7dnKWBXnT5jSie2GvZQU3EEWE5YV9rm0ZSyu6gcNbG
         i/cMZcB0lmjsRqmiTziHTdb80bXILaOH4afBUOy0zkANOzCAUrMi01qoCWYZqHPW0Utw
         KNXEE8ybevS2Hat7cSMNwnhPZxfM62HLEL60jg8kIwuAGTzyEykhm4aXOIP2RduAPKuv
         LaIsH6yN3GUydpofembB105PvA8vrRBpUDbt7eCLHy+uoSg27gcMThAvHl0KbS85Om4g
         8vyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=d9DP88uAd9P05XvxS5muR44EQy5FpKFE8BNP2XruI5k=;
        fh=uV9mUlfxQb47BAxa1CfQ/x0OYDVEwMP3XN2j2e6cr0M=;
        b=Ysk2lPCS5/ZoO381P0+eViQDJHZUK4tDJGCFR9EMAGm44/EYNoaJsTaNqiB6IR84ia
         L2h0T7YMhiXbUlLlt+2XGGS3106J3HAs3O/g37Hah+LC2hULNQ+7rEYMZ72yvc+aTI2D
         iOo/zhhVRcBKtK/bFW2mEmu1Q6AxCQdnU5XcVfZlf8sDNToypzWm/IEZV6R7AXfKAROd
         J/Bm0oKXMYnGkIv15L3dSEdwtnFy0C2uA5yJMObtSDsHfwKFryO23C3Cgz0nXGcy0iAt
         IrWJzpdTMz0zVNUszH6NR9oD5eGpgDtp1zD9mOO8iGSfNKoCKzdTVRZZLjtrOQGmBlRp
         lS4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787221452; x=1787826252; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d9DP88uAd9P05XvxS5muR44EQy5FpKFE8BNP2XruI5k=;
        b=aW0yv+B27AvT3bGhuaNwmfrUvOA61zJliMef40DPymvF+ADmrc2kKgcoeqCuzB6fTH
         SXXWcoIPn5gujMm8L/9cT8lP+5MkGD/zUy7nuNvLYc4oFo4WcrLw8HJ2sZ38MaSFexTE
         LuYux9JD1dPOUkbeVWPpogf+OC1tPPHNwXgWjfzsuehTjOQpsWdByHR8cXiSz8pfnN1B
         BXGD64GTu3T3R9nyw/LUIlK65cCiaxj7AwcidSCJJE6tCH/VMsfzeGW9xKvWrR+7nuTY
         sJnkiHFfWlBLpwN0KscOiHQZJulDi70w0TcD7bSgEOEnS8lhnXj6yXD3fKT+whXViH4h
         DFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787221452; x=1787826252;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d9DP88uAd9P05XvxS5muR44EQy5FpKFE8BNP2XruI5k=;
        b=KnmgZ+xrXXtSa3Dt3v30OAEvNhluN4xl+IS+qnoeb80Xc7fi1jBLQXWq/jWoc8rAVv
         OEr5jNnL/JTwMJZEhlEJh1m9wPfQwHFEdwjSmfbq/tnohPrq/DcJyDxI0bdtRJprUbyn
         PDoIWeqDWXJFgxqfQmKH2aAw2W0CG8yBTbc7X93yAy3TIif44I++OTGkDvQBavZERZeA
         TghNExXx15E6IMnNUANSMk4hsc0nWI2HHlMfh52c1Q8Jvq6WN1gpRDakPMdlkfODpPXv
         TNSxTref273LwPKxubXA2hd60iTC1fpQn+H1CTwOKP6u8MrWeGZdxI47m4LEGGtUUPPF
         CiCQ==
X-Forwarded-Encrypted: i=1; AHgh+RrgtgJk0pjI+WAj+9FfaZhdQu51sfaDIod8ttCqTnsEjmVYhY3vlwCgxYqpvmQWj+MjyeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2krWwroDAOlHKesdSGJ+mYDGd2LUGLIB6tlASVCmBNGrW95a2
	olrNRwQEK+C9j5/8lbbZjOzlndt+ViDD9Ko+ThDAL/0t7qyThh4hXEMNDXyE2IyyTPYsxRdfOGR
	d+SjiLHiPRhiUanMiiGogqoW2cBHTcDA=
X-Gm-Gg: AR+sD10vN330zmDAl8ssjacrPSa+xW7lm3yQpKFSOO4q+7PHlw+3TfhtJzXbIrkLuJL
	rywZtkbfbXUV4mhNqw3IJ6lF4BIJU2hbnpoR91HpVoq4gaggK0Yl/sA47dAZ3ykRAE1yetN9kx5
	hu1BH5nqby/8GPAD9rKKCc3+Gnvz0hXiL4AF3oqkmilQUa8R4juFtsT3hGAcQCuRZ1JlkEmd+sw
	RcPTknJ9A4aq1sUmfvzigNz0W65HjdmcIomC305ZxXegiZViAfoFSl0n7WvSIkB64iikK703TAh
	d/Uax1iPUCXLaWpRd5NztiCtKZFPpGPq1CHGlGvnkeEu2z0RcD+Fiz9lzUE2mexuiLOWOd+Se7Y
	FtD0NlY7bQ+XrM+nBiInB7Tylh8IwS5iSq/9z3tyG2JFTA5w=
X-Received: by 2002:a67:ef03:0:b0:777:ffe0:a0fc with SMTP id
 ada2fe7eead31-777ffe0a5ecmr3143582137.1.1787221451732; Thu, 20 Aug 2026
 03:24:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 06:24:09 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 06:24:09 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260820-b4-pks-odb-generate-pack-v3-2-bc42252f6169@pks.im>
References: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im> <20260820-b4-pks-odb-generate-pack-v3-2-bc42252f6169@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 06:24:09 -0400
X-Gm-Features: AcwNN1XQQCNCej2cWRhnET0Kzp8fWdquX-g9pz18WgWI_QLhouBvtbFHXkA-qk4
Message-ID: <CAOLa=ZQcZ93R6wRyDiQtyATBNfj_6Eu0zXtEx7kbfzihvyP5qg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] upload-pack: generate packfiles via the object database
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000c41f77065977eb99"

--000000000000c41f77065977eb99
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When serving a fetch, git-upload-pack(1) spawns git-pack-objects(1)
> directly to generate the packfile that gets sent to the client. This
> hard-codes the assumption that the object database is able to serve
> packfiles via git-pack-objects(1), which is specific to the "files"
> backend.
>

Naive question, the previous patch says that only the primary odb source
will be used to generate the packfile and we added the implementation
for the files backend.

Does this mean that this will only work if the files backend is the
primary backend?

> Convert git-upload-pack(1) to instead use the pack generation interface
> of the object database.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  upload-pack.c | 125 +++++++++++++++++++++-------------------------------------
>  1 file changed, 45 insertions(+), 80 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index a52856d869..75a857eaa8 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -197,11 +197,11 @@ static void send_client_data(int fd, const char *data, ssize_t sz,
>  	write_or_die(fd, data, sz);
>  }
>
> -static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
> +static int append_one_shallow(const struct commit_graft *graft, void *cb_data)
>  {
> -	FILE *fp = cb_data;
> +	struct oid_array *shallows = cb_data;
>  	if (graft->nr_parent == -1)
> -		fprintf(fp, "--shallow %s\n", oid_to_hex(&graft->oid));
> +		oid_array_append(shallows, &graft->oid);
>  	return 0;
>  }
>

Okay makes sense, we now append to an array

> @@ -299,7 +299,8 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os,
>  static void create_pack_file(struct upload_pack_data *pack_data,
>  			     const struct string_list *uri_protocols)
>  {
> -	struct child_process pack_objects = CHILD_PROCESS_INIT;
> +	struct odb_generate_pack_options opts = ODB_GENERATE_PACK_OPTIONS_INIT;
> +	struct odb_pack_generator *generator;
>  	struct output_state *output_state = xcalloc(1, sizeof(struct output_state));
>  	char progress[128];
>  	char abort_msg[] = "aborting due to possible repository "
> @@ -307,78 +308,42 @@ static void create_pack_file(struct upload_pack_data *pack_data,
>  	uint64_t last_sent_ms = 0;
>  	ssize_t sz;
>  	int i;
> -	FILE *pipe_fd;
> -
> -	if (!pack_data->pack_objects_hook)
> -		pack_objects.git_cmd = 1;
> -	else {
> -		strvec_push(&pack_objects.args, pack_data->pack_objects_hook);
> -		strvec_push(&pack_objects.args, "git");
> -		pack_objects.use_shell = 1;
> -	}
>
>  	if (pack_data->shallow_nr) {
> -		strvec_push(&pack_objects.args, "--shallow-file");
> -		strvec_push(&pack_objects.args, "");
> -	}
> -	strvec_push(&pack_objects.args, "pack-objects");
> -	strvec_push(&pack_objects.args, "--revs");
> -	if (pack_data->use_thin_pack)
> -		strvec_push(&pack_objects.args, "--thin");
> -
> -	strvec_push(&pack_objects.args, "--stdout");
> -	if (pack_data->shallow_nr)
> -		strvec_push(&pack_objects.args, "--shallow");
> -	if (!pack_data->no_progress)
> -		strvec_push(&pack_objects.args, "--progress");
> -	if (pack_data->use_ofs_delta)
> -		strvec_push(&pack_objects.args, "--delta-base-offset");
> -	if (pack_data->use_include_tag)
> -		strvec_push(&pack_objects.args, "--include-tag");
> -	if (repo_has_accepted_promisor_remote(the_repository))
> -		strvec_push(&pack_objects.args, "--missing=allow-promisor");
> -	if (pack_data->filter_options.choice) {
> -		const char *spec =
> -			expand_list_objects_filter_spec(&pack_data->filter_options);
> -		strvec_pushf(&pack_objects.args, "--filter=%s", spec);
> -	}
> -	if (uri_protocols) {
> -		for (i = 0; i < uri_protocols->nr; i++)
> -			strvec_pushf(&pack_objects.args, "--uri-protocol=%s",
> -					 uri_protocols->items[i].string);
> +		for_each_commit_graft(append_one_shallow, &opts.shallows);
> +		opts.shallow = 1;
>  	}
> -
> -	pack_objects.in = -1;
> -	pack_objects.out = -1;
> -	pack_objects.err = -1;
> -	pack_objects.clean_on_exit = 1;
> -
> -	if (start_command(&pack_objects))
> -		die("git upload-pack: unable to fork git-pack-objects");
> -
> -	pipe_fd = xfdopen(pack_objects.in, "w");
> -
> -	if (pack_data->shallow_nr)
> -		for_each_commit_graft(write_one_shallow, pipe_fd);
> -
>  	for (i = 0; i < pack_data->want_obj.nr; i++)
> -		fprintf(pipe_fd, "%s\n",
> -			oid_to_hex(&pack_data->want_obj.objects[i].item->oid));
> -	fprintf(pipe_fd, "--not\n");
> +		oid_array_append(&opts.wants,
> +				 &pack_data->want_obj.objects[i].item->oid);
>  	for (i = 0; i < pack_data->have_obj.nr; i++)
> -		fprintf(pipe_fd, "%s\n",
> -			oid_to_hex(&pack_data->have_obj.objects[i].item->oid));
> +		oid_array_append(&opts.haves,
> +				 &pack_data->have_obj.objects[i].item->oid);
>  	for (i = 0; i < pack_data->extra_edge_obj.nr; i++)
> -		fprintf(pipe_fd, "%s\n",
> -			oid_to_hex(&pack_data->extra_edge_obj.objects[i].item->oid));
> -	fprintf(pipe_fd, "\n");
> -	fflush(pipe_fd);
> -	fclose(pipe_fd);
> -
> -	/* We read from pack_objects.err to capture stderr output for
> -	 * progress bar, and pack_objects.out to capture the pack data.
> -	 */
> +		oid_array_append(&opts.haves,
> +				 &pack_data->extra_edge_obj.objects[i].item->oid);
> +
> +	opts.thin = pack_data->use_thin_pack;
> +	if (!pack_data->no_progress)
> +		opts.progress = ODB_GENERATE_PACK_PROGRESS_STANDARD;
> +	opts.ofs_delta = pack_data->use_ofs_delta;
> +	opts.include_tag = pack_data->use_include_tag;
> +	opts.missing_allow_promisor = repo_has_accepted_promisor_remote(the_repository);
> +	if (pack_data->filter_options.choice)
> +		opts.filter_spec = expand_list_objects_filter_spec(&pack_data->filter_options);
> +	opts.uri_protocols = uri_protocols;
> +	opts.pack_objects_hook = pack_data->pack_objects_hook;
> +	opts.pack_fd = -1;
> +	opts.progress_fd = -1;
> +
> +	if (odb_generate_pack(the_repository->objects, &generator, &opts))
> +		die("git upload-pack: unable to fork git-pack-objects");

Nit: should we still talk about 'forking' here? As far as upload-pack is
considered, it handed over the task to the odb, 'forking' is an internal
implementation detail.

[snip]

rest looks good!

--000000000000c41f77065977eb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9f3924fc0eed1025_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xRzFjWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOXVBQy85MDZnN0lZOTVnVmJWck8xVXVBYWx0RWdjcgpwY3hOM2VsaTJ1
NmUyY1hicG8zdzAxTEZYOXJEWE9wczdSSTFNSmVnQlR3QlRsTnYvaVB2TUIrelljU1V3cE5OClFh
bFBFdXZBL3FLRkNlWkV0UzNjNVpscG96MnJGZmx0Vk01b25VVXEwNDNzWjhmVHZ6OGJTbVpCMFNX
U3JLN3kKaUtiREhUOHN1TEV2Qjh5bW1ONE9jZks5THF2TjFwNWJHR2VtNzJaRENNclR2bXRCM0Ns
di9hNnNaSWpLRFhoSwp1V3pRTTRqVTlKL0ZHQVAza0c3UE5xMEovdStiQjJ3VHlEYi9GRVJ1ZEVZ
MXdIVW1EQko0dk4wOEI4WnkreFNnCnMrRkxOUERvTm96dFhZbDQ2TndXbVpsUVQ2L2RaamNxWms0
S1lNTkYyK1VyRGVSLy9SVk5HREU5VEF0YmFqWXcKY2VHR3I2ZDFZQWJKS0trMTQ5OXVLZnJCTGQz
UGFsUXBMUzdWNmIvcWRCUHFKSi9BRlBYMHZsYU9FOTV2dGxUaApUd29tZHVLWDJHNGxoRmg3d3or
bWV3QlB1WVlQTzd5bmhkT2JtaWhjNjYvRHFSTFNuaThkbXJzY1R1cXlZK3ZyCkp5ektHRkpRNmtW
a0JtaklHOWQ4MmFITVVnbkM5eklqaXdMQ0NqOD0KPUtlRU0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c41f77065977eb99--
