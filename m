From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git send-email: include [anything]-by: signatures
Date: Tue, 3 Sep 2013 17:03:52 -0400
Message-ID: <20130903210352.GA27344@sigill.intra.peff.net>
References: <20130826165747.GA30788@redhat.com>
 <20130831192250.GA3823@redhat.com>
 <20130903063535.GA3608@sigill.intra.peff.net>
 <20130903084454.GC18901@redhat.com>
 <xmqqmwntu96c.fsf@gitster.dls.corp.google.com>
 <20130903210149.GA24480@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 23:04:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGxlX-0007Jn-6X
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 23:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab3ICVDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 17:03:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:58385 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab3ICVDz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 17:03:55 -0400
Received: (qmail 28755 invoked by uid 102); 3 Sep 2013 21:03:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Sep 2013 16:03:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Sep 2013 17:03:52 -0400
Content-Disposition: inline
In-Reply-To: <20130903210149.GA24480@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233780>

On Wed, Sep 04, 2013 at 12:01:49AM +0300, Michael S. Tsirkin wrote:

> > The question of course is the first point Peff raised.  I am not
> > sure offhand what the right per-project customization interface
> > would be.  A starting point might be something like:
> > 
> > 	--cc-trailer=signed-off-by,acked-by,reviewed-by
> 
> tested-by, reported-by ...

Yeah, I think having the list customizable is nice, but not allowing
some pattern matching seems unfriendly, as it requires the user to
enumerate a potentially long list.

> > 	--cc-trailer='*-by'
> > 
> > and an obvious configuration variable that gives the default for it.
> > That would eventually allow us not to special case any fixed set of
> > trailers like S-o-b like the current code does, which would be a big
> > plus.
> 
> What bothers me is that git normally uses gawk based patterns,
> but send-email is in perl so it has a different syntax for regexp.
> What do you suggest?  Make a small binary to do the matching for us?

Would fnmatch-style globbing (like "*-by") be enough? That should be
easy to do in perl.

-Peff
