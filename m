From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: How to use git-svnimport without trunk, tags and branches?
Date: Sun, 11 Mar 2007 21:26:20 +0100
Message-ID: <20070311202620.GB15336@diana.vm.bytemark.co.uk>
References: <45F3EA37.2080502@tropezien.de> <20070311143638.GA7822@diana.vm.bytemark.co.uk> <45F434E9.7040003@tropezien.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Georg Lohrer <pacco@tropezien.de>
X-From: git-owner@vger.kernel.org Sun Mar 11 21:26:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQUcq-0005eF-B6
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 21:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbXCKU0h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 11 Mar 2007 16:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbXCKU0h
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 16:26:37 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3426 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbXCKU0g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 16:26:36 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HQUcW-00046c-00; Sun, 11 Mar 2007 20:26:20 +0000
Content-Disposition: inline
In-Reply-To: <45F434E9.7040003@tropezien.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41975>

On 2007-03-11 17:57:13 +0100, Georg Lohrer wrote:

> Karl Hasselstr=F6m schrieb:
>
> > You could try something like this:
> >
> >  trunk: svnrepos/projectA
> >  tags: svnrepos/dummytags
> >  branches: svnrepos/dummybranches
>
> yes, that does the trick. I use:
>
> $ cd ~/tmp/git-test
> $ tar xvfj fooRepos.tar.bz2
> $ mv fooRepos foorRepos.svnrepos
> $ svn mkdir file:///home/georg/tmp/git-test/fooRepos.svnrepos/dummyta=
gs
> $ svn mkdir file:///home/georg/tmp/git-test/foorRepos.svnrepos/dummyb=
ranches
> $ mkdir fooRepos.git; cd fooRepos.git
> $ git-svnimport -b dummybranches -t dummytags -T projectA file:///hom=
e/georg/tmp/git-test/fooRepos.svnrepos

Did you try importing without creating the dummy* directories? I think
it may work even if they don't exist.

> Unfortunately there was a bunch of directories instead of a single
> projectA-directory. Do I have to repeat the above mentioned sequence
> for every directory (projectA, projectB, ...) or is there a simple
> way of git-svnimport'ing into an existing git-repository?

You could try this:

  trunk: dummy
  tags: dummy
  branches: svnrepos

That should turn svnrepos/projectA into the branch projectA,
svnrepos/projectB into the branch projectB, and so on.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
