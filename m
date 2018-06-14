Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438C71F403
	for <e@80x24.org>; Thu, 14 Jun 2018 18:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755332AbeFNSw0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 14:52:26 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43016 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754695AbeFNSwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 14:52:25 -0400
Received: by mail-pf0-f195.google.com with SMTP id y8-v6so3665238pfm.10
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 11:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xWJ1f2sU1N+PogHQ00XkY+PHtcGLdK0eIEhlhcMML+A=;
        b=YC7X7tMiOqNM6RXfKcjO/8YyoQi6EBAg+YrNFWzglmYGzYBx10FoRPvwqn66W6jkkq
         2w9wyBCHO+mlaS9yI+nDpbXyBTW/xjYBaKlGLzhMpLgSitqHZoUAjtHdRmj8jGvu39vO
         iVZBySc4ImlExKq7PsR+TA4IwGDty8ZtimvVRX5SyFZpOe7KHvt775/hYAgwO65LEAMb
         bNgnToKaIpZPEcEbZWJdWlWw0m3fC9ko7EJHBnZPDXJp2w5uUolJXlNGlDoPhoiz1G5i
         8YJQNUXFyjVnvZf+mYK63unInxjylLFezgwi2Z4jXZlx+3/xk9vom1JhgbwnYvSPd5e1
         wi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xWJ1f2sU1N+PogHQ00XkY+PHtcGLdK0eIEhlhcMML+A=;
        b=K6ea2+9n1q524C+k2nwsU1gVj5mNQCplogAqq/XBw+AnKRM2hg1T42EouVqO3SyDDL
         +GvvdgHZE/JNBuWi/4jqUsR+GVO+2ym6E5CcgB7iOMNOyYX5vFCQwSiryg/XE2MwrlCH
         VaaqYyWLFEo59qlJDbl79PZn1xwdgbHD1+tJMs0g3lR6zsp/y49wlT31K+Nda/uy0ZV3
         c3DikOaHOpztWY/NyEql2EE7K3Q5irRJFPkQ95VRz40XhFspSXSRbVIe43MfsVfE53Zc
         9doQgbtQxFLc+0Hf8cxKlUQXC4pVhsKY5H3Gq5NdKdHIe8kv7gWW5d4iqnbqBPe06ao3
         PIdQ==
X-Gm-Message-State: APt69E1BbruaNhdJCoX2SbmVUeafwxjvKqan6F2D1eTqSlWeZEEUSzRq
        KOIgjSY08nD7Glh04OkPuJi6mA==
X-Google-Smtp-Source: ADUXVKK9flCqlH3N8Sf7x3n7ctBORV+fS0tXGjRcXiTTCFUYGrBzDL/BboJRyenKfeYtOZwMC+j61Q==
X-Received: by 2002:a62:d146:: with SMTP id t6-v6mr10782193pfl.127.1529002342932;
        Thu, 14 Jun 2018 11:52:22 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id j127-v6sm7772526pgc.10.2018.06.14.11.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 11:52:21 -0700 (PDT)
Date:   Thu, 14 Jun 2018 11:52:20 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 2/8] upload-pack: implement ref-in-want
Message-ID: <20180614185220.GH220741@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
 <20180613213925.10560-1-bmwill@google.com>
 <20180613213925.10560-3-bmwill@google.com>
 <CAGZ79kahheyo5gFYbxz-+jN7CMcj7tB1XuUPbmZ6+CBgsqxuow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kahheyo5gFYbxz-+jN7CMcj7tB1XuUPbmZ6+CBgsqxuow@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/14, Stefan Beller wrote:
> Hi Brandon,
> On Wed, Jun 13, 2018 at 2:39 PM Brandon Williams <bmwill@google.com> wrote:
> > negotiation, which may happen if, for example, the desired repository is
> > provided by multiple Git servers in a load-balancing arrangement.
> 
> ... and the repository is not replicated evenly to all servers, yet.

I'll update the commit msg to also include this.

> 
> > In order to eliminate this vulnerability, implement the ref-in-want
> > feature for the 'fetch' command in protocol version 2.  This feature
> > enables the 'fetch' command to support requests in the form of ref names
> > through a new "want-ref <ref>" parameter.  At the conclusion of
> > negotiation, the server will send a list of all of the wanted references
> > (as provided by "want-ref" lines) in addition to the generated packfile.
> 
> This paragraph makes it sound as if it can be combined technically,
> i.e.
> 
> client:
>     want 01234...
>     want-ref master
> 
> .. usual back and forth + pack..
> 
> server:
> 
>   wanted-ref: master 2345..
> 
> What happens if the client "wants" a sha1 that is advertised,
> but happens to be the same as a wanted-ref?

This would be fine, same as sending a want line with the same sha1 lots
of times.  Though there would still be a wanted-ref section from the
server for the wanted-ref.

