From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: problem pushing repository
Date: Fri, 22 Jun 2007 12:26:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706221224310.4059@racer.site>
References: <799406d60706211849h6e4fd1dbn487beab03fe1d79c@mail.gmail.com> 
 <7v8xacbvf1.fsf@assigned-by-dhcp.pobox.com>  <20070622022426.GA2961@bowser.ruder>
 <1182496916.6207.11.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Ruder <andy@aeruder.net>, git@vger.kernel.org
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 22 13:27:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1hID-0004VP-R2
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 13:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbXFVL1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 07:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbXFVL1E
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 07:27:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:37147 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752219AbXFVL1C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 07:27:02 -0400
Received: (qmail invoked by alias); 22 Jun 2007 11:27:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 22 Jun 2007 13:27:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18n2wBgs/QnP5xq1RnB8ZBFltMTAGUNeLBUkngxzY
	aLL5esZz8CtgwQ
X-X-Sender: gene099@racer.site
In-Reply-To: <1182496916.6207.11.camel@localhost>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50689>

Hi,

On Fri, 22 Jun 2007, Raimund Bauer wrote:

> $ git push slcom test:test 
> error: dst refspec test does not match any existing ref on the remote
> and does not start with refs/.
> fatal: The remote end hung up unexpectedly
> error: failed to push to
> 'ray@softwarelandschaft.com:/home/ray/repos/drupal/multirate'

This is a completely unrelated problem!

It says that there is no branch named "test" on the remote side, and since 
you could also want to push a tag, you have to say

	test:refs/heads/test

here. However, I do not understand why you bother to use the :dst syntax 
here, since your target name is _exactly_ the same as the source name. Why 
not just

	git push slcom test

Hm??

> git-remote also has a problem:
> $ git remote show slcom
> bash: git-upload-pack: command not found
> fatal: The remote end hung up unexpectedly
> ls-remote --heads
> ray@softwarelandschaft.com:/home/ray/repos/drupal/multirate: command
> returned error: 1

That's apparently a bug in git-remote.

Ciao,
Dscho
