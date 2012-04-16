From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v5 3/4] git-cherry-pick: Add test to validate new options
Date: Mon, 16 Apr 2012 07:04:02 -0400
Message-ID: <20120416110402.GB13366@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-4-git-send-email-nhorman@tuxdriver.com>
 <20120415093933.GB6263@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Apr 16 13:04:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJjjE-0004Pd-M8
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 13:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174Ab2DPLEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 07:04:12 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:60732 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037Ab2DPLEL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 07:04:11 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SJjj1-0007M3-KH; Mon, 16 Apr 2012 07:04:05 -0400
Content-Disposition: inline
In-Reply-To: <20120415093933.GB6263@ecki>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195620>

On Sun, Apr 15, 2012 at 11:39:35AM +0200, Clemens Buchacher wrote:
> On Fri, Apr 13, 2012 at 02:45:06PM -0400, Neil Horman wrote:
> >  
> > +test_expect_success 'cherry pick an empty non-ff commit without --allow-empty' '
> > +	git checkout master &&
> > +	echo fourth >> file2 &&
> > +	git add file2 &&
> > +	git commit -m "fourth" && {
> > +		test_must_fail git cherry-pick empty-branch2
> > +	}
> > +'
> 
> You don't need the braces. The same below.
> 
> > +
> > +test_expect_success 'cherry pick an empty non-ff commit with --allow-empty' '
> > +	git checkout master && {
> > +		git cherry-pick --allow-empty empty-branch2
> > +	}
> > +'
> > +
> > +test_expect_success 'cherry pick with --keep-redundant-commits' '
> > +	git checkout master && {
> > +		git cherry-pick --keep-redundant-commits HEAD^
> > +	}
> > +'
> 
> And the expected result is that the HEAD commit is not removed, right?
> You should check for that as well.
> 
> Also, please checkout empty-branch2^0 first, in order to make the test
> independent of its predecessor.
> 

ACK, I'll fix these up, thanks
Neil
