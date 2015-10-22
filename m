From: Jeff King <peff@peff.net>
Subject: Re: Poor git write performance to NFS
Date: Thu, 22 Oct 2015 12:11:08 -0400
Message-ID: <20151022161108.GA10917@sigill.intra.peff.net>
References: <56278FD3.3010103@lrz.de>
 <xmqqlhaw5bj2.fsf@gitster.mtv.corp.google.com>
 <5628DED0.3050002@lrz.de>
 <xmqqbnbqubsh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Steinborn <daniel.steinborn@lrz.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 18:11:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpISW-0006ls-76
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 18:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757482AbbJVQLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 12:11:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:47131 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757465AbbJVQLL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 12:11:11 -0400
Received: (qmail 17838 invoked by uid 102); 22 Oct 2015 16:11:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Oct 2015 11:11:10 -0500
Received: (qmail 20515 invoked by uid 107); 22 Oct 2015 16:11:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Oct 2015 12:11:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Oct 2015 12:11:08 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnbqubsh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280060>

On Thu, Oct 22, 2015 at 09:07:42AM -0700, Junio C Hamano wrote:

> Daniel Steinborn <daniel.steinborn@lrz.de> writes:
> 
> > I removed the git Debian package and compiled v2.6.2 manually. The
> > performance is much better now (on the same level als v1.7.12.4).
> 
> Thanks.  It is good that we must have done something good within the
> past 12 months between v2.1 and v2.6, even though it feels somewhat
> unsatisfactory not knowing exactly what that good thing is ;-)

It was almost certainly the commits pulled in by e3b199a (Merge branch
'jk/prune-mtime', 2015-05-05).

And 0eeb077 (index-pack: avoid excessive re-reading of pack
directory, 2015-06-09) helps for certain commands, too.

-Peff
