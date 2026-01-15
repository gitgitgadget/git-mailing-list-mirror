Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DE026D4C7
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768512271; cv=none; b=RUKSqQCMwx/js1bd52ug+ezL4p/lf3uLZZqyYES91emXIyvdD66uTmBVZj1ckUbNQMjQzDJ5faShdybLTrMz93PACUuX/XUkTNqNMBK6jTuH/ZKOS+6DjsxIOVMDFvpYCwZyQZxK8nN8gBbg8nOCcvv1tj/9tvWJJJZ1/XxKG+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768512271; c=relaxed/simple;
	bh=wtTYTNzH7QxvNZZQx3jWD1RmIDbWfEIQ14UN5IZZg2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5vj7BNypbdlebZvJFSybUE5E71XeYiJdGf9NZQukqGnXqYKQTiHXbQ/eFObQ4bI3MXJ3jTZy8ZlCtXhBMXySZc7RoJU1u7MQ7OUoY6fV9m00YoKtImf4mitOfoapEpWOI0SrktdQernr3Cb3t/PyZGEGLwX19JRHYpnRJ6DDmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6Zo3dEa; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6Zo3dEa"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-459ac606f0bso767171b6e.0
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 13:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768512267; x=1769117067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cve6LjQdz9NM/VqDrVDxCHfEelbh3F5/CazYxSFSj3o=;
        b=c6Zo3dEaMrsAZSCo/1WSELvBVJrRUR36b7xDpxhJZ/zoKb/D4ZwlVmwub71gN44Ywh
         o0Q9r4jdwYaYNpY5I8b2BsFi27bJbnqcVwVj0fSfDP+pO4t8/iCNse59MVyfuyRfLJu7
         2UyrgZY0z19gSrAV2UrKMcis6LhycBeQMtCub32Dn9J6cZVd/3bARmgiJaY+o3iVR82m
         Kq7EYOdLWVk1DITZi5BYmEl4xHajReV096jtcBg4O+Rltmnbo/de43xY8Me59Ug6b9gB
         v6qLdjcpEtktOBeWSK6FV3XLL8AieAN88mW/X5fEJ9BHpmew+/JPc2XC802kvcQ2/f4d
         TR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768512267; x=1769117067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cve6LjQdz9NM/VqDrVDxCHfEelbh3F5/CazYxSFSj3o=;
        b=NVvrzDyOQCnUDXfzM4fpzXFwVVLVOi17EGx+A/rcPhdQ+ZMSp/i9VsoGPtt8wEE+90
         kZpxk0mKb2G55nuwOXcsEMVoR7CwP+sBDtokpM8b4rt8KI0Lo6F5jADYOQPiv+J+fuI2
         c9iFlCQBn1KwE8+io+FzlJ9Xv4zpDm2z4EjUYefT3NlPxD4pXAAHt6izwHeiXKBtZHcN
         nC3rl7W/KrYaWON/7Vi7kYZwZ9KDwNvJgfrbjrz9rCWOKC3ISUGmBxhuOyTUJWQtnaqO
         KFWiMLUvQUo7Z1isR+8U4kpg6QZ9FrqMtf6deLOjeWqP6OElLokYOn0upfLd7v2ILyaW
         wNaw==
X-Gm-Message-State: AOJu0Yy6L0s3fw7e5UmLpfI8JzthMFNSqGom45RuCfwTkq2GzlIPc2V8
	x40MZfPSe+k3tN5gi+TK2QpEuEw7rjtIinsWyGDdKUACLkw86qiekkIU
X-Gm-Gg: AY/fxX55gvnfzw3VMcLEete/OQZTRwo+BR2mi7k1hLrwkV2uu2BOp3b5V8PO0ceLBzz
	YepQmODctwQsEuRq4FZd3LOeaZYMFltp0O/TIc67c7xSpWBBLmlVIQL14SlDnRXu7/afzgjZt76
	oZ2AJgw6q976SjiN0x+d2RMusE5YnfLnZlbBxGgANJD53stXb7NZbflq9IkZl8zrF+fp9+2Ew6O
	acsS0eD/IqYtZO2v+qeHi/F1OaPnMrfssuFqA5E80bfX+L/SqMR1iycJCzJk5KSYQxD5XpVc4oI
	jk+87GZ+TZJ1zGMI5iIjSSY0NODWH32sus+3R6N5cJKvCd9r9utYkZYw6RxNgMtYfAbLTM5eQ35
	BkSmnQU7wcWpepVtVXAUrntiV9HVoxL/vJmrCcrPJF7CBhakHdpdloI0RVkNDJ9muio6NkcQp8Z
	WWUuNnrarlijWqlLs=
