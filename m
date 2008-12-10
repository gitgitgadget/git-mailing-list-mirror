From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
	file
Date: Wed, 10 Dec 2008 22:11:47 +0100
Message-ID: <20081210211147.GA13624@localhost>
References: <20081210201259.GA12928@localhost> <7vzlj3ycr4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 22:13:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAWMs-0007ZY-Gr
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 22:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbYLJVL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 16:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754894AbYLJVL4
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 16:11:56 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:30333 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373AbYLJVLz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 16:11:55 -0500
Received: from darc.dyndns.org ([84.154.80.98]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 10 Dec 2008 22:11:52 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LAWLT-0003qZ-Bq; Wed, 10 Dec 2008 22:11:47 +0100
Content-Disposition: inline
In-Reply-To: <7vzlj3ycr4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 10 Dec 2008 21:11:53.0528 (UTC) FILETIME=[ECF90380:01C95B0B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102721>

On Wed, Dec 10, 2008 at 12:51:59PM -0800, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > If it's a regression, it dates far back, since 1.5.0 fails as well.
> 
> A good lit(h)mus test to see if it is a regression or just a plain bug in
> the recursive strategy would be to see what 'resolve' strategy does
> (replace "merge" with "merge -s resolve" in your test).

"merge -s resolve" fails with

Trying really trivial in-index merge...
error: Merge requires file-level merging
Nope.
Trying simple merge.
Simple merge failed, trying Automatic merge.
ERROR: c1.c: Not handling case ae9304576a6ec3419b231b2b9c8e33a06f97f9fb ->
-> 8173b675dc61bb578b411c769c9fb654625a7c4e
fatal: merge program failed
Automatic merge failed; fix conflicts and then commit the result.

and therefore passes the test.
