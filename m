From: Philippe De Muyter <phdm@macq.eu>
Subject: Re: identical hashes on two branches, but holes in git log
Date: Thu, 21 May 2015 09:15:18 +0200
Message-ID: <20150521071518.GA8675@frolo.macqel>
References: <20150519132958.GA21130@frolo.macqel> <xmqq617oa75l.fsf@gitster.dls.corp.google.com> <20150519214719.GA12732@frolo.macqel> <xmqqiobop67k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 09:15:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvKhf-00023m-VX
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 09:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755388AbbEUHPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 03:15:24 -0400
Received: from smtp2.macqel.be ([109.135.2.61]:54558 "EHLO smtp2.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754413AbbEUHPV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 03:15:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp2.macqel.be (Postfix) with ESMTP id 71536130DAD;
	Thu, 21 May 2015 09:15:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mbGi8PzAGsxB; Thu, 21 May 2015 09:15:18 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by smtp2.macqel.be (Postfix) with ESMTP id D1C5B130CBF;
	Thu, 21 May 2015 09:15:18 +0200 (CEST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id B696FDF06BF; Thu, 21 May 2015 09:15:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqiobop67k.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269564>

On Tue, May 19, 2015 at 03:12:31PM -0700, Junio C Hamano wrote:
> Philippe De Muyter <phdm@macq.eu> writes:
> 
> > On Tue, May 19, 2015 at 09:01:10AM -0700, Junio C Hamano wrote:
> >> Philippe De Muyter <phdm@macq.eu> writes:
> >> 
> >> > Trying to understand, I have eventually done "git log" on my branch and
> >> > on v3.15 with the following commands :
> >> >
> >> > git log v3.15 --full-history --decorate=short | grep '^commit' > /tmp/3.15.commits
> >> > git log --full-history --decorate=short | grep '^commit' > /tmp/mybranch.commits
> >> 
> >> Either
> >> 
> >>     git log --oneline v3.15..HEAD ;# show what I have not in theirs
> >> 
> >> or
> >> 
> >>     gitk v3.15...HEAD ;# show our differences graphically
> >
> > This shows the commits in my branch starting from the most recent common point,
> > thus my commits, but I see differences in the files not explained by my commits,
> > but by the fact that many older commits (between v3.13 and v3.14) are missing on
> > my branch, but still in both branches I have a commit called v3.14 with the
> > same hash.  Is that normal ?
> 
> Sorry, cannot parse.  Neither of the above would show files, so just
> about the place where you start talking about "I see differences in
> the files", you lost me.

Look at the other part of the thread, with the discussion with Jeff and John

The light has come, and what I understand is:

	 don't trust the default (ordering) mode of 'git log' :(

I surmise this happens only when 'git merge' has been used.

Philippe
