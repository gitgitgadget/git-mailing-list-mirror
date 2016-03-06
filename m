From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Resumable clone
Date: Sun, 6 Mar 2016 08:59:10 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603060831570.3152@virtualbox>
References: <CANtyZjSJf5_xbsBC5tUaazFT3uiEgJnx2_kHLwYwKcn50Jy_qg@mail.gmail.com> <CACsJy8CESL6vH22mGSLRE1OKTEbGz2Vqmsv5bY3mn_E+03wADw@mail.gmail.com> <xmqqoaasvkrt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Duy Nguyen <pclouds@gmail.com>,
	Kevin Wern <kevin.m.wern@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 06 08:59:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acTbE-0005VL-IB
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 08:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbcCFH7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 02:59:20 -0500
Received: from mout.gmx.net ([212.227.17.20]:62938 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbcCFH7T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 02:59:19 -0500
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MQu9K-1aRw0E0D54-00UNsf; Sun, 06 Mar 2016 08:59:12
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqoaasvkrt.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:5qda6NBm4/7q70FYbmKJfjyAcspXQgg5JqzBeldmtSeBY6NbSqH
 nIQ1MQJwnTEneWUIWOOjNw04TLrosIGjLWXJ8qiS9m2W/25hPTXNHTGm55Z+3sFGUYm/GvZ
 3/s9Ej2lyFr4HabDkljH/sO3nN4IcBrEPRaaqIAHFulP6dERvCqn4bjRnybCj09Ps32rh1a
 V+fJ8LvhruzImCc+hMjIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J6KppFyx89o=:e+4lU/zI6nr5wJEavu2qMQ
 yVi5X8K6CU1TM44Xa5Th/koKXH/msqdqSwuiHlORExiejvvF69M0rDP9w7Ll68P1lXtoMLgFR
 lymzIchBlDHQ1Jxq/7iGaTPsHvS0MmSv1aBr/8Fs7jsvMvkGgis6aVvyIVN3gX4U9kRERUnbZ
 +4ZLUNRE3ULB7rdFNckKLwdpiyNQ7hjXDmamZBaw/NAnaqPB+eEVHjIOJtSEH0Oc4xC3kMqYp
 eq+Kg5TXbXO8rvQHPlphKjFh9JagT8PHm0i89WqkqSpkZbWUCyuuH+ZE+boCetwf8okv0fV2d
 G3uddKt+vLjNXJf1t3cj5jgNB5UVMf2SPgqzKM25cVnsKLG6PFu/OTe1VB+gYyrc8P6pyH8HQ
 mTw3vf+/FujRuZ1uwYrRtP2UOt64+Ty4y+aL8gapu24BZKIBokjEYEAh1Z+o8O0QKgiTvvfIY
 L39WSNeKF/pZUS4fifbWAtXgneeBVqhN6nYMwT2YsGs8YrPd7yUUb4xgUGiaBPK/CncFpyB/S
 TtQD61J9ALEfZXJlWqlcfKhLbvzFrrGTI9qEzurpm4x52lsouR/n5reNZ+RKl/w9LuhQa4rPd
 yim+wRDOuo/WVH2aR0txR1+WWH6vODIccjlPdwMvOmRnIk1Rf8ngiA0Vp5i67hJ4Wr21pxQ8h
 nypqYAFhTjltNsKkoo1PV+kkFNEo+ABZeFnGFP/EmVmMnS7a4iQ7dzM7+s3UfVwJjmVLBwYei
 58Krq2DiNBi6dE1kl7sPjR3Lr0MHYGbUCU5rVdalWeZJ/JMMx34VYlZbhdpPqM/f/D2AFiQ8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288338>

Hi Junio & Duy,

On Sat, 5 Mar 2016, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > Resumable clone is happening. See [1] for the basic idea, [2] and [3]
> > for some preparation work. I'm sure you can help. Once you've gone
> > through at least [1], I think you can pick something (e.g. finalizing
> > the protocol, update the server side, or git-clone....)
> >
> > [1] http://thread.gmane.org/gmane.comp.version-control.git/285921
> > [2] http://thread.gmane.org/gmane.comp.version-control.git/288080/focus=288150
> > [3] http://thread.gmane.org/gmane.comp.version-control.git/288205/focus=288222
> 
> I think your response needs to be refined with a bit higher level
> overview, though.  Here are some thoughts to summarize the discussion
> and to extend it.
> 
> I think the right way to think about this is that we are adding a
> capability for the server to instruct the clients: I prefer not to
> serve a full clone to you in the usual route if I can avoid it.  You
> can help me by going to an alternate resource and populate your
> history first and then coming back to me for an additional fetch to
> complete the history if you want to.  Doing so would also help you
> because that alternate resource can be a static file (or two) that
> you can download over a resumable transport (like static files
> served over HTTPS).

For quite some time I considered presenting some alternate/additional
ideas. I feel a little bad for mentioning them here because I *really*
have no time to follow up on them whatsoever. But maybe they turn out to
contribute something to the final solution.

I tried to follow the discussion as much as possible, sometimes failing
due to time constraints, therefore I'd like to apologize in advance if any
of these ideas have been mentioned already.

First of all: my main gripe with the discussed approach is that it uses
bundles. I know, I introduced bundles, but they just seem too klunky and
too static for the resumable clone feature.

So I wonder whether it would be possible to come up with a subset of the
revs with a stable order, with associated thin packs (using prior revs as
negative revs in the commit range) such that each thin pack weighs roughly
1MB (or whatever granularity you desire). My thinking was that it should
be possible to follow a similar strategy as bisect to come up with said
list.

The client could then state that it was interrupted at downloading a given
rev's pack, with a specific offset, and the (thin) pack could be
regenerated on the fly (or cached), serving only the desired chunk. The
server would then also automatically know where in the list of
stable-ordered revs the clone was interrupted and continue with the next
one.

Oh, and if regenerating the thin pack instead of caching it, we need to
ensure a stable packing (i.e. no threads!). That is, given a commit range,
we need to (re-)generate bytewise-identical thin packs.

Of course this stable-ordered rev list would have to be persisted when the
server serves its first resumable clone and then extended with future
resumable clones whenever new revisions were pushed. (And there would also
have to be some way to evict no-longer-reachable revs, maybe by simply
regenerating the whole shebang.)

For all of this to work, the most crucial idea would be this one: a clone
can *always* start as-is. Only when interrupted, and when the server
supports the "resumable clone" capability, and only when "resuming"
the clone, the client could *actually* ask for a resumable clone.

Yes, this could potentially waste a bit of bandwidth on the part of the
user with a flakey connection (because whatever was transferred during the
first, non-resumable clone would be blown out of the window), but it might
make it easier for us to provide a non-fragile upgrade path because the
cloning process would still default to the current one.

Food for thought?

Ciao,
Dscho
