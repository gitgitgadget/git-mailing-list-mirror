Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633661;
	b=nBnE55kCbwHFlNukQPUX4v2Jg2/4eNsTNzLbSqDHPeGZ1j2Ey1vfSqIsBWzcduklmB4i
	 OeGUip/3m4pxVMxFHstr4o+R/Y9CF7yGWbDDeYz04AhlGY9wbcCtY5F8DUpEKeNIYoKyD
	 uOawR54jKRO7kqOGLW3xST+QKvnBzsNVtlaC34yHyyDArmwGEy0Qj0dKINrKBDBFqtLmq
	 qknXMrxft7JnZ8sqHedpL9uuWGzUierHLZt20rrzuuQf9FGpFhJz2fXoiRtW264czosqw
	 xGCqje83bCwDi/EwA68bCw6bcA2caJjOEzFwuqDSISYKQUgukDLlmz4O/gs8PhyUKzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633661;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Yp84Dx9Kw+Iz2ESlJRDRnhoZC1dgK4PH00RQq2C81UA=;
	b=eLdvOujqmdTv7XJYyjz1KL9PhRt57fljHsjMIle7g7c5wCPwapTuxzQCWLkpGVWhLdWI
	 ErcIlvapnMURV4rEMd7BKPUfgEDoVXeTC8PC5GIgtLty+L9/rDnWp9bE5DhUr/ZBFMrE2
	 1yexlg88LqM1dXwi+jZQHIynImePrMpr0j5h5zcB/riovfvGl+JPZHcySRGhBklNhc4dn
	 +1dN1OLYlTqanGFIfHk33ATOCKfXs1fGL+zYzkAS6b44LbTEixMhtxgKVZqFdqk929uDB
	 CHyFHKNxUF6SdKvbLOq9jdM2csK9qeRtUCgM1CukSTCEE4062W9K6wgf4YuOmP7IT2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=igMH6lCo;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TtoK5VBW;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9754606A327
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9754606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=igMH6lCo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TtoK5VBW
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 0BBDEEC0C50
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:07:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 25 Nov 2026 14:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795633660; x=1795720060; bh=Yp84Dx9Kw+
	Iz2ESlJRDRnhoZC1dgK4PH00RQq2C81UA=; b=igMH6lCoaYjJ46+snIGoeztnTl
	balj9aqEDz5iInmwK5eWG4Fu/TWvUOUBV5PPs9n3jbqN4HRoQfiCo0iJiDL6wH/x
	bUdSjdA3QsFNeB2WlyRSmlpP9vurBN3MO9rBpyHAmFyMqUHTnq+Qer5hkV+VYxBc
	YB2sqrMgwBeauCo+3hj798hYoHiBVqh/gc6dMfEf3JSijRUSVdt5mm69kk9XJ24m
	MeS0d6Tf9lH6ogjJZXRM1a2iwoGh0jXbiu+8EkJ7yXaCjZ3e+SoZOshZAEH2NHgF
	lGAnpnLbCLlq1/pIDDqzcwi77EJofJ5ar2ZX7/n3aXdUYGH/5xsCG41twCsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795633660; x=1795720060; bh=Yp84Dx9Kw+Iz2ESlJRDRnhoZC1dgK4PH00R
	Qq2C81UA=; b=TtoK5VBWT92vhbagergzI9nwtvQfu1gyN22MBSx8R1rsrbqyItq
	dxDagAUjozMpK7BaMgOf3wIP6ki7YWtdt3yX5v5voJl9WKoOY7Y6gxN8pI2DSMVv
	S8onEUni7W7L0JEB/T9iJm6dQJ52OHoahpGoxlCcR/M/gTzCedHTlwTcoLIpfobK
	2gKzJkxoMZOdyuh+/6CVxBOBF+VGkgUdzCItK7pbwKUDWzEHuDk0xQYr8vTW8APS
	cZLA7U7u5y+J3oeiYQ0GreTnKrmGUacFSx5IUKWCFd4t45+8EO67ADecLioi4/Bm
	5yHXSMuAocdE1XAsLRe60gLgZtlTPo8+Otg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795633660; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Ecw5RmkhtBZMM+cz+LdJ6U65yCaj09OrcXiw3hqdKw4cZri
	EnrbUEzkUUMkzowVpkBhMu+FF7rEGNFWbieUizINshMYNGRJ4PKwd5C9bZ9yvYeA
	aPCGMbA7YKJDLofx+zrj9NOku3oxSJt8xojFsjPmkIpUwhZKRKyWjHtYjxbA1lqn
	x6cRIkKLLCNyEcypi6Z0Krg7gH8spZyqL2WE8DYddRvAdl0NZ1nGRecOPRgL7nfx
	24T0cDgYX8hMnf7msARBqy6XvI/OAu3Rcnswj38n0FmqwSXopG8jJvubT5rnqBn0
	84/Ko8ml/YNXYTlh5VllMDQQ3ELdPUxXGcswLVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:7s7fpg4pENVwFkuvjAg9TyN0Sx2CTsXz+fwNxVXAmZk=:exMA5Y2pNYi6O9vhhBwm1naU+hoXQ2MCP7QjOMC2Q+0=;
