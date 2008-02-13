From: Jeff King <peff@peff.net>
Subject: Re: [Bug] git add -i fails in multiple ways prior to first commit.
Date: Wed, 13 Feb 2008 06:34:18 -0500
Message-ID: <20080213113418.GA2736@coredump.intra.peff.net>
References: <C50196C5-B0C5-4536-AD4A-0F9C553782EE@gmail.com> <20080213101649.GA18444@coredump.intra.peff.net> <7v63wtqejf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Rhodes, Kate" <masukomi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 12:35:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPFt9-0002s0-OM
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 12:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757122AbYBMLeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 06:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756940AbYBMLeV
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 06:34:21 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4001 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756109AbYBMLeU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 06:34:20 -0500
Received: (qmail 14270 invoked by uid 111); 13 Feb 2008 11:34:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 13 Feb 2008 06:34:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2008 06:34:18 -0500
Content-Disposition: inline
In-Reply-To: <7v63wtqejf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73778>

On Wed, Feb 13, 2008 at 03:30:44AM -0800, Junio C Hamano wrote:

> > However, I wonder if this is the best approach. It would be nice if
> > there were a shorthand for "the empty tree" for diffing, so you could
> > just diff against that rather than HEAD, and have the regular plumbing
> > generate.
> 
> I guess you can set your worktree to an empty directory and run
> diff-files backwards, like perhaps:
> 
> 	mkdir /var/tmp/empty
>         (cd .git && GIT_WORK_TREE=/var/tmp/empty git diff -R)
> 
> Have I tried it?  No --- I am not sick enough to be motivated.

Actually, I thought of that already. It does work, though when I tried
it, I failed to 'cd .git' which broke it. But yes, I think it is a
nastier solution than just using the "virtual" empty tree.

-Peff
