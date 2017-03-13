Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B25920373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbdCMVgj (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:36:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:51900 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751566AbdCMVgf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:36:35 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MePYV-1cagW03xIl-00QBuW; Mon, 13
 Mar 2017 22:36:24 +0100
Date:   Mon, 13 Mar 2017 22:36:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     David Aguilar <davvid@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Christophe Macabiau <christophemacabiau@gmail.com>,
        Git ML <git@vger.kernel.org>
Subject: Re: [PATCH] difftool: handle changing symlinks in dir-diff mode
In-Reply-To: <20170313175640.14106-1-davvid@gmail.com>
Message-ID: <alpine.DEB.2.20.1703132212430.3767@virtualbox>
References: <alpine.DEB.2.20.1703072332370.3767@virtualbox> <20170313175640.14106-1-davvid@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yf46MwGdawQXUnM5FWQoi8SWs7Pwmr9YgnoXydsPQjNhuyt5+Ap
 21vqDZPeqzCMgqLWNwnydDgqlNjCaosApsNI/XiZF2WX48rjSBo0rq2ukM6zdpETPOByX0q
 R1McDPZAG4VW6ycWtZFOO8+Dseq75nV7x/6LGaYUWfeOuTtPZ4oTRWVHh9w9RkdRa6ShN6e
 wH9LS8dBXKQYmubkfAP7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8d9LXEjvoCE=:rOy86Zd0/HAEfpcFOfxYBp
 liTT0+S4ClxDCpUjXJbAkeXOEXHmO+2KjKMT93fbMnLKkU1cRR5RUybN09AaYOOH0m9Rw9MDc
 a3dp58FAd2t+lmd/F8BIr0/2HqYHGBeHTNmd8C75u69F1FplqIjI0j/Bghgx3nmIcDDMy4CI+
 wI/JHiVHqU0lbQnZpDXBVSh7mgphl6fKMyc8iVpAe3ixxb71534SieYs4mpVhu/c9KCCkGEF8
 djzLOQYtRfqUv7ECvg7zI3bgaDWyG3OkVQeM+GWuN6sEsvXGOmc6cF0MGTC5f2t52VIiX2ADV
 Gxh3IFDqLy+uIFP5DXXl32R8KVOripxO2iqrzxfue4dYPEVEVfN1SkenhbrfFEef4obLKFmaW
 OYW1tJzWXbbzJ9yDudi3Ma87p/ib5j33UBIr1m3La26wLLxFpf27RfWTj+yw9hMraAm7Xxyi0
 9YRhuSA2Db1ZEf0F5F4YM4nuQaiOlV0uPcA9JtPeiYRBxmLwtXpTIFlz1qx3CCkQpRi5Rsbiw
 /AdCXChiFfdvRVRG2T0gyhvhDgNf41wsFDeK7aHpd+Mz3g0HRO6L6gsVwglXWYOAMVQ+S6YoN
 Swa50U/xzjQenQnO2WfJW2xuX9mERwURgfuTTVrwbumi9GxceGaRRQbs1AvEgc1boZ4mGApFO
 PYXq8Qzm4HqrFs+/Yp01rcHRwnmttUVeIBEnLEnUXEMEHgEDQGpHnDWdObXUF6iaStBBNAtg5
 BJVbNBxGtKBAHzu1KR5Lvr9+aNiHIe//pBQ+SkSwL1gVLKJFuky43fZWej31CbMHNwCr9m8wh
 Wq4g+bZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

Thank you very much for picking this up!

On Mon, 13 Mar 2017, David Aguilar wrote:

> Detect the null object ID for symlinks in dir-diff so that difftool can
> prepare temporary files that matches how git handles symlinks.

Maybe a description is needed how the OID can be null in that case. I have
to admit that I failed to wrap my head around this so far.

> Previously, a null object ID would crash difftool.  We now detect null
> object IDs and write the symlink's content into the temporary symlink
> stand-in file.
> 
> Original-patch-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index d13350ce83..6c20e20b45 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -254,6 +254,31 @@ static int ensure_leading_directories(char *path)
>  	}
>  }
>  
> +static int create_symlink_file(struct cache_entry* ce, struct checkout* state)
> +{
> +	/*
> +	 * Dereference a worktree symlink and writes its contents
> +	 * into the checkout state's path.
> +	 */
> +	struct strbuf path = STRBUF_INIT;
> +	struct strbuf link = STRBUF_INIT;
> +
> +	int ok = 0;

It would appear that the convention in Git's C code is for functions to
return 0 upon success and -1 upon error, and to use `int ret` for that
purpose.

> +	if (strbuf_readlink(&link, ce->name, ce_namelen(ce)) == 0) {

Looking at the calling site, I would have expected the code to read the
contents as per ce->hash... After all, we are calling this in the
!use_wt_file() case.

But that is exactly that null hash, isn't it?

> @@ -414,7 +439,12 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,

The lines before this hunk read:

>                       if (!use_wt_file(workdir, dst_path, &roid)) {
>                               ce->ce_mode = rmode;

... and then follow these lines:

>  				oidcpy(&ce->oid, &roid);
>  				strcpy(ce->name, dst_path);
>  				ce->ce_namelen = dst_path_len;
> -				if (checkout_entry(ce, &rstate, NULL))
> +
> +				if (S_ISLNK(rmode) && is_null_oid(&roid)) {
> +					if (!create_symlink_file(ce, &rstate))
> +						return error("unable to create symlink file %s",
> +							     dst_path);
> +				} else if (checkout_entry(ce, &rstate, NULL))
>  					return error("could not write '%s'",
>  						     dst_path);
>  			} else if (!is_null_oid(&roid)) {

Given that we explicitly ask use_wt_file() whether we can use the
worktree's file, and we get the answer "no" before we enter the modified
code block, I would really expect us *not* to want to read the link from
disk at all.

Further, reading the code of use_wt_file(), there seems to be another case
where roid is left alone: when the file could not be lstat()ed. So I
wonder whether the create_symlink_file() is the correct solution, or
whether we could somehow fill roid correctly instead, and keep the
checkout_entry() call?

Ciao,
Dscho
