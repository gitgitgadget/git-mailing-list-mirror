From: Nicolas Pitre <nico@cam.org>
Subject: Re: Reverting an uncommitted revert
Date: Tue, 19 May 2009 23:10:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905192300070.3906@xanadu.home>
References: <4A136C40.6020808@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Wed May 20 05:10:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6cCP-0002CD-Ub
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 05:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbZETDKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 23:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbZETDKV
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 23:10:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60383 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbZETDKU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 23:10:20 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KJX00JGPA35HKF0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 19 May 2009 23:09:05 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4A136C40.6020808@workspacewhiz.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119579>

On Tue, 19 May 2009, Joshua Jensen wrote:

> So here's the idea: What if Git, upon a revert change (or git reset --hard
> HEAD), "committed" the changes to be reverted and then did the revert with a
> 'git reset --hard HEAD^'?  The reverted files would be disconnected from a
> branch, but they would be available in the reflog to retrieve.

I think there is indeed some value in having a commit of the work 
directory dirty state automatically made before this state is discarded, 
and stuff a reference to that commit in the HEAD reflog.  I think such a 
feature would need to be made configurable and active by default.


Nicolas
