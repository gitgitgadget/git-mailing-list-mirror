From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] perl/Git.pm: Honor SSH_ASKPASS as fallback if
 GIT_ASKPASS is not set
Date: Mon, 17 Dec 2012 19:57:25 -0500
Message-ID: <20121218005725.GA4125@sigill.intra.peff.net>
References: <4F00B7F3.1060105@tu-clausthal.de>
 <4F038E49.9080809@tu-clausthal.de>
 <7vy5toqqab.fsf@alter.siamese.dyndns.org>
 <7vmwzzqwud.fsf@alter.siamese.dyndns.org>
 <509FD4F6.5050606@gym-oha.de>
 <50B11AF5.2090701@tu-clausthal.de>
 <7vtxsdvug3.fsf@alter.siamese.dyndns.org>
 <50CF4020.4090901@tu-clausthal.de>
 <7vehiol9w2.fsf@alter.siamese.dyndns.org>
 <50CFB8BF.4000405@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 01:59:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TklXJ-00085T-8F
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 01:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab2LRA52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 19:57:28 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57189 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416Ab2LRA51 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 19:57:27 -0500
Received: (qmail 12594 invoked by uid 107); 18 Dec 2012 00:58:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Dec 2012 19:58:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2012 19:57:25 -0500
Content-Disposition: inline
In-Reply-To: <50CFB8BF.4000405@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211724>

On Tue, Dec 18, 2012 at 01:28:47AM +0100, Sven Strickroth wrote:

> If GIT_ASKPASS environment variable is not set, git-svn does not try to use
> SSH_ASKPASS as git-core does. This change adds a fallback to SSH_ASKPASS.
> 
> Signed-off-by: Sven Strickroth <email@cs-ware.de>
> ---

Thanks, this series looks fine to me.

I skimmed through the original thread. It looks like we got bogged down
in discussion of whether GIT_ASKPASS should fall back on error, and
whether SSH_ASKPASS should come _after_ the terminal has been tried and
failed. This version of the series brings the behavior of git-svn in
line with the rest of git, which I think is a good first step.

I don't know whether we want to take a second step and tweak the order
in both perl and C code. Since nobody has mentioned it in the interim
months, I'm assuming it's not a big deal, and people are happy enough
with the current ordering. So unless somebody feels strongly about it,
it's not worth bothering.

-Peff
