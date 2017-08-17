Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEF0F20899
	for <e@80x24.org>; Thu, 17 Aug 2017 20:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbdHQUH3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 16:07:29 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38475 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbdHQUH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 16:07:28 -0400
Received: by mail-qt0-f196.google.com with SMTP id p3so7176738qtg.5
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Gc5JSKuhVfeqyG05X/Pg+D+l89yAg0cJg8hLyF6gD0=;
        b=McVYP9oVYzjwtFopbzf3Ltun+yQDsZjtPfKEcSsL4DOOL1R3tbONVsKXjJ0Wm83dZZ
         yp1jV97fsK4/BIMw03Hz3zhXH7yGUIgo6NpDY/lRJUJevp791duPytgos4ewfPxZ4q2w
         w230mZijASA+EtLF0yOX0dK4rKfRCbc/iVV829RtZufOhq4ZHelp1VQOY7SNkNoEtOfj
         /MfOMmdvU6jOPmOFnXXovB1+/6OQ1lke2DGkcs0tv1NHzY9c0dEhMJrCvEZfXqMVk38e
         cE99l0nu3hjiATuZU4uYdY4zWy3fW2jjiQ2k8yYs4z9m8x3PmKJHEnq76xwBgOR9LNMr
         M5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Gc5JSKuhVfeqyG05X/Pg+D+l89yAg0cJg8hLyF6gD0=;
        b=uYGVlWQnmI5Imwf4lMjyb5Z0/HOviho27d5n0xixmUUtEO1vpd+hy4eYUADG8iH7mr
         UMs15N+fqtGpuzSkYLcjjpqBXEF3yXL8eMLhOwj70p4+Abcep7nvZ5Y7nh5mCxCv9nlP
         /7FKhyCg4TCriuq+KULAtN38aDmL00mF8rs7hSHOGbQK5SMNe35WoMv6FJJXkJC1DugQ
         qM9caXuA+u2jVaud7eMAO0wr9Q2TofYSqT2x1FNBGiLa+0gYUbCsx+A1ELKIVNs3m4wg
         7OkdIFHneOfcd0NNCp9xHhZjTd2DYPkx/FefTVbATz2/9tLUSsI33WgT+shwtvIAPgmG
         7VhQ==
X-Gm-Message-State: AHYfb5iUwSRis+C6DVCssKInIHt4PD9J/LbESNGh962Y52gfHbqPO5P4
        u7dlkf8UQ5HjX1JEPNw=
X-Received: by 10.200.26.189 with SMTP id x58mr2134865qtj.96.1503000448035;
        Thu, 17 Aug 2017 13:07:28 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id s36sm2755773qts.77.2017.08.17.13.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2017 13:07:26 -0700 (PDT)
Subject: Re: [RFC PATCH] Updated "imported object" design
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
 <20170816003200.19992-1-jonathantanmy@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <850a7b88-8e3c-4c4b-4a0d-16e2aa2145fc@gmail.com>
Date:   Thu, 17 Aug 2017 16:07:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170816003200.19992-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/15/2017 8:32 PM, Jonathan Tan wrote:
> This patch is based on an updated version of my refactoring of
> pack-related functions [1].
> 
> This corresponds to patch 1 of my previous series [2]. I'm sending this
> patch out (before I update the rest) for 2 reasons:
>   * to provide a demonstration of how the feature could be implemented,
>     in the hope of restarting the discussion
>   * to obtain comments about this patch to see if I'm heading in the
>     right direction
> 
> In an earlier e-mail [3], I suggested that loose objects can also be
> marked as ".imported" (formerly ".remote" - after looking at the code, I
> decided to use "imported" throughout, since "remote" can be easily
> confused as the opposite of "local", used to represent objects in the
> local store as opposed to an alternate store).
> 
> However, I have only implemented the imported packed objects part -
> imported loose objects can be added later.
> 
> It still remains to be discussed whether we should mark the imported
> objects or the non-imported objects as the source of promises, but I
> still think that we should mark the imported objects. In this way, the
> new properties (the provision of promises and the mark) coincide on the
> same object, and the same things (locally created objects, fetches from
> non-lazy-object-serving remotes) behave in the same way regardless of
> whether extensions.lazyObject is set (allowing, for example, a repo to
> be converted into a promise-enabled one solely through modifying the
> configuration).
> 

