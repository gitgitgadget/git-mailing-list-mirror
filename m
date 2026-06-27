Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6513A59BC
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782566101; cv=pass; b=W0yGxtuhA2Ja0oLcjd8Xu8QNfEF+1XkLeu5lWxOdWd8oex34GDhQtZCk+8kJkUcu91cFTRXfrmq7eBHpKLrSJe4wmK1whq696p6sECWHyMaHI2VnSblFnxAJWbBdaX0xiv/UaB8pKBz4lVujhrK/gpYIznKjLU6JGWyP43R3Cl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782566101; c=relaxed/simple;
	bh=azKz8I1C8mxfgohXt6wNmE5UtlQgGyHovvYTTjGofr8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrCUhJzXeGQfAHB7cEpLgtHRnWwwz7tedlf6a+EpL00Uaxs3lEOO+1fgIGivVsirS33Kx4oS/E3UAC+tTI37X1UFauhQUPH5re87z3pwfH8gTOwKx9GNP0OCocz2HJuvYVjwBvIlOANeLtiL10qr8T1IVb7B3vhyvaYmDEPLidE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwFvy0in; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwFvy0in"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-966801d093aso553970241.2
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 06:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782566098; cv=none;
        d=google.com; s=arc-20260327;
        b=FV0E5mQHL/2lof1QMH3YYJOaq+8vtBMr6o/3T2Kmn8L18dx49hmgrDC7eSa3O4N19D
         nc1WNl9IQH2/SYI2cSrR2tXVOaaEikvB+Oso6g+2JPdZcL2/mFgs1zebdEeQ3gPCo0dx
         99Ji+wrZZ4Viom40WQYYer+Tn9gxdCP4UzgzLH2QyutbbV+6kqMNpP6wUGKwrjrW1SUy
         TPdJFFan4Id4WHsq2c9GkcXNAZd6uzwUq7A0V90qt2mLNF0bQDuy5xYsw4hepcQ1JhkV
         b7+nloaa2C2C0vQ+bqOH2Y3dXfTb/Ek27ZoHshyxkSYHFX3Th1QdKokG5Q+eutMAuR7O
         tFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=u/tCxO/KXWHjlmpBlbmVCBgTSJQdTaq8Tliy1MuHCzI=;
        fh=RVsDsL3CiYhHKzgk6+PesGhKIdehyrToipqBqD4fAdQ=;
        b=OfkT8ZkyckmEKS/2qYqcyj6gsxcKUE1o2Es3fmSdV1ha7dSAdXdLMbPgEaZfsD+cfn
         UCj6uQ2Dt0Kaf4J83MTOi/XDF5q3nf0k/73WUGEEkNnV+rcI942c6gPwZxz6B8v0cQI4
         3o2NsucNP8Cp770WKmhRzNI0OXaXOYEaCKpDNhMpdddVNmn8EbNMZx9EcjVr53NZb03F
         ZNf7+pYRUetTafeeHPbj7rlJlPtF2Y/IvaxwtiL5A+34CUh2kJUnnuVboSWkiBXLJcN9
         KyHZosgGTCSJTG2bVxcXvikH//MxpgX0GpaQKHlX+baWkUHZiCqruFPblBz1MfQn0tIr
         nwVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782566098; x=1783170898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u/tCxO/KXWHjlmpBlbmVCBgTSJQdTaq8Tliy1MuHCzI=;
        b=pwFvy0in+elSQqG55GmL5Nx9Y2Pk7+IXl4fg8xHy81IaGhauZuOQe74qCaqOgtlXps
         zy+aJuncAZqqlLghDYN4QGLv39wjV2aFmONqI3Z3ss4K0QC/S8qtmLRhL8o4Lo52J326
         uf6yid3w4MtpojYq6evjSH3x9x/darmM/eBh/H2KKVYND4Fdw0VtqIrTnxRTGDJqxW75
         BU2SQt4CULgzn/jLAIkU+0PtUNAxGCezmzDj5RgFPV7tVmMsfQgmHF5fmLmbtANANE8R
         4PjyXapVKFE1RvarESH0f2OJRuzzanJAorYjtrIkb199ZPf23ShQZTbAPP479f7QR+Iz
         mDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782566098; x=1783170898;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/tCxO/KXWHjlmpBlbmVCBgTSJQdTaq8Tliy1MuHCzI=;
        b=PPcyetqwohzc8kF3pCyIR+AA0QwwSAwLhwuZkKLRaMm6dqj5G2baSYVpkiH0FNOya4
         Kxm2keXu4xB2V7fU5cdylPwNXObF1wiAQTFywa+48Jnh4nFRnDkYVaTmfvgBRF8H0YED
         wxxiUgzc3vzogU60CrrWeqa9ksd099z8h5NGd0b1Zjpd8xqdC0G2WscJnARHwvdIGO+A
         IUE10uafeejjGHo3ghiFuGPVXghRW0ia18cnDcmZQ89ah6n4g3/ZvBLIzNMc9GSYUtT3
         OnzJ8NitiaJ1ezRZHYuW2m6HEfM+1UqZpOl2Xlj2o0mrrE2t5xGjsxrZjn8xmiN3Y1+U
         ipCw==
