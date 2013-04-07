From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 7 Apr 2013 18:02:01 +0100
Message-ID: <20130407170201.GH2222@serenity.lan>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com>
 <7v61zz9fu3.fsf@alter.siamese.dyndns.org>
 <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org>
 <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
 <20130407161209.GG2222@serenity.lan>
 <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 19:02:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOsyu-0004KE-5m
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934062Ab3DGRCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:02:12 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:47927 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934058Ab3DGRCL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:02:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id E5F31161E1B6;
	Sun,  7 Apr 2013 18:02:10 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zEIswRhJi0Mz; Sun,  7 Apr 2013 18:02:10 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 7096A161E0F0;
	Sun,  7 Apr 2013 18:02:03 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220330>

On Sun, Apr 07, 2013 at 10:12:28PM +0530, Ramkumar Ramachandra wrote:
> John Keeping wrote:
> > Meaning that every repository using submodules need to have a flag day
> > when all of the people using it switch to the new Git version at once?
> 
> No, I would be totally against a migration that involves a flag-day.
> What I meant is that having old-style submodule side-by-side with
> new-style submodules is confusing (think about people using an older
> version and getting confused), and that we should disallow it.  Users
> will still be able to use existing repositories with new versions of
> git with a few caveats:
> 1. They won't be able to add new new submodules without migrating all
> existing submodules.
> 2. git ls-tree will show the in-tree object incorrectly as a link (ie.
> not commit).
> 
> That's about it, I think.  Obviously, everyone working on the
> repository has to upgrade to a new version of git before they can use
> new-style submodules.

So not a flag day, but still some point at which the repository
transitions to "will not work with Git older than version X".  And if
you need to add a new submodule then you cannot delay that transition
any longer.

> > I think you need a much better argument than "it makes the
> > implementation more beautiful" to convince users that a flag day is
> > necessary.
> 
> There is no flag day necessary, and that is not my argument at all:
> new-style submodules brings lots of new functionality to the table.

I haven't seen anywhere a concise list of what functionality this is.
Do you have a simple bulleted list of what new features this would
allow?
