From: Jason Merrill <jason@redhat.com>
Subject: Re: git clone sending unneeded objects
Date: Sat, 26 Sep 2009 00:44:28 -0400
Message-ID: <4ABD9C2C.60800@redhat.com>
References: <m2tz0j154o.fsf@igel.home> <alpine.LFD.2.00.0908082246020.440@xanadu.home> <m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com> <vpqvdj6izt6.fsf@bauges.imag.fr> <alpine.LFD.2.00.0909251551290.4997@xanadu.home> <4ABD25FE.2040902@redhat.com> <alpine.LFD.2.00.0909251629330.4997@xanadu.home> <4ABD4F7B.4030701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Hin-Tak Leung <hintak.leung@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 26 06:45:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrP9f-000157-IC
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 06:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbZIZEoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 00:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbZIZEoa
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 00:44:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1025 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbZIZEo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 00:44:29 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8Q4iTZ3012557;
	Sat, 26 Sep 2009 00:44:29 -0400
Received: from [IPv6:::1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8Q4iSlZ031892;
	Sat, 26 Sep 2009 00:44:29 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.4pre) Gecko/20090924 Shredder/3.0pre
In-Reply-To: <4ABD4F7B.4030701@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129143>

Incidentally, somewhat related to this issue, I've noticed that if I 
fetch a branch which I don't currently have in my repository, and I have 
most of the commits on that branch in my object store (or in an 
alternate repository) but not the most recent commit, git fetch isn't 
smart enough to only grab the commits I'm actually missing, it wants to 
fetch much more.

I would expect that since the clone pulled down everything in the 
gcc.git repository, I could then do

git config remote.origin.fetch 'refs/remotes/*:refs/remotes/origin/*'
git fetch

and have all the branches, not just the ones in refs/heads.  But when I 
do this git fetch wants to fetch some 500k redundant objects.

Jason
