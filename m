From: Jeff King <peff@peff.net>
Subject: Re: [tig] Feeding specific revisions to tig
Date: Wed, 4 Jun 2008 19:08:58 -0400
Message-ID: <20080604230858.GA27136@sigill.intra.peff.net>
References: <ae63f8b50806041152v11a2997y9411c5ea3ebc9598@mail.gmail.com> <20080604192916.GB17327@sigill.intra.peff.net> <ae63f8b50806041304i20de789ej492681f4b9306934@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jean-Baptiste Quenot <jbq@caraldi.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 01:10:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K427G-00057D-D5
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 01:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188AbYFDXJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 19:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755421AbYFDXJE
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 19:09:04 -0400
Received: from peff.net ([208.65.91.99]:3190 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754505AbYFDXJD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 19:09:03 -0400
Received: (qmail 6498 invoked by uid 111); 4 Jun 2008 23:09:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 04 Jun 2008 19:09:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jun 2008 19:08:58 -0400
Content-Disposition: inline
In-Reply-To: <ae63f8b50806041304i20de789ej492681f4b9306934@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83836>

On Wed, Jun 04, 2008 at 10:04:45PM +0200, Jean-Baptiste Quenot wrote:

> Thanks for the suggestion.  However, my list of commits is too long,
> the shell errors out with "tig: command too long".  I'd like to feed
> tig with a list of commits from stdin, or from a file.
> 
> Something like: ... | tig --no-walk -F -
> 
> Which means: take the list of revisions from specified file, or here -
> for stdin, a la grep.

Ah. Adding "-F" probably wouldn't be that much work, but tig spawns "git
log" internally, so you would probably end up with the same problem
there. Converting tig to use "git rev-list --stdin" would fix that, but
is probably a bit of major surgery.

-Peff
