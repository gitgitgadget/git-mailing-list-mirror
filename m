Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CF7222586
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763990606; cv=none; b=FlNi2EARTQmaWsJuC6gB83Nq7m4LyD17RO0cv+L6RtxzRUtcgQNcz0P3iZzx1Nbtfm9Fc7x9d9pE1928l5YA9JhxC7N+RhRKKOlQ0BB+AOZOWARWGuFCXP83EuQvkKdV8s6jWk5s1V6vEYwLstuPnG65T0Bkp6tdOQsDHA61mkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763990606; c=relaxed/simple;
	bh=vLlgODH5KpLd5AVS127qIpHcnH7EPxxBTRoHkJhNjnA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbxhlftQPDvbR3mJPWoco1d3R8xxKyPRMewZLiY6sykewAvdmn3EAknLV0jPQ1kiGWxsg/lqrXNsHwx9P7sLWHEFGy8xhxUbXA8UeI8+WzASnRNKV0boP4cB3XIU4pCkJDDzZjLASuNaavRPrWZRBRnFsULQfliDgGruXcCrOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2kN19WH; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2kN19WH"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-55b0af02ddeso460522e0c.3
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 05:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763990603; x=1764595403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbww/NgD2AE3J/TJqn2vsb/KttOeSME+r4Tx3HIAVgY=;
        b=U2kN19WHi8YJS6j1hNbrsj8rMHe3cFl46h5Yji419K5D7wVVi5o5rwnRAWGYF2UtSY
         DtYSrc8usWz+SymmHCypFE2/OS1mcbkwUFw+rshdjSPtDfqT/TKEycZ5ZMYWelqkGUMD
         ZqAV7lufMlER/uQZntENK0wiX4Gs2GFS4o1AObSO3Na+3Ujm/IM+S+e0sxRl/vaf6Mcb
         vEoGuDeOiHGWqxRu4FdhoKiAnB9w7NJcWibVBJ0hZ5ZYxJrYDKCTrAy2iyUzDnuLBfek
         jvAANGyy5Gr3PSkkpch3ndjUL9Kh10UqW/jTFE5i8SBXikizh93mfuqp3L1J5ATw4jcf
         H5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763990603; x=1764595403;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbww/NgD2AE3J/TJqn2vsb/KttOeSME+r4Tx3HIAVgY=;
        b=AIvualhf72NQ7dUeu0d8YbnvE+PY4PhiEth0oRQAGix1inaSfmSMbH/JbjvdbX3m9g
         mV/629M9EWjV3R5bs5maDHXcVWgBfHtE0ZSA4ySgzQiglgW861ac0kuBj8c5XmIj8E87
         3/hsMfCfBqJcMLZ14P7B9gszSOIdY4UORykjWVlak7L35B51Wd6fB2lQpDwl6TTngN32
         HYsJXYKILtv6YQxxUwZyw5njMHs9AhrQd189r1ptFFMvofulhbJec/choapbIAThv9pW
         7OhlqsouGlr2J65Y+2hWjMulvStH8m7Hwuqoq0ApUqXl1tHJujhSyM/dUv2Y1PZA1UGv
         MkHQ==
X-Gm-Message-State: AOJu0YwK62cWqN7OE4+/9tD1Ovs3mEg836TEUGO35XMqIVTp95DXL/oC
	o7ckpz2TF55KjHu5hJhlnJ0Vwa4mCTuBBXyZbtUEwrwahnpZZctaZH/RvK11uPQv5CK1JILxj41
	qh32S86EkTuha206oe3ryKDCBBzuA4rgaIg==
X-Gm-Gg: ASbGncs+0YY28zAnxaKuOhHukizlhUYFkLtIVRV1sBT5zgnND+0sDX5YKEyN22QS87m
	g47fuM1ddpLUskHjVdPMcLuuxLm0c6EmeFtbFrtYz1LatlwGWSqxhxidYzQin1ecAKjl/vuAllH
	d7lSqt5sbYfM8O+A2CMyMCH34tr8qxbpMvyvd9KB08XEV5qn6Msuhdc5abo3YrPoOtjRLgadxvE
	a9GtSLroZwcV3xt/8asvHtatDASch7F3vKIJH1Spo5CMGF0dH+ka4ffrOX+ANE55hrGCVYOh2i+
	VMzE0Dn+p0huS5FefLezjoHj6E5bJg==
