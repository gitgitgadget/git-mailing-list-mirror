Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A1E51F461
	for <e@80x24.org>; Fri,  6 Sep 2019 16:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405919AbfIFQsS (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 12:48:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43108 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfIFQsS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 12:48:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so3406192pld.10
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U7Ec0BvIr3abaK3i3i0yN2W34qywUXYKD1T5INTBTUU=;
        b=XgK3AUYb2+1jLkDHqN1JhXJED3R3eA+5uKXAT8/qigpliOTIKpLrMCUM0OaLaZrRoq
         2eqLiOnkUjgN0353CXmgbuMxkLfeUqjks0r/J9EV6eadtV/5RKOvP0EhEl71LRCvNluy
         zBfZWd2p0ON3m+CrMFQL3AHu7mWB6yoN9tw6P82YPe+FSGz9iKasQotYEUns3pjfxe+n
         Bj2WnPKcUHaPkk+zMF+Fk6Ks0CBjFXYJTbhujfte9Gouozi0ZmWtb131Nvyi9Z+4Bh27
         smIaKQG7DWhuM3bbi25PHl6p00Uizh/n7VCxHK5AS71YPIi3rrwV2UgRdxzw0hMiHrhl
         ezDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U7Ec0BvIr3abaK3i3i0yN2W34qywUXYKD1T5INTBTUU=;
        b=poU2ZoBXoDEXIlQjOfnwh1/aFN/4aew2+JDYXUHgTiEtQmTVaAtbRZIYht1VBHMxJW
         TVeqmY6I2sQSUtObHuLdIctkvejjPIDUCYYEzqH8vuCyaw71HggV9ggmU4yoP9CaID7L
         q3nu4pnrUJ1pqav0+1kKpepUPbVqFjtAcXhZDLtgJpwQaynebA6Z4xtSa74S7/ZLRZdS
         b56OO4C5aPbaRyI+mSzcDxtBdAtyqqNIWKxEkuJejAduC+KY1QGMpPEmYbUTkwWHQPCq
         Y1pptKaFsp4AfvkunpSpdYdlvKzBMFK38LRxGnlDbp9NfgOFbit+lXCGKitOSGwsB62T
         1pQw==
X-Gm-Message-State: APjAAAX91vDX6qN2jE17cRGrWFmknMZ+GGr0Q1VzN6vEjMpngGirbWuC
        mP/s+1p/wf6I8VoVzLIanx6+sLpq
X-Google-Smtp-Source: APXvYqzW8uh2SSIxFqTQkANNyFYFmxBjOj8P+qgh7oveanwQQjsBXFWThReexP476V05TSwTTXwSKg==
X-Received: by 2002:a17:902:d898:: with SMTP id b24mr10566962plz.7.1567788496617;
        Fri, 06 Sep 2019 09:48:16 -0700 (PDT)
Received: from ?IPv6:2603:3023:803:400:4c28:4024:4b1c:1fde? ([2603:3023:803:400:4c28:4024:4b1c:1fde])
        by smtp.gmail.com with ESMTPSA id k64sm12583666pge.65.2019.09.06.09.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 09:48:16 -0700 (PDT)
Subject: Re: [RFC PATCH 1/1] commit-graph.c: die on un-parseable commits
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1567563244.git.me@ttaylorr.com>
 <34e4ec793cb0d321d16b88777cd2db64ed7b772e.1567563244.git.me@ttaylorr.com>
 <20190904030456.GA28836@sigill.intra.peff.net>
 <20190904211847.GA20904@syl.local>
 <20190905064723.GC21450@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <36bf0064-b563-74ed-4ae5-01745ced5d2e@gmail.com>
Date:   Fri, 6 Sep 2019 12:48:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190905064723.GC21450@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/5/2019 2:47 AM, Jeff King wrote:
> On Wed, Sep 04, 2019 at 05:18:47PM -0400, Taylor Blau wrote:
> 
>> All of this makes sense to me, so I'm wondering what part(s) of this you
>> feel are worth addressing in this first patch series. Presumably, there
>> is a longer series that we _could_ write which would introduce a new
>> 'corrupt' field and then check for it here.
>>
>> But, I'm hesitant to write those patches, since I only have this one
>> call-site in mind. If we introduce 'corrupt', I feel it would be best to
>> use it uniformly, instead of only checking it here, and relying on other
>> bespoke mechanisms to detect corruption elsewhere.
>>
>> So, I'm content to write the pseudo-code you provided above (which is to
>> say, call and check both 'parse_commit_no_graph', _and_
>> 'get_commit_tree_oid'), because I think that it's expedient, and fix the
>> issue which I'm pointing out here.
> 
> I'd actually be willing to just take the patch you have here, and
> consider the "parsed but we saw an error" thing as an oddity of the
> object code.  IOW, we shouldn't _have_ to be double-checking here.
> Looking for an error return from parse_commit() should really be all a
> caller needs to do. Once that's fixed, then your code would just be
> doing the right thing.
> 
> That said, there's another unhandled case, I think: lookup_tree() might
> return NULL (if somebody previously saw that oid as a non-tree), and
> parse_commit() wouldn't even notice and return an error!
> 
> IMHO that's also something that parse_commit() should be returning an
> error for. And it's probably a lot easier to trigger versus the "parsed
> earlier but corrupted" thing.
> 
> So it might be worth doing the NULL tree check here in the meantime. I
> dunno.
> 
> Below is a sketch of what I'm thinking parse_commit() should do:
> 
>   - remember when an earlier parse returned an error, so we can repeat
>     that error (this requires some unfortunate bit-field adjusting)
> 
>   - notice a lookup_tree failure
> 
>   - likewise, notice a lookup_parent failure
> 
> ---
> diff --git a/commit.c b/commit.c
> index a98de16e3d..7e415932b7 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -391,7 +391,9 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
>  	return ret;
>  }
>  
> -int parse_commit_buffer(struct repository *r, struct commit *item, const void *buffer, unsigned long size, int check_graph)
> +static int parse_commit_buffer_1(struct repository *r, struct commit *item,
> +				 const void *buffer, unsigned long size,
> +				 int check_graph)
>  {
>  	const char *tail = buffer;
>  	const char *bufptr = buffer;
> @@ -401,9 +403,6 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
>  	const int tree_entry_len = the_hash_algo->hexsz + 5;
>  	const int parent_entry_len = the_hash_algo->hexsz + 7;
>  
> -	if (item->object.parsed)
> -		return 0;
> -	item->object.parsed = 1;
>  	tail += size;
>  	if (tail <= bufptr + tree_entry_len + 1 || memcmp(bufptr, "tree ", 5) ||
>  			bufptr[tree_entry_len] != '\n')
> @@ -412,6 +411,10 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
>  		return error("bad tree pointer in commit %s",
>  			     oid_to_hex(&item->object.oid));
>  	set_commit_tree(item, lookup_tree(r, &parent));
> +	if (!item->maybe_tree)
> +		return error("bad tree pointer %s in commit %s",
> +			     oid_to_hex(&parent),
> +			     oid_to_hex(&item->object.oid));
>  	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
>  	pptr = &item->parents;
>  
> @@ -431,15 +434,19 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
>  		if (graft && (graft->nr_parent < 0 || grafts_replace_parents))
>  			continue;
>  		new_parent = lookup_commit(r, &parent);
> -		if (new_parent)
> -			pptr = &commit_list_insert(new_parent, pptr)->next;
> +		if (!new_parent)
> +			return error("bad parent %s in commit %s",
> +				     oid_to_hex(&parent),
> +				     oid_to_hex(&item->object.oid));
> +		pptr = &commit_list_insert(new_parent, pptr)->next;
>  	}
>  	if (graft) {
>  		int i;
>  		struct commit *new_parent;
>  		for (i = 0; i < graft->nr_parent; i++) {
>  			new_parent = lookup_commit(r,
>  						   &graft->parent[i]);
> +			/* Here we ignore bogus grafts. Also should be an error? */
>  			if (!new_parent)
>  				continue;
>  			pptr = &commit_list_insert(new_parent, pptr)->next;
> @@ -453,6 +460,23 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
>  	return 0;
>  }
>  
> +int parse_commit_buffer(struct repository *r, struct commit *item,
> +			const void *buffer, unsigned long size,
> +			int check_graph)
> +{
> +	int ret;
> +
> +	if (item->object.parsed)
> +		return item->object.corrupt ? -1 : 0;
> +	item->object.parsed = 1;
> +
> +	ret = parse_commit_buffer_1(r, item, buffer, size, check_graph);
> +	if (ret < 0)
> +		item->object.corrupt = 1;
> +
> +	return ret;
> +}
> +
>  int repo_parse_commit_internal(struct repository *r,
>  			       struct commit *item,
>  			       int quiet_on_missing,
> diff --git a/object.h b/object.h
> index 0120892bbd..b83d3964ad 100644
> --- a/object.h
> +++ b/object.h
> @@ -59,7 +59,7 @@ struct object_array {
>  
>  /*
>   * object flag allocation:
> - * revision.h:               0---------10                              25----28
> + * revision.h:               0---------10                              24----27
>   * fetch-pack.c:             01
>   * negotiator/default.c:       2--5
>   * walker.c:                 0-2
> @@ -78,13 +78,14 @@ struct object_array {
>   * builtin/show-branch.c:    0-------------------------------------------26
>   * builtin/unpack-objects.c:                                 2021
>   */
> -#define FLAG_BITS  29
> +#define FLAG_BITS  28
>  
>  /*
>   * The object type is stored in 3 bits.
>   */
>  struct object {
>  	unsigned parsed : 1;
> +	unsigned corrupt : 1;
>  	unsigned type : TYPE_BITS;
>  	unsigned flags : FLAG_BITS;
>  	struct object_id oid;
> diff --git a/revision.h b/revision.h
> index 4134dc6029..5c0b831b37 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -33,7 +33,7 @@
>  #define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR)
>  
>  #define TOPO_WALK_EXPLORED	(1u<<27)
> -#define TOPO_WALK_INDEGREE	(1u<<28)
> +#define TOPO_WALK_INDEGREE	(1u<<24)

As an aside, these flag bit modifications look fine, but would need to
be explained. I'm guessing that since you are adding a bit of data
to struct object you want to avoid increasing the struct size across
a 32-bit boundary. Are we sure that bit 24 is not used anywhere else?
(My search for "1u<<24" found nothing, and "1 << 24" found a bit in
the cache-entry flags, so this seems safe.)

Thanks,
-Stolee
