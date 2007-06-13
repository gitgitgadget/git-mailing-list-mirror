From: Jeff King <peff@peff.net>
Subject: Re: How to stage a tree with all changes?
Date: Wed, 13 Jun 2007 14:40:17 -0400
Message-ID: <20070613184017.GF10941@coredump.intra.peff.net>
References: <861wgf964g.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 20:40:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyXlY-0002Sp-C8
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 20:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759113AbXFMSkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 14:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759127AbXFMSkW
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 14:40:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4063 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759032AbXFMSkV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 14:40:21 -0400
Received: (qmail 14302 invoked from network); 13 Jun 2007 18:40:32 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 13 Jun 2007 18:40:32 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jun 2007 14:40:17 -0400
Content-Disposition: inline
In-Reply-To: <861wgf964g.fsf@lola.quinscape.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50113>

On Wed, Jun 13, 2007 at 06:22:23PM +0200, David Kastrup wrote:

> git-add .
> git-commit -a
> 
> seemingly overlooks deletions.

It shouldn't. Try this:

mkdir repo && cd repo
git init
echo foo >foo
git add .
git commit -m initial
rm foo
echo bar >bar
git add .
git commit -a

'bar' is scheduled for addition, and 'foo' is scheduled for deletion.
Have you perhaps removed a file, but it's still in the working
directory, and so picked up by your git-add? Can you give us a test
case?

> What am I overlooking?  This should be simple, shouldn't it?

Yes, it should. :)

-Peff
