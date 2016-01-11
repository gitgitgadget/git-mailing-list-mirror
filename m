From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/2] Correctly handle transient files in shared
 repositories
Date: Mon, 11 Jan 2016 17:06:03 -0500
Message-ID: <20160111220603.GD21131@sigill.intra.peff.net>
References: <cover.1452085713.git.johannes.schindelin@gmx.de>
 <cover.1452537321.git.johannes.schindelin@gmx.de>
 <xmqqa8obx1ll.fsf@gitster.mtv.corp.google.com>
 <xmqq60yzx14w.fsf@gitster.mtv.corp.google.com>
 <20160111213801.GB21131@sigill.intra.peff.net>
 <xmqq1t9nwznm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 23:06:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIkbN-00052l-T9
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 23:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759837AbcAKWGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 17:06:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:51673 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759567AbcAKWGH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 17:06:07 -0500
Received: (qmail 16501 invoked by uid 102); 11 Jan 2016 22:06:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 17:06:05 -0500
Received: (qmail 6297 invoked by uid 107); 11 Jan 2016 22:06:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 17:06:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jan 2016 17:06:03 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1t9nwznm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283729>

On Mon, Jan 11, 2016 at 01:54:05PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not sure I buy this argument. Yes, you should not be writing
> > anything else, but that does not change the fact that "fsck" will
> > unceremoniously abort:
> > ...
> > So I think this would be a reasonable candidate (or alternatively, to
> > treat EPERM on an existing file as a soft error). I am totally fine not
> > to address it as part of this series, though.
> 
> Yeah, that crossed my mind (and I agree with the conclusion).
> 
> Listing what is left deliberately and why is still a good idea, as
> that would force people to think twice before wasting effort to
> convert blindly without thinking.  Listing what is left behind like
> "git fsck" that we know we shouldn't leave behind is even better to
> mark low-hanging fruits.  How do you like this one instead?
> 
>      - git fsck, when writing lost&found blobs (this probably should
>        be changed, but left as a low-hanging fruit for future
>        contributors).

I think that's more accurate. :)

-Peff
