From: Thomas Quinot <thomas@quinot.org>
Subject: Re: [PATCH v2 1/2] git_connect: set ssh shell command in GIT_SSH_CMD
Date: Sun, 9 Nov 2014 13:39:34 +0100
Message-ID: <20141109123934.GA50956@melamine.cuivre.fr.eu.org>
References: <20141108104439.GA89717@melamine.cuivre.fr.eu.org>
 <20141108110958.GB20750@peff.net>
 <20141108123554.GA90057@melamine.cuivre.fr.eu.org>
 <20141108142753.GA28652@melamine.cuivre.fr.eu.org>
 <20141109095155.GB17369@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 09 13:39:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnRmf-0008B9-FT
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 13:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbaKIMjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 07:39:54 -0500
Received: from houdart.cuivre.fr.eu.org ([81.57.40.110]:49914 "EHLO
	melamine.cuivre.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbaKIMjx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 07:39:53 -0500
Received: by melamine.cuivre.fr.eu.org (Postfix, from userid 1000)
	id DC95435E33; Sun,  9 Nov 2014 13:39:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141109095155.GB17369@peff.net>
X-message-flag: WARNING! Using Outlook can damage your computer.
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Jeff King, 2014-11-09 :

> Thanks, I like this much better. The name GIT_SSH_CMD is not too bad.
> Personally, of the two (GIT_SSH and GIT_SSH_CMD) I would expect the
> "_CMD" form to be the one that does not use the shell.

Right, except of course we're stuck with the compatibility issue in any
case.

> But I do not really have a better suggestion for the name, so perhaps
> it's OK.

Could also be GIT_SSH_SHELLCMD, to denote that this is a *shell*
command...

> Parsing complications aside, you cannot even know in git which ssh is
> going to be run until the shell code is executed. I think either we have
> to leave the responsibility for munging "-p" into "-P" on the side of
> the user's shell snippet

That sounds like a reasonable approach, and leaves us with the simpler
change (that splitting circuitry was admittely a bit awkward...)

Thomas.
