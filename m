Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4C620A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 02:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbeLKCAE (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 21:00:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46121 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeLKCAE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 21:00:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so12392819wrt.13
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 18:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DfNPpAFbsVIFnFugUHCHKU9K8GbsmdgTgI8Y0hmhQVY=;
        b=gLilpnwZqfEDtvdEdqM8kaonw5Pj7rXMDvOAkhth7SK30HvE9640VNpK5YEWvXBAmh
         kHcCLyjb3jdxnmTbILJxJy5+PNgQJGxMZu+o13YZtZCHZX6waXBfMCAXqebEceTRolYB
         yGD4Y7lGumbBiFZ7Ab0MmUwGBtjl4JjH6ydJcRmcfv2E3MRjlcf2UJnLrHAxhVFW3CFy
         HrSfQ6Yq5tAq9unXFY+Dfd7bTBz69YYV8dA1q6CXIkh+RBeRj7MB3iI80oPTDppxkOWg
         CRda5HA34NqNDhAXc+UuVK15I7ihnlIixMkyg+3+xIX+8nb8aIWg1uoEAp2iVgI8NKzi
         T/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DfNPpAFbsVIFnFugUHCHKU9K8GbsmdgTgI8Y0hmhQVY=;
        b=H048f2t7oniihP8MkplaXvtGVfWgD9XljE8avyqa08bjUqFebK1yyy+FMI5l/gpOv4
         hj/RdSuY3oSZT77JyCxKcp9HN1aJk9LNOjsntHxT5KArCvVJ25wcpx1lFGS/yMbM18Lm
         kh6c9sD9N/e/O+85cd1FmrQev/jw7KBLD5FEK1XbsRSF9LNI7lWn7nLnKDAED7yEZhYN
         S9s/+kbEtqcvJhYCmLahYBpqVqOzObc9+LJgMRJvnUf5cOHPi/qcD7jhEFfkB1iG3zcm
         SnmYzU4viz/ZxFLRgl1D7zcyCdv6Nqxo+Q5OXBkMA2C3ZnwFgSbx4ZOc+ehrYPN+iiX/
         zR5Q==
X-Gm-Message-State: AA+aEWYTEmW6r+3frGjhXsSLF2mKzGuh8/Dn3Kios23IlYPPkQXbTSc+
        ddvq05Q7guBAFMhkJAh5dks=
X-Google-Smtp-Source: AFSGD/WkeLsmSiBr0t00uYpyq3DzpnlpWSn22x9XC51WKP8typ3Lwo/ri71BsZzbhSyl4zB3cX0KAg==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr11405148wrr.271.1544493601443;
        Mon, 10 Dec 2018 18:00:01 -0800 (PST)
Received: from szeder.dev (x4db2a4b1.dyn.telefonica.de. [77.178.164.177])
        by smtp.gmail.com with ESMTPSA id a18sm16860650wrp.13.2018.12.10.17.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 18:00:00 -0800 (PST)
Date:   Tue, 11 Dec 2018 02:59:57 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/5] multi-pack-index: prepare for 'expire' verb
Message-ID: <20181211015957.GR30222@szeder.dev>
References: <pull.92.git.gitgitgadget@gmail.com>
 <1e34b48a2051089052c0b53b0059576b5ace45de.1544465177.git.gitgitgadget@gmail.com>
 <CAGZ79kYeHgCdzNNXUnp1NaokT=Vpj4mUVt1bZb5c+EkgO2z-4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYeHgCdzNNXUnp1NaokT=Vpj4mUVt1bZb5c+EkgO2z-4w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 05:35:28PM -0800, Stefan Beller wrote:
> On Mon, Dec 10, 2018 at 10:06 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > The multi-pack-index tracks objects in a collection of pack-files.
> > Only one copy of each object is indexed, using the modified time
> > of the pack-files to determine tie-breakers. It is possible to
> > have a pack-file with no referenced objects because all objects
> > have a duplicate in a newer pack-file.
> >
> > Introduce a new 'expire' verb to the multi-pack-index builtin.
> > This verb will delete these unused pack-files and rewrite the
> > multi-pack-index to no longer refer to those files. More details
> > about the specifics will follow as the method is implemented.
> >
> > Add a test that verifies the 'expire' verb is correctly wired,
> > but will still be valid when the verb is implemented. Specifically,
> > create a set of packs that should all have referenced objects and
> > should not be removed during an 'expire' operation.
> >
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >  Documentation/git-multi-pack-index.txt |  8 +++++
> >  builtin/multi-pack-index.c             |  4 ++-
> >  midx.c                                 |  5 +++
> >  midx.h                                 |  1 +
> >  t/t5319-multi-pack-index.sh            | 47 ++++++++++++++++++++++++++
> >  5 files changed, 64 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
> > index f7778a2c85..822d83c845 100644
> > --- a/Documentation/git-multi-pack-index.txt
> > +++ b/Documentation/git-multi-pack-index.txt
> > @@ -31,6 +31,14 @@ verify::
> >         When given as the verb, verify the contents of the MIDX file
> >         at `<dir>/packs/multi-pack-index`.
> >
> > +expire::
> > +       When given as the verb,
> 
> Can it be given in another way? Or rather "if the verb is expire",
> then ...
> (I just checked the current man page, and both write and verify use
> this pattern as well. I find it strange as this first part of the sentence
> conveys little information, but is repeated 3 times now (once for
> each verb)).
> 
> Maybe we can restructure the man page to have it more like
> 
>     The following verbs are available:
>     +write::
>     +    create a new MIDX file, writing to <dir>/packs/multi-pack-index.
>     +
>     +verify::
>     +    verify the contents ...

I think a s/verb/subcommand/ would help a lot, too, because that's
what we call it everywhere else.

