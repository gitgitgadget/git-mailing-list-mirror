Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDFC2DCBFC
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776638199; cv=none; b=Ra8f+0lg4YbDC9BTiKQcerAwP8rPB51TK60vqr889sLEUWeDcN/VouJ0aTmskVu5UU8jp6X9btPHQ6coPEIAK482ugjrmeEeuSwTH0voSU1LItaJYSyvE+nMy+CU9nOYllvO+8eMo1m1eKcr1c55wOqSaEzwNmTwRnPKhV8FS8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776638199; c=relaxed/simple;
	bh=Wng+OVYzh0ei1+RMrJwjD10lwH6hZELelnwcaIJEDWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUBh/H21wlPVJt+G4ZglGSsYGKx+IOzPtPBRaxq+48zVhRO12NQU0l31t8Hxn2AWV0XReoU6hEmwH1OD9T2FOSM344sqR35hOHEDfXMxhjRnY6xpU3nxp5guwejGEEjBKjAZBo8ksaA3J/20J6q589kVo2+2b1Nw0wU2gjIgm3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MehELUFT; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MehELUFT"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89f87257904so21289176d6.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2026 15:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776638197; x=1777242997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JdRqsvo7esrcpXtvM8kcvqPpRtN10o52c0DJJUtYkkA=;
        b=MehELUFTyE2Ao7Av9v8BYF77LVCLctxR/uvdDUVV6G7t+I04depPIWFWCWRPeJ9N8Z
         /YYtX3nvbJnjOMRq4S/Fm+vyv9tABlCPaM97AT3F6xYHI9TTNsNfeLNgEbjFYrox9ySm
         Wy8MlXmj//dHUc2bq1zX12kCpv3psywnPXl0wrarsduvujD8KwqSafVvufnkzjWbjUge
         4lM+9OMj1ZFjgL2XCMy/fXjhTECXaSRl46ReXhnqVXMHeUNXgwrhUtCF2XNlNANHODQa
         2ehgoM4iNJR93/djb+hvsMFCu2lyx9jMUJsPgjgEBZRXmpufEh1y9KBEAoHmShnfznDj
         yHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776638197; x=1777242997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdRqsvo7esrcpXtvM8kcvqPpRtN10o52c0DJJUtYkkA=;
        b=SaPRceXw0M46QVKGr3tdu4PcwiIhjoognujlNcUlxDukNYLXdfdtRsTAKv6yN0fq+i
         1ArxF7qK3zBlFM50Q2J0ujVftIeJZsLDvBWuF8dS1qTBv2LG7JU2cjGwwqdSW+VkAbHc
         Y8Is5lGp2Ell48zNCn8QWVItX3bETNC6GbuueWDnmhM6f1jO5ER4+ec+99iBm9GxbTGM
         M3DrDI/S/Iwk9NGnubWcyQEMVUlZypPjTLRhvW1BYoSRGFYcsKUFaqlAjdkSTlx2DKg0
         J2nkIrMlkac7xXWPwQFo78wfkZjRIJZyri/vTzKx8G0rV874IHv1S+vwi9Pt3YqSi0o+
         8kzQ==
X-Forwarded-Encrypted: i=1; AFNElJ81s9AtGaQhI2qBRC5D+yO2ZIj2w5HUcsUMLXVHB2H+5ta4qaPF44orO1Q80km4FsUbTPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSyiwOKMjYFWxDBWeXZKOu/X0grXrqHD5rBwt48VCfV+sVjOzG
	HdIkfYKLktLfP0u9MO3UCSCPVVXqsv6Vr91Dtap90Kt8Rp9Sxx1cnOb6