X-ME-Sender: <xms:-zEHawXQIns3sj6U0qdC2XygrKUv74-yW5YMBDLgKcel7TJiMOeEvQ>
    <xme:-zEHa4RRxMZCUqUi9vXNSHxcrUvPIOJeXCY5IfIP_X7OaL6YQG6BbkvpOHeGNR04r
    LsPSi4w38iMsPgTZy-FUeMqgeRw5HNAmJLqPVNjoWGWvzqL8CnuRl0>
X-ME-Received: <xmr:-zEHa-OnRukEtIph-93Fk358ui6Zhd5HG_GdciDWDVlD1AbFHcfLFNGzyjtdZ_KKiX_uC7hHDpg2z5UBMroYmgTFMaIJbxAqBWDWwz8>
X-ME-Proxy-Cause: dmFkZTFV0j9q97yMTo2F6xpYUCmh8tSGCfPB/rnHjO6JCDJ3gnInVPU+LTa1oGWQ5gHGvG
    jqDJW1ohoCzcbfXUPbDcxv9pFH2bSO0d8N/PV1nJm8JznuJG+rTURsbmUodjX2CfnQnwoY
    2ikSifFuvg+cIQ8xslm9jp9zM/7e19q9rbuiU1+Ckeq7mKn/ulAc6EDjZnzD+eYlIEyePS
    AgQ53EQL+L5xn+hxN7/kZORT9mCCTtr+aixl/DyAlagHvgBe8xz7aYKMDUfGAsI/XcXhNq
    I5C6jV/L99zAUavM7O5A7NSq59jr/ocnZgZEuPBjOt1EYK8EYdEYJGqYyG5kSyLk+fQqrU
    AfgCrPO8a7ENbBadDBlXTYkEYASmk9ATMO2a1jat8toaMHklZdICoV7JRbCXGmf5pZ0d9x
    JAycibKfExoKxPvlmovX2T7UOYXWdUEv1LCCRHWfyePxcrO2UPQ9D+yHdh+kh7c7ZKjuWe
    dvCTXKxnFoaXz4QMoCxvlrpfCXB1hYT4982FljCyc4KyivShISuWf4aqYXsam0qPWyO+rb
    avwx1PGmmG0sy6/gAJYOoEqQWQv6iR70QHQIje45RSVeXIS6SKzSp5PrrDyMTMSzNnzpFB
    JLaZerathAy2dSyVq43uVaFZBBTmm50f5KZmCpip1f31S6b0qya59X/XlHiQ
X-ME-Proxy: <xmx:-zEHa2TdHFG-IDVy02GRRHUt9Lr_GHQYIBEGTvVK06CcHwqXEKE_uA>
    <xmx:-zEHa8jq165l3on6J4GdjPZM3R-gt4skNEe-lSvqUVXFLoXoDzZZDw>
    <xmx:-zEHa__Fbt53zsdSLfKuzCiemAfJfs5nr10HZcwM3QmHUWoxtrEc_Q>
    <xmx:-zEHazHeKfIRwpaw57JLLq__u9nUIlr-rbYEnB6ssDy7dOWed_xYFA>
    <xmx:_DEHaxKdDnfJ9iWERwU-q8xWlqgAWpLwM7XuIplzZTkRhekWoWK2K-gL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 14:07:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Adithya Chakilam via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Martin Fick <mfick@nvidia.com>,  Christian Couder
 <christian.couder@gmail.com>,  Adithya Chakilam <achakilam@nvidia.com>
