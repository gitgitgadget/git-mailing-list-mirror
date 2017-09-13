Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890E0209B8
	for <e@80x24.org>; Wed, 13 Sep 2017 08:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbdIMIpv (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 04:45:51 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:56666 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750931AbdIMIpt (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 04:45:49 -0400
X-AuditID: 12074411-f95ff70000007f0a-a3-59b8f03ce1b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 4B.6C.32522.C30F8B95; Wed, 13 Sep 2017 04:45:48 -0400 (EDT)
Received: from [192.168.69.190] (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8D8jkMq007257
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 04:45:47 -0400
Subject: Re: [PATCH 4/4] packed refs: pass .git dir instead of packed-refs
 path to init_fn
To:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Richard Maw <richard.maw@gmail.com>
References: <20170912172330.GA144745@aiede.mtv.corp.google.com>
 <20170912173234.GE144745@aiede.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <827535d1-b549-8fe6-166c-23148d4290d8@alum.mit.edu>
Date:   Wed, 13 Sep 2017 10:45:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170912173234.GE144745@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1LX5sCPS4McUcYuuK91MFm9vLmG0
        uHukj8Vi8+Z2FgcWj52z7rJ7LNhU6vF5k1wAcxSXTUpqTmZZapG+XQJXxr6Dt5gK1qhVnNt7
        h6WB8YZ8FyMnh4SAiUT76w3sXYxcHEICO5gk3m55wgLhnGeSWHdoJyNIlbBAjET/1142EFtE
        wFZi+ZVlrCA2s4C3xNUTf9hBbCGBUolHjTvA4mwCuhKLepqZuhg5OHgF7CUW/6sDCbMIqEos
        PbMKrFxUIEKi7+1lMJtXQFDi5EyQvZwcnAIOEtN7frFDjFeX+DPvEjOELS5x68l8JghbXmL7
        2znMExgFZiFpn4WkZRaSlllIWhYwsqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXVy80s0UtN
        Kd3ECAltwR2MM07KHWIU4GBU4uFdcWd7pBBrYllxZe4hRkkOJiVR3v17dkQK8SXlp1RmJBZn
        xBeV5qQWH2KU4GBWEuGVfAeU401JrKxKLcqHSUlzsCiJ8/ItUfcTEkhPLEnNTk0tSC2Cycpw
        cChJ8Pq8B2oULEpNT61Iy8wpQUgzcXCCDOcBGr4UbHhxQWJucWY6RP4Uo6KUOG8+SEIAJJFR
        mgfXC0s9rxjFgV4R5pUAWcEDTFtw3a+ABjMBDT5zGmxwSSJCSqqBceKpvAf73rmLtN12W2jB
        Jr7x9ptjUx1LLLbb3GUN5fTgKtDZkpIszZj/4knKzUsGzSbpdyIUM7fabc63/n3GfFXg7zbP
        JMYpMivdYpcYH53Lsf8Vn45tf4nhpv0/ty/1al6gyGWVt/NcwYUdiu5R0W3HZuwpX++0a54K
        d5XuxIK63ux07dw+JZbijERDLeai4kQAUwtM2xgDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/12/2017 07:32 PM, Jonathan Nieder wrote:
> From: Stefan Beller <sbeller@google.com>
> 
> The first argument of a ref_store_init_fn is documented to represent
> the $GIT_DIR, not the path to the packed-refs file. This brings the
> packed-refs store more in line with the usual ref store interface.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> That's the end of the series.  Thanks for reading.
> 
>  refs/files-backend.c  | 4 ++--
>  refs/packed-backend.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index fccbc24ac4..3b8e13a8b7 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -57,8 +57,8 @@ static struct ref_store *files_ref_store_create(const char *gitdir,
>  	refs->gitdir = xstrdup(gitdir);
>  	get_common_dir_noenv(&sb, gitdir);
>  	refs->gitcommondir = strbuf_detach(&sb, NULL);
> -	strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
> -	refs->packed_ref_store = packed_ref_store_create(sb.buf, flags);
> +	refs->packed_ref_store =
> +			packed_ref_store_create(refs->gitcommondir, flags);
>  	strbuf_release(&sb);
>  
>  	return ref_store;
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 412c85034f..2c5db15279 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -78,7 +78,7 @@ struct packed_ref_store {
>  	struct tempfile tempfile;
>  };
>  
> -struct ref_store *packed_ref_store_create(const char *path,
> +struct ref_store *packed_ref_store_create(const char *common_dir,
>  					  unsigned int store_flags)
>  {
>  	struct packed_ref_store *refs = xcalloc(1, sizeof(*refs));
> @@ -87,7 +87,7 @@ struct ref_store *packed_ref_store_create(const char *path,
>  	base_ref_store_init(ref_store, &refs_be_packed);
>  	refs->store_flags = store_flags;
>  
> -	refs->path = xstrdup(path);
> +	refs->path = xstrfmt("%s/packed-refs", common_dir);
>  	return ref_store;
>  }
>  
> 

This little patch, perhaps surprisingly, brings up some deeper issues.

First of all there is a superficial naming inconsistency. This method is
called `init` in the vtable, but the functions implementing it are
called `*_ref_store_create()`. It actually initializes the data
structures for dealing with the reference store, as opposed to
initializing the reference store on disk (*that* virtual function is
called `init_db`). It should maybe be called `open` instead.

But more fundamentally, what is a `ref_store`? Originally it always
represented a *logical* place to store all of the references for a
repository. In that sense, it made sense to have an "open" method that
takes a `gitdir` as argument.

But its role is currently getting stretched. Now it sometimes represents
a *physical* place to store references, which might be combined with
other physical `ref_store`s to make a logical `ref_store`. There is not
necessarily a 1:1 correspondence between gitdirs and physical
`ref_store`s; more to the point you might want to initialize a physical
refstore that doesn't correspond to `$GITDIR`. So requiring every
`ref_store` to have a factory function with a gitdir argument is
probably incorrect.

For example, a subtree has a single logical reference store, but it is
composed out of three physical reference stores: the loose references in
the subtree's gitdir plus loose and packed references in the common gitdir.

It seems to me that we need two separate concepts:

1. Create an object representing a gitdir's *logical* `ref_store`. This
"class method" could always have a single gitdir as parameter. This
would be the method by which the repository initialization code
instantiates its logical `ref_store`, for example by reading the type of
the reference store from the repo's config, then looking up the class by
its type, then calling its "open" method to create an instance.

2. Create an object representing a physical `ref_store`. Different
reference store classes might have different "constructor" arguments.
For example, if it represents a namespace within a larger reference tree
contained in a shared repository, its arguments might be
`(shared_gitdir, namespace)`. (CC to Richard Maw for this angle.)

Since a `packed_ref_store` is definitely a physical `ref_store`, the
function that we're talking about here is the second type, so I don't
see a need for it to take a gitdir as argument. OTOH, the function
certainly doesn't belong in the vtable slot for `init`, because a
`packed_ref_store` can't serve as a repository's logical reference store.

Did you have a particular reason for changing this now, aside from
"consistency"? If not, feel free to drop this patch and I'll implement
something more like what I have described above when I have time.

Michael
