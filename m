From: Jeff King <peff@peff.net>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Tue, 3 Jul 2007 01:12:54 -0400
Message-ID: <20070703051254.GA6477@coredump.intra.peff.net>
References: <46893F61.5060401@jaeger.mine.nu> <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net> <46895EA4.5040803@jaeger.mine.nu> <20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net> <46896C3B.1050406@jaeger.mine.nu> <20070703041241.GA4007@coredump.intra.peff.net> <7vhcomt7oa.fsf@assigned-by-dhcp.cox.net> <20070703045948.GE4007@coredump.intra.peff.net> <7v4pkmt6nk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Jaeger <christian@jaeger.mine.nu>,
	Yann Dirson <ydirson@altern.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 07:13:01 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5ah8-0004zm-PB
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 07:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbXGCFM4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 01:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbXGCFM4
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 01:12:56 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3368 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498AbXGCFM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 01:12:56 -0400
Received: (qmail 26588 invoked from network); 3 Jul 2007 05:13:17 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 3 Jul 2007 05:13:17 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2007 01:12:54 -0400
Content-Disposition: inline
In-Reply-To: <7v4pkmt6nk.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51458>

On Mon, Jul 02, 2007 at 10:09:35PM -0700, Junio C Hamano wrote:

> Exactly.  And not considering that lossage helps us keep our
> sanity.  I think "git rm --cached" falls into the same
> category.  If the user wants to discard what is in the index
> without losing a copy in the working tree, I think we should let
> him do without fuss.

OK. So should we _remove_ the safety valve in all cases where we're just
losing stuff that's in the index? It is, after all, recoverable. Should
there be a warning (I suspect it would get annoying very quickly)?

I think this would help by making the use of '-f' more rare, which is
the thing that can _really_ screw you, since it turns off the safety
valve even for things that aren't recoverable.

-Peff
