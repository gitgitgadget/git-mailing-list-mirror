From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jul 2011, #01; Wed, 6)
Date: Wed, 13 Jul 2011 19:39:19 -0400
Message-ID: <20110713233919.GA18273@sigill.intra.peff.net>
References: <7vpqlmhoi0.fsf@alter.siamese.dyndns.org>
 <7vd3hd6d9o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 01:39:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh91a-0000MP-Tf
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 01:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937Ab1GMXjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 19:39:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43329
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777Ab1GMXjW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 19:39:22 -0400
Received: (qmail 31499 invoked by uid 107); 13 Jul 2011 23:39:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 19:39:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 19:39:19 -0400
Content-Disposition: inline
In-Reply-To: <7vd3hd6d9o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177093>

On Wed, Jul 13, 2011 at 03:12:35PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > * jk/clone-detached (2011-06-07) 4 commits
> >  - clone: always fetch remote HEAD
> >  - make copy_ref globally available
> >  - consider only branches in guess_remote_head
> >  - t: add tests for cloning remotes with detached HEAD
> >
> > Somewhat involved bugfix.
> > Will merge to "next".
> 
> What is it in this series that causes t5800 to fail when merged to next, i.e.
> 
> $ sh t5800-remote-helpers.sh -i -v
> 
> expecting success: 
>         git clone "testgit::${PWD}/server" localclone &&
>         test_cmp public/file localclone/file
> 
> Cloning into localclone...
> fatal: Got feature command 'relative-marks' after data command

Isn't this the same breakage I reported in the initial series:

  http://article.gmane.org/gmane.comp.version-control.git/174999

The discussion of which led to my remote helper fixes here:

  http://article.gmane.org/gmane.comp.version-control.git/175217

But then the latter series got picked up and merged into Sverre's
sr/transport-helper-fix branch.  I'm not sure what the current status of
that series is.

-Peff
