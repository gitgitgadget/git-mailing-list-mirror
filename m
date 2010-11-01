From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: gittogether session notes
Date: Mon, 1 Nov 2010 13:32:41 -0700
Message-ID: <20101101203241.GB22725@spearce.org>
References: <20101029180530.GA18997@sigill.intra.peff.net> <m3ocachkcy.fsf@localhost.localdomain> <20101101202643.GA6119@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Brad Larson <bklarson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 21:32:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PD13i-0002xV-Sx
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 21:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701Ab0KAUcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 16:32:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49587 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463Ab0KAUcp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 16:32:45 -0400
Received: by iwn10 with SMTP id 10so7424170iwn.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 13:32:44 -0700 (PDT)
Received: by 10.231.152.143 with SMTP id g15mr957259ibw.76.1288643564733;
        Mon, 01 Nov 2010 13:32:44 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.74.25])
        by mx.google.com with ESMTPS id w9sm8863711ibc.19.2010.11.01.13.32.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Nov 2010 13:32:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101101202643.GA6119@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160495>

Jeff King <peff@peff.net> wrote:
> On Fri, Oct 29, 2010 at 12:26:15PM -0700, Jakub Narebski wrote:
> 
> > Below there are proposed talks which either weren't presented, or lack
> > notes / slides.
> > * Hudson and Gerrit integration
> 
> Brad Larson talked about Hudson, and had slides. I don't seem to have an
> email address for him, though.
 
Brad, can you post your Hudson slides on the wiki?

> > * What's new on github: pull requests, git based wiki etc.

Tom talked about this, but there weren't any slides.  He just
presented the web site and described what he was showing.

> > * Git and Big Files

John Hawley and I talked about this a bit, it probably makes sense
to take Avery's bup work and start to formalize it within core Git.
But yea, we didn't ever get around to debating the merits of a new
"sequence" object type vs. defining a new variant of the current
tree mode and reusing the current tree walking support to link in
the segments of the huge file.

I think it really depends on what older versions of Git will
do.  If older Git versions would accept a different tree mode
(e.g. '040001') and treat them as normal trees, we could at least
use older Git servers for push/pull/fsck/gc without breaking the
repository.  But doing a checkout would produce a directory of
segments, and updating a segment would break the directory mode.
But I suspect older gits will choke on that tree mode.

> > * git log -L demo, combination of log and blame
> 
> Thomas did this, but it was mostly just showing off "-L".
 
And this is pretty cool too.  I was pretty impressed by the flag.

> > * RefInsteadOf (discussion)

RefInsteadOf turned out to be a non-discussion.  I asked the SEMC
guys what they wanted... and it turns out its already handled
somewhere else and they didn't realize it.  They just needed to
use the fetch refspec in .git/config correctly.  :-)

> > * git-always-on

This was the Qualcomm guys presenting how they use DRBD to keep
git in sync on multiple machines and implement quick fail-over when
there is a problem with the primary.

-- 
Shawn.
