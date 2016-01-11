From: Jeff King <peff@peff.net>
Subject: Re: git format-patch on empty commit
Date: Mon, 11 Jan 2016 16:09:15 -0500
Message-ID: <20160111210915.GA21173@sigill.intra.peff.net>
References: <CAPMsMoDOqWD+a1pj6BO-QgnknJu+JwnZgefJ=MyP8rEwZQGiPQ@mail.gmail.com>
 <20160111205347.GA14535@sigill.intra.peff.net>
 <xmqqegdnx1xx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: pedro rijo <pedrorijo91@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 22:09:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIjiM-00023F-Ee
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 22:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbcAKVJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 16:09:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:51595 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932523AbcAKVJS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 16:09:18 -0500
Received: (qmail 14072 invoked by uid 102); 11 Jan 2016 21:09:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 16:09:18 -0500
Received: (qmail 5493 invoked by uid 107); 11 Jan 2016 21:09:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 16:09:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jan 2016 16:09:15 -0500
Content-Disposition: inline
In-Reply-To: <xmqqegdnx1xx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283719>

On Mon, Jan 11, 2016 at 01:04:42PM -0800, Junio C Hamano wrote:

> So I think skipping no-op commit from the output was done pretty
> much deliberately and it is definitely not a bug.  I however do not
> think it is incorrect to say that it is a lack of feature that
> nobody so far found necessary or beneficial.
> 
> I would not refuse to consider adding a new option to "format-patch"
> to emit such a no-op message, and add a "having no patch is OK, just
> record a no-op commit" option to "am", though.  But I do not see a
> clear benefit from such change--it sounds more like a set of
> "because we could" not "because we need to" changes to me.

I think we are more or less on the same page. To me it is less "because
we could" but that some people seem to find empty commits useful in
their workflow (which is why we have "commit --allow-empty"), and if you
use such a workflow, it is probably reasonable for "format-patch | am"
or "rebase" to be trusted to preserve the history (at least with an
option).

I do not use such workflows myself[1], so I will leave open the question
of whether they have a benefit. :)

-Peff

[1] Though I will confess to finding "commit --allow-empty" quite useful
    when debugging.
