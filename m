From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-http-fetch: remove unused cmd_http_fetch
Date: Fri, 15 Jun 2012 14:16:36 -0400
Message-ID: <20120615181636.GA14843@sigill.intra.peff.net>
References: <20120614202336.GA3755@w500.iskon.local>
 <20120615162136.GC4572@sigill.intra.peff.net>
 <7vaa04bg5q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Luka Perkov <lists@lukaperkov.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 20:16:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfb4e-00061y-Qx
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 20:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757033Ab2FOSQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 14:16:40 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:57647
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756912Ab2FOSQj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 14:16:39 -0400
Received: (qmail 2137 invoked by uid 107); 15 Jun 2012 18:16:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jun 2012 14:16:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jun 2012 14:16:36 -0400
Content-Disposition: inline
In-Reply-To: <7vaa04bg5q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200076>

On Fri, Jun 15, 2012 at 11:09:53AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > PS There seem to be some other similar declarations: at least
> >    cmd_upload_tar and cmd_pickaxe.
> 
> Thanks.
> 
> $ sed -ne 's/^extern int \(cmd_[^(]*\)(.*/\1/p' builtin.h | sort >/var/tmp/1
> $ nm -g git| sed -ne 's/^[0-9a-f]* T cmd_/cmd_/p' | sort > /var/tmp/2
> $ comm -3 /var/tmp/[12]
> 
> finds only the two you mentioned, so how about doing it this way?

I used a slightly grosser grep that looked in "*.c", and come up with
only those 2. Patch looks good to me.

-Peff
