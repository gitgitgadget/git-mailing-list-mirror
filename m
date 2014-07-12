From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/7] move setting of object->type to alloc_* functions
Date: Sat, 12 Jul 2014 14:07:19 -0400
Message-ID: <20140712180719.GB13806@sigill.intra.peff.net>
References: <20140711084141.GA5521@sigill.intra.peff.net>
 <20140711084611.GB5625@sigill.intra.peff.net>
 <53C14C67.60300@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Jul 12 20:07:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X61hm-0007dl-Mk
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 20:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbaGLSHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 14:07:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:60890 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751840AbaGLSHV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 14:07:21 -0400
Received: (qmail 27705 invoked by uid 102); 12 Jul 2014 18:07:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 12 Jul 2014 13:07:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jul 2014 14:07:19 -0400
Content-Disposition: inline
In-Reply-To: <53C14C67.60300@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253395>

On Sat, Jul 12, 2014 at 03:55:35PM +0100, Ramsay Jones wrote:

> >  	if (!obj) {
> >  		struct commit *c = alloc_commit_node();
> > -		return create_object(sha1, OBJ_COMMIT, c);
> > +		return create_object(sha1, c);
> >  	}
> 
> perhaps:
> 	if (!obj)
> 		return create_object(sha1, alloc_commit_node());
> 
> (increasing similarity with other calls here ...)

Yeah, I noticed that but didn't change it to keep the diff small. The
one that should have is 969eba6, but it is not a big deal to do it here.

-Peff
