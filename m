From: Jason Merrill <jason@redhat.com>
Subject: Re: git clone sending unneeded objects
Date: Fri, 25 Sep 2009 16:20:14 -0400
Message-ID: <4ABD25FE.2040902@redhat.com>
References: <m2tz0j154o.fsf@igel.home> <alpine.LFD.2.00.0908082246020.440@xanadu.home> <m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com> <vpqvdj6izt6.fsf@bauges.imag.fr> <alpine.LFD.2.00.0909251551290.4997@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Hin-Tak Leung <hintak.leung@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Sep 25 22:20:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrHHR-00011f-8k
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 22:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbZIYUU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 16:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbZIYUU1
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 16:20:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20970 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591AbZIYUU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 16:20:26 -0400
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8PKKQNG008873;
	Fri, 25 Sep 2009 16:20:26 -0400
Received: from [IPv6:::1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8PKKESY014116;
	Fri, 25 Sep 2009 16:20:25 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.4pre) Gecko/20090924 Shredder/3.0pre
In-Reply-To: <alpine.LFD.2.00.0909251551290.4997@xanadu.home>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129111>

On 09/25/2009 03:53 PM, Nicolas Pitre wrote:
> I did reproduce the issue with git:// back when this discussion started.
> I also asked for more information about the remote which didn't come
> forth.

Looking back, I only see you asking about the git version on the server, 
which is 1.6.4.

So again:

git clone git://gcc.gnu.org/git/gcc.git
  (1399509 objects, ~600MB .git dir)
git gc --prune=now (988906 objects, ~450MB .git dir)

...then

git clone git://gcc.gnu.org/git/gcc.git --reference $firstclone
  (573401 objects, ~550MB .git dir)
git fsck (clean)
git gc --prune=now (5 objects, ~7MB .git dir)

What's going on here?

Jason
