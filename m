From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] test-lib.sh: fix color support when tput needs
 ~/.terminfo
Date: Wed, 17 Jun 2015 18:26:02 -0400
Message-ID: <20150617222602.GA31735@peff.net>
References: <xmqqvbem5bx9.fsf@gitster.dls.corp.google.com>
 <1434575481-24604-1-git-send-email-rhansen@bbn.com>
 <1434575481-24604-3-git-send-email-rhansen@bbn.com>
 <20150617221331.GA26069@peff.net>
 <xmqq7fr255ze.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 00:27:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5LnL-0003Kw-Ay
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 00:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbbFQW0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 18:26:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:47750 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932784AbbFQW0F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 18:26:05 -0400
Received: (qmail 14988 invoked by uid 102); 17 Jun 2015 22:26:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 17:26:04 -0500
Received: (qmail 30491 invoked by uid 107); 17 Jun 2015 22:26:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 18:26:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jun 2015 18:26:02 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7fr255ze.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271923>

On Wed, Jun 17, 2015 at 03:23:49PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Jun 17, 2015 at 05:11:21PM -0400, Richard Hansen wrote:
> >
> >> +		test -z "$1" && test -n "$quiet" && return
> >> +		eval "say_color_color=\$say_color_$1"
> >
> > Thanks, this looks much simpler.
> >
> > In the non-quiet case, you will eval $say_color_, even though we know it
> > to be bogus.
> 
> Yeah, but there is this gem in this patch:
> 
> +	...
> +	say_color_info=$(tput setaf 6) # cyan
> +	say_color_reset=$(tput sgr0)
> +	say_color_="" # no formatting for normal text

Oh, sorry, I was so focused on the later part that I totally missed
that. That is rather elegant, and nicer than what I wrote.

-Peff
