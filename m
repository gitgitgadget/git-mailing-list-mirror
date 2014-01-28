From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2014, #05; Mon, 27)
Date: Mon, 27 Jan 2014 19:40:42 -0500
Message-ID: <20140128004042.GC17227@sigill.intra.peff.net>
References: <xmqq7g9lnkjz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 28 01:40:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7wjW-0002oo-PX
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 01:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481AbaA1Akp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 19:40:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:39981 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754457AbaA1Ako (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 19:40:44 -0500
Received: (qmail 29364 invoked by uid 102); 28 Jan 2014 00:40:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Jan 2014 18:40:44 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jan 2014 19:40:42 -0500
Content-Disposition: inline
In-Reply-To: <xmqq7g9lnkjz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241173>

On Mon, Jan 27, 2014 at 02:09:52PM -0800, Junio C Hamano wrote:

> [Stalled]
> 
> * jk/color-for-more-pagers (2014-01-17) 4 commits
>  - pager: disable colors for some known-bad configurations
>  - DONOTMERGE: needs matching change to git-sh-setup
>  - setup_pager: set MORE=R
>  - setup_pager: refactor LESS/LV environment setting
> 
>  'more' implementation of BSD wants to be told with MORE=R
>  environment before it shows colored output, while 'more' on some
>  other platforms will die when seeing MORE=R environment.
> 
>  It appears that we are coming to the consensus that trying to be
>  too intimately knowledgeable about quirks of various pager
>  implementations on different platforms is a losing proposition, so
>  perhaps I should replace this with the alternative and simpler
>  approach I posted, unless there are strong objections.

It saddens me that we can't better help people who have a custom
LESS/MORE/LV set out of the box, but I think I agree that the intimacy
with the pagers was just getting too ugly. So I agree we want to drop
what you have there.

I was planning to try to clean up the "like this..." patch to the
Makefile I posted earlier, but haven't gotten around to it. It seemed
like you were positive on that approach. Let me see if I can do that.

-Peff