This illustrates another place we need to resolve the naming/vocabulary. 
  We should at least be consistent to make it easier to discuss/explain. 
  We obviously went with "virtual" when building GVFS but I'm OK with 
"lazy" as long as we're consistent.  Some examples of how the naming can 
clarify or confuse:

'Promise-enable your repo by setting the "extensions.lazyObject" flag'

'Enable your repo to lazily fetch objects by setting the 
"extensions.lazyObject"'

'Virtualize your repo by setting the "extensions.virtualize" flag'

We may want to carry the same name into the filename we use to mark the 
(virtualized/lazy/promised/imported) objects.

(This reminds me that there are only 2 hard problems in computer 
science...) ;)


It is true that converting a normal repo to 
virtualized/lazy/promise-enabled repo wouldn't have to munge with the 
object marking but since this only happens once, I wouldn't make that 
primary decision maker (and switching back would require munging the 
objects anyway).  I think we can make either work (ie tagging local vs 
non-local/remote/imported/promised/lazy/virtual).

I'm fine leaving "how" the objects are marked as an implementation 
detail - the design requires them to be marked, the person writing the 
code can figure out the fastest way to accomplish that.

In the current patch/design, the access time to check for the existence 
of an "imported" file is going to be dwarfed by the cost of opening and 
parsing every object (loose and pack) to get its oid so that isn't 
really an issue.

> +/*
> + * Objects that are believed to be loadable by the lazy loader, because
> + * they are referred to by an imported object. If an object that we have
> + * refers to such an object even though we don't have that object, it is
> + * not an error.
> + */
> +static struct oidset promises;
> +static int promises_prepared;
> +
> +static int add_promise(const struct object_id *oid, struct packed_git *pack,
> +		       uint32_t pos, void *data)
> +{
> +	struct object *obj = parse_object(oid);
> +	if (!obj)
> +		/*
> +		 * Error messages are given when packs are verified, so
> +		 * do not print any here.
> +		 */
> +		return 0;
> +	
> +	/*
> +	 * If this is a tree, commit, or tag, the objects it refers
> +	 * to are promises. (Blobs refer to no objects.)
> +	 */
> +	if (obj->type == OBJ_TREE) {
> +		struct tree *tree = (struct tree *) obj;
> +		struct tree_desc desc;
> +		struct name_entry entry;
> +		if (init_tree_desc_gently(&desc, tree->buffer, tree->size))
> +			/*
> +			 * Error messages are given when packs are
> +			 * verified, so do not print any here.
> +			 */
> +			return 0;
> +		while (tree_entry_gently(&desc, &entry))
> +			oidset_insert(&promises, entry.oid);
> +	} else if (obj->type == OBJ_COMMIT) {
> +		struct commit *commit = (struct commit *) obj;
> +		struct commit_list *parents = commit->parents;
> +
> +		oidset_insert(&promises, &commit->tree->object.oid);
> +		for (; parents; parents = parents->next)
> +			oidset_insert(&promises, &parents->item->object.oid);
> +	} else if (obj->type == OBJ_TAG) {
> +		struct tag *tag = (struct tag *) obj;
> +		oidset_insert(&promises, &tag->tagged->oid);
> +	}
> +	return 0;
> +}
> +
> +static int is_promise(const struct object_id *oid)
> +{
> +	if (!promises_prepared) {
> +		if (repository_format_lazy_object)
> +			for_each_packed_object(add_promise, NULL,
> +					       FOR_EACH_OBJECT_IMPORTED_ONLY);
> +		promises_prepared = 1;
> +	}
> +	return oidset_contains(&promises, oid);
> +}
> +

I think this all works and would meet the requirements we've been 
discussing.  The big trade off here vs what we first discussed with 
promises is that we are generating the list of promises on the fly when 
they are needed rather than downloading and maintaining a list locally.

My biggest concern with this model is the cost of opening and parsing 
every imported object (loose and pack for local and alternates) to build 
the oidset of promises.

In fsck this probably won't be an issue as it already focuses on 
correctness at the expense of speed.  I'm more worried about when we add 
the same/similar logic into check_connected.  That impacts fetch, clone, 
and receive_pack.

I guess the only way we can know for sure it to do a perf test and 
measure the impact.
