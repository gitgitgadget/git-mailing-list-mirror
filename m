From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk changing line color for no reason after merge
Date: Tue, 7 Feb 2006 19:56:48 +1100
Message-ID: <17384.24784.898327.669875@cargo.ozlabs.ibm.com>
References: <1138900897.28967.18.camel@dv>
	<1139289517.15955.23.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 11:35:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6QBc-0000I2-4Z
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 11:35:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWBGKet (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 05:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWBGKet
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 05:34:49 -0500
Received: from ozlabs.org ([203.10.76.45]:12190 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964849AbWBGKes (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2006 05:34:48 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id E09C0689C0; Tue,  7 Feb 2006 21:34:46 +1100 (EST)
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1139289517.15955.23.camel@dv>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15691>

Pavel Roskin writes:
> Hello!

> I didn't realize that the colors correspond to nodes, not branches.
> Every node has one color that is used for lines to all of its children.
> It would be much better to assign colors to "branches" consisting of
> individual lines connecting nodes, but changing that would require many

Why would that be better?

> > -    if {$nparents($id) <= 1 && $nchildren($id) == 1} {
> > +    if {$nchildren($id) == 1} {
> >  	set child [lindex $children($id) 0]
> >  	if {[info exists colormap($child)]
> >  	    && $nparents($child) == 1} {
> > 
> > 
> 
> I still stand behind this patch because it eliminates color changes on
> the nodes that have exactly one child and parent.  $nparents($id) is

Ummm... I don't see that you have changed anything for nodes that have
exactly one parent?

> However, further changes to reduce color changes didn't produce nice
> results for me.  If I try to keep one color running as long as possible,
> I get branches of the same color because, as I said, gitk uses the same
> color for connections to all children.  So, every node on the branch
> spurs branching lines of the same color, which can intersect or run
> side-by-side.

The colors are really just to make the lines visually distinct.  They
(the colors) have no semantic meaning.  (I did try coloring the lines
according to the committer, but I just ended up with an awful lot of
lines being the same color - corresponding to one Linus Torvalds. :)

Paul.
