Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DC1A1F42D
	for <e@80x24.org>; Wed, 30 May 2018 18:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932080AbeE3SaA (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 14:30:00 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33457 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753611AbeE3S37 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 14:29:59 -0400
Received: by mail-qt0-f193.google.com with SMTP id e8-v6so24553140qth.0
        for <git@vger.kernel.org>; Wed, 30 May 2018 11:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eBJY7CwKlC0NidcehjypyLxntLB1RuQ2Uly5f7gmjHc=;
        b=p70nmsn1sCweqjaf1Mc5w27N2mnQJRbTOESvPUIqEEALXi0cPkK/X7u7ZZRIE1eecp
         UtG6Re+ytdQoQbX5LH2AGdnAEFL9YzN7KBYvJtL+9/7Grfq5GQwJoiR1FMmpY8c/Gls+
         ekoYyxqpKyaFg9LwSd2HZrbfQb1Oc34T1jEPht8fTA6BwUyjszCRP5+eUbjReO6fYuD5
         g6DRn09DEwHUYKuyDVnEvLaO9kc63+7T57RPq7Hj6YpNcHCJsvzBOFUNVZ6t2oInlkGB
         iwLRTQzxqaKZ+lVsP/Mp2aflKlQ6UXJo6AOzWkmXkuYxya42jEI7ULHCU0/LPtyB9qHk
         zVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eBJY7CwKlC0NidcehjypyLxntLB1RuQ2Uly5f7gmjHc=;
        b=RuycKsHZrdgjoasKWLDyzjEICvwAoDXI0DbVPu1akrZdDs8/YEtH5mEXc4bdY4jv50
         35QcJ8psnsw83vCe0eySgA1o9eNhXXnAIoG/A1W9pqm7TqfXOoKyg8iY3fJBW5htDUaM
         QDBkGbM+LO2ZI2RXbetCWVOlrGEmGOvhb0LutGAZQ8oFvd1aRFj7UzCSsYez4X9g5IQl
         46plYQEx3qyOUL+iTOMo4zY81AMmTeN8anhTmABTix8CceVclSwSEzefRYzo++kbGH75
         XV8lIyT47Ryd67sdz6xsM7yQfWL+hrAavwYqEqrkVxzzEMymrXbN69uRKgTzbasGWmO3
         WOgg==
X-Gm-Message-State: ALKqPwfuX99gTFwmma7+0Ht1m/JsRJ15e1cEtODiOF2dlZa+wz6iPwvD
        MTnIWLESmOcFzFMZI12RkKM=
X-Google-Smtp-Source: ADUXVKKryvbAUL8PEoQU4BazEzU2VSyYshkKaB8hEAmrt29GEjWP/nm0NLXIuYro/4JkRoBV++EPXw==
X-Received: by 2002:aed:2387:: with SMTP id j7-v6mr3437848qtc.121.1527704998815;
        Wed, 30 May 2018 11:29:58 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id p72-v6sm16356933qkh.5.2018.05.30.11.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 11:29:57 -0700 (PDT)
Subject: Re: [PATCH 03/35] object: add repository argument to
 lookup_unknown_object
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
References: <20180530004810.30076-1-sbeller@google.com>
 <20180530004810.30076-4-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e85dbf10-05f3-6968-97c2-8d9010cae73c@gmail.com>
Date:   Wed, 30 May 2018 14:29:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180530004810.30076-4-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/29/2018 8:47 PM, Stefan Beller wrote:
> From: Jonathan Nieder <jrnieder@gmail.com>
>
> Add a repository argument to allow callers of lookup_unknown_object to
> be more specific about which repository to handle. This is a small
> mechanical change; it doesn't change the implementation to handle
> repositories other than the_repository yet.
>
> As with the previous commits, use a macro to catch callers passing a
> repositor other than the_repository at compile time.
>
> The included coccinelle semantic patch will adapt any new callers in
> the diff produced by `make coccicheck`.

I don't see any coccinelle change in this patch.

Perhaps it is in a later commit?

Thanks,

-Stolee

>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   builtin/fsck.c                   | 2 +-
>   builtin/pack-objects.c           | 2 +-
>   http-push.c                      | 2 +-
>   object.c                         | 2 +-
>   object.h                         | 3 ++-
>   refs.c                           | 2 +-
>   t/helper/test-example-decorate.c | 6 +++---
>   upload-pack.c                    | 2 +-
>   walker.c                         | 2 +-
>   9 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 98fdeef5407..700739804fc 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -638,7 +638,7 @@ static int fsck_cache_tree(struct cache_tree *it)
>   
>   static void mark_object_for_connectivity(const struct object_id *oid)
>   {
> -	struct object *obj = lookup_unknown_object(oid->hash);
> +	struct object *obj = lookup_unknown_object(the_repository, oid->hash);
>   	obj->flags |= HAS_OBJ;
>   }
>   
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 8c108109985..6eae39cf858 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2689,7 +2689,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
>   
>   		for (i = 0; i < p->num_objects; i++) {
>   			nth_packed_object_oid(&oid, p, i);
> -			o = lookup_unknown_object(oid.hash);
> +			o = lookup_unknown_object(the_repository, oid.hash);
>   			if (!(o->flags & OBJECT_ADDED))
>   				mark_in_pack_object(o, p, &in_pack);
>   			o->flags |= OBJECT_ADDED;
> diff --git a/http-push.c b/http-push.c
> index 2615c823d60..04d95bd5da8 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1429,7 +1429,7 @@ static void one_remote_ref(const char *refname)
>   	 * may be required for updating server info later.
>   	 */
>   	if (repo->can_update_info_refs && !has_object_file(&ref->old_oid)) {
> -		obj = lookup_unknown_object(ref->old_oid.hash);
> +		obj = lookup_unknown_object(the_repository, ref->old_oid.hash);
>   		fprintf(stderr,	"  fetch %s for %s\n",
>   			oid_to_hex(&ref->old_oid), refname);
>   		add_fetch_request(obj);
> diff --git a/object.c b/object.c
> index 4de4fa58d59..def3c71cac2 100644
> --- a/object.c
> +++ b/object.c
> @@ -177,7 +177,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
>   	}
>   }
>   
> -struct object *lookup_unknown_object(const unsigned char *sha1)
> +struct object *lookup_unknown_object_the_repository(const unsigned char *sha1)
>   {
>   	struct object *obj = lookup_object(the_repository, sha1);
>   	if (!obj)
> diff --git a/object.h b/object.h
> index fa41d711f44..778f83bf0f7 100644
> --- a/object.h
> +++ b/object.h
> @@ -139,7 +139,8 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
>   struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
>   
>   /** Returns the object, with potentially excess memory allocated. **/
> -struct object *lookup_unknown_object(const unsigned  char *sha1);
> +#define lookup_unknown_object(r, s) lookup_unknown_object_##r(s)
> +struct object *lookup_unknown_object_the_repository(const unsigned char *sha1);
>   
>   struct object_list *object_list_insert(struct object *item,
>   				       struct object_list **list_p);
> diff --git a/refs.c b/refs.c
> index 23d53957deb..3b9e8463656 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -301,7 +301,7 @@ static int filter_refs(const char *refname, const struct object_id *oid,
>   
>   enum peel_status peel_object(const struct object_id *name, struct object_id *oid)
>   {
> -	struct object *o = lookup_unknown_object(name->hash);
> +	struct object *o = lookup_unknown_object(the_repository, name->hash);
>   
>   	if (o->type == OBJ_NONE) {
>   		int type = oid_object_info(the_repository, name, NULL);
> diff --git a/t/helper/test-example-decorate.c b/t/helper/test-example-decorate.c
> index 081115bf8eb..33e727f7fc5 100644
> --- a/t/helper/test-example-decorate.c
> +++ b/t/helper/test-example-decorate.c
> @@ -26,8 +26,8 @@ int cmd__example_decorate(int argc, const char **argv)
>   	 * Add 2 objects, one with a non-NULL decoration and one with a NULL
>   	 * decoration.
>   	 */
> -	one = lookup_unknown_object(one_oid.hash);
> -	two = lookup_unknown_object(two_oid.hash);
> +	one = lookup_unknown_object(the_repository, one_oid.hash);
> +	two = lookup_unknown_object(the_repository, two_oid.hash);
>   	ret = add_decoration(&n, one, &decoration_a);
>   	if (ret)
>   		die("BUG: when adding a brand-new object, NULL should be returned");
> @@ -56,7 +56,7 @@ int cmd__example_decorate(int argc, const char **argv)
>   	ret = lookup_decoration(&n, two);
>   	if (ret != &decoration_b)
>   		die("BUG: lookup should return added declaration");
> -	three = lookup_unknown_object(three_oid.hash);
> +	three = lookup_unknown_object(the_repository, three_oid.hash);
>   	ret = lookup_decoration(&n, three);
>   	if (ret)
>   		die("BUG: lookup for unknown object should return NULL");
> diff --git a/upload-pack.c b/upload-pack.c
> index 20e61180e48..aebab6f3277 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -971,7 +971,7 @@ static void receive_needs(void)
>   static int mark_our_ref(const char *refname, const char *refname_full,
>   			const struct object_id *oid)
>   {
> -	struct object *o = lookup_unknown_object(oid->hash);
> +	struct object *o = lookup_unknown_object(the_repository, oid->hash);
>   
>   	if (ref_is_hidden(refname, refname_full)) {
>   		o->flags |= HIDDEN_REF;
> diff --git a/walker.c b/walker.c
> index 3678e344312..aea96f0eaff 100644
> --- a/walker.c
> +++ b/walker.c
> @@ -282,7 +282,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
>   			error("Could not interpret response from server '%s' as something to pull", target[i]);
>   			goto done;
>   		}
> -		if (process(walker, lookup_unknown_object(oids[i].hash)))
> +		if (process(walker, lookup_unknown_object(the_repository, oids[i].hash)))
>   			goto done;
>   	}
>   
