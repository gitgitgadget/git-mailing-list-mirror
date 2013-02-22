From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix in Git.pm cat_blob crashes on large files
Date: Fri, 22 Feb 2013 10:38:01 -0500
Message-ID: <20130222153801.GA15318@sigill.intra.peff.net>
References: <CAMB+bfKYLjmDavcLaO7scBPfTLmzqAmH+k9uBj0WJ+dzj9vuyA@mail.gmail.com>
 <20130221224319.GA19021@sigill.intra.peff.net>
 <CAMB+bf+whVFD03neCh-gBORXOBoNjgaCbfP_mh8HgDy6UqGFZA@mail.gmail.com>
 <20130221232448.GA23736@sigill.intra.peff.net>
 <CAMB+bf+RyerXP3VP26KJM7wtVKOup15AeRpEewwKJx3=bL9+hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joshua Clayton <stillcompiling@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 16:38:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8uhi-0007Cf-To
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 16:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757383Ab3BVPiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 10:38:07 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57099 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756996Ab3BVPiE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 10:38:04 -0500
Received: (qmail 5356 invoked by uid 107); 22 Feb 2013 15:39:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Feb 2013 10:39:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2013 10:38:01 -0500
Content-Disposition: inline
In-Reply-To: <CAMB+bf+RyerXP3VP26KJM7wtVKOup15AeRpEewwKJx3=bL9+hQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216837>

On Fri, Feb 22, 2013 at 07:11:54AM -0800, Joshua Clayton wrote:

> running git svn fetch on a remote repository (yes I know there are a
> lot of possible outside variables, including network latency)
> Code with 1024 reads and 64k writes:
> 
> real    75m19.906s
> user    16m43.919s
> sys     29m16.326s
> 
> Code with 1024 reads and 1024 writes:
> 
> real    71m21.006s
> user    12m36.275s
> sys     24m26.112s
> 
> ...so the simpler code wins the trivial test.

Interesting; I'd have expected no change or a slight win for your
version, which makes me wonder if the outside variables are dominating.
I wonder what 64K/64K would look like.

> I would say go with it.
> Should I resubmit?

Yes, please.

-Peff