Subject: Re: [PATCH v2 1/2] repack: add --filter-to-loose to write
 filtered-out objects as loose objects
In-Reply-To: <4157ce33a1d6c392575cc27fee7c6bd3126e97c6.1795571091.git.gitgitgadget@gmail.com>
	(Adithya Chakilam via GitGitGadget's message of "Wed, 25 Nov 2026
	01:44:50 +0000")
References: <pull.2314.git.1794607911.gitgitgadget@gmail.com>
	<pull.2314.v2.git.1795571091.gitgitgadget@gmail.com>
	<4157ce33a1d6c392575cc27fee7c6bd3126e97c6.1795571091.git.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 11:07:38 -0800
Message-ID: <xmqq4id43f2d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Adithya Chakilam via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Add --filter-to-loose=<dir> to write filtered-out objects directly as
> loose objects into <dir>, treating it as an object directory. Stream
> the filtered pack into unpack-objects instead of writing an intermediate
> pack file to disk.

Micronit: the patch to the documentation says <directory>, not <dir>.

> The filtered pack is built with --stdin-packs, so this initially handles
> only objects already stored in packs. Loose objects in the source
> repository are left in place.
>
> Signed-off-by: Adithya Chakilam <achakilam@nvidia.com>
> ---
>  Documentation/git-repack.adoc |  11 ++-
>  builtin/repack.c              |  25 ++++-
>  repack-filtered.c             |  44 ++++++++-
>  repack.h                      |   1 +
>  t/t7700-repack.sh             | 172 ++++++++++++++++++++++++++++++++++
>  5 files changed, 246 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
> index a1f9e64f66..bcd7c1fe54 100644
> --- a/Documentation/git-repack.adoc
> +++ b/Documentation/git-repack.adoc
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
>  	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
>  	[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]
> -	[--filter=<filter-spec>] [--drop-filtered [--dry-run]]
> +	[--filter=<filter-spec> [--filter-to-loose=<directory>]] [--drop-filtered [--dry-run]]

This is getting overly long.  Time to line-wrap?

> @@ -183,6 +183,15 @@ depth is 4095.
>  	`objects` and `objects/info/alternates` sections of
>  	linkgit:gitrepository-layout[5].
>  
> +--filter-to-loose=<directory>::
> +	Like `--filter-to`, but treat `<directory>` as an object
> +	directory and write the filtered out objects there as loose
> +	objects instead of as a pack. The directory must already
> +	exist. Cannot be combined with `--filter-to` or
> +	`--max-pack-size`. Objects already present in `<directory>` are
> +	not rewritten. All objects are written before any existing
> +	pack is removed.

I wonder if the readers find this description sufficient to decide
between the use of this option and writing the evicted objects into a
pack.  What is your motivation behind the addition of this option?  What
makes it more useful to evict them as individual loose object files, as
opposed to a single 'junk' pack?  Is there some lesson or story you can
offer to help the readers decide if this option matches their needs?


> diff --git a/builtin/repack.c b/builtin/repack.c
> index 21835453c6..dc2b4a3ce2 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -1,6 +1,7 @@
>  #define DISABLE_SIGN_COMPARE_WARNINGS
>  
>  #include "builtin.h"
> +#include "abspath.h"
>  #include "config.h"
>  #include "environment.h"
>  #include "parse-options.h"
> @@ -41,7 +42,7 @@ static const char *const git_repack_usage[] = {
>  	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
>  	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
>  	   "[--write-midx[=<mode>]] [--name-hash-version=<n>] [--path-walk]\n"
> -	   "[--filter=<filter-spec>] [--drop-filtered [--dry-run]]"),
> +	   "[--filter=<filter-spec> [--filter-to-loose=<directory>]] [--drop-filtered [--dry-run]]"),
>  	NULL
>  };
>  
> @@ -182,6 +183,7 @@ int cmd_repack(int argc,
>  	const char *cruft_expiration = NULL;
>  	const char *expire_to = NULL;
>  	const char *filter_to = NULL;
> +	const char *filter_to_loose = NULL;
>  	const char *opt_window = NULL;
>  	const char *opt_window_memory = NULL;
>  	const char *opt_depth = NULL;
> @@ -257,6 +259,8 @@ int cmd_repack(int argc,
>  			   N_("pack prefix to store a pack containing pruned objects")),
>  		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
>  			   N_("pack prefix to store a pack containing filtered out objects")),
> +		OPT_FILENAME(0, "filter-to-loose", &filter_to_loose,
> +			   N_("object directory to write filtered out objects into as loose objects")),

