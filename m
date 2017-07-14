Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD2BB20357
	for <e@80x24.org>; Fri, 14 Jul 2017 17:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754577AbdGNR1G (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 13:27:06 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36612 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754381AbdGNR1F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 13:27:05 -0400
Received: by mail-pf0-f171.google.com with SMTP id q86so48389502pfl.3
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 10:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XcYImTZSeux64BwYfhkAdnmBYPk4WTHH/ja5uj3VSh8=;
        b=sCkfGxk/2Np0xFVJn62czGHf1tjwXgGXjIZQ5LgFUTSz9AtwlmnnotvHeYS20YzLem
         +2DRBcJ3uHeF6PewuTm5Dc8DyrE4YnncwcYt3vRYh95iBlrWaLgosEShfxx3cylNayst
         uSLXcYjdoqqGJUQ6uzKO3JAM6bmziBls+ZnSqEn4qyb1aSYgYuPIF4WzOHJwLFYyl2T5
         Ijwcmh8emZD6+QKxwrJiEgFz1S3a044kJfPXcmhJcwmLfoe5/GtGFu1dO4h1r3/m3llQ
         09hXn4ozxnhtjiJPHLXZyxkVobehC3K6D5lBLGhZHV51W2QaSB+Jb8JH8B2xCwEkWwH/
         nsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XcYImTZSeux64BwYfhkAdnmBYPk4WTHH/ja5uj3VSh8=;
        b=LHM7O2Z4/rPM+Ogc2fuP0DjAYg219ZrJqzvUNyZgHSOdLgBO5+13xWnfm1UEeBoku5
         jbHrIHKck0oHeYHrbBij3FTjpx6e4aMFSP6KFpb09XLdLMi800n8ieDOdWooxrhXIp48
         1mU0/5GOaK31hEwJCKNQTJSKPR4lTVPVGk6Jm+EnyKzrNB7v8rqh4ABRFkxNMxnoEc0q
         N7IN6s7a6z7K3QTkoebqHr7up4nheK3lfRmEXOYn5DiQG6BvwYl4D5dXFfgk++8350R+
         NfxFL5jEQ9W6ai2xyqcinUztRxBVOWDd52uSAz6NmMt1SHznduAFk6jwOPZCVKHQgff+
         sEZA==
X-Gm-Message-State: AIVw111Qrw2ITBGt6YIV4ynkqKd114l8mLzOoRhKHbH34f5wHJpGCIue
        Djv9AB4lW5WG1D4OgngawyCJAj3lqfjSFGbe1g==
X-Received: by 10.84.215.197 with SMTP id g5mr17059485plj.297.1500053224633;
 Fri, 14 Jul 2017 10:27:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Fri, 14 Jul 2017 10:27:04 -0700 (PDT)
In-Reply-To: <cover.1500043436.git.johannes.schindelin@gmx.de>
References: <cover.1500043436.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 14 Jul 2017 10:27:04 -0700
Message-ID: <CAGZ79kbGqSadRDSQbg3N6pj04igFQG1x15S_vDUD4A6sXRSzXA@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] The final building block for a faster rebase -i
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2017 at 7:44 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> This patch series reimplements the expensive pre- and post-processing of
> the todo script in C.
>
> And it concludes the work I did to accelerate rebase -i so far.
>
> I am still unwilling to replace a compile-time safe way to pass the
> options to the revision machinery by the alternative (which I am still
> flabbergasted about) proposed by Junio. This will not change.

There is new input for this discussion, though. :)

https://public-inbox.org/git/20170706202739.6056-1-sbeller@google.com/
was sent out to gauge interest if we want to pull through with removing
all the submodule hack, such as 'add_submodule_odb' in submodule.c
which just adds the submodule objects as an alternate object store, such
that we can do some things in-process (check if a submodule has certain
commits, merge_submodule).

For one of these ('merge_submodule') I would have to add the
'struct repository' as another parameter to pass around to the
diff and revision walking machinery. But the API for these subsystems
is traditionally only operated via an array of strings instead of passing
assigning a member field to a value.

So If I were to follow the "use arrays of strings only to operate the
revision machinery" I would:
* pass a string indicating which repo to use
  (probably the path to git dir?)
* the repository objects are cached, so we can lookup e.g.
  "the_repository" via the correct string.
* use that repo object inside the revision machinery.

That sounds cumbersome and I would prefer to pass in
the repository object directory. So maybe we want to have some
other way opposed to "an array of strings" to operate the revision
machinery.

>  -static int subject2item_cmp(const struct subject2item_entry *a,
>  -      const struct subject2item_entry *b, const void *key)
>  +static int subject2item_cmp(const void *fndata,

This could also be named unused_fndata.
Please see origin/sb/hashmap-cleanup, if that makes sense as well
(have all arguments const void and cast them inside the function, such
that we can avoid the cast to hashmap_cmp_fn in hashmap_init)

Thanks,
Stefan
