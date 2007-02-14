From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: Newbie experience with push over ssh
Date: Wed, 14 Feb 2007 15:27:31 +0100
Message-ID: <20070214142731.GA1478@moooo.ath.cx>
References: <vpq64a4bzp1.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Feb 14 15:27:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHL6i-0001SY-FV
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 15:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbXBNO1i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 09:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbXBNO1h
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 09:27:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:60665 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932317AbXBNO1h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 09:27:37 -0500
Received: (qmail invoked by alias); 14 Feb 2007 14:27:35 -0000
X-Provags-ID: V01U2FsdGVkX1+SNP58YhWSZIGHXcqYi6CwwLzNvD+rB9USqf1bMO
	EgOQ==
Mail-Followup-To: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <vpq64a4bzp1.fsf@olympe.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39652>

Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> I could create a local repository, commit in it, but then, I tried to
> push it to a remote machine, on which git is installed.
> 
> I would have expected "push" to do this, but:
> 
> $ git push ssh://machine.fr/tmp/foo 
> fatal: '/tmp/foo': unable to chdir or not a git archive
> fatal: The remote end hung up unexpectedly
git push is can only push into an existing repository, there seems to
be no repository in /tmp/foo on machine.fr.

> Then, I tried "clone":
> 
> $ git clone . ssh://machine.fr/tmp/foo
This means: "clone the repository at . to the directory
ssh://machine.fr/tmp/foo".  The first parameter is the repository to
clone from, the second is the directory to put the clone into (this is
optional).

I don't think there is any way to 'clone to remote'.  You'd have to
ssh to the other machine and clone from there, or you can just create
an empty repository on the remote host and push the stuff into it.
