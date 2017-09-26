Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F37D20281
	for <e@80x24.org>; Tue, 26 Sep 2017 22:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936714AbdIZWLs (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 18:11:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:60122 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935403AbdIZWLr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 18:11:47 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzoSt-1dIuSJ1x0F-0150Zt; Wed, 27
 Sep 2017 00:11:21 +0200
Date:   Wed, 27 Sep 2017 00:11:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jason Cooper <jason@lakedaemon.net>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
In-Reply-To: <20170926170502.GY31762@io.lakedaemon.net>
Message-ID: <alpine.DEB.2.21.1.1709262356360.40514@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com> <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com> <alpine.DEB.2.21.1.1709131340030.4132@virtualbox> <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com> <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com> <alpine.DEB.2.21.1.1709142037490.4132@virtualbox>
 <20170926170502.GY31762@io.lakedaemon.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NtqgoZg4tY49nLjvSh5ju3zf6SKMmx2EIcFVML8HKMNxNGyqOLy
 wxpO97eArXlnlKDIT3NIpGtbdImwAoyYdssliU85kzId2l8C8uYfvBFRQW5wrB3rd4+xuBt
 zi6Q72YZHV7C5Eg8A3NoKMaDAxT/LMfw2Z6wZUfM/XJfzqVuU6ITcz5XOtM3O2yFAbZWXXu
 NOJJa3Rqi8LtHlyTSVwcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q9fftR1LsOo=:v7ZUWalstb/y01NMz7Kmfx
 YTU1XSDLEymdgZjWP4RUOs617GN3DEqZ5m81t8mmzm3dmgpnqgI82KFEltuMZvGJYyiISTDF2
 4yVj9fYLOy8+u2PN79mJ2jtpqDShLAkiY45GOyIMbuNYPMCJBatBdCXTZqc8p+QnxfYSIL9Fp
 EyVvIJFtPnvZ9LHp/cPCNDnUTDCIMmJjhbCqPhjlU7VQ/fXsI37yck5ASD3MzvJgKDRBAPGAB
 7tHC8FyNvfU7q7m7ORlT3kbPnk2vy2CkYFyY00P56VkHLWMZ13D/20xSGi5OA/kFMpejDpf8d
 evGJGxtkiDFGpxtaoIObjuYNMXBj4ZPnDKWUFlYirYqXUxsiBlJQ4xqggukcqMm2zTMpV3pAi
 g2uITJIxa8MyGLlri2zrFHw3p11utUhdN5qak1vjlv5SII6U5jNICgw9IXojKrUJ9JDbTmOq1
 fjlLyNNzl+l6fA3kJkPOTIqExb+lUJPM3qCyw3TNs4NK1SV++yCjN0gR1hTQ1ZklFsc10bkuL
 ifxuV8wnaXVDY91TqWngZrwJ1whLJ1cBaScSQwB7UPQwYBaH5KkfhFx2tX2la9P90oNeJyDhf
 LreCJ9WeFhBvC+xuSRVL33wbBYFrFtNfOl7f2XwFmMMOqlDwdwij8xCeHpYa0dJ1XSOFgklCa
 1WoWqxc5iyT40eIUwycXrvUVWWaiO71YZqPAcuyokijie/xofpyCJSLno0T9TuWUjZ8MRQNMR
 fqLiX605SdyFpBCS8rhkkqry6sfxpjO7WbNsUqIPoTwhYjPLwYss6JmdtRMN3KJuSRplN/jpn
 wzlsejuqWtRAV9tFO5jSkTZ6HqSknKtsNooS2UWgJ7sjKwRd1I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jason,

On Tue, 26 Sep 2017, Jason Cooper wrote:

> On Thu, Sep 14, 2017 at 08:45:35PM +0200, Johannes Schindelin wrote:
> > On Wed, 13 Sep 2017, Linus Torvalds wrote:
> > > On Wed, Sep 13, 2017 at 6:43 AM, demerphq <demerphq@gmail.com> wrote:
> > > > SHA3 however uses a completely different design where it mixes a 1088
> > > > bit block into a 1600 bit state, for a leverage of 2:3, and the excess
> > > > is *preserved between each block*.
> > > 
> > > Yes. And considering that the SHA1 attack was actually predicated on
> > > the fact that each block was independent (no extra state between), I
> > > do think SHA3 is a better model.
> > > 
> > > So I'd rather see SHA3-256 than SHA256.
> 
> Well, for what it's worth, we need to be aware that SHA3 is *different*.
> In crypto, "different" = "bugs haven't been found yet".  :-P
> 
> And SHA2 is *known*.  So we have a pretty good handle on how it'll
> weaken over time.

Here, you seem to agree with me.

> > SHA-256 got much more cryptanalysis than SHA3-256, and apart from the
> > length-extension problem that does not affect Git's usage, there are no
> > known weaknesses so far.
> 
> While I think that statement is true on it's face (particularly when
> including post-competition analysis), I don't think it's sufficient
> justification to chose one over the other.