X-Forwarded-Encrypted: i=1; AHgh+RqZsN5VsoDufclqTMhCHsJ10D07+8BpyknZ/eZvhYW33GP+uVm/IiFH4LkcU9pCB+tEUH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwX6mbeUjknGdmPxzq/k+GusFMN1lXMXwsY/J9UUxQjLNFEMVC
	rC0lbDi6vhgUGT+qDY281b4uDpX1vkWriRp+uoPlggd436pBMoZQ1GV9veP3fWFbUf4c7sxWyju
	55iRE0zhtc/PCKu9C7KXlI0x1npF8Dxs=
X-Gm-Gg: AfdE7cm2PcdJ2OrKQ1hAecc09G823eijvXC3kLimDPA8XutqfbVMVtSG22UagJavD/Q
	9P31tTppie6gxt80DKqbsWpvE0dGuQ7Vv4LInUuS1UwcCKvNW/Cdz3hruUemWIYQ9GjVUqpqPFl
	606ydlot3SbcrBigrA8XwN1NA4JeENNIre68t2lBG0tttaBXKXk3EF9+HDSPka/itffPYdvp4eE
	/5bETeubDW5LIMs4OkUB6JlRU7kwjKj9tRX+zhaDikfm0A9+z034F/M2g5aBvyJhVEtKX7u27GE
	FP5pvH045ljO7qg4JjbqMhS/ak4MFm6ImTDM/u99+o3ty1WCKT/khmWCVs++/vQ=
X-Received: by 2002:a05:6102:1489:b0:607:5cd7:d7c0 with SMTP id
 ada2fe7eead31-734360a1990mr4936764137.19.1782566098460; Sat, 27 Jun 2026
 06:14:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 27 Jun 2026 08:14:57 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 27 Jun 2026 08:14:57 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260625-ps-eric-work-rebase-v14-11-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com> <20260625-ps-eric-work-rebase-v14-11-09f7ffe21a53@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 27 Jun 2026 08:14:57 -0500
X-Gm-Features: AVVi8Cfh9qpyVdUuJ-Et9NW7VBRA5Br6XH1g7KYTAcNPBbXOixrIaNid-vKHeI4
Message-ID: <CAOLa=ZSCKbwckV-j+DyUqOkDkfYcW5xSCPza562mq+OJtQc7DA@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 11/13] cat-file: add remote-object-info to batch-command
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com, Jonathan Tan <jonathantanmy@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: multipart/mixed; boundary="0000000000001685a706553c03c1"

--0000000000001685a706553c03c1
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

[snip]

> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
> index 86b9181599..aba20eb770 100644
> --- a/Documentation/git-cat-file.adoc
> +++ b/Documentation/git-cat-file.adoc
> @@ -169,6 +169,13 @@ info <object>::
>  	Print object info for object reference `<object>`. This corresponds to the
>  	output of `--batch-check`.
>
> +remote-object-info <remote> <object>...::
> +	Print object info for object references `<object>` at specified
> +	`<remote>` without downloading objects from the remote.
> +	Raise an error when the `object-info` capability is not supported by the remote.
> +	Raise an error when no object references are provided.
> +	This command may be combined with `--buffer`.
> +
>  flush::
>  	Used with `--buffer` to execute all preceding commands that were issued
>  	since the beginning or since the last flush was issued. When `--buffer`
> @@ -312,7 +319,8 @@ newline. The available atoms are:
>  	The full hex representation of the object name.
>
>  `objecttype`::
> -	The type of the object (the same as `cat-file -t` reports).
> +	The type of the object (the same as `cat-file -t` reports). See
> +	`CAVEATS` below. Not supported by `remote-object-info`.
>

