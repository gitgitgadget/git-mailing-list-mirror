From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: Which VCS besides git?
Date: Wed, 03 Mar 2010 12:12:16 +0000
Message-ID: <80fx4hbo4f.fsf@tiny.isode.net>
References: <201003021455.52483.karlis.repsons@gmail.com>
            <m3y6ialn3z.fsf@localhost.localdomain>
            <201003021622.22196.karlis.repsons@gmail.com>
            <201003030241.16959.jnareb@gmail.com>
            <94a0d4531003030358q276a8e9bue086a8ec06aba395@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?utf-8?Q?K=C4=81rlis?= Repsons <karlis.repsons@gmail.com>,
	git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 13:19:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmnXJ-00004s-30
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 13:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab0CCMSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 07:18:22 -0500
Received: from rufus.isode.com ([62.3.217.251]:42664 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab0CCMSV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 07:18:21 -0500
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2010 07:18:20 EST
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (submission channel) via TCP with ESMTPA 
          id <S45SIAAu7r0w@rufus.isode.com>; Wed, 3 Mar 2010 12:12:16 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Wed, 03 Mar 2010 12:12:16 +0000
X-Hashcash: 1:20:100303:git@vger.kernel.org::kTHxW7vCeNXiqV2T:0000000000000000000000000000000000000000001nxK
X-Hashcash: 1:20:100303:karlis.repsons@gmail.com::0cKHfWJ3oAMuAO/Q:00000000000000000000000000000000000002UAq
X-Hashcash: 1:20:100303:jnareb@gmail.com::bmI3OXF4WK5yIsXz:06spZ
X-Hashcash: 1:20:100303:felipe.contreras@gmail.com::t6xq2/srrpbvRiB2:00000000000000000000000000000000000Eoba
In-Reply-To: <94a0d4531003030358q276a8e9bue086a8ec06aba395@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 3 Mar 2010 13:58:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141448>

Felipe Contreras <felipe.contreras@gmail.com> writes:

[...]

> That's not exactly correct. Monotone works very differently; a
> revision doesn't include the ancestry, that's handled in a separate
> structure, so the revision hash doesn't tell you anything about the
> ancestry.

Not so.  Long ago that was the case (ancestry was via certs), but that's
not been the case for a long time.  There are (in retrospect) obvious
advantages in including the ancestry in the hash.

> In fact, a revision doesn't contain anything, the data is handled by
> "certs", and certs can be added later.

Revisions lack date, author, branch, commit message, but include
ancestry and the actual changes (which files/directories have changed
and how).

> For example, it's possible to clone a repository and then add a second
> commit message to a bunch of revisions. The revision hash doesn't
> change. Instead, they ensure security by signing every piece of data
> about a commit (commit date, author, commit message). So it's possible
> to have multiple commit dates, authors, messages, etc. each signed by
> a different person.
>
> I'm not really fond of this approach :P

It has the nice feature that many people can create merges, and if they
create exactly the same merge (from exactly the same parents) then only
one revision results (just with multiple certs decorating it).

(Monotone has changed since I last used it but I think the above is
still true.  There's been discussion about larger certs (rather than
having separate certs for branch, date, author, message, to have just
one covering the usual combination) AFAIK that hasn't happened yet.)
