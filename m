X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 16:18:21 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611151559470.2591@xanadu.home>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home>
 <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home>
 <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <20061115201227.GM7201@pasky.or.cz>
 <Pine.LNX.4.64.0611151524000.2591@xanadu.home>
 <Pine.LNX.4.64.0611151243030.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 15 Nov 2006 21:18:35 +0000 (UTC)
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0611151243030.3349@woody.osdl.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31501>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkS9K-0002Kh-FL for gcvg-git@gmane.org; Wed, 15 Nov
 2006 22:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030998AbWKOVSX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 16:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031001AbWKOVSX
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 16:18:23 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34642 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1030998AbWKOVSW
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 16:18:22 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8S00K45J6L8X50@VL-MO-MR001.ip.videotron.ca> for git@vger.kernel.org; Wed,
 15 Nov 2006 16:18:21 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006, Linus Torvalds wrote:

> 
> 
> On Wed, 15 Nov 2006, Nicolas Pitre wrote:
> > 
> > I think "fetch" is sane.  Its only problem is a missing symetrical 
> > counterpart verb, like "get" and "put".
> 
> If you're a dog owner, the obvious counterpart for "fetch" is "throw" ;)

Yeah.  You could always throw a branch to your dog.

Or maybe we should introduce the concept of "bones" to GIT in place of 
branches?  ;-)

> I think "get" and "put" would be bad, just because of confusion with 
> "sccs get" (ie it has that "get this file" connotations).

Has SCCS really had a similar level of influence than BK or CVS in that 
matter?

> Maybe "fetch" and "push" aren't totally diametrically opposite, but 
> really, I don't think they are that hard to understand either. We do have 
> the BK legacy of "pull" implying a merge, and that's fairly fundamental. 
> 
> It's also true that in a lot of usage schenarios, what people actually 
> _use_ is "pull" and "push", and no, they aren't mirror images (since push 
> will _not_ do the merge), but at the same time, from a _usage_ standpoint 
> they really _are_ each others opposites. 

The problem is the "usage standpoint" distinction that has to be made.  
Exactly because in GIT it is a bit distorted from what most people 
expect from other standpoints.

> You "pull" to get other peoples data into your branch (and once you've 
> internalized local branches and the merge thing, you know what this 
> means), and you "push" to push your changes out. It really _is_ the usage 
> schenario, and using "opposite" words really _does_ make sense.

But that's exactly why newbies have problems.  Instead of simply 
understanding the bare operation (fetch data in a branch _then_ merge 
it) they sort of need to abstract the concept of branch away because a 
"pull" does it all automagically.  Which is fine as long as you're 
willing to ignore branch concepts altogether.  But once branches are 
back in the picture for more involved operations then the "pull" word 
simply feels odd.  Even more so with the local merge syntax.

When I say to someone "just merge branch weezee with your current 
branch" the most intuitive command would be:

	git merge weezee

But because "pull" mixes two concepts together this makes the thing more 
esoteric.  Unless, of course, you get used to the mental model you 
outlined above, but IMHO simply needing a mental model to explain the 
tool is a sign that something is mapped wrong.


