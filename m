Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81B1B1F790
	for <e@80x24.org>; Tue,  2 May 2017 18:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbdEBSNM (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 14:13:12 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35495 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdEBSNL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 14:13:11 -0400
Received: by mail-pg0-f52.google.com with SMTP id o3so59972251pgn.2
        for <git@vger.kernel.org>; Tue, 02 May 2017 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h/iOSDTHSGuXXyvp7a1A99o6UT3uYEuCT/CCLPSGZyM=;
        b=qe9qpnOUxkUoJ5PjOckIqIsbIlmd0sJhtUv0C8FGB/PgAbF2oCyweURYu09OyRWA2Y
         vPiTKuiP9uXD+alZhQTA3CMI5ePv3XyZvXTcUZA/8IG89ppAzox1j75/WeglExwAzdSW
         ajoWfvgzWotriB8XSp/FvxBrYLQejWk5MYhhgMWFAe+4ZqzD/8N5mytmFgMHQMNQuE4u
         UH+1N2bG86TAX3dMsQr2iPZam357F5Nz1BaZuiihIbSHeCcsX64Viiu48AuNIEGGNtbp
         f2nO/dKIcnfiXpnpt94qw++G/BNepJ0Erl9vqB3HSr/N8ddiu4NBXuufemqQcKiZ1A1M
         lU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h/iOSDTHSGuXXyvp7a1A99o6UT3uYEuCT/CCLPSGZyM=;
        b=G5/+nmtCji438tlGBEYCYbO2FnMXV5j+c75AHx//67ObmL0kY+q6FCEdKWQYV9ZZs3
         ei2v7Z8F/EQN+owD/uo1bDE6CdXBATC+09HJ8amtVmndDOeSSpSqNE7KCXShrc1/X7yB
         ed2wOuoFtI0xGGOtKe2DIlw6Vxh8k2ZbuGGX98+O76Zj0+foNEaL3j44X5Szr2Xc3lcN
         wJ2G5KNWymcMhzjBL8auT+9qCntj1gApQej59mmUxiZSCV4IaJL9E37W9yGCHzuCpFzl
         rzzLestujM+G0QSABKJbV+slYW+bSILBjSVQdilPNzLRg4a2r2VwhSrlmQ4Vb/50UeLj
         x+ZA==
X-Gm-Message-State: AN3rC/6AnJO+Ie00UXs6HbfepB8i8i/D4Two3uthz2bKB0ooOl0FikTq
        EWG22nYPJ7IO3EeI
X-Received: by 10.99.55.78 with SMTP id g14mr34541610pgn.191.1493748790288;
        Tue, 02 May 2017 11:13:10 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:61ee:b5d7:71fe:5285])
        by smtp.gmail.com with ESMTPSA id v187sm28425684pgv.18.2017.05.02.11.13.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 11:13:09 -0700 (PDT)
Date:   Tue, 2 May 2017 11:13:08 -0700
From:   Brandon Williams <bmwill@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 03/53] Convert struct cache_tree to use struct
 object_id
Message-ID: <20170502181308.GD181268@google.com>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
 <20170501022946.258735-4-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170501022946.258735-4-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01, brian m. carlson wrote:
