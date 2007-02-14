From: Jeff King <peff@peff.net>
Subject: Re: Stupid question on getting branch from yesterday
Date: Wed, 14 Feb 2007 15:36:26 -0500
Message-ID: <20070214203626.GB14729@coredump.intra.peff.net>
References: <17875.25882.784307.731860@lisa.zopyra.com> <20070214194919.GE28290@spearce.org> <17875.28901.705687.843342@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 21:36:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHQro-0007oz-K1
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 21:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbXBNUga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 15:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbXBNUga
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 15:36:30 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1368 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932572AbXBNUg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 15:36:29 -0500
Received: (qmail 18933 invoked from network); 14 Feb 2007 15:36:34 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 14 Feb 2007 15:36:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Feb 2007 15:36:26 -0500
Content-Disposition: inline
In-Reply-To: <17875.28901.705687.843342@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39741>

On Wed, Feb 14, 2007 at 02:28:21PM -0600, Bill Lear wrote:

> >Use `git checkout <SHA>` which will detach your HEAD and seek to
> >the commit, leaving your current commit alone.  Later you can get
> >back by `git checkout oldbranch`.
> 
> BTW, we are still using 1.4.4.1.  This will work with that?

No. Detached HEAD is a 1.5 thing.

> Another BTW: this seems very similar to something that you would
> tackle with git bisect (haven't used that yet), but as I understand
> it, git bisect works on tags(??).

It can work on arbitrary commits. You can either pick the commit out of
git-log or gitk manually, or you can use your reflog:

  git bisect start
  git bisect good master@{2.days.ago}
  git bisect bad

-Peff
