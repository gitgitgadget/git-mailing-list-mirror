From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH 6/7] walk $PATH to generate list of commands for "help -a"
Date: Sun, 28 Oct 2007 02:45:31 -0700
Message-ID: <20071028094530.GA7749@srparish.net>
References: <1193474215-6728-1-git-send-email-srp@srparish.net> <1193474215-6728-2-git-send-email-srp@srparish.net> <1193474215-6728-3-git-send-email-srp@srparish.net> <1193474215-6728-4-git-send-email-srp@srparish.net> <1193474215-6728-5-git-send-email-srp@srparish.net> <1193474215-6728-6-git-send-email-srp@srparish.net> <7vsl3vzrs5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 10:45:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im4iO-0008Lk-21
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 10:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbXJ1Jpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 05:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbXJ1Jpi
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 05:45:38 -0400
Received: from smtp-gw6.mailanyone.net ([208.70.128.57]:39528 "EHLO
	smtp-gw6.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbXJ1Jph (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 05:45:37 -0400
Received: from mailanyone.net
	by smtp-gw6.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1Im4i4-0007dL-Jz; Sun, 28 Oct 2007 04:45:35 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 501
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Sun, 28 Oct 2007 02:45:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsl3vzrs5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62543>

On Sat, Oct 27, 2007 at 11:18:02PM -0700, Junio C Hamano wrote:

> > We walk all the paths in $PATH collecting the names of "git-*"
> > commands. To help distinguish between the main git commands
> > and commands picked up elsewhere (probably extensions) we
> > print them seperately. The main commands are the ones that
> > are found in the first directory in $PATH that contains the
> > "git" binary.
> 
> This is not right.  $(gitexecdir) in Makefile is designed to
> allow distros to move git-* commands out of the primary user
> $PATH directories and install only "git" wrapper in /usr/bin.
> "Use the directory 'git' is in" rule breaks this.
> 
> The "main commands" should be the first of argv_exec_path,
> EXEC_PATH_ENVIRONMENT or builtin_exec_path.

This is after we've already prepended the above three paths (if
they're specified) to $PATH, so yes, generally they should be in
one of those directories, but more generally, it will be in one of
the directories in $PATH.

Its not clear to me what exactly you're looking for me to change,
just the wording i'm using in my comment? Or are you refering to
the approach?

When i email the changes, should i keep emailing the whole
patch series, or just the few patches that have changed?

Thanks
sRp

-- 
Scott Parish
http://srparish.net/