And here you don't.

I find that very confusing.

> > It would seem that the experts I talked to were much more concerned about
> > that amount of attention than the particulars of the algorithm. My
> > impression was that the new features of SHA3 were less studied than the
> > well-known features of SHA2, and that the new-ness of SHA3 is not
> > necessarily a good thing.
> 
> The only thing I really object to here is the abstract "experts".  We're
> talking about cryptography and integrity here.  It's no longer
> sufficient to cite anonymous experts.  Either they can put their
> thoughts, opinions and analysis on record here, or it shouldn't be
> considered.  Sorry.

Sorry, you are asking cryptography experts to spend their time on the Git
mailing list. I tried to get them to speak out on the Git mailing list.
They respectfully declined.

I can't fault them, they have real jobs to do, and none of their managers
would be happy for them to educate the Git mailing list on matters of
cryptography, not after what happened in 2005.

> Other than their anonymity, though, I do agree with your experts
> assessments.

I know what our in-house cryptography experts have to prove to start
working at Microsoft. Forgive me, but you are not a known entity to me.

> However, whether we chose SHA2 or SHA3 doesn't matter.

To you, it does not matter.

To me, it matters. To the several thousand developers working on Windows,
probably the largest Git repository in active use, it matters. It matters
because the speed difference that has little impact on you has a lot more
impact on us.

> Moving away from SHA1 does.  Once the object_id code is in place to
> facilitate that transition, the problem is solved from git's
> perspective.

Uh oh. You forgot the mapping. And the protocol. And pretty much
everything except the oid.

> If SHA3 is chosen as the successor, it's going to get a *lot* more
> adoption, and thus, a lot more analysis.  If cracks start to show, the
> hard work of making git flexible is already done.  We can migrate to
> SHA4/5/whatever in an orderly fashion with far less effort than the
> transition away from SHA1.

Sure. And if XYZ789 is chosen, it's going to get a *lot* more adoption,
too.

We think.

Let's be realistic. Git is pretty important to us, but it is not important
enough to sway, say, Intel into announcing hardware support for SHA3.

And if you try to force through *any* hash function only so that it gets
more adoption and hence more support, in the short run you will make life
harder for developers on more obscure platforms, who may not easily get
high-quality, high-speed implementations of anything but the very
mainstream (which is, let's face it, MD5, SHA-1 and SHA-256). I know I
would have cursed you for such a decision back when I had to work on AIX
and IRIX.

> For my use cases, as a user of git, I have a plan to maintain provable
> integrity of existing objects stored in git under sha1 while migrating
> away from sha1.  The same plan works for migrating away from SHA2 or
> SHA3 when the time comes.

Please do not make the mistake of taking your use case to be a template
for everybody's use case.

Migrating a large team away from any hash function to another one *will*
be painful, and costly.

Migrating will be very costly for hosting companies like GitHub, Microsoft
and BitBucket, too.

Ciao,
Johannes
