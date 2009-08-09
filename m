From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] merge: indicate remote tracking branches in merge
 message
Date: Sun, 9 Aug 2009 17:49:12 -0400
Message-ID: <20090809214911.GA27796@coredump.intra.peff.net>
References: <20090809065936.GA24112@coredump.intra.peff.net>
 <7vab29a1fr.fsf@alter.siamese.dyndns.org>
 <20090809074035.GA4778@coredump.intra.peff.net>
 <20090809091443.GA676@coredump.intra.peff.net>
 <20090809100045.GA25197@coredump.intra.peff.net>
 <20090809100712.GA26250@coredump.intra.peff.net>
 <7vprb47pam.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 23:49:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaGGW-0005pj-OC
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 23:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbZHIVtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 17:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753700AbZHIVtM
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 17:49:12 -0400
Received: from peff.net ([208.65.91.99]:45854 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753624AbZHIVtM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 17:49:12 -0400
Received: (qmail 9366 invoked by uid 107); 9 Aug 2009 21:51:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 17:51:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 17:49:12 -0400
Content-Disposition: inline
In-Reply-To: <7vprb47pam.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125389>

On Sun, Aug 09, 2009 at 12:36:17PM -0700, Junio C Hamano wrote:

> > Previously, merging a tag directly via "git merge tag" would
> > get you the message "Merge commit 'tag'". It is a little
> > more descriptive to note that it was actually a tag (i.e.,
> > "Merge tag 'tag'").
> 
> Maybe "Merge version 'v1.6.3'" or "Merge commit tagged as 'v1.6.3'"? 
> I dunno.

Definitely "Merge version" is bad. Doing "git tag feature-x-working" and
merging it would lead to "Merge version 'feature-x-working'", which
doesn't really make sense. I don't think the developer would refer to
such a tag as a "version".

Your "Merge commit tagged as..." version is reasonable to me. I'm
dubious whether the additional information that it was a tag is actually
worth anything. That is, given

  (1) Merge commit '1234abcd'
  (2) Merge commit 'v1.6.3'
  (3) Merge tag 'v1.6.3'

where (1) is what we do now and will do in the future for arbitrary
commits, (2) is what we do now for tags, and (3) is the proposed change.
I am not sure that (3) really tells the reader anything useful over the
other two. And your "Merge commit tagged as" is just the same
information written slightly differently.

So maybe this patch should simply be dropped. I don't feel strongly
either way.

-Peff
