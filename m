Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0857620958
	for <e@80x24.org>; Wed, 29 Mar 2017 20:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932797AbdC2UDj (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 16:03:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:60029 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752944AbdC2UCs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 16:02:48 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Metpl-1cVSJk2m2j-00OZW6; Wed, 29
 Mar 2017 22:02:33 +0200
Date:   Wed, 29 Mar 2017 22:02:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] PREVIEW: Introduce DC_AND_OPENSSL_SHA1 make flag
In-Reply-To: <xmqq7f3d6ev1.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703291509450.48202@virtualbox>
References: <cover.1490397869.git.johannes.schindelin@gmx.de> <xmqq7f3d6ev1.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JNnFdxNRYJnh3mzYyIady1ZlLY06ZKTsZ3SNHw7Pr8yPQj52bgP
 lxR9yMWwLXqHtaeLFy1d7L82zbVMpnknRFrsFkJ10FZbvs3N1oaPQteGwbZWA6hxOAbJV1k
 oWQOAlBEA7OVu910qNyaVycs565cGg9No3nT1tieO1hb8sfIb1hP7Jal7hoiUB4g8rUZiHN
 vNbO6tiM7+m6F98IKtw4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:10VzTFl0tSg=:Tluoe5wHN5X2vukSOH3D1q
 653puGstJiP1DlC59oQQgaf7+ZSWw76k2VPxY8H3a3cA2mTgpLZV/LtGMa2PVXvD3kSgb2aO1
 7Zug/BNoDDyQyx3vdTR4pJcmoBiia3toXI7B+mSHf7ZgYPb1BGQpMPfb15UXK2Asg4Rh1XyGl
 RLStn9fSs6q8tuJLoQvHcju964leNlYpZwuEac+2+zdD4kHlgVpzsteXipWPi2qSISZlr69Lk
 7ayjOtC36KbhilCU/z/IkLAcfVTxVzh85wrLQpzhSwCbjhIF2ZXsWcCX04ixO+o/dp0fyu4vg
 bTTm4FPSP2ualeiVyxw2hq1/2uzYoFo+yLluhFVfDupmkeq4YFkf4n+RoeTvJZGsoPNHYTqw3
 2s2HOQ7Zm23pGRbW5501lz9SsFmG89VC9DeG99kpvVe0jyeZ8+Bbfz4BfQDD5JLFSBgSZwSFK
 yVrjZEGAcw5hoENdc00i9l23l8ceSzw1k2Xz47APeCgPyI7Q9ZMHqtR9VOkjSe9GCJxV9qtfy
 aa2KdSx59KD/VBp3epL3MLLuh1N++UVaxeGU/EwOXxjCGc9u3DuN+7lLXRbFF54bGXMqPEMsh
 v6td/gG6KHyNCc2C3TTtE/Yr26+BhZYUODg9b4ek6tX22RO9kdRgH3rCkEJ6URPornougp1QV
 1doOot7lnVTOu1dzBKzyQ1QXbmRsnCpSLef2Qxm6oIGVYJmANGwlmDDx+WFrpmAty50sqE9bm
 pU4pWuTl77pWTzwNuULwRSRpLFINx4LH/s3C86pyIt81e2mfxYrEweGRQyE/DwuaGFN9dB2ks
 Auy11IF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 24 Mar 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > - the most important part will be the patch turning core.enableSHA1DC
> > into a tristate: "externalOnly" or "smart" or "auto" or something
> > indicating that it switches on collision detection only for commands
> > that accept objects from an outside source into the local repository,
> > such as fetch, fast-import, etc
> 
> There are different uses of SHA-1 hashing in Git, and I do agree
> that depending on the use, some of them do not need the overhead for
> the collision-attack detection.

Indeed.

I guess I should have clarified very clearly what I intended to accomplish
with this preview.

Let me first summarize the background:

- Git originally used SHA-1 as a convenient catch-all hashing algorithm,
  with the security of the hash merely being a nice afterthought.
  Unfortunately, SHA-1 was hardcoded. Mistakes were made. They always are.

- After the SHAttered blog post became public, Linus first made the case
  that it matters not all that much: the development of the Linux kernel
  is based on trust, and nobody would pull from a person they do not trust.
  This approach does obviously not extend to most other projects.

- By switching the default to DC_SHA1 already in `master`, you now took
  the exact opposite position: it *always* matters, even when you trust
  people, and the 6x slowdown demonstrated by my perf test is something that
  everybody needs to accept, even if it is spent for no benefit in return.

Between these two extremes ("collision attacks do not matter if you run
your project based on trust" vs "we always mistrust everybody, including
the user's own source code that they stage for commit"), I think there are
many shades of green, and I think it would be delusional to believe that
we can predict the trust model for each and every Git user [*1*], baking
it into a single compile time setting.

That is why I wanted to implement a tristate config so that users can
adapt Git to their particular scenario. That way, maintainers of
precompiled Git packages do not have to dictate to Git users what trust
model they should use.

One scenario seems to be common, and it is certainly one that I have a
direct interest in supporting: inside a company, where the server as well
as the developers are implicitly trusted not to fiddle with collision
attacks (because there are much easier ways to hide malicious code, let's
be frank). And in this scenario, slowing down the SHA-1 computation half
an order of magnitude by trying to detect collision attacks is simply
unacceptable, because there is no benefit, only cost to it.

An even more common scenario is when a developer works on a local
repository, adds a couple of files, then runs rebase, then merges, etc. In
*none* of these cases does the developer distrust any of the objects
flying about. Like above, forcing the developer to accept half an order of
magnitude slow down of the SHA-1 computation is something I would consider
disrespectful of those developers' time. Note: in this scenario, any
object coming from elsewhere would most likely be subject to the collision
detection, as the developer may not trust anybody but themselves.

In other words: I disagree that, say, `git add` should use the collision
detecting SHA-1.

I also suspect that you had a much more elaborate (maybe even fragile)
strategy than mine in mind when you tried to determine which code paths
would need collision detection and which ones would not: we have *no*
context in the object-oriented sense whenever we call the object hashing
functions. Meaning that you would have to introduce such a context, or to
add some sort of thread local state. I have to admit that I do not like
either way.

The approach I chose instead was to make the switch global, per command.
Obviously, the next step is to identify the Git commands which accept
objects from external sources (`clone`, `fetch`, `fast-import` and all the
remote helpers come to mind) and let them set a global flag before asking
git_default_config() to parse the core.enableSHA1DC setting, so that the
special value `external` could trigger the collision detecting code for
those, and only those, commands. That would still err on the safe side if
these commands are used to hash objects originating from the same machine,
but that is a price I would be willing to pay for the simplicity of this
approach.

Does my explanation manage to illustrate in a plausible way why I chose
the approach that I did?

Ciao,
Johannes

Footnote *1*: It is equally delusional, of course, to claim that every Git
user can and should configure and compile Git for themselves.
