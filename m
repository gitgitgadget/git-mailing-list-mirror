From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/5] pretty: make %H/%h/etc respect --abbrev[-commit]
Date: Sun, 2 May 2010 01:40:04 -0400
Message-ID: <20100502054004.GA19267@coredump.intra.peff.net>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
 <1272656128-2002-3-git-send-email-wmpalmer@gmail.com>
 <7vocgzyp1f.fsf@alter.siamese.dyndns.org>
 <20100502044506.GA14776@coredump.intra.peff.net>
 <7v39yazx4i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	raa.lkml@gmail.com, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 02 07:40:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Ruf-0001N0-Qq
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 07:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552Ab0EBFkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 01:40:06 -0400
Received: from peff.net ([208.65.91.99]:33436 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124Ab0EBFkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 01:40:06 -0400
Received: (qmail 3902 invoked by uid 107); 2 May 2010 05:40:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 02 May 2010 01:40:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 May 2010 01:40:04 -0400
Content-Disposition: inline
In-Reply-To: <7v39yazx4i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146138>

On Sat, May 01, 2010 at 10:33:01PM -0700, Junio C Hamano wrote:

> >> > Here we make "git log --pretty=%H --abbrev-commit" synonymous with
> >> > "git log --pretty=%h", and make %h/abbreviated-%H respect the length
> >> > specified for --abbrev.
> >> 
> >> I think it is a good change to make %h follow --abbrev, but %H should stay
> >> the full length no matter what (otherwise why would anybody use %H not %h?).
> >
> > But I thought the point of %h was to be abbreviated? If it follows
> > --abbrev, then "git log --format=%h" would show the full sha1, no?
> 
> Sorry, but I meant that the point of %h was to be abbreviated and the
> point of %H was not to be abbreviated.  So no matter whaqt --abbrev-commit
> says on the command line, --format=%H should show the full commit object
> name.

Ah, I see. So the change you called "good" above was that %h should
respect --abbrev=10, but keep the same default?

I do think that's an improvement, but it discards what Will was trying
to accomplish (a placeholder that behaves different depending on whether
abbreviation has been requested). I guess we would need a new syntax for
that.

-Peff
