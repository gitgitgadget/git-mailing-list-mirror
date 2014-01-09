From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] implement @{publish} shorthand
Date: Thu, 9 Jan 2014 13:20:24 -0500
Message-ID: <20140109182024.GA30970@sigill.intra.peff.net>
References: <20140108093338.GA15659@sigill.intra.peff.net>
 <20140108093716.GE15720@sigill.intra.peff.net>
 <xmqqeh4iavn2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 09 19:20:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1KDb-000806-1D
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 19:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925AbaAISUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 13:20:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:57914 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754878AbaAISU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 13:20:27 -0500
Received: (qmail 30612 invoked by uid 102); 9 Jan 2014 18:20:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jan 2014 12:20:26 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jan 2014 13:20:24 -0500
Content-Disposition: inline
In-Reply-To: <xmqqeh4iavn2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240262>

On Wed, Jan 08, 2014 at 03:42:09PM -0800, Junio C Hamano wrote:

> > This patch introduces the <branch>@{publish} shorthand (or
> > "@{pu}" to be even shorter). It refers to the tracking
> 
> If @{u} can already be used for upstream, why not allow @{p} but
> require two letters @{pu}?  Just being curious---I am not advocating
> strongly for a shorter short-hand.
> 
> Or is @{p} already taken by something and my memory is not
> functioning well?

It is my brain that was not functioning well. I somehow thought "well,
@{u} is already taken, so we must use "@{pu}". Which of course makes no
sense, unless you are middle-endian. :)

We may want to be cautious about giving up a short-and-sweet
single-letter, though, until the feature has proved itself. We could
also teach upstream_mark and friends to match unambiguous prefixes (so
"@{u}, "@{up}", "@{upst}", etc). That means "@{p}" would work
immediately, but scripts should use "@{publish}" for future-proofing.

-Peff
