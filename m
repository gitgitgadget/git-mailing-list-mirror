From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] "error: cache entry has null sha1"
Date: Thu, 31 Oct 2013 13:15:40 -0400
Message-ID: <20131031171539.GA19142@sigill.intra.peff.net>
References: <20131031063451.GA5513@sigill.intra.peff.net>
 <20131031063626.GB5812@sigill.intra.peff.net>
 <xmqqeh719xgq.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 18:15:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbvqV-0005gr-6y
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 18:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078Ab3JaRPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 13:15:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:59308 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751536Ab3JaRPm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 13:15:42 -0400
Received: (qmail 15370 invoked by uid 102); 31 Oct 2013 17:15:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Oct 2013 12:15:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Oct 2013 13:15:40 -0400
Content-Disposition: inline
In-Reply-To: <xmqqeh719xgq.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237130>

On Thu, Oct 31, 2013 at 10:11:49AM -0700, Junio C Hamano wrote:

>  - Try to discard
> 
>    $ git am --abort
>    error: cache entry has null sha1: remote-curl.c
>    fatal: unable to write new index file
> 
>    This should not happen, no?
> 
> "git reset --hard" will remove the funnies, but still...

I ran into this recently, too. Isn't it just the twoway_merge bug we
were discussing here:

  http://thread.gmane.org/gmane.comp.version-control.git/202440/focus=212316

I don't think we ever actually applied a fix.

-Peff
