From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git-log - hide parent (was: merging two equivalent branches)
Date: Fri, 8 Jan 2010 06:00:25 +0100
Message-ID: <201001080600.26088.chriscool@tuxfamily.org>
References: <B0543B3C-C139-4BD3-B028-58B4DA132422@gmail.com> <46d6db661001071022t79ca65foac249d948a20c328@mail.gmail.com> <DF05F91F-CBFD-458A-A99F-79E98ACA5146@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian MICHON <christian.michon@gmail.com>
To: David Reitter <david.reitter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 05:57:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT6ur-0005dI-HP
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 05:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab0AHE5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 23:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618Ab0AHE5i
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 23:57:38 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:54487 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759Ab0AHE5h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 23:57:37 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D924981803B;
	Fri,  8 Jan 2010 05:57:31 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id F2434818042;
	Fri,  8 Jan 2010 05:57:28 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <DF05F91F-CBFD-458A-A99F-79E98ACA5146@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136416>

On jeudi 07 janvier 2010, David Reitter wrote:
> On Jan 7, 2010, at 1:22 PM, Christian MICHON wrote:
> > I recall asking a similar question in 2008, and the answer was to look
> > at "git graft" and use "git filter-branch" to recreate history.
>
> Thanks, I've tried that and I recall that filter-branch wasn't willing to
> rewrite just the recent history - at least in started going over all 100k
> revisions at a very slow pace.
>
> I'm still unsure how, after the filter-branch, I would have some ancestor
> from the B series so that future pulls from the remote work, while having
> an ancestor from A, to make sure I can continue merging into C.  If
> history is rewritten, I'll get new revisions and lose ancestors. I'm
> beginning to thing that the cutting and pasting I'd like is conceptually
> impossible.
>
> So what one would need is to specify a "silent parent" for a revision
> that is relevant w.r.t. future three-way merges, but indicates that the
> history behind the silent parent is irrelevant and shouldn't be shown in
> a git-log.  The runaway parent would be guaranteed to _not_ contribute
> any content to the tree of the child revision, as is the case with a
> "merge ours".

What you could perhaps do with "git replace" or a graft is to change the 
merge commit so that it has only one parent instead of 2.

> This could be implemented as a way to mark a parent as silent (checked by
> git-log at least), but one could also allow for an empty commit that,
> while having a normal parent, clears out the tree.
>
> Let me know if this idea is completely crazy. --

This looks like the right thing to do using "git replace" or grafts.

Best regards,
Christian. 
