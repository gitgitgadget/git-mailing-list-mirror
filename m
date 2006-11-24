X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 24 Nov 2006 12:29:03 +0100
Organization: At home
Message-ID: <ek6kuq$dd8$1@sea.gmane.org>
References: <20061116160700.GA3383@thunk.org> <E1Gn1PG-0002oW-00@skye.ra.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 24 Nov 2006 11:27:58 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 53
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32209>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnZDX-0007oB-4a for gcvg-git@gmane.org; Fri, 24 Nov
 2006 12:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933058AbWKXL1g (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 06:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933059AbWKXL1g
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 06:27:36 -0500
Received: from main.gmane.org ([80.91.229.2]:51669 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S933058AbWKXL1f (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 06:27:35 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GnZDP-0007lo-MU for git@vger.kernel.org; Fri, 24 Nov 2006 12:27:33 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 12:27:31 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 24 Nov 2006
 12:27:31 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Sanjoy Mahajan wrote:

> The car analogy is excellently clear.
> 
>> they need more than the "stupid simple" git usage, but if they don't
>> need the extreme power of git, Hg is simpler for people to learn how
>> to use.
> 
> As a 80%-hg/20%-git user, I'm curious what features of git you had in
> mind, so I know where to look as I wander up the git learning curve.
> 
> My experience with the git user interface, for what it's worth, is
> that I never quite get the conceptual model crystal clear enough in my
> head. So it won't stay for long enough for me to progress up the
> learning curve and retain the gains.  I move up a bit, but the gain
> soon evaporates and I backslide, and then just hack my way through it.
> 
> I found hg's conceptual model very easy to learn, almost as if I don't
> have to remember anything.  Maybe that simplicity comes at a price,
> whence my question at the start about the extreme-power features of
> git.

As I never used Mercurial (hg), only read a bit about it and discussed on
#revctrl, I cannot say what features git has that hg has not, but I can
tell what powerfull git features differ from other SCM.

First, usually in other SCM the concept of branch is closely tied to the
concept of repository, perhaps allowing to share storage between branches
on the same local filesystem (on the same machine). In git, repository
holds DAG, the graph of revisions (of versions). Branches are "only" ways
to access this graph, and to extend it of the new commits. This makes git
more powerfull, but also perhaps unnecessary complicated if you deal with
single-branch repositories, or few-branch case. Additionally this
"complication" makes very clean model of repository - but you have to
understand it...

Second, the index. One might think that it is performance hack, but it
allows for commiting changes piece by piece and, what is more important,
a place form making merge in. Cogito (alternate Git UI/porcelain) tries to
hide index. By the way, I wonder how hg does merges without index to
provide place where do merges in...

Third, explicit/on-demand packing. This allows for the most (I think)
compression of all SCMs, and for the wire format to be the same as on-disk
format (with the addition that you can send thin packs on wire). As of now
no porcelain tries to hide it, although with the latest work allowing for
historical packs it would be easy to add this without significantly
affecting preformance.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

