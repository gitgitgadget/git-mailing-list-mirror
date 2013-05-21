From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] contrib/git-subtree: Use /bin/sh interpreter instead of
 /bin/bash
Date: Tue, 21 May 2013 08:55:05 +0100
Message-ID: <20130521075505.GN27005@serenity.lan>
References: <20130520202434.GA3151@hades.panopticon>
 <7vsj1hth11.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Marakasov <amdmi3@amdmi3.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 09:55:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UehPm-0002qI-SF
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 09:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab3EUHzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 03:55:16 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:50946 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab3EUHzP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 03:55:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 5CE8FCDA5B9;
	Tue, 21 May 2013 08:55:14 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B1RXL7uneqQ8; Tue, 21 May 2013 08:55:12 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id EC19C866001;
	Tue, 21 May 2013 08:55:07 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vsj1hth11.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225022>

On Mon, May 20, 2013 at 03:36:58PM -0700, Junio C Hamano wrote:
> Dmitry Marakasov <amdmi3@amdmi3.ru> writes:
> 
> > Use /bin/sh interpreter instead of /bin/bash for contrib/git-subtree:
> > it's required for systems which don't use bash by default (for example,
> > FreeBSD), while there seem to be no bashisms in the script (confirmed
> > by looking through the source and tesing subtree functionality with
> > FreeBSD's /bin/sh) to require specifically bash and not the generic
> > posix shell.
> 
> Has anybody audited to make sure that the script itself is free of
> bash-isms?
> 
> I somehow had an impression that in the past it was littered with
> bash-isms like function local variables and array variables and
> assumed that the #!/bin/bash was necessary.  I did a quick
> eyeballing and did not see anything glaringly bash-only, but I may
> have missed something (the coding style is so different from the
> core part of Git Porcelains and distracting for me to efficiently
> do a good job of scanning).

I ran the test suite with dash and everything passed.

checkbashisms doesn't find any problems either.

> >
> > Signed-off-by: Dmitry Marakasov <amdmi3@amdmi3.ru>
> > ---
> >  contrib/subtree/git-subtree.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> > index 8a23f58..5701376 100755
> > --- a/contrib/subtree/git-subtree.sh
> > +++ b/contrib/subtree/git-subtree.sh
> > @@ -1,4 +1,4 @@
> > -#!/bin/bash
> > +#!/bin/sh
> >  #
> >  # git-subtree.sh: split/join git repositories in subdirectories of this one
> >  #
