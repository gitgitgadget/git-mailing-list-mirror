From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Following renames
Date: Mon, 27 Mar 2006 00:07:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603270005330.15714@g5.osdl.org>
References: <20060326014946.GB18185@pasky.or.cz>  <7virq1sywj.fsf@assigned-by-dhcp.cox.net>
 <e06fl8$p9f$1@sea.gmane.org>  <Pine.LNX.4.64.0603260843250.15714@g5.osdl.org>
  <e06hts$1ne$1@sea.gmane.org>  <Pine.LNX.4.64.0603260947100.15714@g5.osdl.org>
  <e5bfff550603261122m5e680c62ye1290f3e601e947e@mail.gmail.com> 
 <Pine.LNX.4.64.0603261422280.15714@g5.osdl.org>
 <e5bfff550603262147t3aec8da6p6bf2a333e2d35f1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 10:07:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNmkz-0001JB-TL
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 10:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWC0IHP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 03:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWC0IHP
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 03:07:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29593 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750788AbWC0IHO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Mar 2006 03:07:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2R87BDZ031875
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Mar 2006 00:07:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2R87AgG004427;
	Mon, 27 Mar 2006 00:07:11 -0800
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550603262147t3aec8da6p6bf2a333e2d35f1d@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18078>



On Mon, 27 Mar 2006, Marco Costalba wrote:
> 
> Historic Linux test (63428 revisions)
> 
> File: drivers/net/tg3.c
> Revisions that modify tg3.c : 292
> 
> With qgit
> 15s to retrieve file history (git-rev-list)
> 19.5s to annotate (git-diff-tree -p, current GNU algorithm, not new faster one)

.. and it does absolutely _nothing_ while it's doing that, does it?

> $ time git-whatchanged HEAD drivers/net/tg3.c > /dev/null
> 98.01user 2.44system 1:46.19elapsed 94%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (797major+43033minor)pagefaults 0swaps

In contrast, git-whatchanged will start outputting the recent changes 
immediately.

And that's the point. Almost always, we're interested in the _recent_ 
stuff. The fact that it takes longer to get the old history  is not very 
important. You generally don't ask "what changed in this file" for a file 
that hasn't changed in five years.

		Linus
