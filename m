From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [RFC] rename detection: allow more renames
Date: Wed, 25 Nov 2015 13:03:15 +0100
Message-ID: <20151125120315.GC11192@inner.h.apk.li>
References: <20151113163506.GD16219@inner.h.apk.li> <20151124233328.GA13872@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 13:03:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1YnK-00065o-IA
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 13:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbbKYMD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 07:03:28 -0500
Received: from continuum.iocl.org ([217.140.74.2]:50881 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbbKYMD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 07:03:28 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id tAPC3FY09629;
	Wed, 25 Nov 2015 13:03:15 +0100
Content-Disposition: inline
In-Reply-To: <20151124233328.GA13872@sigill.intra.peff.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281702>

Hi Jeff,

thanks for the reply!

On Tue, 24 Nov 2015 18:33:28 +0000, Jeff King wrote:
...
> I didn't dig in the archive, but I think we discussed the "just show
> progress for destinations" before. The problem you run into is that the
> items aren't a good indication of the amount of work. You really are
> doing n*m work, so if you just count "m", it can be very misleading if
> "n" is high (and vice versa).

True, but the loops do progress indication for destinations only anyway.
So if you only have three destinations and a zillion sources, you
will still get only three progress updates, even if they say
'one zillion (33%)', 'two zillion (67%)', ...

I think as long as this is the case we can as well report the destination
count; maybe put the source count somewhere in the progress text.

> Might it make more sense just to move to a larger integer size?

Which would be? I'd venture into the progress code to identify
the necessary changes.

> Or
> perhaps to allow a higher limit for each side as long as the product of
> the sides does not overflow?

We're somewhat close to getting there. The rename detection runs
for several minutes in our cases.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
