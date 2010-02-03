From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git-mv redux: there must be something else going on
Date: Wed, 03 Feb 2010 15:44:44 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002031533560.1681@xanadu.home>
References: <ron1-32BD5F.10255403022010@news.gmane.org>
 <32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com>
 <ron1-5F71CB.11234903022010@news.gmane.org>
 <alpine.LFD.2.00.1002031436490.1681@xanadu.home>
 <ron1-34F9C6.12273203022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 21:45:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncm5u-0003zC-2G
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 21:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932845Ab0BCUo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 15:44:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49560 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932827Ab0BCUo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 15:44:56 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXA000S19MK3331@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 03 Feb 2010 15:44:45 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <ron1-34F9C6.12273203022010@news.gmane.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138893>

On Wed, 3 Feb 2010, Ron Garret wrote:

> OK, on closer reading I see that the information is there, but it's well 
> hidden :-)  (For example, the -M option takes an optional numerical 
> argument so you can tweak how much similarity is needed to be considered 
> a move.  But the docs for git log don't mention this.  It's buried deep 
> in the git diffcore docs.  But yes, it's there.)

The doc is indeed not perfect.  Probably the -M option and friends could 
be listed again in the git-log and git-diff pages with a more casual 
explanation.

> So I think I'm beginning to understand how this works, but that leads me 
> to another question: it seems to me that there are potential screw cases 
> for this purely content-based system of tracking files.  For example, 
> suppose I have a directory full of sample config files, all of which are 
> similar to each other.  Will that cause diffcore to get confused?

There are ways to fool the heuristics indeed.  But overall it is still 
more reliable than manually having to record the rename into the tool 
since humans are known for screwing these things up more often than 
machines.  And again the heuristics can be modified after the fact if 
needed, unlike the manually recorded false renames (or lack of rename 
record) which will remain wrong unless another manual correction is 
applied to the database.


Nicolas
