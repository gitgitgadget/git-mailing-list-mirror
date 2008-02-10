From: Jeff King <peff@peff.net>
Subject: Re: Minor annoyance with git push
Date: Sun, 10 Feb 2008 17:34:40 -0500
Message-ID: <20080210223440.GA15051@sigill.intra.peff.net>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de> <alpine.LSU.1.00.0802091307160.11591@racer.site> <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802100213330.11591@racer.site> <0DE4061C-7189-4932-AA3D-D09009F753F2@wincent.com> <alpine.LSU.1.00.0802101625200.11591@racer.site> <07136779-23EB-4DAA-84C3-D54B7AC029AB@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:35:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOKlb-0003o7-9I
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 23:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbYBJWep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 17:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbYBJWeo
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 17:34:44 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2435 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437AbYBJWeo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 17:34:44 -0500
Received: (qmail 1309 invoked by uid 111); 10 Feb 2008 22:34:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 10 Feb 2008 17:34:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Feb 2008 17:34:40 -0500
Content-Disposition: inline
In-Reply-To: <07136779-23EB-4DAA-84C3-D54B7AC029AB@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73429>

On Sun, Feb 10, 2008 at 07:18:24PM +0100, Wincent Colaiuta wrote:

> I'm all for protecting the user from nasty surprises (like "git clean"; 
> "clean" doesn't sound nearly as destructive as it can actually turn out to 
> be) but I don't think that anyone typing "git push" can fairly claim to be 
> surprised when Git goes ahead and, er, pushes something.

I don't think people are surprised that "git push" pushes something. I
think they are surprised that "git push" makes changes based on non-HEAD
branches (which may or may not be in a useful state). Are there any
other git commands which use non-HEAD branches that have not been
explicitly mentioned by the user?  I can think only of query-type
commands (like show-branch, or describe) that are non-state-changing.

I think what is problematic here is that push makes changes based on
state that is irrelevant to most git actions. Thus you have things like
Martin's complaint: "what, why are you rejecting branch foo? I haven't
even worked on that in months." He is expected to either remember the
state of all branches in his repository, or to keep it extremely tidy
(either deleting branches immediately after use, or keeping them up to
date with upstream, which is extra useless work from his perspective).

-Peff
