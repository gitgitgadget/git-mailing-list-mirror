From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH 00/11] More preparatory work for multiparent tree-walker
Date: Tue, 11 Feb 2014 12:17:16 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20140211081716.GA4455@tugrik.mns.mnsspb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
 <xmqqeh3aqyq6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 11 09:15:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WD8VU-0005LI-1S
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 09:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbaBKIPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 03:15:41 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:57453 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbaBKIPe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 03:15:34 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WD8V6-0005HJ-PK; Tue, 11 Feb 2014 12:15:28 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WD8Wq-0001ny-NR; Tue, 11 Feb 2014 12:17:16 +0400
Content-Disposition: inline
In-Reply-To: <xmqqeh3aqyq6.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241939>

On Mon, Feb 10, 2014 at 04:28:33PM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@mns.spb.ru> writes:
> 
> > Here I'm preparing tree-diff.c to be ready for the new tree-walker, so that the
> > final change is tractable and looks good and non noisy. Some small speedups
> > are gained along the way. The final bits are almost ready, but I don't want to
> > release them in a hurry.
> 
> No worries.  We are not in a hurry to apply non-regression-fix
> changes during a pre-release feature freeze period anyway.

I see.


> This seems to somehow conflict with other topics and does not
> cleanly apply on top of your other tree-diff topic, by the way.

Sorry for the confusion. Could you please do the following:

Patches should be applied over to ks/tree-diff-walk
(74aa4a18). Before applying the patches, please cherry-pick

    c90483d9    (tree-diff: no need to manually verify that there is no
                 mode change for a path)

    ef4f0928    (tree-diff: no need to pass match to
                 skip_uninteresting())

into that branch, and drop them from ks/combine-diff - we'll have one
branch reworking the diff tree-walker, and the other taking advantage of
it for combine-diff.

Then apply sent-here patches, which, as I've verified this time, should
apply cleanly.

Thanks and sorry again,
Kirill
