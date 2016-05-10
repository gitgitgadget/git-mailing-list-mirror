From: Jeff King <peff@peff.net>
Subject: Re: t4151 missing quotes
Date: Tue, 10 May 2016 09:48:36 -0400
Message-ID: <20160510134836.GA8177@sigill.intra.peff.net>
References: <CALR6jEiBsU+jQ8VoRsniMdztCpVDemQ3r00W-OXdRP6ZEt9CFg@mail.gmail.com>
 <CAPig+cTbAA8xDWvCXbBF+HJpxONS38hcjAiNuocC+PUBro9ALg@mail.gmail.com>
 <CALR6jEgaNSAQOpxSK46h71PMRhakDa=UCC5gbTyg77BcaOaoPg@mail.gmail.com>
 <xmqq37pruklb.fsf@gitster.mtv.corp.google.com>
 <CAPig+cS4Bj4N8d1a29z8=f30owOec1pB=yF32ZUPmDH2Tu2kXA@mail.gmail.com>
 <xmqqmvnzt0yx.fsf@gitster.mtv.corp.google.com>
 <CAPig+cSRUqSQZ1G73X6szfXjJEwopaO20H_k2vrmmy1qpEftLQ@mail.gmail.com>
 <CALR6jEiFq6kjB0pQgvvd0Pc3i1ZNbGSG2a=i7Hij0HmgUNjgEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 10 15:48:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b081p-000446-Kp
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 15:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbcEJNsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 09:48:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:36947 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751119AbcEJNsk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 09:48:40 -0400
Received: (qmail 32346 invoked by uid 102); 10 May 2016 13:48:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 May 2016 09:48:39 -0400
Received: (qmail 29760 invoked by uid 107); 10 May 2016 13:48:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 May 2016 09:48:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 May 2016 09:48:36 -0400
Content-Disposition: inline
In-Reply-To: <CALR6jEiFq6kjB0pQgvvd0Pc3i1ZNbGSG2a=i7Hij0HmgUNjgEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294131>

On Tue, May 10, 2016 at 03:44:32PM +0200, Armin Kunaschik wrote:

> I'm building on a quite current AIX 6.1 where /bin/sh defaults to /bin/ksh
> which is a posix shell (ksh88).
> Using /bin/bash doesn't work because SHELL_PATH is only used in
> git scripts but not in any t* test scripts.

If you run "make test" (or just "make" inside "t/") the test scripts
will be executed with SHELL_PATH. If you run:

  ./t1234-whatever.sh

then obviously no, they will not be. Don't do that. Either use:

  make t1234-whatever.sh

or:

  $YOUR_SHELL_PATH t1234-whatever.sh

-Peff
