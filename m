From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Sep 2014, #02; Tue, 9)
Date: Tue, 9 Sep 2014 18:20:54 -0400
Message-ID: <20140909222054.GC14029@peff.net>
References: <xmqqa968jxj5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:21:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRTmX-0005Wg-Mx
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 00:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbaIIWU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 18:20:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:46222 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752506AbaIIWU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 18:20:57 -0400
Received: (qmail 19594 invoked by uid 102); 9 Sep 2014 22:20:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Sep 2014 17:20:57 -0500
Received: (qmail 11282 invoked by uid 107); 9 Sep 2014 22:21:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Sep 2014 18:21:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Sep 2014 18:20:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa968jxj5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256716>

On Tue, Sep 09, 2014 at 02:26:22PM -0700, Junio C Hamano wrote:

> * jk/command-line-config-empty-string (2014-08-05) 1 commit
>   (merged to 'next' on 2014-08-29 at 74f04af)
>  + config: teach "git -c" to recognize an empty string
> 
>  "git -c section.var command" and "git -c section.var= command"
>  should pass the configuration differently (the former should be
>  a boolean true, the latter should be an empty string).

Hmm, there is something funny about the authorship on the sole commit in
that topic. It's too late to fix now (and I do not care too much), but
you may want to puzzle out what happened (stray --reset-author, weird
use of "git am"?).

> * jk/index-pack-threading-races (2014-08-29) 1 commit
>  - index-pack: fix race condition with duplicate bases
> 
>  When receiving an invalid pack stream that records the same object
>  twice, multiple threads got confused due to a race.  We should
>  reject or correct such a stream upon receiving, but that will be a
>  larger change.
> 
>  Will merge to 'next'.

I have been meaning to revisit this topic since the earlier discussion.
At the very least, we need to improve the error message for this case. I
think it's OK to merge this first patch, though, as anything else can
build on it.

-Peff
