From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t9100: fix breakage when SHELL_PATH is not /bin/sh
Date: Mon, 8 Feb 2016 14:56:30 -0500
Message-ID: <20160208195630.GB30693@sigill.intra.peff.net>
References: <982f6f499c988e1063275e2951c9856d622a83f3.1454872161.git.git@drmicha.warpmail.net>
 <20160208135013.GA27054@sigill.intra.peff.net>
 <CAA19uiRSu_6Os3b498obSNec7b2uiYv20SZ=y93CkjsWqhqHzA@mail.gmail.com>
 <20160208163700.GA22929@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602082027550.2964@virtualbox>
 <20160208193509.GA30554@sigill.intra.peff.net>
 <xmqqlh6v7zu0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 20:56:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSrvM-0001VH-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 20:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbcBHT4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 14:56:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:39414 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752617AbcBHT4d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 14:56:33 -0500
Received: (qmail 14208 invoked by uid 102); 8 Feb 2016 19:56:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 14:56:33 -0500
Received: (qmail 8571 invoked by uid 107); 8 Feb 2016 19:56:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 14:56:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 14:56:30 -0500
Content-Disposition: inline
In-Reply-To: <xmqqlh6v7zu0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285797>

On Mon, Feb 08, 2016 at 11:43:19AM -0800, Junio C Hamano wrote:

> > But then what is write_script buying us?
> 
> The correct way to write a script for a specific interpreter is to
> give a second parameter to write_script, i.e.
> 
> 		write_script exec.sh /bin/sh </dev/null &&
> 
> and the answer to the question is "it will save us one line".

At the cost of a useless "cat" invocation, though. :)

> The version in 'master' that does
> 
>                 echo "#!/bin/sh" >exec.sh &&
>                 chmod +x exec.sh &&
> 
> should be equivalent, so dropping that hunk from the patch is the
> right resolution perhaps?

Yeah, but I still don't understand why the original did not work on
Windows, once all the other hunks from bcb11f1 are applied.

-Peff
