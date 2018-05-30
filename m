Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E43B01F42D
	for <e@80x24.org>; Wed, 30 May 2018 18:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932078AbeE3SeX (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 14:34:23 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45514 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753591AbeE3SeW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 14:34:22 -0400
Received: by mail-qk0-f196.google.com with SMTP id c198-v6so15175212qkg.12
        for <git@vger.kernel.org>; Wed, 30 May 2018 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hMQ+rF0zv5OX5cu+qcOOlTqYn6B4mzs01ZlcZQj8jdM=;
        b=rlT/ngLFkdo4CaLX23IHj7DVmpNx+23w48GV8483vdWSva8kLkhCyJsOF2/8tUoXCD
         hJdJi8K5Ba7fB9sx2sKkQh0+qWnT39zzgzm5FE+P3CuLovc0KioxknnpLLxxmhLT157w
         zEr6aJCEjsRfDcenA+E2Sua201FeDG7XH9GbsLlUP6Ld4o4w0nAvNlNjQoQJsQR7eTrg
         0uRCj2II9yA66JH3cQLX122N3AJEpdakydBVQVllc1AlVmurrAzsuq85TfXU+7M1DUBO
         /wPiMOaVxui2fQvBeLZsVkqd8To836S/W76zjSywrt31m5lw/d4fSFgrpZJNlc7+/e4O
         P5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hMQ+rF0zv5OX5cu+qcOOlTqYn6B4mzs01ZlcZQj8jdM=;
        b=uEJ/NUC5gM7Ntp0Tj6k4KLSCO9U44rMuNb84DVcpZ0Ye2X2OZy8fpVFlU5dnbA72Ki
         kuaqtTyN9CM2y73pFoX9goOJn7ope3gyDvNZMsevA2OCthikSzYrGUDLN9x39bhz5H+W
         vfliqvbPi0us4qd16HdFxzyKCxeBhbuSBVGnsBtaZqYqAI9knM3cw1SN/zUT1f1BAXkd
         bkGKRZFwHv9KEiPSAA64XWM29rBwq7A7Gu6wzuhxi5w1aVmd3+wBaZIPF/0XvjLuh+ix
         M7GLNQ+4LT/g7S7Q0uey3gs9P9Lpnpz0gWLsA/X/4/+Y1p6+wicYiZr9VfG0C1neQ7o4
         X3ew==
X-Gm-Message-State: APt69E2q+r0jYSs6klq5o9CpJNNeqQA4nDQ1YFsk6mtPnk9BgG+ryvbL
        GYH9hyYBL0C56VBVAgvhN0s=
X-Google-Smtp-Source: ADUXVKIVOx97hwEJ0WfDeShWa6QIaSJNqdjZMrqFvVWoJw8UGidQGBttuDRSYwFkGQkcmVVo6xn4sg==
X-Received: by 2002:a37:17ea:: with SMTP id 103-v6mr3338678qkx.373.1527705262093;
        Wed, 30 May 2018 11:34:22 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id a8-v6sm5907554qtb.15.2018.05.30.11.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 11:34:21 -0700 (PDT)
Subject: Re: [PATCH 04/35] object: add repository argument to
 parse_object_buffer
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
References: <20180530004810.30076-1-sbeller@google.com>
 <20180530004810.30076-5-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e6651365-dd04-98dd-10b7-867bebcc4e27@gmail.com>
Date:   Wed, 30 May 2018 14:34:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180530004810.30076-5-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/29/2018 8:47 PM, Stefan Beller wrote:
> Add a repository argument to allow the callers of parse_object_buffer
> to be more specific about which repository to act on. This is a small
> mechanical change; it doesn't change the implementation to handle
> repositories other than the_repository yet.
>
> As with the previous commits, use a macro to catch callers passing a
> repository other than the_repository at compile time.
>
> Add the cocci patch that converted the callers.

Again, I'm missing the cocci patch here.


> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   builtin/fast-export.c    | 3 ++-
>   builtin/fsck.c           | 6 ++++--
>   builtin/index-pack.c     | 3 ++-
>   builtin/unpack-objects.c | 3 ++-
>   object.c                 | 5 +++--
>   object.h                 | 3 ++-
>   ref-filter.c             | 3 ++-
>   7 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 24d42842f9d..a34ab9768f4 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -245,7 +245,8 @@ static void export_blob(const struct object_id *oid)
>   			die ("Could not read blob %s", oid_to_hex(oid));
>   		if (check_object_signature(oid, buf, size, type_name(type)) < 0)
>   			die("sha1 mismatch in blob %s", oid_to_hex(oid));
> -		object = parse_object_buffer(oid, type, size, buf, &eaten);
> +		object = parse_object_buffer(the_repository, oid, type,
> +					     size, buf, &eaten);
>   	}
>   
>   	if (!object)
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 700739804fc..e6d6eb266eb 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -392,7 +392,8 @@ static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
>   	 * verify_packfile(), data_valid variable for details.
>   	 */
>   	struct object *obj;
> -	obj = parse_object_buffer(oid, type, size, buffer, eaten);
> +	obj = parse_object_buffer(the_repository, oid, type, size, buffer,
> +				  eaten);
>   	if (!obj) {
>   		errors_found |= ERROR_OBJECT;
>   		return error("%s: object corrupt or missing", oid_to_hex(oid));
> @@ -522,7 +523,8 @@ static struct object *parse_loose_object(const struct object_id *oid,
>   	if (!contents && type != OBJ_BLOB)
>   		die("BUG: read_loose_object streamed a non-blob");
>   
> -	obj = parse_object_buffer(oid, type, size, contents, &eaten);
> +	obj = parse_object_buffer(the_repository, oid, type, size,
> +				  contents, &eaten);
>   
>   	if (!eaten)
>   		free(contents);
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index e2f670bef9e..0dd10693597 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -848,7 +848,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
>   			 * we do not need to free the memory here, as the
>   			 * buf is deleted by the caller.
>   			 */
> -			obj = parse_object_buffer(oid, type, size, buf,
> +			obj = parse_object_buffer(the_repository, oid, type,
> +						  size, buf,
>   						  &eaten);
>   			if (!obj)
>   				die(_("invalid %s"), type_name(type));
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 9a4d2708123..8e454c48649 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -265,7 +265,8 @@ static void write_object(unsigned nr, enum object_type type,
>   		int eaten;
>   		hash_object_file(buf, size, type_name(type), &obj_list[nr].oid);
>   		added_object(nr, type, buf, size);
> -		obj = parse_object_buffer(&obj_list[nr].oid, type, size, buf,
> +		obj = parse_object_buffer(the_repository, &obj_list[nr].oid,
> +					  type, size, buf,
>   					  &eaten);
>   		if (!obj)
>   			die("invalid %s", type_name(type));
> diff --git a/object.c b/object.c
> index def3c71cac2..4250ddd3f7f 100644
> --- a/object.c
> +++ b/object.c
> @@ -186,7 +186,7 @@ struct object *lookup_unknown_object_the_repository(const unsigned char *sha1)
>   	return obj;
>   }
>   
> -struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
> +struct object *parse_object_buffer_the_repository(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p)
>   {
>   	struct object *obj;
>   	*eaten_p = 0;
> @@ -278,7 +278,8 @@ struct object *parse_object_the_repository(const struct object_id *oid)
>   			return NULL;
>   		}
>   
> -		obj = parse_object_buffer(oid, type, size, buffer, &eaten);
> +		obj = parse_object_buffer(the_repository, oid, type, size,
> +					  buffer, &eaten);
>   		if (!eaten)
>   			free(buffer);
>   		return obj;
> diff --git a/object.h b/object.h
> index 778f83bf0f7..c6386d7b6b1 100644
> --- a/object.h
> +++ b/object.h
> @@ -136,7 +136,8 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
>    * parsing it.  eaten_p indicates if the object has a borrowed copy
>    * of buffer and the caller should not free() it.
>    */
> -struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
> +#define parse_object_buffer(r, o, t, s, b, e) parse_object_buffer_##r(o, t, s, b, e)
> +struct object *parse_object_buffer_the_repository(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
>   
>   /** Returns the object, with potentially excess memory allocated. **/
>   #define lookup_unknown_object(r, s) lookup_unknown_object_##r(s)
> diff --git a/ref-filter.c b/ref-filter.c
> index 6ebb4630f9c..7e57c07bf54 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -806,7 +806,8 @@ static void *get_obj(const struct object_id *oid, struct object **obj, unsigned
>   	void *buf = read_object_file(oid, &type, sz);
>   
>   	if (buf)
> -		*obj = parse_object_buffer(oid, type, *sz, buf, eaten);
> +		*obj = parse_object_buffer(the_repository, oid, type, *sz,
> +					   buf, eaten);
>   	else
>   		*obj = NULL;
>   	return buf;
