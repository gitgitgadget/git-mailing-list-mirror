From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] git-send-pack: fix --all option when used with
 directory
Date: Thu, 31 Mar 2016 19:26:23 -0400
Message-ID: <20160331232623.GA6120@sigill.intra.peff.net>
References: <1459432509-12934-1-git-send-email-stanislav@assembla.com>
 <xmqq1t6qmlxk.fsf@gitster.mtv.corp.google.com>
 <xmqqoa9ul30c.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, dborowitz@google.com, stanislav@assembla.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 01:26:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1allz1-0003mX-81
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 01:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbcCaX01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 19:26:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:42050 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752947AbcCaX00 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 19:26:26 -0400
Received: (qmail 26764 invoked by uid 102); 31 Mar 2016 23:26:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 19:26:26 -0400
Received: (qmail 19401 invoked by uid 107); 31 Mar 2016 23:26:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 19:26:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2016 19:26:23 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoa9ul30c.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290488>

On Thu, Mar 31, 2016 at 03:02:43PM -0700, Junio C Hamano wrote:

> By the way, for some reason it was unusually painful to find the
> exact breakage by bisecting between maint-2.4 and maint-2.6.  It
> somehow ended up on fingering random places like v2.6.0 itself.
> 
> The true culprit is 068c77a5 (builtin/send-pack.c: use parse_options
> API, 2015-08-19).  I didn't dug deep enough to tell if we recently
> broke "git bisect" or if there are something wrong in the shape of
> my history.

Weird. I bisected this when v1 was published, and didn't have any
trouble. I guess it's possible I just got lucky in where I landed,
though, if I started at different endpoints than you.

-Peff
