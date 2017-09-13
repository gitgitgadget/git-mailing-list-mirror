Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D5320286
	for <e@80x24.org>; Wed, 13 Sep 2017 12:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbdIMMGB (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 08:06:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:61552 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbdIMMGA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 08:06:00 -0400
Received: from virtualbox ([37.201.203.107]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MC4VE-1djKzf2Lr6-008v3f; Wed, 13
 Sep 2017 14:05:27 +0200
Date:   Wed, 13 Sep 2017 14:05:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
In-Reply-To: <20170911185913.GA5869@google.com>
Message-ID: <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com> <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Rxu6gu5rzX0d6Xt9BEOO0Be+ZFf8VIGVGpkLlcgNmeqPcz5VrRZ
 Sjx56X34HXlcpy/hGWtanFuSR0OAwF99nm9XtfHLe7P6JagxwUo2vhGninxGDsQEXWz6vb9
 lFSxL9KYhABI104TqJJno3LtIwNSEd9V/suBRZ2q/SdZ29kGTPwSRvVmHKbV4Y9ecarQiqY
 /tFnR0tM0tk+xHpkc5RLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:niiewoEaKhA=:FTxe3NbjwbbH3PzvVV/0P4
 Vk4vyfIIleyII9pJ73mpVQW+u5qgq9XJVda0hlBQLH0UZ0cILB/nIzHXS4zYZptfcls1B2Ujl
 u8p6Zt6vrjXLfmMm3yCkuno7ddcXJ0HXqRk28y+UpdCwUdrLeETuJaShpnyu/9KEEsiB+nX8R
 tuhH7ZGGw+EgFNssxpiAIx7cNWx0gMgLIy+m9odfdhKFDJJHwf/+AC//23Jt1ba2lJHlhyDEu
 1iNq4lsS1GvofMbakzcZT1ZyZGDVq2lEEUSbdr6Nfr1TW9RtPlp2o+Jh5EGQfKJp9ghgiKPjc
 FBL5QJcXjmj+/26s0G5EGOmds/5BuFfInIlDrnhT6dSetz+q146AAJCc/KruWgqH1oXudGvOt
 XbyK0eXzpD3NVL2monWfpT+905jOzWD8KJGDsn3M/wA+4bOKuWObSAjYjnU8ye2ps+buCPZCk
 J2r3VF2eLpzGjZYGhM/y8s9SB5MgTBRsla+TslX4U8cP30Tob+R1ZD6mjByNx0ApZ2emlS9mY
 LP6t80nR/CMkDrkVdkb6iXi9gwjy1DSPUtbV3eNVnC80zJD88lDfvdOdVTvaxU4341cbg5Jy6
 fu+975yHcT5qm2mSRyqJzNaDbSl92w4zsGcGgVkT4P2LKInTa73mSmGAAeJlelGcCyksobC3q
 YZpDVrR8qpLcU+5UFk2U5IMSMqm2jJRx1y7DDaBw0Wm2YJ0z0lSpFEpDX/Jk3h07/EAD7vA4q
 CsJCrmk0q9mNjnHuJTh5GrhqhI+tK/5yiKm+xn1hpngQwUAMy3JtkzXdbvj7P+DuPDbkK2Ap1
 5Z+cpOPz5ylT1lSkME4gd84SvYNXDW37wh8PKcp0lR/81cfv8g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Mon, 11 Sep 2017, Brandon Williams wrote:

> On 09/08, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > One thing I still do not know how I feel about after re-reading the
> > > thread, and I didn't find the above doc, is Linus's suggestion to
> > > use the objects themselves as NewHash-to-SHA-1 mapper [*1*].  
> > > ...
> > > [Reference]
> > >
> > > *1* <CA+55aFxj7Vtwac64RfAz_u=U4tob4Xg+2pDBDFNpJdmgaTCmxA@mail.gmail.com>
> > 
> > I think this falls into the same category as the often-talked-about
> > addition of the "generation number" field.  It is very tempting to add
> > these "mechanically derivable but expensive to compute" pieces of
> > information to the sha3-content while converting from sha1-content and
> > creating anew.  
> 
> We didn't discuss that in the doc since this particular transition plan
> we made uses an external NewHash-to-SHA1 map instead of an internal one
> because we believe that at some point we would be able to drop
> compatibility with SHA1.

Is there even a question about that? I mean, why would *any* project that
switches entirely to SHA-256 want to carry the SHA-1 baggage around?

So even if the code to generate a bidirectional old <-> new hash mapping
might be with us forever, it *definitely* should be optional ("optional"
at least as in "config setting"), allowing developers who only work with
new-hash repositories to save the time and electrons.

> Now I suspect that wont happen for a long time but I think it would be
> preferable over carrying the SHA1 luggage indefinitely.

It should be possible to push back the SHA-1 ginny into a small gin bottle
inside Git's source code, so to say, i.e. encapsulate it to the point
where it is a compile-time option, in addition to a runtime option.

Of course, that's only unless the SHA-1 calculation is made mandatory as
suggested above. I really shudder at the idea of requiring SHA-1 to be
required forever. We ignored advice in 2005 against making ourselves too
dependent on SHA-1, and I would hope that we would learn from this.

> At some point, then, we would be able to stop hashing objects twice
> (once with SHA1 and once with NewHash) instead of always requiring that
> we hash them with each hash function which was used historically.

Yes, please.

> > Because the "sha1-name" or the "generation number" can mechanically
> > be computed,

... as long as a shallow clone you do not have, of course...

> > as long as everybody agrees to _always_ place them in the
> > sha3-content, the same sha1-content will be converted into exactly the
> > same sha3-content without ambiguity, and converting them back to
> > sha1-content while pushing to an older repository will correctly
> > produce the original sha1-content, as it would just be the matter of
> > simply stripping these extra pieces of information.

... or Git would simply handle the absence of the generation number header
gracefully, so that sha1-content == sha3-content...

> > The same thing could happen if we decide to bake "generation number"
> > in the SHA-3 commit objects.  One possible definition would be that a
> > root commit will have gen #0; a commit with 1 or more parents will get
> > max(parents' gen numbers) + 1 as its gen number.  But somebody may
> > botch the counting and records sum(parents' gen numbers) as its gen
> > number.
> > 
> > In these cases, not just the SHA3-content but also the resulting SHA-3
> > object name would be different from the name of the object that would
> > have recorded the same contents correctly.  So converting back to
> > SHA-1 world from these botched SHA-3 contents may produce the original
> > contents, but we may end up with multiple "plausibly looking" set of
> > SHA-3 objects that (clain to) correspond to a single SHA-1 object,
> > only one of which is a valid one.
> > 
> > Our "git fsck" already treats certain brokenness (like a tree whose
> > entry has mode that is 0-padded to the left) as broken but still
> > tolerate them.  I am not sure if it is sufficient to diagnose and
> > declare broken and invalid when we see sha3-content that records
> > these "mechanically derivable but expensive to compute" pieces of
> > information incorrectly.
> > 
> > I am leaning towards saying "yes, catching in fsck is enough" and
> > suggesting to add generation number to sha3-content of the commit
> > objects, and to add even the "original sha1 name" thing if we find
> > good use of it.  But I cannot shake this nagging feeling off that I
> > am missing some huge problems that adding these fields and opening
> > ourselves to more classes of broken objects.
> > 
> > Thoughts?

Seeing as current Git versions would always ignore the generation number
(and therefore work perfectly even with erroneous baked-in generation
numbers), and seeing as it would be easy to add a config option to force
Git to ignore the embedded generation numbers, I would consider `fsck`
catching those problems the best idea.

It seems that every major Git hoster already has some sort of fsck on the
fly for newly-pushed objects, so that would be another "line of defense".

Taking a step back, though, it may be a good idea to leave the generation
number business for later, as much fun as it is to get side tracked and
focus on relatively trivial stuff instead of the far more difficult and
complex task to get the transition plan to a new hash ironed out.

For example, I am still in favor of SHA-256 over SHA3-256, after learning
some background details from in-house cryptographers: it provides
essentially the same level of security, according to my sources, while
hardware support seems to be coming to SHA-256 a lot sooner than to
SHA3-256.

Which hash algorithm to choose is a tough question to answer, and
discussing generation numbers will sadly not help us answer it any quicker.

Ciao,
Dscho
