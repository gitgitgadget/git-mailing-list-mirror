From: Jeff King <peff@peff.net>
Subject: Re: [BUG] remote-curl.c: honor pushurl
Date: Fri, 14 Oct 2011 11:48:53 -0400
Message-ID: <20111014154853.GA10722@sigill.intra.peff.net>
References: <4E985744.6050904@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, rctay89@gmail.com
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 17:49:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REk0M-0002EZ-Nb
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 17:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906Ab1JNPs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 11:48:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60633
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882Ab1JNPs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 11:48:58 -0400
Received: (qmail 11484 invoked by uid 107); 14 Oct 2011 15:49:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Oct 2011 11:49:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2011 11:48:53 -0400
Content-Disposition: inline
In-Reply-To: <4E985744.6050904@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183584>

On Fri, Oct 14, 2011 at 05:37:40PM +0200, Michael Schubert wrote:

> When doing a push (fetch, ..) over http(s), git calls git-remote-http to
> communicate with the server.
> 
> 	git-remote-http <remote> [<url>]
> 
> Git correctly honors a configured pushurl and passes it to git-remote-http,
> but git-remote-http is initiating the http connection with the url defined
> for remote (remote->url) rather than the passed url. This undermines the
> purpose of a config like
> 
> 	url = https://example.com/repo.git
> 	pushurl = https://user@example.com/repo.git
> 
> Introduced around 888692b7 - CC'ing Tay Ray Chuan. (I don't know if it was
> working before, though.)

Already noticed and fixed last week.

See this thread, starting at the focused message.

  http://thread.gmane.org/gmane.comp.version-control.git/182752/focus=182872

-Peff
