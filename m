From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-push through git protocol
Date: Sun, 21 Jan 2007 19:01:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701211858340.14248@woody.osdl.org>
References: <17843.29798.866272.414435@lisa.zopyra.com>  <ep00nl$mop$1@sea.gmane.org>
  <Pine.LNX.4.64.0701211034490.14248@woody.osdl.org> 
 <17843.55730.456139.247155@lisa.zopyra.com>  <Pine.LNX.4.64.0701211341300.14248@woody.osdl.org>
  <17844.5120.316805.794579@lisa.zopyra.com>  <Pine.LNX.4.64.0701211749140.14248@woody.osdl.org>
 <46a038f90701211826v54340352lf4376db41ad5be37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>, Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 22 04:01:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8pRQ-0002Hf-NR
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 04:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbXAVDBt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 22:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbXAVDBt
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 22:01:49 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53453 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889AbXAVDBs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 22:01:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0M31khB012013
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 21 Jan 2007 19:01:46 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0M31jgL015380;
	Sun, 21 Jan 2007 19:01:45 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90701211826v54340352lf4376db41ad5be37@mail.gmail.com>
X-Spam-Status: No, hits=-0.66 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37392>



On Mon, 22 Jan 2007, Martin Langhoff wrote:

> On 1/22/07, Linus Torvalds <torvalds@osdl.org> wrote:
> > Umm. Your git daemon is probably running as "nobody", and simply doesn't
> > have write permissions to the archive, does it?
> > 
> > > % cat /etc/xinet.d/git-daemon
> > > service git
> > > {
> > >         user            = nobody
> > 
> > iow, I think you simply need to make sure that git-daemon will have write
> > permission to the thing. Either by making the whole repository writable by
> > nobody, or by running git-daemon as the proper user.
> 
> Whereby I personaly run back quickly to cover under my git-over-ssh
> safety blanket.

Sure. 

I suspect that git-daemon is possibly easier and faster to set up in the 
kind of situation where you set up git instead of CVS inside a company, 
though.

In that situation, you could just say: "machine X is the central CVS 
repository, and now it also contains a set of git repositories, all owned 
by nobody:nobody".

That way, you basically get the exact same situation as you had with CVS, 
with minimal setup.

If the alternative is some NFS thing, I'd take that writing git-daemon 
over shared NFS-access from everybody any day..

		Linus
