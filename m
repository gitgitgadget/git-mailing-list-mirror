From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: http git and curl 7.16.0
Date: Wed, 27 Dec 2006 22:35:21 -0300
Message-ID: <200612280135.kBS1ZL5v004756@laptop13.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Nick Hengeveld <nickh@reactrix.com>,
	George Sherwood <pilot@beernabeer.com>, skimo@liacs.nl,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 02:35:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzkBP-0002SZ-2S
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 02:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWL1Bfn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 20:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWL1Bfn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 20:35:43 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:37104 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964859AbWL1Bfm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 20:35:42 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id kBS1ZSFn012027
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 27 Dec 2006 22:35:32 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kBS1ZL5v004756;
	Wed, 27 Dec 2006 22:35:21 -0300
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Wed, 27 Dec 2006 11:53:58 -0800." <7vlkkt5d49.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Delayed for 00:01:39 by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 27 Dec 2006 22:35:37 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35500>

Junio C Hamano <junkio@cox.net> wrote:
> "Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:
> > Sven Verdoolaege <skimo@kotnet.org> wrote:
> >> On Sat, Nov 18, 2006 at 08:07:08AM +0400, George Sherwood wrote:
> >> > I seem to be having a problem doing an http checkout with git built
> >> > with curl 7.16.0 enabled.  If I build against curl 7.16.0 and try a
> >> > clone, I get:
> > ...
> >> > git clone http://dmlb2000.homelinux.org/~dmlb2000/git-repos/local/castfs.git
> >> > error: Unable to start request error: Could not interpret heads/master
> >> > as something to pull
> >> > 
> >> > If I rebuild git against curl 7.15.5 then I get:
> >> [..]
> >> > and the checkout finishes.
> >> > 
> >> > Has any one else seen this?
> >
> >> FWIW, I've seen the same with curl 7.16.0 on a Solaris 9 machine.
> >> It worked fine with curl 7.15.0.
> >
> > It works fine for me on Aurora Corona (sparc) with curl-7.15.5-1.al3, while
> > it fails as above on Fedora rawhide (i386) with curl-7.16.0-4.fc7.
> >
> > Furthermore, with new curl pulling from HTTP repos when there are updates
> > gives double free errors and a crash.
> 
> Hmmm.  Could somebody please run http-fetch under gdb and see
> where it breaks?  The exact command line you need to use would
> be obtainable by running "sh -x git-clone" once.

It crashes the kernel for me here :-(

I tried to chop down a tig repo a few commits from the top for checking out
the crash I'm seeing (only when pulling from a remote repo by HTTP, and it
is not up to date here) by doing:

  cp -r tig tig.tst
  cd tig.tst
  git reset --hard HEAD~3
  git prune

But now git-pull /doesn't/ fetch anything, so I see no crash. What am I
doing wrong here?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