As OPT_FILENAME() always gives you a newly allocated string, you would
need to free(filter_to_loose) below the 'cleanup' label, where you
release resources held by other variables like 'po_args', 'existing',
etc.

It may make sense to drop 'const' from the type, as it seems to be our
convention to make things we pass to free() non-const.

> @@ -282,8 +286,19 @@ int cmd_repack(int argc,
>  	po_args.depth = xstrdup_or_null(opt_depth);
>  	po_args.threads = xstrdup_or_null(opt_threads);
>  
> -	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
> -		!!filter_to, "--filter-to");
> +	die_for_incompatible_opt3(drop_filtered, "--drop-filtered",
> +			!!filter_to, "--filter-to",
> +			!!filter_to_loose, "--filter-to-loose");
> +	die_for_incompatible_opt2(!!filter_to, "--filter-to",
> +			!!filter_to_loose, "--filter-to-loose");
> +	die_for_incompatible_opt2(!!filter_to_loose, "--filter-to-loose",
> +			!!po_args.max_pack_size, "--max-pack-size");
> +
> +	if (filter_to_loose) {
> +		if (!is_directory(filter_to_loose))
> +			die(_("'%s' is not a directory"), filter_to_loose);
> +		filter_to = filter_to_loose;
> +	}

What happens when you use --filter-to-loose and specify your own object
directory, e.g., --filter-to-loose=objects in a bare repository, or
--filter-to-loose=.git/objects?

unpack-objects runs while the source packs are still on disk, sees via
odb_freshen_object() that every filtered-out object already exists in a
pack, and skips writing loose copies.  With -d, cmd_repack() then
removes the old packs, losing those objects, I suspect.

Perhaps you want to prevent such permanent data loss by comparing
realpath(filter_to_loose) and repo_get_object_directory(repo) or
something?  Perhaps add a test to make sure this does not happen?

>  	else if (filter_to)
> -		die(_("option '%s' can only be used along with '%s'"), "--filter-to", "--filter");
> +		die(_("option '%s' can only be used along with '%s'"),
> +		    filter_to_loose ? "--filter-to-loose" : "--filter-to", "--filter");

OK.

> +test_expect_success '--filter-to-loose writes filtered out objects loose' '
> +	rm -rf loose-work loose-src.git loose-dst.git &&
> +	git init --bare loose-dst.git &&
> +	git init loose-work &&
> +	test_commit -C loose-work base file1 content1 &&
> +	git clone --bare loose-work loose-src.git &&
> +	git -C loose-src.git repack -a -d &&
> +
> +	blob=$(git -C loose-src.git rev-parse HEAD:file1) &&
> +	git -C loose-src.git -c repack.writebitmaps=false repack -a -d \
> +		--filter=blob:none --filter-to-loose=../loose-dst.git/objects &&
> +
> +	test_path_is_file loose-dst.git/objects/$(test_oid_to_path $blob) &&
> +	find loose-dst.git/objects/pack -name "*.pack" >actual-packs &&
> +	test_must_be_empty actual-packs &&
> +	test_must_fail git -C loose-src.git cat-file -e $blob &&
> +
> +	echo $(pwd)/loose-dst.git/objects >loose-src.git/objects/info/alternates &&
> +	echo content1 >expect &&
> +	git -C loose-src.git cat-file blob $blob >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--filter-to-loose writes objects that also exist in the source' '
> +	rm -rf loose-work loose-src.git loose-dst.git &&
> +	git init --bare loose-dst.git &&
> +	git init loose-work &&
> +	test_commit -C loose-work base file1 content1 &&
> +	git clone --bare loose-work loose-src.git &&
> +	git -C loose-src.git repack -a -d &&
> +
> +	blob=$(git -C loose-src.git rev-parse HEAD:file1) &&
> +	git -C loose-src.git -c repack.writebitmaps=false repack -a -d \
> +		--filter=blob:none --filter-to-loose=../loose-dst.git/objects &&
> +
> +	test_path_is_file loose-dst.git/objects/$(test_oid_to_path $blob)
> +'

Curious.  This is identical to the early half of the previous test.  If
the previous one passes, this one certainly would, as there is nothing
done differently.
