From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] t5550: fix typo in $HTTPD_URL
Date: Thu, 28 Apr 2016 11:25:50 -0400
Message-ID: <20160428152549.GB31063@sigill.intra.peff.net>
References: <20160428133534.GA19056@sigill.intra.peff.net>
 <20160428133636.GA25319@sigill.intra.peff.net>
 <CA+P7+xqSYA5++pq0_0FYFg8TXhc7f0=X_4uNWtFRpebEDzqtHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:26:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avnpG-000468-52
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbcD1PZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:25:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:58430 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751865AbcD1PZx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:25:53 -0400
Received: (qmail 30898 invoked by uid 102); 28 Apr 2016 15:25:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 11:25:52 -0400
Received: (qmail 10639 invoked by uid 107); 28 Apr 2016 15:25:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 11:25:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 11:25:50 -0400
Content-Disposition: inline
In-Reply-To: <CA+P7+xqSYA5++pq0_0FYFg8TXhc7f0=X_4uNWtFRpebEDzqtHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292898>

On Thu, Apr 28, 2016 at 08:24:05AM -0700, Jacob Keller wrote:

> On Thu, Apr 28, 2016 at 6:36 AM, Jeff King <peff@peff.net> wrote:
> > Commit 14111fc (git: submodule honor -c credential.* from
> > command line, 2016-02-29) accidentally wrote $HTTP_URL. It
> > happened to work because we ended up with "credential..helper",
> > which we treat the same as "credential.helper", applying it
> > to all URLs.
> 
> You say "credential.helper" twice here? I think that's confusing. The
> patch looks perfectly fine but I am having trouble parsing this
> description. 'We end up with X which we treat the same as X"?

Note the two dots in the first one. There is no variable $HTTP_URL, so:

  credential.$HTTP_URL.helper

becomes:

  credential..helper

-Peff
