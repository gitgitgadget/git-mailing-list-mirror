From: Willy Tarreau <w@1wt.eu>
Subject: Re: Multiple working trees with GIT ?
Date: Thu, 24 Jan 2008 13:56:06 +0100
Message-ID: <20080124125606.GB13247@1wt.eu>
References: <20080124074952.GA8793@1wt.eu> <Pine.LNX.4.64.0801240947230.14173@reaper.quantumfyre.co.uk> <alpine.LSU.1.00.0801241102260.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 24 14:28:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI27f-0002tQ-0N
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 14:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbYAXN11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 08:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbYAXN10
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 08:27:26 -0500
Received: from 1wt.eu ([62.212.114.60]:1587 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbYAXN10 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 08:27:26 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801241102260.5731@racer.site>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71617>

On Thu, Jan 24, 2008 at 11:04:42AM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 24 Jan 2008, Julian Phillips wrote:
> 
> > You might want to have a look at the git-new-workdir script in contrib, 
> > it does basically the same thing.  It's been there for about 10 months 
> > now. It was based on an email from Junio:
> > 
> > http://article.gmane.org/gmane.comp.version-control.git/41513/
> 
> FWIW I have a patch to do something like that in "git branch" itself.
>
> > However, there are some caveats about using this approach, basically 
> > about the fact that there is nothing stopping you from updating refs 
> > that are currently checked out in another directory and causing yourself 
> > all sorts of pain ... the topic has cropped up a couple of times on the 
> > list since the script was added.
> 
> I agree; maybe we should have a telltale file 
> "refs/heads/<bla>.checkedout" which is heeded by "git checkout" and "git 
> branch -d/-D", as well as update_ref() (should only update that ref when 
> it HEAD points to it)?

Why not generalize this into HEAD.$branch (thus limiting to one checkout
per branch) or HEAD.$checkoutdir ?

Best regards,
Willy
