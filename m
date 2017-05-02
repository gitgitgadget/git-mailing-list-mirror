Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E16DE1F790
	for <e@80x24.org>; Tue,  2 May 2017 18:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbdEBSFS (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 14:05:18 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34536 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbdEBSFR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 14:05:17 -0400
Received: by mail-pf0-f174.google.com with SMTP id e64so811749pfd.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 11:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LxBPfy7TfFKXOnfCQl27v67wV9vdabF/0ty6B7VI9aU=;
        b=ID85qNhYgbIHly1Nsdl37ahvj1IRg0xAoAS1sdYnVgfROcSyqqR+YxBjcOxN62cJdd
         8EaUb9lcRKOnVif60aC+CPZ+k3ajtgkQSrC4QBxSWJVogPvRHWK9Kb6qa0F2l0hEMIsU
         K6hn2c/fzkHE7xc3MU/OhK2ANraWupnkOgmFHKgA7/qhohB3sqM1aHBQ0JEUVp44wsDK
         CAT3llvWzQKkCu7v2BsrriafYnW4j0TiIxZ8SjlHLfOP6GZFphXRF9tz7wNa8m1zYEni
         iQJNrBH+VF9nPP+5nbU9Tlfd/330y87DAZQDk3fAnauKuvva7M6XxVPTFaW8ZzuB50Fh
         aRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LxBPfy7TfFKXOnfCQl27v67wV9vdabF/0ty6B7VI9aU=;
        b=YJzkYYhhZq71V0gIejfyENezIfOkZAXi9ZUUA8iwT2TVq4DdnJcdsnjKGNAk9UtZDy
         FfRNuT4j7EePL89FKADAzlQveBc39nqRpwJaXsIob8Nuqemh5PJE74njlCXab89oLmGJ
         21pxPvRlgQKeI0IxnuNdv2EU5ARxmT3MdzpDaKnNS52Vi+4Px/KvpidRTna16NliIDys
         8D1G22wU2gV0Oqm1M7xGOGBgFOWI3ua3zQKjXs6pgtk8f8n8vG0SmyGH2OW+9arP68hh
         gHuSpT8aNtPC52kY5VycHmR2pVeQ6NUsPwEe5F/nFmI+50wIMoUna9ytfEncPp/O59dt
         Tqnw==
X-Gm-Message-State: AN3rC/47nkSHUv3wAyHaCeLB/puWze7j9GMz7p6lci14e5GnFABx2W0f
        FLs68iDUiCOXguTZ
X-Received: by 10.98.11.205 with SMTP id 74mr305978pfl.214.1493748316916;
        Tue, 02 May 2017 11:05:16 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:61ee:b5d7:71fe:5285])
        by smtp.gmail.com with ESMTPSA id 194sm4143352pgf.62.2017.05.02.11.05.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 11:05:15 -0700 (PDT)
Date:   Tue, 2 May 2017 11:05:14 -0700
From:   Brandon Williams <bmwill@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 02/53] Clean up outstanding object_id transforms.
Message-ID: <20170502180514.GC181268@google.com>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
 <20170501022946.258735-3-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170501022946.258735-3-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01, brian m. carlson wrote:
> The semantic patch for standard object_id transforms found two
> outstanding places where we could make a transformation automatically.
> Apply these changes.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/diff.c | 2 +-
>  reflog-walk.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/diff.c b/builtin/diff.c
> index d184aafab..a25b4e4ae 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -408,7 +408,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  		} else if (obj->type == OBJ_BLOB) {
>  			if (2 <= blobs)
>  				die(_("more than two blobs given: '%s'"), name);
> -			hashcpy(blob[blobs].oid.hash, obj->oid.hash);
> +			oidcpy(&blob[blobs].oid, &obj->oid);
>  			blob[blobs].name = name;
>  			blob[blobs].mode = entry->mode;
>  			blobs++;
> diff --git a/reflog-walk.c b/reflog-walk.c
> index 99679f582..c8fdf051d 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -241,7 +241,7 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
>  		logobj = parse_object(reflog->ooid.hash);
>  	} while (commit_reflog->recno && (logobj && logobj->type != OBJ_COMMIT));
>  
> -	if (!logobj && commit_reflog->recno >= 0 && is_null_sha1(reflog->ooid.hash)) {
> +	if (!logobj && commit_reflog->recno >= 0 && is_null_oid(&reflog->ooid)) {

Not relevant to this series but I was confused for a second seeing
'ooid' as I have no clue what that means :)

>  		/* a root commit, but there are still more entries to show */
>  		reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
>  		logobj = parse_object(reflog->noid.hash);

-- 
Brandon Williams
