From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v5 3/4] git-cherry-pick: Add test to validate new options
Date: Mon, 16 Apr 2012 12:50:24 -0400
Message-ID: <20120416165024.GF13366@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-4-git-send-email-nhorman@tuxdriver.com>
 <20120415093933.GB6263@ecki>
 <20120416161431.GD13366@hmsreliant.think-freely.org>
 <7vvckzws73.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:50:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJp8S-0001sw-Ef
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 18:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650Ab2DPQuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 12:50:32 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:37165 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab2DPQub (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 12:50:31 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SJp8D-00012I-NG; Mon, 16 Apr 2012 12:50:27 -0400
Content-Disposition: inline
In-Reply-To: <7vvckzws73.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195664>

On Mon, Apr 16, 2012 at 09:35:12AM -0700, Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > On Sun, Apr 15, 2012 at 11:39:35AM +0200, Clemens Buchacher wrote:
> > ...
> >> > +test_expect_success 'cherry pick an empty non-ff commit with --allow-empty' '
> >> > +	git checkout master && {
> >> > +		git cherry-pick --allow-empty empty-branch2
> >> > +	}
> >> > +'
> >> > +
> >> > +test_expect_success 'cherry pick with --keep-redundant-commits' '
> >> > +	git checkout master && {
> >> > +		git cherry-pick --keep-redundant-commits HEAD^
> >> > +	}
> >> > +'
> >> 
> >> And the expected result is that the HEAD commit is not removed, right?
> >> You should check for that as well.
> >> 
> >> Also, please checkout empty-branch2^0 first, in order to make the test
> >> independent of its predecessor.
> >
> > Not sure I follow what your saying here.  The expected result with both of these
> > tests is that a new commit is created, referencing the current HEAD as the new
> > HEAD's parent.
> 
> If the request were "checkout master^0 first" I would understand.  The
> precondition for the second test will be different depending on the first
> one succeeds or not.  Perhaps that is what Clemens meant?
> 
Perhaps, but if so, I'm still not sure how a checkout of empty-branch2^0 affects
these tests at all, nor do I grok the relevance to ensuring that the HEAD commit
wasn't removed (as AIUI, cherry pick never does that anyway).  Clement, can you
clarify your thoughts here please?
Neil
