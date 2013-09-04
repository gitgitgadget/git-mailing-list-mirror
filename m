From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] git send-email: include [anything]-by: signatures
Date: Wed, 4 Sep 2013 11:09:28 +0300
Message-ID: <20130904080928.GA30491@redhat.com>
References: <20130826165747.GA30788@redhat.com>
 <20130831192250.GA3823@redhat.com>
 <20130903063535.GA3608@sigill.intra.peff.net>
 <20130903084454.GC18901@redhat.com>
 <xmqqmwntu96c.fsf@gitster.dls.corp.google.com>
 <20130903210149.GA24480@redhat.com>
 <20130903210352.GA27344@sigill.intra.peff.net>
 <xmqqk3ixpoue.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 10:07:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH87t-00010f-Gh
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 10:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321Ab3IDIHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 04:07:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39360 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756051Ab3IDIHc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 04:07:32 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8487Q3J003871
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 4 Sep 2013 04:07:27 -0400
Received: from redhat.com (vpn1-7-190.ams2.redhat.com [10.36.7.190])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r8487OC3026779;
	Wed, 4 Sep 2013 04:07:25 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk3ixpoue.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233817>

On Tue, Sep 03, 2013 at 02:39:05PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Sep 04, 2013 at 12:01:49AM +0300, Michael S. Tsirkin wrote:
> >
> >> > The question of course is the first point Peff raised.  I am not
> >> > sure offhand what the right per-project customization interface
> >> > would be.  A starting point might be something like:
> >> > 
> >> > 	--cc-trailer=signed-off-by,acked-by,reviewed-by
> >> 
> >> tested-by, reported-by ...
> >
> > Yeah, I think having the list customizable is nice, but not allowing
> > some pattern matching seems unfriendly, as it requires the user to
> > enumerate a potentially long list.
> >
> >> > 	--cc-trailer='*-by'
> >> > 
> >> > and an obvious configuration variable that gives the default for it.
> >> > That would eventually allow us not to special case any fixed set of
> >> > trailers like S-o-b like the current code does, which would be a big
> >> > plus.
> >> 
> >> What bothers me is that git normally uses gawk based patterns,
> >> but send-email is in perl so it has a different syntax for regexp.
> >> What do you suggest?  Make a small binary to do the matching for us?
> >
> > Would fnmatch-style globbing (like "*-by") be enough? That should be
> > easy to do in perl.
> 
> Web query finds File::FnMatch; I do not know if that is the most
> commonly used, or if it comes with the base distribution, though.

It's also just a wrapper for the system's fnmatch - so I expect
it doesn't work in the mingw environment.

-- 
MST
