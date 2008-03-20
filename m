From: Jeff King <peff@peff.net>
Subject: Re: Importing all modules in a CVS repo with git-cvsimport
Date: Thu, 20 Mar 2008 11:37:28 -0400
Message-ID: <20080320153728.GA7798@sigill.intra.peff.net>
References: <1205951736.24610.3.camel@pitcairn.cambridgebroadband.com> <20080319204154.GA19556@coredump.intra.peff.net> <1206007130.24610.6.camel@pitcairn.cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 16:38:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcMqJ-0005y0-F9
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 16:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756462AbYCTPhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 11:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbYCTPhb
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 11:37:31 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4669 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038AbYCTPhb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 11:37:31 -0400
Received: (qmail 7235 invoked by uid 111); 20 Mar 2008 15:37:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 20 Mar 2008 11:37:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2008 11:37:28 -0400
Content-Disposition: inline
In-Reply-To: <1206007130.24610.6.camel@pitcairn.cambridgebroadband.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77666>

On Thu, Mar 20, 2008 at 09:58:50AM +0000, Alex Bennee wrote:

> WARNING: file /newcvs/CVSROOT/cvsignore doesn't match strip_path /newcvs/all/. ignoring
> 
> test.cvs is a fresh checkout of the whole tree. "newcvs" is the root of
> CVS on the server. The warnings are the same when I try with "." as the
> module. Or where you saying do this with the actually CVS repo itself?

Hmm. I tested and it worked fine on my system. I'm not sure what you
mean by "the CVS repo itself." I actually linked within the $CVSROOT
hierarchy. If your version of CVS isn't happy with the symlinks for some
reason, you could just munge your cvs hierarchy (assuming you are just
doing a one-shot import):

  cd /newcvs
  mkdir all
  for i in `ls | grep -v all | grep -v CVSROOT`; do
      mv $i all
  done

-Peff
