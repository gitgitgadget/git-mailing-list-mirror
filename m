From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] patch-ids.c: cache patch IDs in a notes tree
Date: Mon, 13 May 2013 15:02:43 +0100
Message-ID: <20130513140243.GQ2299@serenity.lan>
References: <9d9e56d323b40fe9ea2a6484e35f0afcd3a3a85b.1368301939.git.john@keeping.me.uk>
 <CA+55aFyn0+Q4CA6yQZipaCRB0w9cW4YpuL3XuxU2JR5QPp98XQ@mail.gmail.com>
 <20130511214900.GF2299@serenity.lan>
 <CA+55aFzinmXA2HtA3hmN1VVOcLPWedfqJRws0RJMEc1By1VLLg@mail.gmail.com>
 <7v1u9cx5pf.fsf@alter.siamese.dyndns.org>
 <20130512085934.GG2299@serenity.lan>
 <7v1u9bvo1m.fsf@alter.siamese.dyndns.org>
 <20130513075906.GP2299@serenity.lan>
 <7vzjvzoujq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 16:02:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbtL7-0003Yq-EB
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 16:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375Ab3EMOCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 10:02:53 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:49590 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab3EMOCw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 10:02:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 4DD5E606597;
	Mon, 13 May 2013 15:02:52 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pf1zFDaqNjzi; Mon, 13 May 2013 15:02:52 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 47987606593;
	Mon, 13 May 2013 15:02:45 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vzjvzoujq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224148>

On Mon, May 13, 2013 at 06:53:29AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > The caching layer could also introduce false positives though, which is
> > more serious.  If you cache patch IDs with a pathspec restriction ...
> 
> What?  What business does patch-id have with pathspec-limited diff
> generation?  You do not rebase or cherry-pick with pathspec, so
> unless you are populating the patch-id cache at a wrong point (like,
> say whenevern "git show $commit" is run), I am not sure why pathspec
> limit becomes even an issue.

revision.c::cherry_pick_list() sets the pathspec to what was specified
in the revision options.  It's done that since commit 36d56de (Fix
--cherry-pick with given paths, 2007-07-10) and t6007 tests that it
works.
