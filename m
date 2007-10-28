From: Scott Parish <sRp@srparish.net>
Subject: Re: [PATCH 6/7] walk $PATH to generate list of commands for "help -a"
Date: Sun, 28 Oct 2007 04:15:18 -0700
Message-ID: <20071028111517.GB7749@srparish.net>
References: <1193474215-6728-1-git-send-email-srp@srparish.net> <1193474215-6728-2-git-send-email-srp@srparish.net> <1193474215-6728-3-git-send-email-srp@srparish.net> <1193474215-6728-4-git-send-email-srp@srparish.net> <1193474215-6728-5-git-send-email-srp@srparish.net> <1193474215-6728-6-git-send-email-srp@srparish.net> <7vsl3vzrs5.fsf@gitster.siamese.dyndns.org> <20071028094530.GA7749@srparish.net> <7vodejv9gt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 12:15:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im67H-0002bs-82
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 12:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbXJ1LPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 07:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754130AbXJ1LPY
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 07:15:24 -0400
Received: from smtp-gw51.mailanyone.net ([208.70.128.77]:47245 "EHLO
	smtp-gw51.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027AbXJ1LPW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 07:15:22 -0400
Received: from mailanyone.net
	by smtp-gw51.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1Im66x-00075K-6W; Sun, 28 Oct 2007 06:15:19 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 501
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Sun, 28 Oct 2007 04:15:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vodejv9gt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62554>

On Sun, Oct 28, 2007 at 03:07:14AM -0700, Junio C Hamano wrote:

> Scott Parish <sRp@srparish.net> writes:
> 
> > On Sat, Oct 27, 2007 at 11:18:02PM -0700, Junio C Hamano wrote:
> >
> >> > We walk all the paths in $PATH collecting the names of "git-*"
> >> > commands. To help distinguish between the main git commands
> >> > and commands picked up elsewhere (probably extensions) we
> >> > print them seperately. The main commands are the ones that
> >> > are found in the first directory in $PATH that contains the
> >> > "git" binary.
> >> ...
> > Its not clear to me what exactly you're looking for me to change,
> > just the wording i'm using in my comment? Or are you refering to
> > the approach?
> 
> "git" binary will be found as /usr/bin/git while git-foo will be
> found as /usr/libexec/git/git-foo in such an installation that
> takes advantage of $(gitexecdir).  And /usr/libexec/git/git will
> not exist.  Using existence of /usr/bin/git (I am referring to
> your 'first directory on $PATH that contains the "git" binary'
> above) as the cue for the location of "main commands" is wrong.

Thanks for the clarification, that would be a problem. I've modified
the patch to list the main commands from git_exec_path(); i have
mixed feelings, but curious what you think.

sRp

-- 
Scott Parish
http://srparish.net/
