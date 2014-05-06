From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 8/9] cache-tree: convert struct cache_tree to use object_id
Date: Tue, 06 May 2014 16:53:47 +0200
Message-ID: <5368F77B.8090409@alum.mit.edu>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net> <1399147942-165308-9-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 20:43:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiUl-0008Jm-JG
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757652AbaEFOxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 10:53:52 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50311 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754609AbaEFOxv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2014 10:53:51 -0400
X-AuditID: 1207440d-f79d86d0000043db-a5-5368f77e9c53
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 50.61.17371.E77F8635; Tue,  6 May 2014 10:53:50 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97C6E.dip0.t-ipconnect.de [79.201.124.110])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s46ErlhS030132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 6 May 2014 10:53:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1399147942-165308-9-git-send-email-sandals@crustytoothpaste.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqFv3PSPY4NhUBYuuK91MFm0zfzA5
	MHksv/mXyePzJrkApihum6TEkrLgzPQ8fbsE7owbq46yFNyUqVj7o7yBcbJYFyMHh4SAicST
	NS5djJxAppjEhXvr2boYuTiEBC4zSizc+5AFwjnPJHF90TFWkCpeAW2J57MmsoDYLAKqEvcW
	TmcCsdkEdCUW9TQzgQwVFQiS+HNWEaJcUOLkzCdg5SICXhLzH80AGyMs4C9x51UD1Px+Roll
	d2cygiQ4Bfwkth1ZwQxxnLhET2MQSJhZQEfiXd8DZghbXmL72znMExgFZiFZMQtJ2SwkZQsY
	mVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW6KWmlG5ihAQp7w7G/+tkDjEKcDAq8fB2
	vMgIFmJNLCuuzD3EKMnBpCTKO+EzUIgvKT+lMiOxOCO+qDQntfgQowQHs5IIb8MXoBxvSmJl
	VWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYJX/xtQo2BRanpqRVpmTglCmomD
	E2Q4l5RIcWpeSmpRYmlJRjwoSuOLgXEKkuIB2msA0s5bXJCYCxSFaD3FqMtxoWFFC5MQS15+
	XqqUOO/+r0BFAiBFGaV5cCtgKekVozjQx8K8P0CqeIDpDG7SK6AlTEBLuIzTQZaUJCKkpBoY
	1S8ITq9zUT7f/raX+fv3eyVsv5l6Bab78fdPCmzlDnR4skD1rEetzJrYjJaIo9PkdF9nsHwT
	854e8lG9blbzmt9r1ukv4O6ssJG2TW9YI57RP3mblFfAo4IOtzMT5Ffw1Ux7OkXr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248210>

On 05/03/2014 10:12 PM, brian m. carlson wrote:
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/commit.c       |  2 +-
>  builtin/fsck.c         |  4 ++--
>  cache-tree.c           | 30 +++++++++++++++---------------
>  cache-tree.h           |  3 ++-
>  merge-recursive.c      |  2 +-
>  reachable.c            |  2 +-
>  sequencer.c            |  2 +-
>  test-dump-cache-tree.c |  4 ++--
>  8 files changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 9cfef6c..639f843 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1659,7 +1659,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		append_merge_tag_headers(parents, &tail);
>  	}
>  
> -	if (commit_tree_extended(&sb, active_cache_tree->sha1, parents, sha1,
> +	if (commit_tree_extended(&sb, active_cache_tree->sha1.oid, parents, sha1,
>  				 author_ident.buf, sign_commit, extra)) {
>  		rollback_index_files();
>  		die(_("failed to write commit object"));
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index fc150c8..6854c81 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -587,10 +587,10 @@ static int fsck_cache_tree(struct cache_tree *it)
>  		fprintf(stderr, "Checking cache tree\n");
>  
>  	if (0 <= it->entry_count) {
> -		struct object *obj = parse_object(it->sha1);
> +		struct object *obj = parse_object(it->sha1.oid);
>  		if (!obj) {
>  			error("%s: invalid sha1 pointer in cache-tree",
> -			      sha1_to_hex(it->sha1));
> +			      sha1_to_hex(it->sha1.oid));
>  			return 1;
>  		}
>  		obj->used = 1;
> diff --git a/cache-tree.c b/cache-tree.c
> index 7fa524a..b7b2d06 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -219,7 +219,7 @@ int cache_tree_fully_valid(struct cache_tree *it)
>  	int i;
>  	if (!it)
>  		return 0;
> -	if (it->entry_count < 0 || !has_sha1_file(it->sha1))
> +	if (it->entry_count < 0 || !has_sha1_file(it->sha1.oid))
>  		return 0;
>  	for (i = 0; i < it->subtree_nr; i++) {
>  		if (!cache_tree_fully_valid(it->down[i]->cache_tree))
> @@ -244,7 +244,7 @@ static int update_one(struct cache_tree *it,
>  
>  	*skip_count = 0;
>  
> -	if (0 <= it->entry_count && has_sha1_file(it->sha1))
> +	if (0 <= it->entry_count && has_sha1_file(it->sha1.oid))
>  		return it->entry_count;
>  
>  	/*
> @@ -311,7 +311,7 @@ static int update_one(struct cache_tree *it,
>  		struct cache_tree_sub *sub;
>  		const char *path, *slash;
>  		int pathlen, entlen;
> -		const unsigned char *sha1;
> +		const struct object_id *sha1;
>  		unsigned mode;
>  
>  		path = ce->name;
> @@ -327,21 +327,21 @@ static int update_one(struct cache_tree *it,
>  				die("cache-tree.c: '%.*s' in '%s' not found",
>  				    entlen, path + baselen, path);
>  			i += sub->count;
> -			sha1 = sub->cache_tree->sha1;
> +			sha1 = &sub->cache_tree->sha1;
>  			mode = S_IFDIR;
>  			if (sub->cache_tree->entry_count < 0)
>  				to_invalidate = 1;
>  		}
>  		else {
> -			sha1 = ce->sha1;
> +			sha1 = (struct object_id *)ce->sha1;

This topic was discussed on the mailing list in the abstract.  Here is a
concrete example.

This cast is undefined, because you can't make the assumption that
cache_entry::sha1 has the same alignment and padding as (struct object_id).

I think the transition will be more tractable if you rewrite the data
structures *first*; in this case changing cache_entry::sha1 to be
(struct object_id) *before* rewriting code that works with it.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
