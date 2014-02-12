From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH 00/11] More preparatory work for multiparent tree-walker
Date: Wed, 12 Feb 2014 13:30:57 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20140212093057.GA3408@tugrik.mns.mnsspb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
 <xmqqeh3aqyq6.fsf@gitster.dls.corp.google.com>
 <20140211081716.GA4455@tugrik.mns.mnsspb.ru>
 <xmqq61olpgjd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 10:29:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDW89-0000S8-Mw
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 10:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbaBLJ3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 04:29:16 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:35828 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbaBLJ3O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 04:29:14 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WDW7w-0006WT-Qh; Wed, 12 Feb 2014 13:29:08 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WDW9h-0001AO-IV; Wed, 12 Feb 2014 13:30:57 +0400
Content-Disposition: inline
In-Reply-To: <xmqq61olpgjd.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241977>

On Tue, Feb 11, 2014 at 11:59:02AM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@mns.spb.ru> writes:
> 
> > Sorry for the confusion. Could you please do the following:
> >
> > Patches should be applied over to ks/tree-diff-walk
> > (74aa4a18). Before applying the patches, please cherry-pick
> >
> >     c90483d9    (tree-diff: no need to manually verify that there is no
> >                  mode change for a path)
> >
> >     ef4f0928    (tree-diff: no need to pass match to
> >                  skip_uninteresting())
> >
> > into that branch, and drop them from ks/combine-diff - we'll have one
> > branch reworking the diff tree-walker, and the other taking advantage of
> > it for combine-diff.
> 
> As long as that does not lose changes to tests and clean-ups, I'm
> fine with that direction.  For example, I do not know if you want to
> lose e3f62d12 (diffcore-order: export generic ordering interface,
> 2014-01-20), which is part of the combine-diff topic.

Sorry for the confusion again, and please don't worry: we are not going
to lose anything - my only plea here was to transfer two of the patches
to more appropriate topic.

That couple touches tree-diff.c - they were some initial cleanups I've
noticed while working on separate combine-diff tree-walker, which we
decided to drop instead of generalizing diff tree-walker to handle all
cases. Only the cleanups are still relevant and needed as a base for
what I've sent you here.

And as to e3f62d12 (diffcore-order: export generic ordering interface,
2014-01-20) and other patches on ks/diff-c-with-diff-order topic - they
stay as they are - we do not need to rework them as ks/combine-diff
builds on top of the topic and generalizing diff tree-walker is
orthogonal work.


So in short: could you please transform the two "tree-diff" patches from
ks/combine-diff to ks/tree-diff-walk, then apply sent-here patches to
ks/tree-diff-walk; thats all.


Thanks,
Kirill
