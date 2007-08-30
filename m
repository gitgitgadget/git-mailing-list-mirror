From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: gitk startup time improvement
Date: Thu, 30 Aug 2007 22:42:22 +0200
Message-ID: <20070830204222.GB15405@steel.home>
References: <18134.45449.527540.940620@cargo.ozlabs.ibm.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 22:42:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQqqT-00076J-U3
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 22:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759357AbXH3UmZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 16:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759262AbXH3UmZ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 16:42:25 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:49214 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238AbXH3UmY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 16:42:24 -0400
Received: from tigra.home (Fc93c.f.strato-dslnet.de [195.4.201.60])
	by post.webmailer.de (fruni mo18) (RZmta 12.1)
	with ESMTP id 506af7j7UGLBzf ; Thu, 30 Aug 2007 22:42:22 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 90D93277BD;
	Thu, 30 Aug 2007 22:42:22 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 73112BE2A; Thu, 30 Aug 2007 22:42:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <18134.45449.527540.940620@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAPiog==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57068>

Paul Mackerras, Thu, Aug 30, 2007 14:01:13 +0200:
> In the 'dev' branch of the gitk.git repository at
> 
> git://git.kernel.org/pub/scm/gitk/gitk.git
> 
> there is now a version of gitk that is much faster at starting up than
> the standard version.  Firstly, it doesn't lay out the whole graph,
> only the parts that get displayed (plus a little bit either side), and
> secondly, it caches the topology information that is used to determine
> which tags a commit precedes and follows, and which branches it is on.
> 
> I'd like people to try it.  Comments, bug reports, patches etc. are
> welcome, of course.

Well, it works. The improvements are not very noticeable, though (I
tried git and kernel repos). Besides, there is a slight delay (~1-2
sec) in kernel repo (writing the cache out?) on exit.

I used gitk from this commit:

    commit 5cd15b6b7f87dc61f729ad31a682ffc394560273
    Author: Paul Mackerras <paulus@samba.org>
    Date:   Thu Aug 30 21:54:17 2007 +1000

	gitk: Add a cache for the topology info

BTW, what should happen if I try running many gitks in the same repo?
Is the cache safe for concurrent writing by them? Is it NFS-safe?
