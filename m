From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] pull: require choice between rebase/merge on
 non-fast-forward pull
Date: Tue, 2 Jul 2013 22:18:20 +0100
Message-ID: <20130702211820.GD9161@serenity.lan>
References: <20130523164114.GV27005@serenity.lan>
 <7vbo81e7gs.fsf@alter.siamese.dyndns.org>
 <20130523215557.GX27005@serenity.lan>
 <7vli75cpom.fsf@alter.siamese.dyndns.org>
 <CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
 <7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
 <20130628080953.GD2232@serenity.lan>
 <7vli5up2tq.fsf@alter.siamese.dyndns.org>
 <20130628174252.GF2232@serenity.lan>
 <7vvc4xluxt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 23:18:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu7yA-0001e8-Ff
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 23:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816Ab3GBVSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 17:18:35 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:40745 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510Ab3GBVSe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 17:18:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A7515CDA5DB;
	Tue,  2 Jul 2013 22:18:33 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c4agM43EwdKH; Tue,  2 Jul 2013 22:18:31 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id F1672CDA597;
	Tue,  2 Jul 2013 22:18:30 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id E056B161E452;
	Tue,  2 Jul 2013 22:18:30 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wch2iyN3IIRS; Tue,  2 Jul 2013 22:18:29 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id A2078161E424;
	Tue,  2 Jul 2013 22:18:22 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vvc4xluxt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229432>

On Fri, Jun 28, 2013 at 03:41:34PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> >> Here, "git pull . branch1" is merely saying "I want to integrate
> >> the work on my current branch with that of branch1" without saying
> >> how that integration wants to happen.
> >
> > The change that I think is important is that the "bring my branch
> > up-to-date" operation should force the user to choose what to do if the
> > branch does not fast-forward to its upstream.  If that was spelled "git
> > update" then having "git pull" perform a merge would be fine, but we
> > spell this operation as "git pull" so the change needs to happen there.
> 
> I am not sure I quite get what you want to say with "git update",
> and I am not sure if I necessarily want to know---I do not think we
> would want to add yet another command that DWIMs for certain _I_,
> that may not match newbie expectations.

I wasn't proposing any new command, I was trying to express the
operation that users coming from non-distributed VCSs want to perform
(which is called "update" in svn).  The problem is that a DVCS operates
in a completely different way and a lot of users do not seem to want to
learn the difference but simply try to map the existing commands that
they know onto Git commands ([1] is the top result for "svn commands to
git" on Google and maps "svn update" straight to "git pull").

[1] http://git.or.cz/course/svn.html

> > I don't think "git pull remote branch" falls into the same category as
> > plain "git pull" so I'm not convinced that defaulting to merge there is
> > unreasonable.  The original message about this [1] did talk about only
> > "git pull" with no arguments.
> 
> If you want to limit the scope to only "git pull" (without any
> command line argument), I actually do not have strong preference for
> or against it either way.  Perhaps a follow-up patch to be squashed?

I remember looking at this a few weeks ago and being concerned that it's
impossible to tell what options you actually have in git-pull because it
just invokes 'git fetch "$@"' and git-pull(1) does advertise a number of
fetch options.  It may be that "test $# = 0" is good enough, but ideally
I want to test for non-option arguments.

I can't see a way of doing this without putting knowledge of all of the
fetch options in git-pull so that we can handle options with arguments
correctly.