X-Google-Smtp-Source: AGHT+IEYbtlCg+w3QkAkmD5y+p0BaPpRQdmOJdejSrf6e10Jhc/zB4c10yoOAzytH6S1xU7uFjfMys9H8gZHk8PlsUI=
X-Received: by 2002:a05:6122:546:b0:559:6723:628c with SMTP id
 71dfb90a1353d-55b8f02589cmr3019054e0c.16.1763990603359; Mon, 24 Nov 2025
 05:23:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Nov 2025 05:23:21 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Nov 2025 05:23:21 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <3kdv5xzzoci5hmxau2qwhwtkx5rw7752vdb4a2mricrgt5vdqj@oxm7jvcr6ysy>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com> <3kdv5xzzoci5hmxau2qwhwtkx5rw7752vdb4a2mricrgt5vdqj@oxm7jvcr6ysy>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Nov 2025 05:23:21 -0800
X-Gm-Features: AWmQ_bnYeDQaYurIX3nnsDcAAwn_Dw9IovHqoQeJuoMHs0eYKoAgsolzTxkD7r8
Message-ID: <CAOLa=ZS0oTvVK7bYGwOx-RhnfFw-p+ZjChJ5-3C-790qqLqX1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004d10ba06445711dd"

--0000000000004d10ba06445711dd
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 25/11/19 10:48PM, Karthik Nayak wrote:
>> Git allows setting a different object directory via
>> 'GIT_OBJECT_DIRECTORY', but provides no equivalent for references.
>> This asymmetry makes it difficult to test different reference backends
>> or use alternative reference storage locations without modifying the
>> repository structure.
>>
>> Add a new environment variable 'GIT_REF_URI' that specifies both the
>> reference backend and directory path using a URI format:
>>
>>     <ref_backend>://<path>
>
> Ok, we include the reference format as part of the URI here since it is
> possible that the alternative reference store could be using a different
> backend that what the repository is currently configured to use. Makes
> sense.
>
>> When set, this variable is used to obtain the main reference store for
>> all Git commands. The variable is checked in `get_main_ref_store()`
>> when lazily assigning `repo->refs_private`. We cannot initialize this
>> earlier in `repo_set_gitdir()` because the repository's hash algorithm
>> isn't known at that point, and the reftable backend requires this
>> information during initialization.
>>
>> When used with worktrees, the specified directory is treated as the
>> reference directory for all worktree operations.
>>
>> Add a new test file 't1423-ref-backend.sh' to test this environment
>> variable.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  Documentation/git.adoc |   8 ++++
>>  environment.h          |   1 +
>>  refs.c                 |  53 +++++++++++++++++++++++-
>>  t/meson.build          |   1 +
>>  t/t1423-ref-backend.sh | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 171 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git.adoc b/Documentation/git.adoc
>> index ce099e78b8..a1d1078f42 100644
>> --- a/Documentation/git.adoc
>> +++ b/Documentation/git.adoc
>> @@ -584,6 +584,14 @@ double-quotes and respecting backslash escapes. E.g., the value
>>  	repositories will be set to this value. The default is "files".
>>  	See `--ref-format` in linkgit:git-init[1].
>>
>> +`GIT_REF_URI`::
>> +    Specify which reference backend and path to be used, if not specified the
>> +    backend is inferred from the configuration and $GIT_DIR is used as the
>> +    path.
>> ++
>> +Expects the format '<ref_backend>://<path>', where the 'backend' specifies the
>> +reference backend and the 'path' specifies the directory used by the backend.
>
> I think some users may assume that the path to the reference backend
> would be something like ".git/refs" similar to how
> `GIT_OBJECT_DIRECTORY` is usually ".git/objects". It might be worth
> clarifying this in the docs here.
>

Fair enough. I'll amend the commit.

