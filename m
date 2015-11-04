From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Add git-grep threads param
Date: Wed, 4 Nov 2015 01:40:21 -0500
Message-ID: <20151104064021.GB16605@sigill.intra.peff.net>
References: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
 <xmqqvb9jc81q.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Victor Leschuk <vleschuk@gmail.com>, git@vger.kernel.org,
	Victor Leschuk <vleschuk@accesssoftek.com>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"john@keeping.me.uk" <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 07:40:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtrkD-0000KG-1f
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 07:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575AbbKDGkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 01:40:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:52547 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751064AbbKDGkY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 01:40:24 -0500
Received: (qmail 32189 invoked by uid 102); 4 Nov 2015 06:40:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Nov 2015 00:40:24 -0600
Received: (qmail 300 invoked by uid 107); 4 Nov 2015 06:40:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Nov 2015 01:40:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Nov 2015 01:40:21 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvb9jc81q.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280854>

On Tue, Nov 03, 2015 at 09:22:09AM -0800, Junio C Hamano wrote:

> > +grep.threads::
> > +	Number of grep worker threads, use it to tune up performance on
> > +	multicore machines. Default value is 8. Set to 0 to disable threading.
> > +
> 
> I am not enthused by this "Set to 0 to disable".  As Zero is
> magical, it would be more useful if 1 meant that threading is not
> used (i.e. there is only 1 worker), and 0 meant that we would
> automatically pick some reasonable parallelism for you (and we
> promise that the our choice would not be outrageously wrong), or
> something like that.

Not just useful, but consistent with other parts of git, like
pack.threads, where "0" already means "autodetect".

-Peff
