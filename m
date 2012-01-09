From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] rebase --fix: interactive fixup mode
Date: Mon, 9 Jan 2012 21:33:58 +0100
Message-ID: <20120109203357.GC25269@ecki>
References: <20120108213134.GA18671@ecki.lan>
 <7vfwfpg5st.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 21:42:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkM2w-0006q0-ND
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 21:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933256Ab2AIUmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 15:42:18 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:34909 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933151Ab2AIUmR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 15:42:17 -0500
Received: from localhost (p5B22D760.dip.t-dialin.net [91.34.215.96])
	by bsmtp.bon.at (Postfix) with ESMTP id 217EDA7EB8;
	Mon,  9 Jan 2012 21:42:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vfwfpg5st.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188188>

On Sun, Jan 08, 2012 at 02:58:42PM -0800, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> >
> > In order to determine a suitable range automatically, it is a reasonable
> > heuristic to rebase onto the most recent merge commit.
> 
> I understand the problem you are trying to solve, but I am not sure if
> this is a good idea from the UI point of view for two reasons.
> 
>  - "We want to limit the extent of the operation to commits since the last
>    merge" is by itself a reasonable thing to ask, and I do not think it
>    should be limited to "rebase". If we had an extended SHA-1 syntax to
>    express it, for example, you may want to say "I want to see what I did
>    since the last merge" and run "git log $last_merge_before_HEAD..".
>    Perhaps HEAD~{merge} or something?

Ok, sounds reasonable.

I am not sure what to do if the history has no merges, though.  If it's
just rev-parse HEAD~{merge} I suppose I could return nothing, or an
error. But what about the HEAD~{merge}..HEAD range? I think it would be
useful if that were not an error but the entire history.

>  - If your "rebase --fix" is to "fix" things, what is "rebase -i" about?

I would have suggested this to be the default behavior for rebase -i
without an <upstream> argument, but unfortunately we already handle this
case using @{upstream}.
