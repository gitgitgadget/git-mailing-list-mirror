From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v5 3/4] git-cherry-pick: Add test to validate new options
Date: Wed, 18 Apr 2012 06:48:59 -0400
Message-ID: <20120418104859.GB22172@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-4-git-send-email-nhorman@tuxdriver.com>
 <20120415093933.GB6263@ecki>
 <20120416161431.GD13366@hmsreliant.think-freely.org>
 <7vvckzws73.fsf@alter.siamese.dyndns.org>
 <20120416165024.GF13366@hmsreliant.think-freely.org>
 <20120416214247.GA5606@ecki>
 <20120417105604.GB11462@hmsreliant.think-freely.org>
 <20120417213851.GA20082@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Apr 18 12:49:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKSRo-0002ae-V2
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 12:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab2DRKtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 06:49:10 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:34982 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416Ab2DRKtH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 06:49:07 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SKSRY-0004Uk-B0; Wed, 18 Apr 2012 06:49:03 -0400
Content-Disposition: inline
In-Reply-To: <20120417213851.GA20082@ecki>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195852>

On Tue, Apr 17, 2012 at 11:38:52PM +0200, Clemens Buchacher wrote:
> On Tue, Apr 17, 2012 at 06:56:04AM -0400, Neil Horman wrote:
> > On Mon, Apr 16, 2012 at 11:42:49PM +0200, Clemens Buchacher wrote:
> > > 
> > > It seems that I was implying a lot more than I realized. What I meant
> > > was that master and empty-branch2 are equivalent for the purposes of
> > > that test (empty-branch2^ also is a non-empty commit [*1*]), but while
> > > master is a moving target, empty-branch2 is untouched. 
> > > 
> > for the purposes of the --keep-redundant-commits however, the target is
> > irrelevant.  The only requirement is that we cherry-pick a commit that is
> > guaranteed to become empty when applied.
> 
> That we agree on.
> 
> > We certainly could do that on empty branch2, but theres no advantage
> > to doing so,
> 
> The advantage is that I do not have to read the other tests in order to
> understand what this test does, because contrary to the master branch,
> they do not modify empty-branch2.
> 
But empty-branch2, as the name implies, doesn't have a non-empty commit on it
yet, and so theres nothing to cherry-pick on that branch that would 'become'
empty.  We could fix that of course, but I'd worry that that would look odd
against the other tests.

> > and given that every other test attempts to cherry-pick to master, I
> > rather like the consistency.
> 
> We could also consistently not use the master branch.
> 
Yes, This would be my perferred solution I think.  That way we clarify the test
to your satisfaction and keep the consistency of the test methodology.

> > > However, I just notice that empty-branch2 is also the root commit, so
> > > maybe this will not work after all. But that should be easy to fix.
> >
> > It is easy to fix, given your clarified description above, its just that IMO,
> > its not broken.
> 
> Well, I don't mind too badly if this doesn't go may way. But I hope that
> I managed at least to explain my point.
> 
Yes, absolutely.  How about this:  Given that we agree on our ability to
consistently not use master above, what if we table this discussion for now,
leave the tests as they are, and fix them all up in a separate patch set?  I
don't mind making the change your requesting at all, but I'd rather do it as
part of modifying all the tests not to use master, and doing it in a separate
changeset, so we don't convolute what this series is doing.  Does that sound
reasonable?
Neil
