From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] git send-email: include [anything]-by: signatures
Date: Wed, 4 Sep 2013 00:24:32 +0300
Message-ID: <20130903212432.GC24480@redhat.com>
References: <20130826165747.GA30788@redhat.com>
 <20130831192250.GA3823@redhat.com>
 <20130903063535.GA3608@sigill.intra.peff.net>
 <20130903084454.GC18901@redhat.com>
 <xmqqmwntu96c.fsf@gitster.dls.corp.google.com>
 <20130903210149.GA24480@redhat.com>
 <20130903210352.GA27344@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 03 23:23:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGy4A-00060d-MM
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 23:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761306Ab3ICVXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 17:23:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37159 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760899Ab3ICVXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 17:23:09 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r83LMUxL014773
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 3 Sep 2013 17:22:30 -0400
Received: from redhat.com (vpn1-6-201.ams2.redhat.com [10.36.6.201])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r83LMS0a020485;
	Tue, 3 Sep 2013 17:22:29 -0400
Content-Disposition: inline
In-Reply-To: <20130903210352.GA27344@sigill.intra.peff.net>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233782>

On Tue, Sep 03, 2013 at 05:03:52PM -0400, Jeff King wrote:
> On Wed, Sep 04, 2013 at 12:01:49AM +0300, Michael S. Tsirkin wrote:
> 
> > > The question of course is the first point Peff raised.  I am not
> > > sure offhand what the right per-project customization interface
> > > would be.  A starting point might be something like:
> > > 
> > > 	--cc-trailer=signed-off-by,acked-by,reviewed-by
> > 
> > tested-by, reported-by ...
> 
> Yeah, I think having the list customizable is nice, but not allowing
> some pattern matching seems unfriendly, as it requires the user to
> enumerate a potentially long list.
> 
> > > 	--cc-trailer='*-by'
> > > 
> > > and an obvious configuration variable that gives the default for it.
> > > That would eventually allow us not to special case any fixed set of
> > > trailers like S-o-b like the current code does, which would be a big
> > > plus.
> > 
> > What bothers me is that git normally uses gawk based patterns,
> > but send-email is in perl so it has a different syntax for regexp.
> > What do you suggest?  Make a small binary to do the matching for us?
> 
> Would fnmatch-style globbing (like "*-by") be enough? That should be
> easy to do in perl.
> 
> -Peff

If you mean only support * - that would be easy.
Once you get into bracket expressions it gets messy quickly
http://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap09.html#tag_09_03_05

-- 
MST