> 
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  Documentation/config.txt                |   7 ++
> >  Documentation/technical/protocol-v2.txt |  29 ++++-
> >  t/t5703-upload-pack-ref-in-want.sh      | 153 ++++++++++++++++++++++++
> >  upload-pack.c                           |  64 ++++++++++
> >  4 files changed, 252 insertions(+), 1 deletion(-)
> >  create mode 100755 t/t5703-upload-pack-ref-in-want.sh
> >
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > index ab641bf5a..fb1dd7428 100644
> > --- a/Documentation/config.txt
> > +++ b/Documentation/config.txt
> > @@ -3479,6 +3479,13 @@ Note that this configuration variable is ignored if it is seen in the
> >  repository-level config (this is a safety measure against fetching from
> >  untrusted repositories).
> >
> > +uploadpack.allowRefInWant::
> > +       If this option is set, `upload-pack` will support the `ref-in-want`
> > +       feature of the protocol version 2 `fetch` command.  This feature
> > +       is intended for the benefit of load-balanced servers which may
> > +       not have the same view of what OIDs their refs point to due to
> > +       replication delay.
> 
> Instead of saying who benefits, can we also say what the feature is about?
> Didn't someone mention on the first round of this series, that technically
> ref-in-want also provides smaller net work load as refs usually are shorter
> than oids (specifically as oids will grow in the hash transisition plan later)?
> Is that worth mentioning?

Well I basically just took this from what a previous reviewer thought it
should say.  I think what you have listed here isn't really a big
benefit of using ref-in-want, its the issue with load-balanced servers
that this is trying to solve.

> 
> When using this feature is a ref advertisement still needed?

Maybe in the future no, but as of right now the code is structured to
still request a ref advertisement.

> 
> > +
> >  url.<base>.insteadOf::
> >         Any URL that starts with this value will be rewritten to
> >         start, instead, with <base>. In cases where some site serves a
> > diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> > index 49bda76d2..6020632b4 100644
> > --- a/Documentation/technical/protocol-v2.txt
> > +++ b/Documentation/technical/protocol-v2.txt
> > @@ -299,12 +299,22 @@ included in the client's request:
> >         for use with partial clone and partial fetch operations. See
> >         `rev-list` for possible "filter-spec" values.
> >
> > +If the 'ref-in-want' feature is advertised, the following argument can
> > +be included in the client's request as well as the potential addition of
> > +the 'wanted-refs' section in the server's response as explained below.
> > +
> > +    want-ref <ref>
> > +       Indicates to the server that the client wants to retrieve a
> > +       particular ref, where <ref> is the full name of a ref on the
> > +       server.  A server should ignore any "want-ref <ref>" lines where
> > +       <ref> doesn't exist on the server.
> 
> Are patterns allowed?, e.g. I might want refs/tags/* at all times.

Nope, "Where <ref> is the full name of a ref".  We can maybe allow this
at a later point in time.

> 
> > @@ -319,6 +329,10 @@ header.
> >      shallow = "shallow" SP obj-id
> >      unshallow = "unshallow" SP obj-id
> >
> > +    wanted-refs = PKT-LINE("wanted-refs" LF)
> > +                 *PKT-LINE(wanted-ref LF)
> > +    wanted-ref = obj-id SP refname
> > +
> >      packfile = PKT-LINE("packfile" LF)
> >                *PKT-LINE(%x01-03 *%x00-ff)
> >
> > @@ -379,6 +393,19 @@ header.
> >         * This section is only included if a packfile section is also
> >           included in the response.
> >
> > +    wanted-refs section
> > +       * This section is only included if the client has requested a
> > +         ref using a 'want-ref' line and if a packfile section is also
> > +         included in the response.
> 
> Is it possible to fetch non-fast-forwarded refs this way? Or specifcially
> refs that were reset to an older point in history such that no pack file
> is needed to transfer; would we transfer an empty pack and then
> the wanted-refs section for that use case?

Yeah there are cases where an empty packfile would be sent like you've
described.

> 
> 
> > +
> > +# c(o/foo) d(o/bar)
> > +#        \ /
> > +#         b   e(baz)  f(master)
> > +#          \__  |  __/
> > +#             \ | /
> > +#               a
> 
> time is up in this diagram, most diagrams I looked at in tests
> are sideways. Should be fine either way.
> 
> > +test_expect_success 'invalid want-ref line' '
> > +       test-pkt-line pack >in <<-EOF &&
> > +       command=fetch
> > +       0001
> > +       no-progress
> > +       want-ref refs/heads/non-existent
> > +       done
> > +       0000
> > +       EOF
> > +
> > +       test_must_fail git serve --stateless-rpc 2>out <in &&
> > +       grep "unknown ref" out
> 
> The docs disagree with the test?
>      A server should ignore any "want-ref <ref>" lines where
>     <ref> doesn't exist on the server.

I forgot to remove this when i updated the docs.  I'll remove this test
as it fails now :(

> 
> 
> > +
> > +test_expect_success 'mix want and want-ref' '
> 
> cool!

-- 
Brandon Williams
