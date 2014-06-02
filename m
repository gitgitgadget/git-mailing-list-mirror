From: Jeff King <peff@peff.net>
Subject: Re: feature request - implement a "GIT_AUTHOR_EMAIL" equivalent, but
 processed BEFORE .gitconfig
Date: Mon, 2 Jun 2014 02:59:51 -0400
Message-ID: <20140602065947.GC27254@sigill.intra.peff.net>
References: <5388CBA5.9030403@neulinger.org>
 <20140530182746.GK12314@google.com>
 <5388D175.3060500@neulinger.org>
 <xmqqvbsn82u6.fsf@gitster.dls.corp.google.com>
 <5388E2F7.606@neulinger.org>
 <20140530200945.GB5513@sigill.intra.peff.net>
 <xmqq1tvb7xw6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nathan Neulinger <nneul@neulinger.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 08:59:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrMDu-0006i2-50
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 08:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbaFBG7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 02:59:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:35734 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752462AbaFBG7x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 02:59:53 -0400
Received: (qmail 547 invoked by uid 102); 2 Jun 2014 06:59:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Jun 2014 01:59:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jun 2014 02:59:51 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tvb7xw6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250557>

On Fri, May 30, 2014 at 02:35:37PM -0700, Junio C Hamano wrote:

> Nathan's installation can set a "GIT_MYSELF" and then have something
> like this in the shared $HOME/.gitconfig
> 
> 	[include]
>         	path = /usr/local/users/$GIT_MYSELF/ident
> 
> we could even make the whole thing fail when GIT_MYSELF is not set
> but I haven't thought things through ;-)

Yeah, that is something I considered[1] when writing the initial
include.path implementation. Something like:

  [include]
	path = .gitconfig-$HOSTNAME

could be potentially useful. But I punted at the time to wait for
somebody to actually ask for it. If somebody wanted to implement it, I
don't see a reason to avoid it.

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/190196
