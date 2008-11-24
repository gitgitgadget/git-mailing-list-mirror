From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH] config.txt: alphabetize configuration variable groups
Date: Mon, 24 Nov 2008 15:00:09 -0500
Message-ID: <1227556809.2628.8.camel@mattlaptop2.local>
References: <1227510109.32583.2.camel@mattlaptop2.local>
	 <492A579B.5000304@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 24 21:02:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4hcz-0001BZ-BV
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 21:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbYKXUAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 15:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbYKXUAX
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 15:00:23 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:59567 "EHLO
	jankymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753201AbYKXUAW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2008 15:00:22 -0500
Received: from [129.2.134.244] (129-2-134-244.wireless.umd.edu [129.2.134.244])
	by jankymail-a1.g.dreamhost.com (Postfix) with ESMTP id C62B5986D3;
	Mon, 24 Nov 2008 12:00:20 -0800 (PST)
In-Reply-To: <492A579B.5000304@viscovery.net>
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101621>

On Mon, 2008-11-24 at 08:28 +0100, Johannes Sixt wrote:
> Matt McCutchen schrieb:
> > @@ -963,6 +953,8 @@ man.<tool>.path::
> >  	Override the path for the given tool that may be used to
> >  	display help in the 'man' format. See linkgit:git-help[1].
> >  
> > +include::merge-config.txt[]
> > +
> >  merge.conflictstyle::
> >  	Specify the style in which conflicted hunks are written out to
> >  	working tree files upon merge.  The default is "merge", which
> 
> Here, the list is not in alphabetic order anymore.

After my change, the list is in alphabetical order by the first
component (before the first dot).  I assume you're pointing out that I
haven't separated the merge.<driver> parameters from the non-<driver>
merge parameters.

The reason I left it that way was I thought there might be some reason
why merge.conflictstyle is in config.txt rather than merge-config.txt
(the difference being that it appears in "man git-config" but not
"man git-merge"), and to keep that arrangement while grouping together
the non-<driver> merge parameters, I would have to split
merge-config.txt into two separately included files.

I went back and looked at the commit (b5412484) that documented
merge.conflictstyle, and it appears that the placement in config.txt may
have been a mistake arising from the unsortedness of config.txt rather
than a conscious decision.  Thus, I'll move that entry to
merge-config.txt for the better grouping.  That does mean "man
git-merge" will contain two explanations of merge.conflictstyle (the
brief config-parameter one and the "HOW CONFLICTS ARE PRESENTED"
section), but I don't see that as a big problem.

> BTW, your commit message should emphasize the use-cases where an
> alphabetic order is a real benefit. Otherwise, this is just code churn.

I don't see alphabetization as a major benefit except that it might help
people add new parameters in the right place (case in point: the
addition of merge.conflictstyle).  And I figured that the config
parameters might as well be in /some/ order.  I'll state that in the
commit message.

Updated patch to follow.

Matt
