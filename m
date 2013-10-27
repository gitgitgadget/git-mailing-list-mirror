From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [Ksummit-2013-discuss] [PATCH] commit: Add -f, --fixes <commit>
 option to add Fixes: line
Date: Sun, 27 Oct 2013 09:23:13 +0000
Message-ID: <20131027092313.GC13149@leaf>
References: <20131024122255.GI9378@mwanda>
 <20131024122512.GB9534@mwanda>
 <20131026181709.GB10488@kroah.com>
 <20131027013402.GA7146@leaf>
 <526CA7D4.1070904@alum.mit.edu>
 <20131027071407.GA11683@leaf>
 <CANN689HctBYZfU+OQ7movFFWNm6rwUdU7G-ExxhPcBPg1KF8Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	LKML <linux-kernel@vger.kernel.org>,
	ksummit-attendees@lists.linuxfoundation.org,
	Git Mailing List <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>
To: Michel Lespinasse <walken@google.com>
X-From: linux-kernel-owner@vger.kernel.org Sun Oct 27 10:23:28 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VaMZD-0002Dw-P8
	for glk-linux-kernel-3@plane.gmane.org; Sun, 27 Oct 2013 10:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab3J0JXV (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 27 Oct 2013 05:23:21 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40358 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab3J0JXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Oct 2013 05:23:19 -0400
Received: from mfilter23-d.gandi.net (mfilter23-d.gandi.net [217.70.178.151])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id CB6C9A80B5;
	Sun, 27 Oct 2013 10:23:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter23-d.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter23-d.gandi.net (mfilter23-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 1Y2Nc4iUro8m; Sun, 27 Oct 2013 10:23:15 +0100 (CET)
X-Originating-IP: 77.221.165.98
Received: from leaf (ip-77-221-165-98.dsl.twang.net [77.221.165.98])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 6ACF7A80B1;
	Sun, 27 Oct 2013 10:23:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANN689HctBYZfU+OQ7movFFWNm6rwUdU7G-ExxhPcBPg1KF8Jw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236796>

On Sun, Oct 27, 2013 at 01:03:47AM -0700, Michel Lespinasse wrote:
> On Sun, Oct 27, 2013 at 12:14 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> >> > +-f <commit>::
> >> > +--fixes=<commit>::
> >> > +   Add Fixes line for the specified commit at the end of the commit
> >> > +   log message.  This line includes an abbreviated commit hash for
> >> > +   the specified commit; the `core.abbrev` option determines the
> >> > +   length of the abbreviated commit hash used, with a minimum length
> >> > +   of 12 hex digits.
> >>
> >> You might also mention that the "Fixes:" line includes the old commit's
> >> subject line.
> >
> > I only mentioned the abbreviated commit hash because it was necessary to
> > explain the factors affecting hash length.  -s, above, doesn't mention
> > that the Signed-off-by line includes the name and email address of the
> > committer.
> 
> I do wonder, if we're going to bake into git the idea that too-short
> abbreviated sha1s don't make sense, why don't we just change the
> core.abbrev default to 12 everywhere rather than just in this one
> command ?

You won't get any argument from me on that one.  I personally would have
argued for making the hashes 40 characters always, but in any case
bumping up the default (and minimum) for core.abbrev seems entirely
sensible.

- Josh Triplett
