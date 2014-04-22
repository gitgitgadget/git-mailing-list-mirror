From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: What is missing from Git v2.0
Date: Tue, 22 Apr 2014 17:30:39 -0400
Message-ID: <20140422213039.GB21043@thunk.org>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
 <xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
 <CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
 <xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
 <5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 23:30:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WciHG-0005aO-2r
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 23:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbaDVVar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 17:30:47 -0400
Received: from imap.thunk.org ([74.207.234.97]:54925 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758452AbaDVVan (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 17:30:43 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1WciH2-0005KE-KP; Tue, 22 Apr 2014 21:30:40 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id D5E9E580922; Tue, 22 Apr 2014 17:30:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=thunk.org; s=ef5046eb;
	t=1398202239; bh=GHjbkvYBetlCXmWyhu8ZB5sFS9wbORm7VFFK2EWii04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I06SmxqsN2ADuaLOcMbW09BjzAvC6Nq+noJRcWAwpxo5HLjoOOAgYB1HmqE+YeY9/
	 yZ19TaPGxRnuxxWUiq2jc5OjsajwDG/3/ZmhYD5E7ZNgPMi68caAnzKK85Wlaegjc1
	 goLnbWLuTQyWiaPyVwS5Lukv/PygQiftwgmf1QII=
Content-Disposition: inline
In-Reply-To: <5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246789>

On Tue, Apr 22, 2014 at 02:23:18PM -0500, Felipe Contreras wrote:
> > I am not fundamentally opposed.  I just do not think it would add
> > much value to new people at this point, and it will actively hurt
> > if we shoved barely cooked one in 2.0.
> 
> You are probably biased in that you've used Git far much more than
> the average user has (or future new users).

I think Junio has a really strong point.  If the goal is to make life
easier for new users, allowing them to save a few keystrokes is
probably not the most significant thing we can do.  And we have to
balance this with the additional cognitive load in remembering how a
particular two character alias maps to the "real" command.  This is
especially true for commands which might not be used as often -- e.g.,
"rebase", and for commands where the meaning of "git commit" without
any argument is qualitatively different from what "ci" (for checkin)
means in most other source management systems.

So I do think it's worth thinking about this very carefully.  For
certain, I would **not** recommend using shortcuts in example command
sequences.  If the user reads "git rebase" or "git cherry-pick" it
means a lot more than if they see a series of apparent chicken
scratches filled with things like "git rb", "git pi", "git st", etc.

In fact, to be fair, you may be getting biased because you're used to
using the two character shortcuts, so for you, of *course* "rb" and
"pi" and "ci" make a lot of sense.  But for someone who is starting
from scratch, I really question how much it helps, and how much it
might hurt, to see the two character shortcuts or even to have to
remember the two character shortcuts.  And for a command like "rebase"
where the user can very easily shoot themselves in the foot to begin
with, I'd actually suggest that it's a _good_ thing that they have to
type it out in full.

						- Ted
