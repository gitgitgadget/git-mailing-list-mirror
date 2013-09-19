From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 19 Sep 2013 18:05:31 -0400
Message-ID: <20130919220531.GA13723@sigill.intra.peff.net>
References: <523094F0.9000509@gmail.com>
 <20130911182921.GE4326@google.com>
 <20130911191620.GB24251@sigill.intra.peff.net>
 <CAA01CsrN+VLw4WQmObvh72_MoH1Lyh9dQbizJcVhqyJoRyms-Q@mail.gmail.com>
 <CAPc5daVt4Q9twub5KyOQqZHx9CwOnkuwA97sXV44fF2j1e5HVg@mail.gmail.com>
 <CAA01CspCWFMGxXs9M3A1mtTctiUCCeJ9pJjHt=auMjhHHJU3Dg@mail.gmail.com>
 <20130919211659.GB16556@sigill.intra.peff.net>
 <xmqqy56sqxj1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 00:05:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMmM5-0002Ci-JT
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 00:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781Ab3ISWFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 18:05:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:38801 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696Ab3ISWFl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 18:05:41 -0400
Received: (qmail 7531 invoked by uid 102); 19 Sep 2013 22:05:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Sep 2013 17:05:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Sep 2013 18:05:31 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy56sqxj1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235034>

On Thu, Sep 19, 2013 at 03:03:46PM -0700, Junio C Hamano wrote:

> >> But only when someone compiles on MinGW, no?
> >
> > Yeah. I think a more clear way to phrase the question would be: is there
> > some trick we can use to booby-trap strcasecmp as a function pointer so
> > that it fails to compile even on systems where it would otherwise work?
> 
> That line of thought nudges us toward the place Linus explicitly
> said he didn't want to see us going, no?  We do not particularly
> want to care the exact nature of the breakage on MinGW.  Do we
> really want to set a booby-trap that intimately knows about how
> their strcasecmp is broken, and possibly cover breakages of the same
> kind but with other functions?

Exactly. You snipped my second paragraph, but the gist of it was "...and
no, we do not want to go there". Calling it a booby-trap was meant to be
derogatory. :)

-Peff
