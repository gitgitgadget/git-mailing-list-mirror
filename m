Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EC73D45CF
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154482; cv=pass; b=RkUIEm4fQaeg9ZhlBEjg9/ChRkgGe17ayiCUgV78+n6PAKPkCGKaKLMPPopxuDMSuQDb9djepVmssIBSDG4vFmldX5aUyGXfeRveIRaQR2ysSWDkA5kr6N2okD4uBHmqPyJJeuArPy7IEHJok/ZaJv9d2OVzMQMzl0X3wP9fQuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154482; c=relaxed/simple;
	bh=49EIJiZxkslBJTicdbShz3rnhPqoMU/ixnWyhkKsAEw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R26Ogs8MR21qiZYkpbQdpG297Tl0rg0UOR07URbU7IhSI5YCjBSBwDzl0Hlb9uNEzDra+lc+UwfyBSroc9FevGxcOU/G4BhaOM68hjDfJbXA2jy1LqloDwE7cGeHYSgNKQdQMfJvmjimaPGqo68yGumTUr0WLvFda7WIA0UZt0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qgBNaQyH; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgBNaQyH"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-966e7380109so1297488241.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784154480; cv=none;
        d=google.com; s=arc-20260327;
        b=HFSVYCuomosBi/LQji6ObbGnIdob2oXpB/Um4GoDfV/LU0nIZt09Z90/zAf49NV0wH
         vB7bYXATvmhZNq4CYfj9ukuRp2E0Y/W80rhBanex7vPvZ9i/k2zbIyEg6t3tBkbg659k
         aXmX1eKUnWwxbPFjpaagrsZqWWOeFNV6+NFZnQegJtZZ6kaBjt7nYV5UEP6K8i6azFlG
         8zZNhw2UaQaqxtBt0n+d4ZTSQgrL/QXbqQDpa4r9MYb0cmYa4urSC6Nxa5WXGV8jXW+F
         +oRzeW1BlepRvzwIgP7r1GHDf9g2bAEcr59O1AMNOLphaR1hB6hh5Gl6CPNeHYI9AIB2
         Zfbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=QdXp8urdc7PUcM2Va3sQ4c1a0YdTsopjaSd8o2bSgVA=;
        fh=nvC0uII0/KWCUaxkhkD37M9WHFOdWRdpkNI+FzicL3U=;
        b=fM9fTpgt6Il53RbtPWDmPGkz2e0qEsyr1eEscyFLN8EDGEeyE5hD3sUxhyIf2rMHCc
         gjwCmrPaSODX98rB6IrR38OMIhJR8zkWCzyJTjPff3qvr4ma65fZMqOhe7No/Ee0F46v
         yXGDfh+hThzbCnfTVs0mgGNoZqOI26S8C19ZSi+hPTwyIvlnnIiV35/4Ln8VsI5mJoeF
         leFO/nZxrxp80mXk6YKzNDDWO4gTcLeSnUZokz4Zz/t7f6OCWvbrJl8wm6F+Io6nuu0q
         JgFPdMSxBVQxGwbYOY56j75QkojZZ2p4UbyOPMTXWZcr9bO/I6iRj+YRTsE8m/21b3g2
         KySg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154480; x=1784759280; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QdXp8urdc7PUcM2Va3sQ4c1a0YdTsopjaSd8o2bSgVA=;
        b=qgBNaQyHq77gl/ZJX/QIi4I1gaAIETi1VYiIRBbC3QOzWbjjGNfOTIPdhvqrJX3xjS
         FpJMoOOtNMxSViPwkfB4SHTLEr47H5NxADd+arKwvIXuAZDX4OBRytQKuVg4qolUVceE
         IRwQ66LNF6UKcuugDrYaQ1shgmOhliQu+3ww/3FNhxBUiYvBRKUjKYw6fwPF2pvAFriw
         u93vxtiP67wcA4eTb5KX2rIuLhvyRBUfHwGP+D7XmBwwpOVY9qglHfeo/4QTfQ4Gs8Lu
         WahFKj0v1fa2V090CZWO56y7hElQv078jgvdloi2upeovcoXu8eeh+M41yvmV5EyaJ5L
         69Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154480; x=1784759280;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QdXp8urdc7PUcM2Va3sQ4c1a0YdTsopjaSd8o2bSgVA=;
        b=Un+JSn/rjEMwu69sPEBIkr6Y3UmFE95aCOEgmulgzAj2XEQRDzqnTwGj/jPc5Y5PeD
         eDJkscsxaAAcH7mDkp9AD4cPcn7GtwgKKBY2ZWXLN4c5q8oGRgMy1DQqoXokppp8CwNq
         ktbZGI0rjVhcIhQmpk5Ca0nCgCKhLH4RJl2xPHo4+JW8+UN1A0nMLQiKbS8JsS7UgCAH
         hiYJU2E8A1QFIYzvG8NsMRZy86kabwrel77is3EVrdkoE9PHhr2ndjpuAbXRyGR87oce
         3Hou0GtwC3M4kN7Y5DgybyQ78VUE4vsN6+CImhaHmSkN4t5AXSy/RYhq5IQagPtKwkaA
         X7Og==
