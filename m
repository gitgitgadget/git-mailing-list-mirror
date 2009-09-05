From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Sat, 5 Sep 2009 02:28:46 -0400
Message-ID: <20090905062846.GD29863@coredump.intra.peff.net>
References: <7vy6oy9z9r.fsf@alter.siamese.dyndns.org>
 <200909012325.45739.j6t@kdbg.org>
 <7vtyzmxkpr.fsf@alter.siamese.dyndns.org>
 <20090902011513.GA3874@coredump.intra.peff.net>
 <7vmy5egefh.fsf@alter.siamese.dyndns.org>
 <20090902051248.GB12046@coredump.intra.peff.net>
 <7vljkxdiil.fsf@alter.siamese.dyndns.org>
 <20090902100730.GA18226@gmail.com>
 <20090902175908.GA5998@coredump.intra.peff.net>
 <20090903011234.GA7415@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 08:29:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjoli-00016Y-HZ
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 08:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbZIEG2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 02:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbZIEG2r
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 02:28:47 -0400
Received: from peff.net ([208.65.91.99]:40481 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbZIEG2r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 02:28:47 -0400
Received: (qmail 25263 invoked by uid 107); 5 Sep 2009 06:29:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 02:29:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 02:28:46 -0400
Content-Disposition: inline
In-Reply-To: <20090903011234.GA7415@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127782>

On Wed, Sep 02, 2009 at 06:12:36PM -0700, David Aguilar wrote:

> The only use case would be for --amend.
> Which is why I asked about --porcelain; really what I want is
> something like
> 
> 	git status --porcelain HEAD^
> 
> Rolling a patch to make --porcelain an alias for --short seems
> like a good idea.  If we want to support HEAD^ and HEAD^ only
> then perhaps an --amend flag is useful.
> 
> The real crux of my question was about being able to script
> it, which is why commit --dry-run is not enough.

I see. I still think you may want to improve "commit --dry-run" with a
plumbing format, though, instead of "git status". Then it would
automagically support "--amend", as well as other dry-run things (e.g.,
"git commit --dry-run --porcelain --amend foo.c"). And not having looked
at the code, I would guess it is a one-liner patch to switch the "output
format" flag that commit passes to the wt-status.c code.

-Peff
