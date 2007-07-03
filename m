From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Mon, 02 Jul 2007 23:26:40 -0700
Message-ID: <7vsl86roin.fsf@assigned-by-dhcp.cox.net>
References: <46893F61.5060401@jaeger.mine.nu>
	<20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<46895EA4.5040803@jaeger.mine.nu>
	<20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<46896C3B.1050406@jaeger.mine.nu>
	<20070703041241.GA4007@coredump.intra.peff.net>
	<7vhcomt7oa.fsf@assigned-by-dhcp.cox.net>
	<20070703045948.GE4007@coredump.intra.peff.net>
	<7v4pkmt6nk.fsf@assigned-by-dhcp.cox.net>
	<20070703051254.GA6477@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Jaeger <christian@jaeger.mine.nu>,
	Yann Dirson <ydirson@altern.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 08:26:45 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5bqW-0006wm-LW
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 08:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbXGCG0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 02:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbXGCG0m
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 02:26:42 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:63749 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbXGCG0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 02:26:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070703062641.CXNM1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Jul 2007 02:26:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JuSg1X0081kojtg0000000; Tue, 03 Jul 2007 02:26:41 -0400
In-Reply-To: <20070703051254.GA6477@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 3 Jul 2007 01:12:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51462>

Jeff King <peff@peff.net> writes:

> On Mon, Jul 02, 2007 at 10:09:35PM -0700, Junio C Hamano wrote:
>
>> Exactly.  And not considering that lossage helps us keep our
>> sanity.  I think "git rm --cached" falls into the same
>> category.  If the user wants to discard what is in the index
>> without losing a copy in the working tree, I think we should let
>> him do without fuss.
>
> OK. So should we _remove_ the safety valve in all cases where we're just
> losing stuff that's in the index? It is, after all, recoverable. Should
> there be a warning (I suspect it would get annoying very quickly)?

I personally do not think we would need any safety check for
"git rm --cached", as it does not touch the working tree.  For
non-cached case I think the current behaviour is fine.

But I should warn you that I rarely use "git rm" myself.