X-Forwarded-Encrypted: i=1; AHgh+RoMVGW8fd6BBDA7yc/bqC+RcX5CLQOeQL+1L/3oDworfg99/jcLXWE0uwrCCmOfL31uH7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTGSepUVQu/4JR3WnR5mgo/HNQswsO0kbaIb0VyAAXLdAyCqj9
	jpztO/HHIX6ep/E6CpT44ZCTkNZk0kZ86DGd6pd9AHfBc/ALDtYJL18kocthJzQOT4O4UhflNfe
	cz8u+UUyyIHtnTNq9GHooxFFko3DwcnYTwg==
X-Gm-Gg: AfdE7cmi1O1ztzLD+wNp9QKuCm69cLGPXq69Bp4WTZsMOABkJsZl/rI79ce9PredG8t
	36tIZBW/ie2Rgsu3TLddcD8BpBEZGfIbm3zEkJNXicBBWqmFt7uZssLvu11Emj2IwYfdeyHDajM
	ksx7brxCEKicW0bWK/JxZ2r5lEdA9HQjahc8VIiPlz1CXUXg6pPlm/wDt2pFE2vDxH9PW+vvPG6
	H+8yii+zSgGjUomTuiW9ngFjbvO1xw2LrSXbI2QPPm3hy/SpNJsG+2O+ha5hrItVniVtwhcMwkC
	dDlLJyTJG8TKvoO7oUhIZK4OPjRA6pqPI+Jyi3CUEQe/nhUvBzle
X-Received: by 2002:a05:6102:5e8f:b0:740:127:c81b with SMTP id
 ada2fe7eead31-74533bee3eemr13386962137.7.1784154480132; Wed, 15 Jul 2026
 15:28:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 18:27:58 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 18:27:58 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260715-ps-eric-work-rebase-v18-11-34d7adb051bb@gmail.com>
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com> <20260715-ps-eric-work-rebase-v18-11-34d7adb051bb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jul 2026 18:27:58 -0400
X-Gm-Features: AUfX_mydrw4x27RqrtDCJ3F9AFZfD_G_mXEdlLqZeH8WWR9uAQhFIpC8nu3VSmQ
Message-ID: <CAOLa=ZSzgsxA0ysJ6hMv9OJNVHco0YHmwQWwirD0ZTDJKMSWfQ@mail.gmail.com>
Subject: Re: [PATCH GSoC v18 11/13] cat-file: add remote-object-info to batch-command
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com, Jonathan Tan <jonathantanmy@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: multipart/mixed; boundary="000000000000036da00656add6e7"

--000000000000036da00656add6e7
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
> index 86b9181599..a7fa6674c3 100644
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
> @@ -301,7 +308,8 @@ one per line, and print information based on the command given. With
>  `--batch-command`, the `info` command followed by an object will print
>  information about the object the same way `--batch-check` would, and the
>  `contents` command followed by an object prints contents in the same way
> -`--batch` would.
> +`--batch` would. The `remote-object-info` command followed by a remote and
> +objects IDs prints object info from the remote without downloading the objects.
>
>  You can specify the information shown for each object by using a custom
>  `<format>`. The `<format>` is copied literally to stdout for each
> @@ -324,15 +332,12 @@ newline. The available atoms are:
>  	reports).
>
>  `objectsize:disk`::
> -	The size, in bytes, that the object takes up on disk. See the
> -	note about on-disk sizes in the `CAVEATS` section below.
> +	The size, in bytes, that the object takes up on disk.
>

Why did we remove the second sentence here? Cause the caveat still
exists and holds good.

>  `deltabase`::
>  	If the object is stored as a delta on-disk, this expands to the
>  	full hex representation of the delta base object name.
> -	Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
> -	below.
> -
> +	Otherwise, expands to the null OID (all zeroes).

We also remove the newline here...