X-Gm-Gg: AeBDiesIbqTk/jpvhs+oC4nmO3WEgBaujHUMAohZyrxOR6BWGPpMtBjIyRflXvHfRyv
	3fCm1SV+po9Pj69dcu6LJkKZsWZPwLyLa4JkyIRrCAmduFAf6UsrDcNy/08GK0qloH+LLBGkIae
	JSfmsunFQyTTTaELy8bqYJ87PvG2qro182YGuuGahA+5HTQZhQ8yYxy+6JHoz1ZtvtgrtwL6FVJ
	VuGZywCM+x2VeqDXPkeP0arBWH8ji3cH/TqfL8DPtaB6o5w2Yg8BVO5A8IpKe4pO3+wIuF4KRws
	bSOJ9ntEs7FEZIak4pLI8LZ7wgkR8KBLGMjMLJn5AbpbDQgiYNSYo2T6itcp2PTINHNSFB91r/p
	gj6d/+Vc+AlyxMdo3wlTE2rN5MCv9fF/0t0qbDenOduBQ8aHLWXxIkGQ0unBGPVANbwArV5ke+5
	lJl1oD8LTgAcdYhukaQuLcCMRu9tWFdZv1GrvEMk2WmvaU+53wFyu52yAC/t1VykLciq735LJ9E
	FPKiAdYLNjQXZ9B1aP9NIXhFRCwCZovUG6enKZ5DMvE+ohXxBqKwogj
