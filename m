From: Jeff King <peff@peff.net>
Subject: Re: setting merge conflict style
Date: Wed, 15 Feb 2012 00:00:03 -0500
Message-ID: <20120215050002.GA29902@sigill.intra.peff.net>
References: <CAJ6vYjcefsPUfibnySpwFk2bGTC1mpBWF6Tjv5AgyyZcn0-d3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chris Leong <walkraft@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 06:00:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxWyR-0004WK-1I
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 06:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915Ab2BOFAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 00:00:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36196
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712Ab2BOFAF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 00:00:05 -0500
Received: (qmail 16306 invoked by uid 107); 15 Feb 2012 05:07:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Feb 2012 00:07:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2012 00:00:03 -0500
Content-Disposition: inline
In-Reply-To: <CAJ6vYjcefsPUfibnySpwFk2bGTC1mpBWF6Tjv5AgyyZcn0-d3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190810>

On Wed, Feb 15, 2012 at 02:12:57PM +1100, Chris Leong wrote:

> Apparently setting merge.conflictstyle to diff3 will display the base
> when diffing an incomplete merge, instead of just ours and theirs.

Yep.

> Is there a way to run this command without setting the config, so that
> I can switch between normal diffs and diff3s easily?

If a conflict is marked in the index (i.e., the state you are in after a
conflicted merge, but before you mark a path as resolved), you can do:

  git checkout --conflict=diff3 <path...>

Note that that is actually checking out the index contents into the
working tree, so any edits you may have made to the conflicted working
tree copy will be overwritten.

-Peff