>> +
>>  Git Commits
>>  ~~~~~~~~~~~
>>  `GIT_AUTHOR_NAME`::
>> diff --git a/environment.h b/environment.h
>> index 51898c99cd..9bc380bba4 100644
>> --- a/environment.h
>> +++ b/environment.h
>> @@ -42,6 +42,7 @@
>>  #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
>>  #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
>>  #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
>> +#define GIT_REF_URI_ENVIRONMENT "GIT_REF_URI"
>>
>>  /*
>>   * Environment variable used to propagate the --no-advice global option to the
>> diff --git a/refs.c b/refs.c
>> index 23f46867f2..0922f08c9f 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2186,15 +2186,66 @@ static struct ref_store *get_ref_store_for_dir(struct repository *r,
>>  	return maybe_debug_wrap_ref_store(dir, ref_store);
>>  }
>>
>> +static struct ref_store *get_ref_store_from_uri(struct repository *repo,
>> +						const char *uri)
>> +{
>> +	struct string_list ref_backend_info = STRING_LIST_INIT_DUP;
>> +	enum ref_storage_format format;
>> +	struct ref_store *store = NULL;
>> +	char *format_string;
>> +	char *dir;
>> +
>> +	if (!uri || !uri[0]) {
>> +		error("reference backend uri is empty");
>> +		goto cleanup;
>> +	}
>> +
>> +	if (string_list_split(&ref_backend_info, uri, ":", 2) != 2) {
>> +		error("invalid reference backend uri format '%s'", uri);
>> +		goto cleanup;
>> +	}
>> +
>> +	format_string = ref_backend_info.items[0].string;
>> +	dir = ref_backend_info.items[1].string + 2;
>> +
>> +	if (!dir || !dir[0]) {
>> +		error("invalid path in uri '%s'", uri);
>> +		goto cleanup;
>> +	}
>> +
>> +	format = ref_storage_format_by_name(format_string);
>> +	if (format == REF_STORAGE_FORMAT_UNKNOWN) {
>> +		error("unknown reference backend '%s'", format_string);
>> +		goto cleanup;
>> +	}
>> +
>> +	store = get_ref_store_for_dir(repo, dir, format);
>
> Since we don't update the reference format stored in repo, if we were to
> run:
>
>   $ GIT_REF_URI="reftable://<path> git repo info references.format
>
> it would still report what ever the repository was originally configured
> with. Since only a single reference backend can be used at time, I
> wonder if we should go a bit further and update `r->ref_storage_format`
> to be inline with how the repository reference backend is configured via
> `GIT_REF_URI`.
>

Updating it here won't here won't work, this flow is lazy and only
evaluated when you actually want to deal with references.

Commands like 'git repo info reference.format' will not trigger this
flow and will only read the config. I'm also not sure we should be
modifying it. Because the output of such a command is to note how the
repository is configured. We are not changing that configuration, but
instead we're simply asking the git to use a different backend for when
the env is provided. What do you think?

> -Justin

--0000000000004d10ba06445711dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 11036e0629c4a236_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ra1hFWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2FXQy85QzQrVWxjV3Z4QjdiTVV4OHNHQkJmWDRhVApJQ1F5Rk1ZZ202
dXI0WDBSNDNDS2xranVmMG10S3I1TVgvbElHMTQxVHQ4VzJlS3dZam5FbUthRGk4S2JxQzJJCnJE
cXAyMzBERVkzS1FuUlFmbVJabFJPbkhicmNTR0pmTmpobm9NUTZQdVdqek1IdzV1SDZiS1ZjU2N0
VXcwNnkKZFZNQ0hCclJYN2VySzBaSUlDSytPVUhCVWtOdk1pODVnR1NzSFNuSXQ3ZmZicjRIdnVW
Nktvbm9MdURJRjIxUApvWU5DdFhyaWxhcEtOUzRDNlJSdnNXZVZZWXZDOWNkMnQ1UUliR3BvdnR3
RVRYWW0zQXJNaUd6NTl1MGNvYUhJCnZKUnZoOFVya1NGRC9Ib0dtdjhBQzdTMkNqcGtiTkc4SGtF
YkpoeWk0RjYxSnBEc3NOZTUrUWJzeXMwVTJtazMKOTVGdUp2TjdxSEx4RGRrSFFrSkxIaWx3Q0M1
aVJwajR0c2FVMXhNV2ViMUdVL3psZ1ZoT3g0cGdlMjB1NUVrago3REZxS2N2b1JrMmxqdzdlYTVI
eWxDM1dKRlNGRXYybkg2Sm4zeVBYREhqSHRmb1EzVDRVcmd4MTRHLzdJbXM5CjF3YzB1SDRhUnVC
dEFGYUw5Q0N4QUxpZnYzSEt5N1UrcGtPaVo1OD0KPVRsQy8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004d10ba06445711dd--
