Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0A4220286
	for <e@80x24.org>; Wed, 13 Sep 2017 14:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbdIMOG6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 10:06:58 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:44573 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbdIMOGw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 10:06:52 -0400
Received: by mail-wr0-f178.google.com with SMTP id v109so786741wrc.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 07:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p/H19Byxl4xArD4a7bfT3ON2wIwlAlFd0UvyY6Om0V8=;
        b=JGoD7g8h0TXgQUOoAdVTmw8bHZWh9RjvMveUYTFFuUXvjuJNkkZPvRyU9/DW/ALmzv
         r9sZFeGXUMagj1d9CGyjB6ogqY/Nnb/dsK9laRvKSMLFXLXoNaynQOIEd/7r5dCmLVrD
         l0VYTtJj6+YW8eO3bNUHaTpOw1ihmQk2rhpa+mOFKMOnXPu/pY3sGhrbkgNDd1IpHkTP
         awcs5w96owddTaABvoJEsJ4rEihXYXaUOKuyri/zMEkj6HNTu5OgpqT/o5gOYcgznjy4
         4bZnpUrMwDJas7UjWywy6c3JZhir6nnlKD3nXteJMOC0E4E5S2cCzJ5Pxp4B+6e02F7P
         /OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p/H19Byxl4xArD4a7bfT3ON2wIwlAlFd0UvyY6Om0V8=;
        b=psZLDAnzefbqjgiJOuEaB9Xx8I6ulFCME5InWiPaOrmLHo6Q5n3J3I/r1FzOqfAdZ7
         VgTPdxtacLNtnvw+QEfbF9QWxWS+HkWLH+uu5OYYziXz7GGeYT+7FpfzZYQznWgY3Z6x
         bAhvl8KvFh2UHCgVbiTo0EdetlWg3530oyjwKVrujxFQbXGviDpfcXfgRhYLOFN7L9b0
         O5nCHJclsIqu+Z7pFMD+zcmCeC9M75TIf+5AAYaYn5ZMn1McglXYuaL8dKpkGodH7K5Y
         QVJC1FHZeo6Nb8oOYqkxRvRvA2hdzeguOFBfrS3IVTHOfuIHKWBEfYI+JEBMJXDiSAO+
         dx5w==
X-Gm-Message-State: AHPjjUhmTAs7oNU0Rtin/q8/Lf5zua3qCc2twwnjM0JPUklHp2OH2HcC
        zDcKHYMzBsWbkA==
X-Google-Smtp-Source: ADKCNb5uallaQpQ/Ogo2fvwa0MeciJc0wRUL2lEqOF2Ge8BlAZHFO+eZOevhGiQF9ynsr5imbNYE8Q==
X-Received: by 10.223.152.199 with SMTP id w65mr16647910wrb.254.1505311610734;
        Wed, 13 Sep 2017 07:06:50 -0700 (PDT)
Received: from mimir ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id j65sm1346862wmj.3.2017.09.13.07.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Sep 2017 07:06:50 -0700 (PDT)
Date:   Wed, 13 Sep 2017 15:06:45 +0100
From:   Richard Maw <richard.maw@gmail.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 4/4] packed refs: pass .git dir instead of packed-refs
 path to init_fn
Message-ID: <20170913140633.GB2281@mimir>
References: <20170912172330.GA144745@aiede.mtv.corp.google.com>
 <20170912173234.GE144745@aiede.mtv.corp.google.com>
 <827535d1-b549-8fe6-166c-23148d4290d8@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <827535d1-b549-8fe6-166c-23148d4290d8@alum.mit.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 10:45:45AM +0200, Michael Haggerty wrote:
> First of all there is a superficial naming inconsistency. This method is
> called `init` in the vtable, but the functions implementing it are
> called `*_ref_store_create()`. It actually initializes the data
> structures for dealing with the reference store, as opposed to
> initializing the reference store on disk (*that* virtual function is
> called `init_db`). It should maybe be called `open` instead.
> 
> But more fundamentally, what is a `ref_store`? Originally it always
> represented a *logical* place to store all of the references for a
> repository. In that sense, it made sense to have an "open" method that
> takes a `gitdir` as argument.
> 
> But its role is currently getting stretched. Now it sometimes represents
> a *physical* place to store references, which might be combined with
> other physical `ref_store`s to make a logical `ref_store`. There is not
> necessarily a 1:1 correspondence between gitdirs and physical
> `ref_store`s; more to the point you might want to initialize a physical
> refstore that doesn't correspond to `$GITDIR`. So requiring every
> `ref_store` to have a factory function with a gitdir argument is
> probably incorrect.
>
> For example, a subtree has a single logical reference store, but it is
> composed out of three physical reference stores: the loose references in
> the subtree's gitdir plus loose and packed references in the common gitdir.

One way to implement a namespacing backend would include
a loose references backend of the subtree of refs for the namespace
overlayed with a namespace translating backend backed onto packed references,
so there's benefits to not being strict about it being a gitdir.

> It seems to me that we need two separate concepts:
> 
> 1. Create an object representing a gitdir's *logical* `ref_store`. This
> "class method" could always have a single gitdir as parameter. This
> would be the method by which the repository initialization code
> instantiates its logical `ref_store`, for example by reading the type of
> the reference store from the repo's config, then looking up the class by
> its type, then calling its "open" method to create an instance.
> 
> 2. Create an object representing a physical `ref_store`. Different
> reference store classes might have different "constructor" arguments.
> For example, if it represents a namespace within a larger reference tree
> contained in a shared repository, its arguments might be
> `(shared_gitdir, namespace)`. (CC to Richard Maw for this angle.)

The distinction confused me while attempting to add the namespaced ref backend,
since I was unfamiliar with how the ref stores were meant to be defined.
In the end I just omitted the init function and create them separately.

I'm not sure drawing the line at "logical ref stores init" and
"physical ref stores are constructed differently" is the right division,
since the namespaced ref store is more of a local ref store
and its current interface is an existing ref store and a namespace.

Perhaps a better distinction would be frontend vs implementation ref stores
where frontend ones are registered to be found with find_ref_storage_backend,
while implementation ref stores don't use that
and hence don't need the next, name, init or init_db.

Then the physical vs logical distinction is whether they access refs directly
or only via another backend.

It wouldn't be implausible for the namespaced ref store backend
to be a frontend logical ref store that constructs the files ref store itself;
I just didn't have enough of a feel of how things went together to spot that.
