From: Theodore Tso <tytso@mit.edu>
Subject: Re: Git vs Monotone
Date: Thu, 31 Jul 2008 15:24:05 -0400
Message-ID: <20080731192405.GC20819@mit.edu>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Jul 31 21:25:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOdlx-0006Fm-At
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 21:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbYGaTYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 15:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbYGaTYL
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 15:24:11 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:37242 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751146AbYGaTYK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 15:24:10 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KOdks-0001ej-79; Thu, 31 Jul 2008 15:24:06 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KOdkr-0005o7-KW; Thu, 31 Jul 2008 15:24:05 -0400
Content-Disposition: inline
In-Reply-To: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90972>

On Thu, Jul 31, 2008 at 08:13:59PM +0200, Sverre Rabbelier wrote:
> 
> I just read this blog post [0] in which one of the Pidgin devs sheds
> his light on their 'tool choice'. In the post he mentions the
> following figures:

The main thing this proves was that the Pidgin devs were most familiar
with Monotone, and weren't sufficiently familiar with git; hence, they
didn't know how to do a fair comparison.  First of all, sure, if they
are willing to use a single working directory and want to switch
between branches using "git checkout", that works well.  But suppose
they really want separate working directories.  The simplist and
easist way is to use "git clone -s".

So if they do:

git clone git://github.com/felipec/pidgin-clone.git pidgin
git clone -s pidgin clone-1
git clone -s pidgin clone-2
git clone -s pidgin clone-3
git clone -s pidgin clone-4
git clone -s pidgin clone-5
git clone -s pidgin clone-6
git clone -s pidgin clone-7
git clone -s pidgin clone-8
git clone -s pidgin clone-9
git clone -s pidgin clone-10

The net disk usage is 746 megabytes, as compared to the 900 megabytes
claimed in the blog post.  The main difference is the git database is
only takes 87 megabytes, compared to the 229 megabytes for the
Monotone database.  The main issue is the pidgin developers simply
didn't know how to use the -s flag so they didn't need to duplicate
the git database for every single clone.

Shrug; whatever, I've always said the biggest issue for any tool is
what the developers are familiar with.  It may be that monotone was
the right choice for the pidgin core developers, if they weren't
familiar enough with git.

						- Ted
