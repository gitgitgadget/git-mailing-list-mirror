Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2392C20802
	for <e@80x24.org>; Thu, 22 Jun 2017 21:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753708AbdFVVpd (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 17:45:33 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35514 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753379AbdFVVpc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 17:45:32 -0400
Received: by mail-pf0-f176.google.com with SMTP id c73so14478991pfk.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 14:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cdH7MrzoGW1w6J8yfMhY8HknizzMIuCJXyoPqZsMSgQ=;
        b=HarGzhmRE8bqi5q5qI4FRui5B0m91u7paqAWC5bwkN0NAOof0VATZAY2EknX4n0zRj
         onYSHtsCok8+yzOoegI8ofXos3j5BjqdA0ETrmFDvEmAkMbK+/KwO2gHXZfnzFoasy+R
         bzdcQmnrrgR0NkLS18PTCHO461K8EetrWKc9fxxxabxSM2EGEfHED/ElG3chcNXA/VMQ
         Vf1sLf+cEWO7362VfPv2VrHd84ccwb7JWuddWL3GCyXCrXTc/BuPYwx7o25uDHSmExEz
         U/zBHP4+sEd2e6aUvLhmuZWTs18kF8l3OyWNgm0+6XjKjIkEW8rsUkpAxhFgqxaNh6AR
         u++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cdH7MrzoGW1w6J8yfMhY8HknizzMIuCJXyoPqZsMSgQ=;
        b=Yfi464rIPbk4I5S4yYWI1xE8NHm6n/QrQ13bolDS3HRPf64Tx7PNiPJHDDF3YMqMyF
         KCY1H7oPyMI0/lRITWpz90pNk/X7tkfGluO2lhUVDYMumw1KVmYxWo4Ls66oMZzLIswe
         vZaxMov7OSyVB1Pq6hWipm0+z8JRNoUhk2ZI871JARj/2N6vvgVEjpFDTfgpwciubRvT
         xtBPV64Xzp4kVOkyn5wU1wWl5V4in7IlxlUwQ7Ns9Iy25kHCP0rgp7Gx5tmLLE8x40/r
         oINgMfLCRAeVp598ovVUR5MpMwOUvvjW/ckbsFgf7b5LmnqOfepEAz6C0YCM65tF/Ol0
         MKTw==
X-Gm-Message-State: AKS2vOyeUXZBeZhy8l51pyvJ88i3quP0NLQg9eofcGZGUOKsAdE16qlO
        SKhPfQ4li+zS916x
X-Received: by 10.84.225.5 with SMTP id t5mr5235247plj.108.1498167931473;
        Thu, 22 Jun 2017 14:45:31 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:3100:42b2:b45a:528c])
        by smtp.gmail.com with ESMTPSA id l85sm5731809pfj.130.2017.06.22.14.45.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 14:45:31 -0700 (PDT)
Date:   Thu, 22 Jun 2017 14:45:26 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jrnieder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/3] list-objects: add filter_blob to
 traverse_commit_list
Message-ID: <20170622144526.3f5813f5@twelve2.svl.corp.google.com>
In-Reply-To: <20170622203615.34135-2-git@jeffhostetler.com>
References: <20170622203615.34135-1-git@jeffhostetler.com>
        <20170622203615.34135-2-git@jeffhostetler.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 22 Jun 2017 20:36:13 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> In preparation for partial/sparse clone/fetch where the
> server is allowed to omit large/all blobs from the packfile,
> teach traverse_commit_list() to take a blob filter-proc that
> controls when blobs are shown and marked as SEEN.
> 
> Normally, traverse_commit_list() always marks visited blobs
> as SEEN, so that the show_object() callback will never see
> duplicates.  Since a single blob OID may be referenced by
> multiple pathnames, we may not be able to decide if a blob
> should be excluded until later pathnames have been traversed.
> With the filter-proc, the automatic deduping is disabled.

Comparing this approach (this patch and the next one) against mine [1],
I see that this has the advantage of (in pack-objects) avoiding the
invocation of add_preferred_base_object() on blobs that are filtered
out, avoiding polluting the "to_pack" data structure with information
that we do not need.

But it does add an extra place where blobs are filtered out (besides
add_object_entry()), which makes it harder for the reader to keep track
of what's going on. I took a brief look to see if filtering could be
eliminated from add_object_entry(), but that function is called from
many places, so I couldn't tell.

Anyway, I think both approaches will work (this patch's and mine [1]).

[1] https://public-inbox.org/git/6f7934621717141ce3bb6bc05cf1d59c7900ccc5.1496432147.git.jonathantanmy@google.com/

[snip]

>  static void process_blob(struct rev_info *revs,
>  			 struct blob *blob,
>  			 show_object_fn show,
> +			 filter_blob_fn filter_blob,
>  			 struct strbuf *path,
>  			 const char *name,
>  			 void *cb_data)
> @@ -24,11 +25,28 @@ static void process_blob(struct rev_info *revs,
>  		die("bad blob object");
>  	if (obj->flags & (UNINTERESTING | SEEN))
>  		return;
> -	obj->flags |= SEEN;
>  
>  	pathlen = path->len;
>  	strbuf_addstr(path, name);
> -	show(obj, path->buf, cb_data);
> +	if (!filter_blob) {
> +		/*
> +		 * Normal processing is to imediately dedup blobs
> +		 * during commit traversal, regardless of how many
> +		 * times it appears in a single or multiple commits,
> +		 * so we always set SEEN.
> +		 */
> +		obj->flags |= SEEN;
> +		show(obj, path->buf, cb_data);
> +	} else {
> +		/*
> +		 * Use the filter-proc to decide whether to show
> +		 * the blob.  We only set SEEN if requested.  For
> +		 * example, this could be used to omit a specific
> +		 * blob until it appears with a ".git*" entryname.
> +		 */
> +		if (filter_blob(obj, path->buf, &path->buf[pathlen], cb_data))
> +			obj->flags |= SEEN;
> +	}
>  	strbuf_setlen(path, pathlen);
>  }

After looking at this code again, I wonder if we should explicitly
document that SEEN will be set on the object before show(), and that
show() is allowed to unset SEEN if it wants traversal to process that
object again. That seems to accomplish what we want to accomplish
without this expansion of the API.

(This does mean that the next patch will need to call strrchr() itself,
since show() does not provide the basename of the file name.)

Having said that, if we keep with the current approach, I think there
should be a show() call after the invocation to filter_blob(). That is
much less surprising to me, and also allows us to remove some
show_object() invocations in the next patch.

> +void traverse_commit_list_filtered(
> +	struct rev_info *revs,
> +	show_commit_fn show_commit,
> +	show_object_fn show_object,
> +	filter_blob_fn filter_blob,
> +	void *data)
> +{
>  	int i;
>  	struct commit *commit;
>  	struct strbuf base;

Git style is to indent to the location after the first "(", I believe.
Likewise in the header file below.

>  typedef void (*show_commit_fn)(struct commit *, void *);
>  typedef void (*show_object_fn)(struct object *, const char *, void *);
> +typedef int  (*filter_blob_fn)(struct object *, const char *, const char *, void *);

Can this have parameter names added (especially both the const char *
ones, otherwise indistinguishable) and, if necessary, documented?
