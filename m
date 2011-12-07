From: Jeff King <peff@peff.net>
Subject: Re: Yo dawg, I heard you like trees...
Date: Wed, 7 Dec 2011 17:12:02 -0500
Message-ID: <20111207221202.GB21596@sigill.intra.peff.net>
References: <20111205235740.GB27318@thinkpad>
 <CABURp0rBkGtGfU=od2XeuhD6otUWUfL2ASqo1XBckra18WKy7w@mail.gmail.com>
 <20111207155411.GB2003@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: Sebastian Morr <sebastian@morr.cc>
X-From: git-owner@vger.kernel.org Wed Dec 07 23:12:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYPil-0004Qf-Th
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 23:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758474Ab1LGWMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 17:12:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42908
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852Ab1LGWMF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 17:12:05 -0500
Received: (qmail 20543 invoked by uid 107); 7 Dec 2011 22:18:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Dec 2011 17:18:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Dec 2011 17:12:02 -0500
Content-Disposition: inline
In-Reply-To: <20111207155411.GB2003@thinkpad>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186509>

On Wed, Dec 07, 2011 at 04:54:11PM +0100, Sebastian Morr wrote:

> > Git uses a DAG. The A stands for "acyclic". Loops are not allowed.
> 
> I'm aware of that. It's acyclic by design, but is this actually enforced
> by the code? Or does it simply trust that no loops will ever occur,
> because it's so improbable?

The latter. And not just "improbable", but "so improbable that trying to
do it on purpose should still take billions of years".

Assuming sha1 isn't totally broken, of course.

> After Andrew's response I investigated a bit, and it seems I
> overvalued the attempts to "break" SHA-1. Wikipedia quotes a 2008
> attack, that can create a collision with 2^51 hash function calls.

According to wikipedia, it _may_ produce collisions in 2^51 to 2^57.

Worrisome numbers, certainly, but 2^51 is probably within our ability to
compute if a big project is undertaken. Yet to my knowledge nobody has
actually created such a collision. So the attack is still theoretical at
this point, and there's no good way to create a loop within the git DAG
(or within a tree).

-Peff
