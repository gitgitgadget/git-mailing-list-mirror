From: Pavel Roskin <proski@gnu.org>
Subject: Re: cvsimport weird
Date: Wed, 17 May 2006 23:59:31 -0400
Message-ID: <1147924771.32050.40.camel@dv>
References: <4fb292fa0605171800n4f041dd2l8af06d82bdbe6bff@mail.gmail.com>
	 <46a038f90605171954n7e75ee64t412b22e8d405d909@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Bertrand Jacquin <beber.mailing@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 18 05:59:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgZfu-0004jn-BD
	for gcvg-git@gmane.org; Thu, 18 May 2006 05:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWERD7g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 23:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWERD7g
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 23:59:36 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:24961 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750781AbWERD7f
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 23:59:35 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FgZfi-0007a2-Oq
	for git@vger.kernel.org; Wed, 17 May 2006 23:59:34 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FgZff-0004CA-VO; Wed, 17 May 2006 23:59:31 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605171954n7e75ee64t412b22e8d405d909@mail.gmail.com>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20258>

On Thu, 2006-05-18 at 14:54 +1200, Martin Langhoff wrote:
> On 5/18/06, Bertrand Jacquin <beber.mailing@gmail.com> wrote:
> >
> The cvs server is strange -- buggy probably. cvsps thinks it is old,
> but it is not even returning a version string. Is it really cvs?

The version reporting is working for me:

$ cvs -d :pserver:anonymous@anoncvs.enlightenment.org:/var/cvs/e version
Client: Concurrent Versions System (CVS) 1.11.21 (client/server)
Server: Concurrent Versions System (CVS) 1.11.17 (client/server)

But I can reproduce the problem with git-cvsimport.  git main branch,
cvsps 2.1.

I'm quite sure that it's a bug in cvsps.  It displays such things on
x86_64, but works properly on 32-bit PowerPC.

x86_64:
$ cvsps --cvs-direct -A -u --root :pserver:anonymous@anoncvs.enlightenment.org:/var/cvs/e e17
connect error: Network is unreachable
WARNING: malformed CVS version: no data
WARNING: malformed CVS version str: (UNKNOWN CLIENT)
WARNING: Your CVS client version:
[(UNKNOWN CLIENT)]
and/or server version:
[(UNKNOWN SERVER)]

ppc:
$ cvsps --cvs-direct -A -u --root :pserver:anonymous@anoncvs.enlightenment.org:/var/cvs/e e17
cvs_direct initialized to CVSROOT /var/cvs/e
cvs rlog: Logging e17
cvs rlog: Logging e17/CVSROOT
cvs rlog: Logging e17/apps
cvs rlog: Logging e17/apps/e
cvs rlog: Logging e17/apps/e/client
...

Both are cvsps 2.1 on Fedora Core 5.

-- 
Regards,
Pavel Roskin
