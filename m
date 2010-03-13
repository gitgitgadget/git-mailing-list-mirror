From: Jeff King <peff@peff.net>
Subject: Re: FEATURE REQUEST: sendemail.aliasesfile support enavironment
 variables and tilde
Date: Sat, 13 Mar 2010 02:40:31 -0500
Message-ID: <20100313074031.GA5467@sigill.intra.peff.net>
References: <87zl2dtl5g.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Mar 13 08:40:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqLxp-0006Z7-Ib
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 08:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758887Ab0CMHkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 02:40:36 -0500
Received: from peff.net ([208.65.91.99]:35150 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758877Ab0CMHkf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 02:40:35 -0500
Received: (qmail 27091 invoked by uid 107); 13 Mar 2010 07:40:58 -0000
Received: from cpe-066-057-045-211.nc.res.rr.com (HELO sigill.intra.peff.net) (66.57.45.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 13 Mar 2010 02:40:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Mar 2010 02:40:31 -0500
Content-Disposition: inline
In-Reply-To: <87zl2dtl5g.fsf@jondo.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142089>

On Fri, Mar 12, 2010 at 09:06:19PM +0200, Jari Aalto wrote:

> It apperas that this is not possible with 1.7.0:
> 
>     # ~/.gitconfig
>     [sendemail]
>             aliasesfile = $HOME/.mailrc
> 
> => opening $HOME/.mailrc: No such file or directory
> ls -la $HOME/.mailrc
> lrwxrwxrwx 1 root root 35 2008-05-31 11:08 /home/foo/.mailrc -> vc/git/shell-account-common/.mailrc
> 
> Neither seems to be "~/.mailrc" accpeted. Please add support for at
> least tilde(~).

If you (or anyone) are interested in writing the patch, it is as simple
as adding "--path" to the "git config" call for sendemail.aliasesfile.
Which unfortunately is not that simple, due to the way that sendemail
handles its config values, but the refactoring should not be too hard.

-Peff
