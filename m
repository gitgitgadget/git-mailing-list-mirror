From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 09:41:06 -0400
Message-ID: <20140424134106.GA27035@thunk.org>
References: <5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
 <20140422213039.GB21043@thunk.org>
 <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
 <53588713347b7_59ed83d308cf@nysa.notmuch>
 <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
 <53588f448d817_59ed83d3084e@nysa.notmuch>
 <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, James Denholm <nod.helm@gmail.com>,
	David Lang <david@lang.hm>, Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 15:41:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdJty-0004kP-UY
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 15:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbaDXNlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 09:41:19 -0400
Received: from imap.thunk.org ([74.207.234.97]:58733 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753979AbaDXNlR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 09:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=kvxj3/L0kTuvXPmJe2IVgVllOLJw0s4GKMSVHN4pEjQ=;
	b=b+wft1hCT+MW3QX19Nuv7KXYYCKXN2mJ48yU+a3pfHEXcqjgGzfKCFsOrUOe1W/3lHr07xOOqP5NBYWBKLNMHboo009awaM2gTdiSv1GlfYyXfmvTaCoDsTW2d4sZ3TKGQ0AJ1rBVSfLw2YbmLWfCZPoeG0Gggtn1j+FPVcl54k=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1WdJtj-00018t-6e; Thu, 24 Apr 2014 13:41:07 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 300105804B7; Thu, 24 Apr 2014 09:41:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246969>

On Thu, Apr 24, 2014 at 03:23:54AM -0500, Felipe Contreras wrote:
> 
> There is evidence for the claim that there won't be those problems. You have
> absolutely no evidence there there will.

Felipe,

It's clear that you've not been able to produce evidence that can
convince most of the people on this thread.  Simply repeating the same
assertions over and over again, in a shrill fashion, is not likely to
convince those of us who that this would not be a good idea for git
v2.0.

Creating a ~/.gitconfig file if one doesn't already is one I agree
with, and at least on Unix systems, telling them that the config file
lives in ~/.gitconfig, or where ever it might happen to be on other
platforms, is a good one.  If it's in some really weird place on
Windows, then sure, we can tell them about "git config -e".  But the
point is to let the user look at the default .gitconfig file, where we
can put in comments to help explain what is going on, and perhaps have
links to web pages for more information.

I don't even think we need to query the user to fill out all of the
fields.  We can prepopulate a lot of the fields (name, e-mail address,
etc.) from OS specific defaults that are available on most systems ---
specifically, the default values we would use the name and e-mail
address are not specified in a config file.

We can just tell the user that we have created a default .gitconfig
file, and tell them how they can take a look at it.

In the long term, if the worry is how to bridge the gap between
complete newbies, one way of dealing with this is to have a tutorial
mode (off by default, on in the default .gitconfig) which despenses
some helpful hints at certain strategic points (i.e., after five
commits, give a message that introduces git log --oneline, after the
third merge commit is created by the user, give a message which
introduces git log --merge, and so on).  The challenge is not strawing
over the line to the point where the hints become as annoying as
"clippy", but that is what UX labs are for, to tune the experience for
completely new users to git.

Without doing a formal UX experiment, all of us are going to making
assertions without formal evidence --- at best some of us who have
tutored a few newbies might have some anecdates, but remember the old
saying about the plural of anecdote not being data.

Cheers,

						- Ted
