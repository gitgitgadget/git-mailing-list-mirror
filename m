From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysgit? bug] crlf double-conversion on win32
Date: Wed, 14 Oct 2009 16:03:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910141601580.4985@pacific.mpi-cbg.de>
References: <38cfaa83fdf80dec3a3d81ed3e0de0e2.squirrel@intranet.linagora.com> <loom.20091014T001602-378@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 16:05:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My4T9-0000tK-7f
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 16:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932977AbZJNOBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 10:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932952AbZJNOBv
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 10:01:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:42745 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932869AbZJNOBv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 10:01:51 -0400
Received: (qmail invoked by alias); 14 Oct 2009 14:01:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 14 Oct 2009 16:01:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18t3vE4lQwt3rMxCG2fW1H+0uGaz6T8IkYMA+vUin
	/wqPWTutIgUTKD
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <loom.20091014T001602-378@post.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130288>

Hi,

On Tue, 13 Oct 2009, Eric Raible wrote:

> Yann Dirson <y.dirson <at> e-sidor.com> writes:
> 
> > 
> > With a msysgit 1.6.4 package, I got stuck after someone copied a CRLF file
> > to a Linux box and committed it.
> > 
> > In that situation, the win32 client in autocrlf mode keeps telling that
> > the files are locally modified, even after eg "git reset --hard".  Without
> > touching the crlf setting (which I believe should not ever be necessary),
> > this can be corrected by committing the faulty files after dos2unix'ing
> > them, and using "git fetch && git reset --hard origin/master" ("git pull
> > --rebase" refuses to do the job since it believes there are local
> > changes).
> 
> See http://thread.gmane.org/gmane.comp.version-control.git/122823/focus=122862
> 
> In which Junio suggests:
> $ rm .git/index
> $ git reset --hard
> 
> in order to "restore sanity to your work tree"

Of course this is insane as a user interface.  It is not even plumbing.

So I started some time ago to code a "git checkout --fix-crlf", but I 
am not really happy with the user interface.  I think that Git should 
realize itself that something went wrong with the line endings.  If I say 
"git reset --hard", it is just a bug in Git when it insists afterwards 
that the files are modified.

Ciao,
Dscho
