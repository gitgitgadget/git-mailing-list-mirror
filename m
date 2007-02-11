From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Allow aliases to expand to shell commands
Date: Sun, 11 Feb 2007 11:21:36 -0500
Message-ID: <20070211162136.GA26461@thunk.org>
References: <20070209014852.GA13207@thunk.org> <1171123504783-git-send-email-tytso@mit.edu> <11711235041527-git-send-email-tytso@mit.edu> <11711235042388-git-send-email-tytso@mit.edu> <20070210181357.GE25607@thunk.org> <Pine.LNX.4.63.0702102129110.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070211001346.GA19656@thunk.org> <Pine.LNX.4.63.0702111701160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 11 17:21:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGHSY-0003Nq-9I
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 17:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbXBKQVr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 11:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbXBKQVr
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 11:21:47 -0500
Received: from thunk.org ([69.25.196.29]:59338 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720AbXBKQVq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 11:21:46 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HGHXX-0006gt-4I; Sun, 11 Feb 2007 11:26:59 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HGHSK-0007Oj-Qi; Sun, 11 Feb 2007 11:21:36 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702111701160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39288>

On Sun, Feb 11, 2007 at 05:03:29PM +0100, Johannes Schindelin wrote:
> > ... and git-shell only allows git-receive-pack and git-upload-pack to be 
> > called, with a single argument, and aliases aren't allowed to override 
> > commands.  So we're safe here, I think.
> 
> Yes, sorry. I have a modified git-shell, which allows the git wrapper, 
> too, to allow setting the config. I'll just fix it here.

If all you've enabled is the ability to set the config, I think we're
still safe, since aliases can't override commands.  

Still there are enough config options that might be scary, either now
(the http.ssl* options) or in the future (someone might think that it
makes sense to set the post-commit, post-push, et. al hooks in the
config), that I wouldn't be particularly comfortable letting git-shell
have unrestricted access to set the config without having some
restriction about which config parameters were allowed to be set from
the restricted shell.  Why did you add that ability, out of curiosity?

						- Ted