> Convert the sha1 member of struct cache_tree to struct object_id by
> changing the definition and applying the following semantic patch, plus
> the standard object_id transforms:
> 
> @@
> struct cache_tree E1;
> @@
> - E1.sha1
> + E1.oid.hash
> 
> @@
> struct cache_tree *E1;
> @@
> - E1->sha1
> + E1->oid.hash
> 
> Fix up one reference to active_cache_tree which was not automatically
> caught by Coccinelle.  These changes are prerequisites for converting
> parse_object.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/commit.c                |  2 +-
>  builtin/fsck.c                  |  4 ++--
>  cache-tree.c                    | 31 ++++++++++++++++---------------
>  cache-tree.h                    |  3 ++-
>  merge-recursive.c               |  2 +-
>  revision.c                      |  2 +-
>  sequencer.c                     |  3 ++-
>  t/helper/test-dump-cache-tree.c |  4 ++--
>  8 files changed, 27 insertions(+), 24 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 1d805f5da..8685c888f 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1758,7 +1758,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		append_merge_tag_headers(parents, &tail);
>  	}
>  
> -	if (commit_tree_extended(sb.buf, sb.len, active_cache_tree->sha1,
> +	if (commit_tree_extended(sb.buf, sb.len, active_cache_tree->oid.hash,
>  			 parents, oid.hash, author_ident.buf, sign_commit, extra)) {
>  		rollback_index_files();
>  		die(_("failed to write commit object"));
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index b5e13a455..c40e14de6 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -599,10 +599,10 @@ static int fsck_cache_tree(struct cache_tree *it)
>  		fprintf(stderr, "Checking cache tree\n");
>  
>  	if (0 <= it->entry_count) {
> -		struct object *obj = parse_object(it->sha1);
> +		struct object *obj = parse_object(it->oid.hash);
>  		if (!obj) {
>  			error("%s: invalid sha1 pointer in cache-tree",
> -			      sha1_to_hex(it->sha1));
> +			      oid_to_hex(&it->oid));
>  			errors_found |= ERROR_REFS;
>  			return 1;
>  		}
> diff --git a/cache-tree.c b/cache-tree.c
> index 345ea3596..35d507ed7 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -225,7 +225,7 @@ int cache_tree_fully_valid(struct cache_tree *it)
>  	int i;
>  	if (!it)
>  		return 0;
> -	if (it->entry_count < 0 || !has_sha1_file(it->sha1))
> +	if (it->entry_count < 0 || !has_sha1_file(it->oid.hash))
>  		return 0;
>  	for (i = 0; i < it->subtree_nr; i++) {
>  		if (!cache_tree_fully_valid(it->down[i]->cache_tree))
> @@ -253,7 +253,7 @@ static int update_one(struct cache_tree *it,
>  
>  	*skip_count = 0;
>  
> -	if (0 <= it->entry_count && has_sha1_file(it->sha1))
> +	if (0 <= it->entry_count && has_sha1_file(it->oid.hash))
>  		return it->entry_count;
>  
>  	/*
> @@ -340,7 +340,7 @@ static int update_one(struct cache_tree *it,
>  				die("cache-tree.c: '%.*s' in '%s' not found",
>  				    entlen, path + baselen, path);
>  			i += sub->count;
> -			sha1 = sub->cache_tree->sha1;
> +			sha1 = sub->cache_tree->oid.hash;
>  			mode = S_IFDIR;
>  			contains_ita = sub->cache_tree->entry_count < 0;
>  			if (contains_ita) {
> @@ -402,12 +402,13 @@ static int update_one(struct cache_tree *it,
>  		unsigned char sha1[20];
>  		hash_sha1_file(buffer.buf, buffer.len, tree_type, sha1);
>  		if (has_sha1_file(sha1))
> -			hashcpy(it->sha1, sha1);
> +			hashcpy(it->oid.hash, sha1);
>  		else
>  			to_invalidate = 1;
>  	} else if (dryrun)
> -		hash_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1);
> -	else if (write_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1)) {
> +		hash_sha1_file(buffer.buf, buffer.len, tree_type,
> +			       it->oid.hash);
> +	else if (write_sha1_file(buffer.buf, buffer.len, tree_type, it->oid.hash)) {
>  		strbuf_release(&buffer);
>  		return -1;
>  	}
> @@ -417,7 +418,7 @@ static int update_one(struct cache_tree *it,
>  #if DEBUG
>  	fprintf(stderr, "cache-tree update-one (%d ent, %d subtree) %s\n",
>  		it->entry_count, it->subtree_nr,
> -		sha1_to_hex(it->sha1));
> +		oid_to_hex(&it->oid));
>  #endif
>  	return i;
>  }
> @@ -457,14 +458,14 @@ static void write_one(struct strbuf *buffer, struct cache_tree *it,
>  	if (0 <= it->entry_count)
>  		fprintf(stderr, "cache-tree <%.*s> (%d ent, %d subtree) %s\n",
>  			pathlen, path, it->entry_count, it->subtree_nr,
> -			sha1_to_hex(it->sha1));
> +			oid_to_hex(&it->oid));
>  	else
>  		fprintf(stderr, "cache-tree <%.*s> (%d subtree) invalid\n",
>  			pathlen, path, it->subtree_nr);
>  #endif
>  
>  	if (0 <= it->entry_count) {
> -		strbuf_add(buffer, it->sha1, 20);
> +		strbuf_add(buffer, it->oid.hash, 20);

Should this 20 be converted to GIT_{SHA1,MAX}_RAWSZ?  I know this is a
generated patch so maybe this is addressed, or will be addressed later?

-- 
Brandon Williams
