From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC] What to you think about a loose status for submodules?
Date: Wed, 21 Oct 2009 18:01:23 +0200
Message-ID: <20091021160122.GA2067@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <jens.lehmann@web.de>, Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 18:01:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0dcw-00082z-SF
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 18:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbZJUQBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 12:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754154AbZJUQBU
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 12:01:20 -0400
Received: from darksea.de ([83.133.111.250]:44135 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753876AbZJUQBU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 12:01:20 -0400
Received: (qmail 22299 invoked from network); 21 Oct 2009 18:01:23 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 21 Oct 2009 18:01:23 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130928>

Hi,

for some time now I have been thinking about submodules which are
not checked out by default. So for example if you have a project which
consist of the submodules:

project/core
       /help
       /app
...

Consider the situation that 'help' is really big because it is a user
friendly application ;)

So you usually do not need the help folder to develop the application
but it still is tied to a certain revision.

For such a workflow I would like to implement what I call 'loose'
submodules. Where a

  git clone project.git
  cd project
  git submodule init && git submodule update

would omit the 'help' folder. But in case I specify it directly like

  git submodule init help

it would update to the recorded revision.

Of course the relation would be configurable. E.g.:

  git config submodule."name".relation loose

and the opposite as

  git config submodule."name".relation tight

Initially the implementation would only deal with the initialization
case. As a second step I would like to deal with the situation whether a
submodule should be shown as changed or not. What do you think about such
an extension?

cheers Heiko
