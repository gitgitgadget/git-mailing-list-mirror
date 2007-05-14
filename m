From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use $Id$ as the ident attribute keyword rather than $ident$  to be consistent with other VCSs
Date: Mon, 14 May 2007 07:54:44 -0700
Message-ID: <7v646vo3pn.fsf@assigned-by-dhcp.cox.net>
References: <200705141429.58412.andyparkins@gmail.com>
	<200705141437.25528.andyparkins@gmail.com>
	<46486FE6.16A82D9A@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon May 14 16:55:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnbxO-0008KH-P7
	for gcvg-git@gmane.org; Mon, 14 May 2007 16:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756460AbXENOyq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 10:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756979AbXENOyq
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 10:54:46 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:49538 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756949AbXENOyp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 10:54:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070514145445.ZRFA26353.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 14 May 2007 10:54:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id z2uk1W00C1kojtg0000000; Mon, 14 May 2007 10:54:44 -0400
In-Reply-To: <46486FE6.16A82D9A@eudaptics.com> (Johannes Sixt's message of
	"Mon, 14 May 2007 16:19:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47248>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> Andy Parkins wrote:
>> I think that bzr uses $Id$; Mercurial has examples hooks for $Id$;
>> monotone has $Id$ on its wishlist.  I can't think of a good reason not
>> to stick with the de-facto standard and call ours $Id$ instead of
>> $ident$.
>
> I very much agree. I wondered why it was named $ident$ in the first
> place. Now that I'm not alone, I thought I'd throw my 2 cents in...

My take when I did the $ident$ stuff on this issue was quite the
opposite.  CVS "$Id$" means quite a different thing (pathname,
per-file revision number, date, and status) and it would not be
right to overwrite it with $ident$ which does not record any of
those "context sensitive" information.

I did not think other systems making that mistake was not an
excuse for us to do so, but on the other hand, if the users of
those other systems are happy to lose the information from CVS
then perhaps the users do want $Id$.

Obviously I do not care much about this feature and I have not
look at Andy's patch too deeply yet, but in any case I think the
inverse conversion needs to be modified to match it, if it
hasn't been done so.