Do we have to keep adding 'Not supported by `remote-object-info`' to
each type? Can't we do the inverse and only add 'Supported by
`remote-object-info`' to `objectsize`. This avoid having to add this
line to every new type.

>  If no format is specified, the default format is `%(objectname)
> -%(objecttype) %(objectsize)`.
> +%(objecttype) %(objectsize)`, except for `remote-object-info` commands which use
> +`%(objectname) %(objectsize)` for now because "%(objecttype)" is not supported yet.

Nit: I would drop the 'for now' here, since we don't know when the changes
for 'objecttype' will land.

[snip]

>  enum batch_mode {
>  	BATCH_MODE_CONTENTS,
> @@ -633,6 +649,81 @@ static void batch_one_object(const char *obj_name,
>  	object_context_release(&ctx);
>  }
>
> +static int get_remote_info(struct batch_options *opt,
> +			   int argc,
> +			   const char **argv,
> +			   struct object_info **remote_object_info,
> +			   struct oid_array *object_info_oids)
> +{
> +	int retval = 0;
> +	struct remote *remote = NULL;
> +	struct object_id oid;
> +	struct string_list object_info_options = STRING_LIST_INIT_NODUP;
> +	struct transport *gtransport;
> +
> +	/*
> +	 * Change the format to "%(objectname) %(objectsize)" when

Nit: perhaps prepend a "TODO"

> +	 * remote-object-info command is used. Once we start supporting objecttype
> +	 * the default format should change to DEFAULT_FORMAT.
> +	 */
> +	if (!opt->format)
> +		opt->format = "%(objectname) %(objectsize)";
> +
> +	remote = remote_get(argv[0]);
> +	if (!remote)
> +		die(_("must supply valid remote when using remote-object-info"));
> +
> +	oid_array_clear(object_info_oids);
> +	for (size_t i = 1; i < argc; i++) {
> +		if (get_oid_hex(argv[i], &oid)) {
> +			size_t len = strlen(argv[i]);
> +
> +			if (len < the_hash_algo->hexsz && len >= 4) {
> +				size_t j;
> +				for (j = 0; j < len; j++)
> +					if (!isxdigit(argv[i][j]))
> +						break;
> +				if (j == len)
> +					die(_("remote-object-info does not support "
> +					      "short oids, %d characters required"),
> +					    (int)the_hash_algo->hexsz);
> +			}
> +			die(_("not a valid object name '%s'"), argv[i]);
> +		}
> +		oid_array_append(object_info_oids, &oid);
> +	}
> +
> +	if (!object_info_oids->nr)
> +		die(_("remote-object-info requires objects"));
> +
> +	gtransport = transport_get(remote, NULL);
> +
> +	if (!gtransport->smart_options) {
> +		retval = -1;
> +		goto cleanup;
> +	}
> +
> +	CALLOC_ARRAY(*remote_object_info, object_info_oids->nr);
> +	gtransport->smart_options->object_info = 1;
> +	gtransport->smart_options->object_info_oids = object_info_oids;
> +
> +	/* 'objectsize' is the only option currently supported */
> +	if (!strstr(opt->format, "%(objectsize)"))
> +		die(_("%s is currently not supported with remote-object-info"), opt->format);
> +

Aren't we setting the opt->format ourselves in this function? Why do we
need to check it?

> +	string_list_append(&object_info_options, "size");
> +
> +	if (object_info_options.nr > 0) {
> +		gtransport->smart_options->object_info_options = &object_info_options;
> +		gtransport->smart_options->object_info_data = *remote_object_info;
> +		retval = transport_fetch_refs(gtransport, NULL);
> +	}
> +cleanup:
> +	string_list_clear(&object_info_options, 0);
> +	transport_disconnect(gtransport);
> +	return retval;
> +}
> +
>  struct object_cb_data {
>  	struct batch_options *opt;
>  	struct expand_data *expand;
> @@ -714,6 +805,57 @@ static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
>  		load_mailmap();
>  }
>
> +static void parse_cmd_remote_object_info(struct batch_options *opt,
> +					 const char *line, struct strbuf *output,
> +					 struct expand_data *data)
> +{
> +	int count;
> +	const char **argv;
> +	char *line_to_split;
> +	struct object_info *remote_object_info = NULL;
> +	struct oid_array object_info_oids = OID_ARRAY_INIT;
> +
> +	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
> +		die(_("remote-object-info command too long"));
> +
> +	line_to_split = xstrdup(line);
> +	count = split_cmdline(line_to_split, &argv);
> +	if (count < 0)
> +		die(_("split remote-object-info command"));

We should  be using `split_cmdline_strerror()` here

> +	if (count - 1 > MAX_ALLOWED_OBJ_LIMIT)
> +		die(_("remote-object-info supports at most %d objects"),
> +		    MAX_ALLOWED_OBJ_LIMIT);
> +
> +	if (get_remote_info(opt, count, argv, &remote_object_info,
> +			    &object_info_oids))
> +		goto cleanup;
> +
> +	data->skip_object_info = 1;
> +	for (size_t i = 0; i < object_info_oids.nr; i++) {
> +		data->oid = object_info_oids.oid[i];
> +		if (remote_object_info[i].sizep) {
> +			/*
> +			 * When reaching here, it means remote-object-info can retrieve
> +			 * information from server without downloading them.
> +			 */
> +			data->size = *remote_object_info[i].sizep;
> +			opt->batch_mode = BATCH_MODE_INFO;
> +			batch_object_write(argv[i + 1], output, opt, data, NULL, 0);
> +		} else {
> +			report_object_status(opt, oid_to_hex(&data->oid), &data->oid, "missing");
> +		}
> +	}
> +	data->skip_object_info = 0;
> +
> +cleanup:
> +	for (size_t i = 0; i < object_info_oids.nr; i++)
> +		free_object_info_contents(&remote_object_info[i]);
> +	free(line_to_split);
> +	free(argv);
> +	free(remote_object_info);
> +	oid_array_clear(&object_info_oids);
> +}
> +

[snip]

> diff --git a/t/meson.build b/t/meson.build
> index 3219264fe7..54d21111a3 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -170,6 +170,7 @@ integration_tests = [
>    't1014-read-tree-confusing.sh',
>    't1015-read-index-unmerged.sh',
>    't1016-compatObjectFormat.sh',
> +  't1017-cat-file-remote-object-info.sh',
>    't1020-subdirectory.sh',
>    't1022-read-tree-partial-clone.sh',
>    't1050-large.sh',

[snip]

--0000000000001685a706553c03c1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4b5958953647b7d8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vL3pOQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meC9xREFDWTBubWFtczRWclFFQzhnWHBsSlorYW1McQpkNHpJUFBsd3Av
R1VmdjUzQW93NWU5QlNZSG5GZUJZZ3h4UXUwVlQyNmU5NC9sSHd6MXhseGNNSTBhb0RPeGFtClIw
SUYxWnNJSU1uZlRVblVGbGpqZmFEWTZzVzZMRW9YQ01HLzdPbzg3UERkRkRtbXhWaHcrcFBvNjBs
NVFhNFIKd2VyVFBUMG1kdGV0akRodzRROWplNFRDMWJaV0NDbjltY3BzeW9jRTE0VklqYTllSHdS
TkZWTEw0RWEzMkdJWQp2ZlJTN0doL280bE1Gb1N1S243RDhvUm5lYXlGaXpxSEZmY3hNRXNtMURv
TmFKSkMybTJrZW92ZUFoUS9WYVlDCmpJa1BRUDNwb2VIWDRweFptZ3lKWWNQVE5VN1Ywc0pKS3Jj
NTRYb3QxODdKZk90MmtFS2REWEgxd09XVUdmWW8KNWsrN0p2LytTOGlpMUwzakR6M0QxcjM3UlRt
MFlSUlljQ0RvRTdXWlFNd0M4eVlxbXVPTUErUDZYZW44QjZiVwpvcmlSdGE5N0QwS2Z6QXpVUHlH
ZWtqMmJwVSs0TEZXaE02RkF3OUZjU1ZOS3RQVXl1ZldNenVJTXAwSUhZWEhXCmtTUHNzTDF5LzZY
TlFPOVVNK1NMQjVPSlZBbzF3bTloWXJ5N29RYz0KPTk3R1UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001685a706553c03c1--
