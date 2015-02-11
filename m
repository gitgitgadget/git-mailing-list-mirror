From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/8] write_ref_sha1(): remove check for lock == NULL
Date: Tue, 10 Feb 2015 19:06:00 -0500
Message-ID: <20150211000600.GB30561@peff.net>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
 <1423473164-6011-2-git-send-email-mhagger@alum.mit.edu>
 <CAGZ79kbCHAS3kbF_rwiGFxNCG1movygkcyOddELM7ikOM+wKBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 01:06:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLKoj-0001yT-6s
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 01:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbbBKAGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 19:06:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:47518 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750905AbbBKAGD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 19:06:03 -0500
Received: (qmail 13941 invoked by uid 102); 11 Feb 2015 00:06:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Feb 2015 18:06:02 -0600
Received: (qmail 11350 invoked by uid 107); 11 Feb 2015 00:06:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Feb 2015 19:06:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2015 19:06:00 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kbCHAS3kbF_rwiGFxNCG1movygkcyOddELM7ikOM+wKBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263663>

On Tue, Feb 10, 2015 at 02:52:23PM -0800, Stefan Beller wrote:

> On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> > None of the callers pass NULL to this function, and there doesn't seem
> > to be any usefulness to allowing them to do so.
> 
> Usually I'd oppose this change, as it seems to be a good defensive
> measure. (I cannot assume future me or anybody knows what they're
> doing), but as this function (write_ref_sha1) is not widely exposed
> any more since aae383db8 (Apr 28, refs.c: make write_ref_sha1 static),
> I think it's safe to assume changes affecting this call are well
> understood in the future.

Thanks, I was iffy on this change for the same reason, but after your
explanation, I too think it is reasonable.

-Peff
