Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4DD61F404
	for <e@80x24.org>; Mon, 26 Mar 2018 18:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbeCZSFW (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 14:05:22 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:44367 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeCZSFU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 14:05:20 -0400
Received: by mail-pg0-f54.google.com with SMTP id v26so5054285pge.11
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 11:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0kNdxlVlDN2eW1c8DlYWwz+MX/1EE2t1n1XW8cSTX3U=;
        b=JKAzIJT1gehu2tMoqZrMDyZS0lNTnRKr45wYYmPiEEU4RYeceEXqqDMM3OOFZxi/P+
         nA+v10iqRYXFJUdD/Q28OVKfVcl63qbzfc6zS7v2wR7MjKq43NuvjFXbbakioVfwu8SE
         f6qPkTvtT28JVZYf1RSvtCU032By0lkCVReAKstIGgx0xUxS+mT8/Fgdxsg2rB7jAl9T
         AGq1KKzV6eeKMZbwMMNYnyh29pf7yc9YKNIqbRjE0loyg7CkFcmnaCJ3H5xENm17FIJk
         tx/WxwEib4w50aZoO7d7DxkgBEEMYwas17ub4a7qZo986GHOBx2Rp2RPIhw27bpSREdC
         VtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0kNdxlVlDN2eW1c8DlYWwz+MX/1EE2t1n1XW8cSTX3U=;
        b=kNZXQmUEu3wlPTB3i/8K8/ZP830yUvlmvk46YsLJvuXz3F4O6oTeWtN9F7nionPnoF
         cy601emp3fhyPu4LBQfDdTwgbW6E6kUouWGS2YeGJ/1Pnw2FZpOz3T9iVazcBf1K8OzW
         usVzvKFyX/vEZXC596j4Kc5K6vCyAazo/pvxLBUNfn1PG+R5bzsw4pNB2v81osl/tGA7
         aItsoVyuhTL7i1G8d/+Z6YBXoPKBAj90vYJZoN4UhnSMEICVo8Zy8e6TtKfcWRTWwVyZ
         DiVEHAuwVTQUdfs1Wc19cUFghv6+TDsZkKzaE76MyY2YbTTEDr/FlHPG0KSTPJOetybM
         zohw==
X-Gm-Message-State: AElRT7F4Oa9hvC+W6fkgTjcpIKS+IArL2Ofp3kGma5V0ghpgyDOLsh/7
        P4u5+4YlDkkGfX+ACa4dxNOJAw==
X-Google-Smtp-Source: AG47ELt12W+V/rmszaM10UIHn+0ohgwjzTbVRlv1/G3sXJqbTp0EtNZC2I2HfUQjC4fbYDAh4zyGZg==
X-Received: by 10.99.170.70 with SMTP id x6mr27073348pgo.114.1522087519738;
        Mon, 26 Mar 2018 11:05:19 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id a6sm11078920pfi.12.2018.03.26.11.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 11:05:18 -0700 (PDT)
Date:   Mon, 26 Mar 2018 11:05:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org,
        jonathantanmy@google.com, stolee@gmail.com, sbeller@google.com,
        peff@peff.net, johannes.schindelin@gmx.de,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git Merge contributor summit notes
Message-ID: <20180326180517.GA205538@google.com>
References: <alpine.DEB.2.20.1803091557510.23109@alexmv-linux>
 <874ll3yd75.fsf@evledraar.gmail.com>
 <0c3bb65f-d418-b39e-34c7-c2f3efec7e50@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c3bb65f-d418-b39e-34c7-c2f3efec7e50@jeffhostetler.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/26, Jeff Hostetler wrote:
> 
> 
> On 3/25/2018 6:58 PM, Ævar Arnfjörð Bjarmason wrote:
> > 
> > On Sat, Mar 10 2018, Alex Vandiver wrote:
> > 
> > > New hash (Stefan, etc)
> > > ----------------------
> > >   - discussed on the mailing list
> > >   - actual plan checked in to Documentation/technical/hash-function-transition.txt
> > >   - lots of work renaming
> > >   - any actual work with the transition plan?
> > >   - local conversion first; fetch/push have translation table
> > >   - like git-svn
> > >   - also modified pack and index format to have lookup/translation efficiently
> > >   - brian's series to eliminate SHA1 strings from the codebase
> > >   - testsuite is not working well because hardcoded SHA1 values
> > >   - flip a bit in the sha1 computation and see what breaks in the testsuite
> > >   - will also need a way to do the conversion itself; traverse and write out new version
> > >   - without that, can start new repos, but not work on old ones
> > >   - on-disk formats will need to change -- something to keep in mind with new index work
> > >   - documentation describes packfile and index formats
> > >   - what time frame are we talking?
> > >   - public perception question
> > >   - signing commits doesn't help (just signs commit object) unless you "recursive sign"
> > >   - switched to SHA1dc; we detect and reject known collision technique
> > >   - do it now because it takes too long if we start when the collision drops
> > >   - always call it "new hash" to reduce bikeshedding
> > >   - is translation table a backdoor? has it been reviewed by crypto folks?
> > >     - no, but everything gets translated
> > >   - meant to avoid a flag day for entire repositories
> > >   - linus can decide to upgrade to newhash; if pushes to server that is not newhash aware, that's fine
> > >   - will need a wire protocol change
> > >   - v2 might add a capability for newhash
> > >   - "now that you mention md5, it's a good idea"
> > >   - can use md5 to test the conversion
> > >   - is there a technical reason for why not /n/ hashes?
> > >   - the slow step goes away as people converge to the new hash
> > >   - beneficial to make up some fake hash function for testing
> > >   - is there a plan on how we decide which hash function?
> > >   - trust junio to merge commits when appropriate
> > >   - conservancy committee explicitly does not make code decisions
> > >   - waiting will just give better data
> > >   - some hash functions are in silicon (e.g. microsoft cares)
> > >   - any movement in libgit2 / jgit?
> > >     - basic stuff for libgit2; same testsuite problems
> > >     - no work in jgit
> > >   - most optimistic forecast?
> > >     - could be done in 1-2y
> > >   - submodules with one hash function?
> > >     - unable to convert project unless all submodules are converted
> > >     - OO-ing is not a prereq
> > 
> > Late reply, but one thing I brought up at the time is that we'll want to
> > keep this code around even after the NewHash migration at least for
> > testing purposes, should we ever need to move to NewNewHash.
> > 
> > It occurred to me recently that once we have such a layer it could be
> > (ab)used with some relatively minor changes to do any arbitrary
> > local-to-remote object content translation, unless I've missed something
> > (but I just re-read hash-function-transition.txt now...).
> > 
> > E.g. having a SHA-1 (or NewHash) local repo, but interfacing with a
> > remote server so that you upload a GPG encrypted version of all your
> > blobs, and have your trees reference those blobs.
> > 
> > Because we'd be doing arbitrary translations for all of
> > commits/trees/blobs this could go further than other bolted-on
> > encryption solutions for Git. E.g. paths in trees could be encrypted
> > too, as well as all the content of the commit object that isn't parent
> > info & the like (but that would have different hashes).
> > 
> > Basically clean/smudge filters on steroids, but for every object in the
> > repo. Anyone who got a hold of it would still see the shape of the repo
> > & approximate content size, but other than that it wouldn't be more info
> > than they'd get via `fast-export --anonymize` now.
> > 
> > I mainly find it interesting because presents an intersection between a
> > feature we might want to offer anyway, and something that would stress
> > the hash transition codepath going forward, to make sure it hasn't all
> > bitrotted by the time we'll need NewHash->NewNewHash.
> > 
> > Git hosting providers would hate it, but they should probably be
> > charging users by how much Michael Haggerty's git-sizer tool hates their
> > repo anyway :)
> > 
> 
> While we are converting to a new hash function, it would be nice
> if we could add a couple of fields to the end of the OID:  the object
> type and the raw uncompressed object size.
> 
> If would be nice if we could extend the OID to include 6 bytes of data
> (4 or 8 bits for the type and the rest for the raw object size), and
> just say that an OID is a {hash,type,size} tuple.
> 
> There are lots of places where we open an object to see what type it is
> or how big it is.  This requires uncompressing/undeltafying the object
> (or at least decoding enough to get the header).  In the case of missing
> objects (partial clone or a gvfs-like projection) it requires either
> dynamically fetching the object or asking an object-size-server for the
> data.
> 
> All of these cases could be eliminated if the type/size were available
> in the OID.
> 
> Just a thought.  While we are converting to a new hash it seems like
> this would be a good time to at least discuss it.

Echoing what Stefan said.  I don't think its a good idea to embed this
sort of data into the OID.  There are a lot of reasons but one of them
being that would block having access to this data behind completing the
hash transition (which could very well still be years away from
completing).

I think that a much better approach would be to create a meta-data data
structure, much like the commit graph that stolee has been working on)
which can store this data along side the objects (but not in the
packfiles themselves).  It could be a stacking structure which is
periodically coalesced and we could add in a wire feature to fetch this
meta data from the server upon fetching objects.

-- 
Brandon Williams
