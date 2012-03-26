From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: odd behavior with git-rebase
Date: Mon, 26 Mar 2012 16:04:18 -0400
Message-ID: <20120326200418.GC12843@hmsreliant.think-freely.org>
References: <20120323185205.GA11916@hmsreliant.think-freely.org>
 <7vvclvrrad.fsf@alter.siamese.dyndns.org>
 <20120324165536.GA17932@neilslaptop.think-freely.org>
 <7v1uofqoa7.fsf@alter.siamese.dyndns.org>
 <CABURp0oJwM-KtdBRVHgvOaqFVjA-MEAfJoJH=52Y=QRcgFL+3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 22:04:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCG9b-0007E5-6o
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 22:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725Ab2CZUEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 16:04:30 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:39378 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab2CZUE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 16:04:29 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SCG9M-0002xa-4L; Mon, 26 Mar 2012 16:04:22 -0400
Content-Disposition: inline
In-Reply-To: <CABURp0oJwM-KtdBRVHgvOaqFVjA-MEAfJoJH=52Y=QRcgFL+3Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193970>

On Mon, Mar 26, 2012 at 02:29:24PM -0400, Phil Hord wrote:
> On Mon, Mar 26, 2012 at 1:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Neil Horman <nhorman@tuxdriver.com> writes:
> >
> >> Is there a way to differentiate a commit that is made empty as the result of a
> >> previous patch in the rebase, and a commit that is simply empty?
> >
> > An empty commit has the same tree object as its parent commit.
> >
> >> I agree, I think perhaps adding an --allow-empty option to the rebase logic, so
> >> that empty commits (or perhaps just initially empty, as opposed to commits made
> >> empty) would be very beneficial.
> >
> > Yeah, that probably may make sense.
> 
> 
> Can we have three behaviors?
> 
> A: Current mode, stop and error on empty commits
> B: --keep-empty, to retain empty commits without further notice
> C: --purge-empty, to remove empty commits without further notice
> 
Yeah, I've got most of --keep-empty in a private branch here now.  I was calling
it allow-empty, but given (C) above, I like --keep-empty better.

I'll add --purge-empty to me todo list. and augment the rebase code to pass
these options along.

One more question - The options for cherry-pick are currently mostly merged with
git revert.  Are there any opinions on the applicability of
--keep-empty/--purge-empty to reverts?  

Regards
Neil
