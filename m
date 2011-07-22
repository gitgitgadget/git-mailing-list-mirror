From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/14] introduce credentials API
Date: Fri, 22 Jul 2011 14:40:07 -0600
Message-ID: <20110722204007.GB11922@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
 <20110718075034.GF12341@sigill.intra.peff.net>
 <7vvcuvz458.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 22:40:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkMWE-00046M-N4
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 22:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140Ab1GVUkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 16:40:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43045
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932096Ab1GVUkN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 16:40:13 -0400
Received: (qmail 23117 invoked by uid 107); 22 Jul 2011 20:40:42 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Jul 2011 16:40:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jul 2011 14:40:07 -0600
Content-Disposition: inline
In-Reply-To: <7vvcuvz458.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177667>

On Thu, Jul 21, 2011 at 02:59:31PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/credential.c b/credential.c
> > new file mode 100644
> > index 0000000..c403289
> > --- /dev/null
> > +++ b/credential.c
> > @@ -0,0 +1,190 @@
> > ...
> > +void credential_fill(struct credential *c, const struct string_list *methods)
> > +{
> > +	...
> > +	}
> > +	die(err.buf);
> 
> credential.c:195: error: format not a string literal and no format arguments
> 
> This needs to be
> 
> 	die("%s", err.buf);

Thanks, silly me. I'm surprised I didn't get a warning, as I compile
with -Wall. Is there an extra flag you need to give gcc?

-Peff
