From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as
 required
Date: Fri, 3 Jul 2015 14:46:08 -0400
Message-ID: <20150703184608.GA11526@peff.net>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com>
 <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
 <xmqq8uaz8vjb.fsf@gitster.dls.corp.google.com>
 <xmqq4mln8ve2.fsf@gitster.dls.corp.google.com>
 <20150702135309.GA18286@peff.net>
 <xmqq38155e3s.fsf@gitster.dls.corp.google.com>
 <20150703180718.GB9223@peff.net>
 <CAJo=hJsoKSB23KNNF9Xr-NUAqUXvq+O-ZYOSyb4wAC1TZKZ2-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Borowitz <dborowitz@google.com>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 03 20:46:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB5ya-0006Fh-Dl
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 20:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946AbbGCSqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 14:46:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:55453 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755340AbbGCSqK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 14:46:10 -0400
Received: (qmail 19866 invoked by uid 102); 3 Jul 2015 18:46:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jul 2015 13:46:10 -0500
Received: (qmail 15034 invoked by uid 107); 3 Jul 2015 18:46:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jul 2015 14:46:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jul 2015 14:46:08 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJsoKSB23KNNF9Xr-NUAqUXvq+O-ZYOSyb4wAC1TZKZ2-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273311>

On Fri, Jul 03, 2015 at 11:43:33AM -0700, Shawn Pearce wrote:

> > For (2), hopefully we can implement it in the same way, and rely on
> > empty sideband-0 packets. I haven't tested it in practice, though (I
> > have some very rough patches for (1) already).
> 
> sideband-0 is not going to work for JGit clients.

Er, sorry, mental hiccup. It is 0-length sideband-1 packets that I
meant. The same as for upload-pack keepalives.

> JGit clients are strict about the sideband stream being 1,2,3 and fail
> hard if they get any other stream from the server[1].

I think git does, too.

-Peff
