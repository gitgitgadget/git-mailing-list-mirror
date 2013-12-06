From: Jeff King <peff@peff.net>
Subject: Re: Git reports
Date: Fri, 6 Dec 2013 17:22:01 -0500
Message-ID: <20131206222201.GF25620@sigill.intra.peff.net>
References: <CAMAQ3n+OtBdYALh4pg6kywtbgPtQjHr6Xc-2ff63df-h=TLwbA@mail.gmail.com>
 <20131206210035.17413ee7bcdf3ca0c9655d81@domain007.com>
 <20131206210958.59f553060e3802d56f4a53b8@domain007.com>
 <CAMAQ3nKVjF-5oW2pZZaD9MSz9wqoXJBQDoGcdy5mb=gxCguuSA@mail.gmail.com>
 <20131206215334.1a9031a1450d9c436943ce3d@domain007.com>
 <CAMAQ3nLgnpDo1jWFL1rqtEvmQm8LeEpZ41Uxo0GTQOk8ttpSZA@mail.gmail.com>
 <20131206192651.GK29959@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Muzaffer Tolga Ozses <tolga@ozses.net>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 06 23:22:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp3mm-00052s-W3
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 23:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162187Ab3LFWWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 17:22:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:51883 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161659Ab3LFWWE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 17:22:04 -0500
Received: (qmail 12032 invoked by uid 102); 6 Dec 2013 22:22:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Dec 2013 16:22:03 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Dec 2013 17:22:01 -0500
Content-Disposition: inline
In-Reply-To: <20131206192651.GK29959@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238961>

On Fri, Dec 06, 2013 at 11:26:51AM -0800, Jonathan Nieder wrote:

> > I am cloning over http
> 
> I am guessing you are using the "dumb" (plain static file transfer)
> HTTP protocol.  With that protocol the server doesn't do anything
> other than shuttle out files, so it doesn't need to do its own
> progress reporting.

Yeah, that would also explain why GIT_TRACE_PACKET produced no output.

> Perhaps the client should do some progress reporting based on file
> sizes and amount downloaded so far, but it's hard to get excited
> about given the existence of "smart" (transfer only what is needed)
> HTTP protocol.  See git-http-backend(1) for details.

You get some very verbose and nasty progress with "-vv". It would be
nice to have a regular throughput meter for dumb-http, though. I haven't
bothered adding one so far because I don't expect many people are using
http. However, if we start supporting fetching via bundles over http,
then it will be very nice to have some kind of progress display there
(since the main use is to get gigantic full clones).

-Peff