X-Received: by 2002:a05:6808:2392:b0:45a:639c:99ca with SMTP id 5614622812f47-45c9bf8df8emr458629b6e.1.1768512266869;
        Thu, 15 Jan 2026 13:24:26 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9decac58sm277884b6e.5.2026.01.15.13.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 13:24:26 -0800 (PST)
Date: Thu, 15 Jan 2026 15:24:25 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/14] builtin/fsck: refactor to use
 `odb_for_each_object()`
Message-ID: <aWlaA2cwDS39pvRx@denethor>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <20260115-pks-odb-for-each-object-v1-8-5418a91d5d99@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-pks-odb-for-each-object-v1-8-5418a91d5d99@pks.im>

On 26/01/15 12:04PM, Patrick Steinhardt wrote:
> In git-fsck(1) we have two callsites where we iterate over all objects
> via `for_each_loose_object()` and `for_each_packed_object()`. Both of
> these are trivially convertible with `odb_for_each_object()`.
> 
> Refactor these callsites accordingly.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fsck.c | 57 ++++++++++++---------------------------------------------
>  1 file changed, 12 insertions(+), 45 deletions(-)
> 
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 4979bc795e..96107695ae 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -218,15 +218,17 @@ static int mark_used(struct object *obj, enum object_type type UNUSED,
>  	return 0;
>  }
>  
> -static void mark_unreachable_referents(const struct object_id *oid)
> +static int mark_unreachable_referents(const struct object_id *oid,
> +				      struct object_info *io UNUSED,
> +				      void *data UNUSED)
>  {
>  	struct fsck_options options = FSCK_OPTIONS_DEFAULT;
>  	struct object *obj = lookup_object(the_repository, oid);
>  
>  	if (!obj || !(obj->flags & HAS_OBJ))
> -		return; /* not part of our original set */
> +		return 0; /* not part of our original set */
>  	if (obj->flags & REACHABLE)
> -		return; /* reachable objects already traversed */
> +		return 0; /* reachable objects already traversed */
>  
>  	/*
>  	 * Avoid passing OBJ_NONE to fsck_walk, which will parse the object
> @@ -243,22 +245,7 @@ static void mark_unreachable_referents(const struct object_id *oid)
>  	fsck_walk(obj, NULL, &options);
>  	if (obj->type == OBJ_TREE)
>  		free_tree_buffer((struct tree *)obj);
> -}
>  
> -static int mark_loose_unreachable_referents(const struct object_id *oid,
> -					    const char *path UNUSED,
> -					    void *data UNUSED)
> -{
> -	mark_unreachable_referents(oid);
> -	return 0;
> -}
> -
> -static int mark_packed_unreachable_referents(const struct object_id *oid,
> -					     struct packed_git *pack UNUSED,
> -					     uint32_t pos UNUSED,
> -					     void *data UNUSED)
> -{
> -	mark_unreachable_referents(oid);

Ah ok, now that object iteration is unified, we don't need the two
separate callbacks. Makes sense. :)

>  	return 0;
>  }
>  
> @@ -394,12 +381,8 @@ static void check_connectivity(void)
>  		 * and ignore any that weren't present in our earlier
>  		 * traversal.
>  		 */
> -		for_each_loose_object(the_repository->objects,
> -				      mark_loose_unreachable_referents, NULL, 0);
> -		for_each_packed_object(the_repository,
> -				       mark_packed_unreachable_referents,
> -				       NULL,
> -				       0);
> +		odb_for_each_object(the_repository->objects, NULL,
> +				    mark_unreachable_referents, NULL, 0);

Nice! Now we no longer have to explicitly handle the various object
backends while iterating. This patch looks good.

-Justin
