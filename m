From: Stephan Beyer <s-beyer@gmx.net>
Subject: easy way to make tracking branches?
Date: Sun, 18 Jan 2009 11:55:30 +0100
Message-ID: <20090118105530.GG11992@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 18 11:57:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOVKz-0000Qx-R4
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 11:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763772AbZARKzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 05:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763485AbZARKzm
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 05:55:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:37150 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762002AbZARKzm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 05:55:42 -0500
Received: (qmail invoked by alias); 18 Jan 2009 10:55:39 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp037) with SMTP; 18 Jan 2009 11:55:39 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+vstpnxkavxjPQb3ghEymveXl7PuYe8vimXyJ9mh
	D/AhbAt6kbcN5r
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LOVJS-0004GN-NR
	for git@vger.kernel.org; Sun, 18 Jan 2009 11:55:30 +0100
Content-Disposition: inline
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106170>

Hi,

assume I have a branch "foo" in my local repo, a remote "srv", and
a branch "bar" on srv (i.e. generated with "git push srv foo:bar").

Now I want to make "foo" a tracking branch for "bar".
I do:

	git config branch.foo.remote srv
	git config branch.foo.merge refs/heads/bar

And to get a comfortable git-push, I do:

	git config --add remote.srv.push foo:bar


Because I do not always remember the sequence, I have to look it
up or I just do

	git checkout -b foo2 srv/bar
	git branch -d foo
	git branch -m foo

which is suboptimal because deleting foo can remove some
other settings for the branch, e.g. mergeoptions.


So I wonder if there is some easier-to-remind way to let my branch
foo track my remote branch bar, or, if not, could it be useful to
have something like

	git push --make-tracking srv foo:bar
	# push foo -> bar and let foo track bar...
	# if foo already tracks bar, ignore the option

or should I just write a tiny script for me and shut up? :-)


Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