>  `rest`::
>  	If this atom is used in the output string, input lines are split
>  	at the first whitespace boundary. All characters before that
> @@ -340,8 +345,14 @@ newline. The available atoms are:
>  	after that first run of whitespace (i.e., the "rest" of the
>  	line) are output in place of the `%(rest)` atom.
>
> +The command `remote-object-info` only supports the `%(objectname)` and
> +`%(objectsize)` placeholders. See `CAVEATS` below for more information.
> +
>  If no format is specified, the default format is `%(objectname)
> -%(objecttype) %(objectsize)`.
> +%(objecttype) %(objectsize)`, except for `remote-object-info` commands which
> +use `%(objectname) %(objectsize)` because "%(objecttype)" is not supported yet.
> +WARNING: When "%(objecttype)" is supported, the default format WILL be unified,
> +so DO NOT RELY on the current default format to stay the same!!!
>
>  If `--batch` is specified, or if `--batch-command` is used with the `contents`
>  command, the object information is followed by the object contents (consisting
> @@ -438,6 +449,10 @@ scripting purposes.
>  CAVEATS
>  -------
>
> +Note that since only `%(objectname)` and `%(objectsize)` are currently
> +supported by the `remote-object-info` command. Using any other placeholder in
> +the format string will raise an error.
> +
>  Note that the sizes of objects on disk are reported accurately, but care
>  should be taken in drawing conclusions about which refs or objects are
>  responsible for disk usage. The size of a packed non-delta object may
> be
>

[snip]


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
> +		die(_("remote-object-info: %s"), split_cmdline_strerror(count));

Nit: Should we provide some context here? Otherwise no point being
marked for translation?

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
>  static void dispatch_calls(struct batch_options *opt,
>  		struct strbuf *output,
>  		struct expand_data *data,
> @@ -748,8 +889,9 @@ static const struct parse_cmd {
>  } commands[] = {
>  	{ "contents", parse_cmd_contents, 1 },
>  	{ "info", parse_cmd_info, 1 },
> -	{ "flush", NULL, 0 },
>  	{ "mailmap", parse_cmd_mailmap, 1 },
> +	{ "remote-object-info", parse_cmd_remote_object_info, 1 },
> +	{ "flush", NULL, 0 },

Why do we move this? we remove the alphabetical ordering by doing s

>  };
>
>  static void batch_objects_command(struct batch_options *opt,
> diff --git a/object-file.c b/object-file.c
> index 6453b1d6fa..07f019a0f6 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1694,3 +1694,13 @@ struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
>
>  	return &transaction->base;
>  }
> +
> +void free_object_info_contents(struct object_info *object_info)
> +{
> +	if (!object_info)
> +		return;
> +	free(object_info->typep);
> +	free(object_info->sizep);
> +	free(object_info->disk_sizep);
> +	free(object_info->delta_base_oid);
> +}

[snip]

--000000000000036da00656add6e7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 11f1cea90527e225_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wWUNXc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1pNQy85aWk2ZXYzaWR6cTNSZHR6QkxCYnRzK2JwWQpZeDlFNHllMlQw
MkkzNExDKzFaTHZDdzJHRW9yZWlLdUhZbkUxTXRLWlkvYU5JT0ZuQm9TT0V1SlgzUTZEc1NZCmh0
MkhNUlN6WHQzUTJwOWovWHd6Z0IxYnBydmJZNkpKTFBwZ0s4WVJFNXR5Y0hJakxwWUtwRGdhc1lH
dnNNd2wKMG9HMU4rZnBjcXNCTnRtRGxLZEgzTjN0c1NROXhnWXQ5UnVqQ05pYmlQRnNOcmw3WFlQ
QlQ4WHFjc1dscDY2NQpWK2tnM2c1TjFTUGVyUXU3UWdXL0NxOWFxbUJZMUhJNDN1YzVVcmp3SVlG
ek1Za21xMWQ2U0ZrVFdCRUJNNmlECnE1aWhyNzJjTDhKU2xFbTJCODNJOXljYXlHeHF5ZXYxVFhs
UDRkR3lqR2pBY2JpZWMwcjd2YmtPNHZNTmNEQUMKajhLNnRWN0wvZGtPZHIycXRkMkJ5TDA1L1Fo
bHZJTzF1dXp3K2NhV3JZOXhuL215SmJOWFRkL2hZd3hvY0lZZgpoYjRLRVo4Z0tMWmhUVmZoR2F0
YW9Tbk41V2ZCMll6Q0lFbG9odVdxdGorUVc2cEZXdWdPUHo2cUxLcGs0OFFICk1wb3JqRjZQeG5o
S2FDZ3oxWWxQbVE5SGVWYmc5RFZlcTdLVUxWaz0KPTFhbGMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000036da00656add6e7--
