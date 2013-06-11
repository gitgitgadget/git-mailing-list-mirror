From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/4] commit-queue: LIFO or priority queue of commits
Date: Tue, 11 Jun 2013 02:36:48 -0400
Message-ID: <20130611063648.GB23650@sigill.intra.peff.net>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-3-git-send-email-gitster@pobox.com>
 <20130610052500.GD3621@sigill.intra.peff.net>
 <7vwqq2l9cz.fsf@alter.siamese.dyndns.org>
 <20130610181557.GA2084@sigill.intra.peff.net>
 <7v1u89iyla.fsf@alter.siamese.dyndns.org>
 <20130610185907.GD2084@sigill.intra.peff.net>
 <7vd2rteej0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 08:37:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmICP-0004eP-J4
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 08:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab3FKGgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 02:36:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:52022 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104Ab3FKGgx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 02:36:53 -0400
Received: (qmail 27712 invoked by uid 102); 11 Jun 2013 06:37:44 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 11 Jun 2013 01:37:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jun 2013 02:36:48 -0400
Content-Disposition: inline
In-Reply-To: <7vd2rteej0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227420>

On Mon, Jun 10, 2013 at 04:23:31PM -0700, Junio C Hamano wrote:

> OK, I pushed out a result of some renaming and rebasing.  Notable
> changes are:
> 
>  - The data and API is called prio-queue and they live in prio-queue.[ch];
> 
>  - The test script is also named test-prio-queue.c, to leave the
>    door open for other kinds of queue;

Sounds reasonable, though you may want to update the commit message of
jc/topo-author-date-sort~2.

>  - For now, record_author_date() does the obvious read-sha1-file and
>    free; and

I think that is a good place to leave it in this series. It does not
hurt performance in any existing cases, and any parsing refactoring can
come later if somebody wants to work on it.

>  - The comparison callback's function signature had three "void *",
>    so they are named in the header file now.  Also two "thing"
>    pointers are marked as "const void *".

Yeah, I noticed both when porting my tests, but didn't want to add too
many distracting details. Thanks for fixing.

Overall, it looks good for me except for the commit message tweaks I
mentioned above.

-Peff
