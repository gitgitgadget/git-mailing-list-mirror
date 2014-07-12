From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/7] move setting of object->type to alloc_* functions
Date: Sat, 12 Jul 2014 14:05:39 -0400
Message-ID: <20140712180539.GA13806@sigill.intra.peff.net>
References: <20140711084141.GA5521@sigill.intra.peff.net>
 <20140711084611.GB5625@sigill.intra.peff.net>
 <53C149B6.7010705@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Jul 12 20:05:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X61g9-0005lL-O6
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 20:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbaGLSFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 14:05:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:60882 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751452AbaGLSFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 14:05:41 -0400
Received: (qmail 27598 invoked by uid 102); 12 Jul 2014 18:05:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 12 Jul 2014 13:05:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jul 2014 14:05:39 -0400
Content-Disposition: inline
In-Reply-To: <53C149B6.7010705@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253394>

On Sat, Jul 12, 2014 at 03:44:06PM +0100, Ramsay Jones wrote:

> > -	return alloc_node(&name##_state, sizeof(type));		\
> > +	return alloc_node(&name##_state, flag, sizeof(type));	\
> >  }
> 
> I don't particularly like 'flag' here. (not a massive dislike, mind you:)
> 
> Perhaps: flag->object_type, type->node_type?
> Or, if that's too verbose, maybe just: flag->type, type->node?

Me either, but as you noticed, type was taken. Your suggestions seem
fine. We could also just do away with the macro as discussed earlier (we
already do in the commit_node case, anyway...).

-Peff
