From: Raimund Bauer <ray007@gmx.net>
Subject: Re: problem pushing repository
Date: Fri, 22 Jun 2007 09:21:56 +0200
Message-ID: <1182496916.6207.11.camel@localhost>
References: <799406d60706211849h6e4fd1dbn487beab03fe1d79c@mail.gmail.com>
	 <7v8xacbvf1.fsf@assigned-by-dhcp.pobox.com>
	 <20070622022426.GA2961@bowser.ruder>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Ruder <andy@aeruder.net>
X-From: git-owner@vger.kernel.org Fri Jun 22 09:22:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1dT6-000161-4l
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 09:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbXFVHWG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 03:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbXFVHWE
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 03:22:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:58737 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751803AbXFVHWC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 03:22:02 -0400
Received: (qmail invoked by alias); 22 Jun 2007 07:22:00 -0000
Received: from unknown (EHLO [192.168.178.21]) [84.152.160.195]
  by mail.gmx.net (mp042) with SMTP; 22 Jun 2007 09:22:00 +0200
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX18Y7wxuVwsYC22RPC/rgQ0P//4phCxjTs5KpocXbL
	q0qBqS/NaL6ABL
In-Reply-To: <20070622022426.GA2961@bowser.ruder>
X-Mailer: Evolution 2.10.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50681>

On Thu, 2007-06-21 at 21:24 -0500, Andrew Ruder wrote:
> On Thu, Jun 21, 2007 at 07:00:18PM -0700, Junio C Hamano wrote:
> > 	$ ssh newberry.ihepa.ufl.edu sh -c 'echo $PATH'
> > 
> > may be a good starting point to test this, and the first step
> > to fix it would be
> > 
> > 	$ man ssh
> > 	$ man sshd
> 
> While I wholeheartedly agree with Junio here, you may also find
> 
> remote.<name>.receivepack

Yes, but it doesn't always work.
I have a server with several repositories, and git is installed
in /usr/local/bin.
All my local repostories know this server as a remote named 'slcom' and
I have a 2 global options
remote.slcom.uploadpack=/usr/local/bin/git-upload-pack
remote.slcom.receivepack=/usr/local/bin/git-receive-pack

Fetching, pulling and normal pushing works.
Pushing a new branch to the remote doesn't work:
$ git branch test
$ git push slcom test:test 
error: dst refspec test does not match any existing ref on the remote
and does not start with refs/.
fatal: The remote end hung up unexpectedly
error: failed to push to
'ray@softwarelandschaft.com:/home/ray/repos/drupal/multirate'

git-remote also has a problem:
$ git remote show slcom
bash: git-upload-pack: command not found
fatal: The remote end hung up unexpectedly
ls-remote --heads
ray@softwarelandschaft.com:/home/ray/repos/drupal/multirate: command
returned error: 1

All this with git from yesterday (next).

> - Andy

-- 
best regards

  Ray
