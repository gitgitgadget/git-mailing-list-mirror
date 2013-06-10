From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] toposort: rename "lifo" field
Date: Mon, 10 Jun 2013 01:05:26 -0400
Message-ID: <20130610050526.GC3621@sigill.intra.peff.net>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 07:05:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UluIk-00010H-Bh
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 07:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477Ab3FJFFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 01:05:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:41675 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151Ab3FJFF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 01:05:29 -0400
Received: (qmail 18604 invoked by uid 102); 10 Jun 2013 05:06:19 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Jun 2013 00:06:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jun 2013 01:05:26 -0400
Content-Disposition: inline
In-Reply-To: <1370820277-30158-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227233>

On Sun, Jun 09, 2013 at 04:24:34PM -0700, Junio C Hamano wrote:

> The name "lifo", however, is too strongly tied to the way how the
> function implements its behaviour, and does not describe what the
> behaviour _means_.
> 
> Replace this field with an enum rev_sort_order, with two possible
> values: REV_SORT_IN_GRAPH_ORDER and REV_SORT_BY_COMMIT_DATE, and
> update the existing code.  The mechanical replacement rule is:
> 
>   "lifo == 0" is equivalent to "sort_order == REV_SORT_BY_COMMIT_DATE"
>   "lifo == 1" is equivalent to "sort_order == REV_SORT_IN_GRAPH_ORDER"

Thanks. Having looked at this code for the first time in a long time
recently, I was very confused by the purpose of the "lifo" flag; this
patch would have made it much clearer.

Patch itself looks fine to me.

-Peff
