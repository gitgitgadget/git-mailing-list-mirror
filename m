From: Jeff King <peff@peff.net>
Subject: Re: t5539 fails on ubuntu for v2.0.0-rc2
Date: Thu, 8 May 2014 00:14:23 -0400
Message-ID: <20140508041423.GC26630@sigill.intra.peff.net>
References: <536A8FF8.7080909@fabiodalfonso.com>
 <xmqqeh056z6q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: fabio.dalfonso@fabiodalfonso.com
X-From: git-owner@vger.kernel.org Thu May 08 06:14:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiFj6-0003m0-3Z
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 06:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbaEHEO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 00:14:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:47188 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750704AbaEHEOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 00:14:25 -0400
Received: (qmail 10054 invoked by uid 102); 8 May 2014 04:14:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 May 2014 23:14:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2014 00:14:23 -0400
Content-Disposition: inline
In-Reply-To: <xmqqeh056z6q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248402>

On Wed, May 07, 2014 at 02:45:01PM -0700, Junio C Hamano wrote:

> Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com> writes:
> 
> > root@HDUBVM01:~/builds/git/t# ./t5539-fetch-http-shallow.sh
> > ok 1 - setup shallow clone
> > not ok 2 - clone http repository
> [...]

> Does not reproduce for me but I am on Ubuntu 12.04.2 LTS, so...

Nor me on Debian unstable.

> Running it with the -v option might give you more hints, and
> running it as
> 
>     $ sh -x ./t5539-fe* -v
> 
> might give you more to chew.

Yes, definitely that, but also, from:

> > httpd (pid 10653?) not running
> > # failed 2 among 3 test(s)

...it looks like the httpd server did not start. Look in httpd/error.log
of "trash directory.t5539-fetch-http-shallow" to see the apache log. It
may give some reason for failing to start.

-Peff
