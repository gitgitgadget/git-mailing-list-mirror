From: Chris Frey <cdfrey@foursquare.net>
Subject: Re: Rebasing a merged branch
Date: Sat, 10 Jul 2010 02:55:41 -0400
Message-ID: <20100710065541.GB15600@foursquare.net>
References: <alpine.DEB.2.00.1007081247410.18908@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Sat Jul 10 08:56:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXTyf-0003dE-Qv
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 08:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab0GJGzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jul 2010 02:55:53 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:40396 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab0GJGzx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jul 2010 02:55:53 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (nic.NetDirect.CA [216.16.235.2])
	by rubicon.netdirect.ca (8.13.8/8.13.8) with ESMTP id o6A6tftR016474;
	Sat, 10 Jul 2010 02:55:41 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1007081247410.18908@ds9.cixit.se>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150712>

On Thu, Jul 08, 2010 at 12:52:08PM +0100, Peter Krefting wrote:
> Hi!
> 
> If I slightly modify the example from the git-rebase manual page to look 
> like this:
> 
>   o---o---o---o  master
>          \
>           o---o---o---o---o  topicA
>            \     /
>             A---B---C---D  topicB
> 
> (topicA has merged "B" into its history; its first-parent from the line of 
> "o"s).
> 
> If I now do a "git rebase --onto master topicA topicB", I only get commit C 
> and D, as it sees A and B as being part of both branches.
> 
> Is there a way to make git rebase pick up A, B, C and D (and only them)?
> 
> I.e., I would like "all commits on topicB which are not in topicA's 
> --first-parent history".


I'm no expert on rebase --onto, but aren't you trying to rebase so that
the tree looks like this afterward?


   o---o---o---o  master
            \   \
             \   A---B---C---D  topicB
              \
               o---o---o---o---o  topicA
                \     /
                 A---B
 
In which case, won't this work?

	git checkout topicB
	git rebase master

- Chris