X-Received: by 2002:a05:6214:27e7:b0:8ac:ae66:8eb9 with SMTP id 6a1803df08f44-8b028132d90mr177876916d6.46.1776638197263;
        Sun, 19 Apr 2026 15:36:37 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:84d:e5ce:d94:dc76? ([2605:a601:9b88:8300:84d:e5ce:d94:dc76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02e035b0asm56136736d6.22.2026.04.19.15.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 15:36:36 -0700 (PDT)
Message-ID: <4c9fee0b-99bb-4e41-9227-f09c63df9f9d@gmail.com>
Date: Sun, 19 Apr 2026 18:36:36 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] rev-list: add --missing=print-only mode
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: chriscool@tuxfamily.org, toon@iotcl.com, ps@pks.im,
 karthik.188@gmail.com, justin@parity.io
References: <20260419084840.33986-1-siddharthasthana31@gmail.com>
 <20260419084840.33986-2-siddharthasthana31@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260419084840.33986-2-siddharthasthana31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/19/26 4:48 AM, Siddharth Asthana wrote:
> When working with partial clones, it's common to want just the list of
> missing objects. The current --missing=print mode does this but mixes
> present and missing objects together, with missing ones prefixed by '?'.
> Getting only the missing OIDs requires an extra pipe:
> 
>    git rev-list --objects --all --missing=print | perl -ne 'print if s/^[?]//'
> 
> Add --missing=print-only which outputs only the missing object OIDs, one
> per line, without any prefix. This makes the above one-liner unnecessary
> and the output directly usable by downstream tools.

I'm a fan of this mode. It saves time dealing with the I/O.

>   static struct oidmap missing_objects;
>   enum missing_action {
> -	MA_ERROR = 0,    /* fail if any missing objects are encountered */
> -	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
> -	MA_PRINT,        /* print ALL missing objects in special section */
> -	MA_PRINT_INFO,   /* same as MA_PRINT but also prints missing object info */
> +	MA_ERROR = 0, /* fail if any missing objects are encountered */
> +	MA_ALLOW_ANY, /* silently allow ALL missing objects */
> +	MA_PRINT, /* print ALL missing objects in special section */
> +	MA_PRINT_INFO, /* same as MA_PRINT but also prints missing object info */
> +	MA_PRINT_ONLY, /* print ONLY missing objects, without the "?" prefix */
>   	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */

I'm not a fan of this adjustment of spacing on the comments,
though I do see that MA_ALLOW_PROMISOR had already broken the
pattern. MA_PRINT_ONLY would still work with the earlier
comment alignment, though.

> -	if (line_term)
> +	if (arg_missing_action == MA_PRINT_ONLY) {
> +		printf("%s", oid_to_hex(&entry->entry.oid));
> +		putchar(line_term);

Is there a reason you didn't use a printf("%s%c") here to
put the oid and line_term together?

> +		return;
> +	} else if (line_term) {
>   		printf("?%s", oid_to_hex(&entry->entry.oid));
> -	else
> +	} else {
>   		printf("%s%cmissing=yes", oid_to_hex(&entry->entry.oid),
>   		       info_term);
> +	}



>   	if (!print_missing_info) {
>   		putchar(line_term);
> @@ -209,6 +222,7 @@ static inline void finish_object__ma(struct object *obj, const char *name)
>   
>   	case MA_PRINT:
>   	case MA_PRINT_INFO:
> +	case MA_PRINT_ONLY:
>   		add_missing_object_entry(&obj->oid, name, obj->type);
>   		return;
>   
> @@ -246,6 +260,11 @@ static void show_commit(struct commit *commit, void *data)
>   		return;
>   	}
>   
> +	if (arg_missing_action == MA_PRINT_ONLY) {
> +		finish_commit(commit);
> +		return;
> +	}
> +
>   	if (show_disk_usage)
>   		total_disk_usage += get_object_disk_usage(&commit->object);
>   
> @@ -384,6 +403,8 @@ static void show_object(struct object *obj, const char *name, void *cb_data)
>   	if (finish_object(obj, name, cb_data))
>   		return;
>   	display_progress(progress, ++progress_counter);
> +	if (arg_missing_action == MA_PRINT_ONLY)
> +		return;
>   	if (show_disk_usage)
>   		total_disk_usage += get_object_disk_usage(obj);
>   	if (info->flags & REV_LIST_QUIET)
> @@ -525,6 +546,12 @@ static inline int parse_missing_action_value(const char *value)
>   		return 1;
>   	}
>   
> +	if (!strcmp(value, "print-only")) {
> +		arg_missing_action = MA_PRINT_ONLY;
> +		fetch_if_missing = 0;
> +		return 1;
> +	}
> +
>   	if (!strcmp(value, "allow-promisor")) {
>   		arg_missing_action = MA_ALLOW_PROMISOR;
>   		fetch_if_missing = 0;
> @@ -967,8 +994,7 @@ int cmd_rev_list(int argc,
>   
>   	if (arg_print_omitted)
>   		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
> -	if (arg_missing_action == MA_PRINT ||
> -	    arg_missing_action == MA_PRINT_INFO) {
> +	if (missing_action_prints()) {
>   		struct oidset_iter iter;
>   		struct object_id *oid;
>   
> @@ -994,8 +1020,7 @@ int cmd_rev_list(int argc,
>   			printf("~%s\n", oid_to_hex(oid));
>   		oidset_clear(&omitted_objects);
>   	}
> -	if (arg_missing_action == MA_PRINT ||
> -	    arg_missing_action == MA_PRINT_INFO) {
> +	if (missing_action_prints()) {
>   		struct missing_objects_map_entry *entry;
>   		struct oidmap_iter iter;
>   
> @@ -1011,7 +1036,7 @@ int cmd_rev_list(int argc,
>   
>   	stop_progress(&progress);
>   
> -	if (revs.count) {
> +	if (revs.count && arg_missing_action != MA_PRINT_ONLY) {
>   		if (revs.left_right && revs.cherry_mark)
>   			printf("%d\t%d\t%d\n", revs.count_left, revs.count_right, revs.count_same);
>   		else if (revs.left_right)
> @@ -1022,7 +1047,7 @@ int cmd_rev_list(int argc,
>   			printf("%d\n", revs.count_left + revs.count_right);
>   	}
>   
> -	if (show_disk_usage)
> +	if (show_disk_usage && arg_missing_action != MA_PRINT_ONLY)
>   		print_disk_usage(total_disk_usage);

I'm a little worried about all of these checks that need
special-casing. These seem like options that are enabled
by other options and could easily be grouped with the
print-only setting.

If there is something wrong here where these need to be
disabled, then we should update the documentation to say
how this interacts with those options. And perhaps some
warnings to say "these options are not compatible".

On that note: this patch is missing a document update.

Thanks,
-Stolee


