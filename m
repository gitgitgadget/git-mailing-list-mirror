From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: merge into branch currently not active / checked out
Date: Wed, 20 Jun 2007 09:54:46 +0200
Message-ID: <20070620075446.GA30186@diana.vm.bytemark.co.uk>
References: <20070617072225.GF23473@cip.informatik.uni-erlangen.de> <7vmyyzylpl.fsf@assigned-by-dhcp.pobox.com> <20070617101635.GK23473@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Wed Jun 20 09:55:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0v1p-0007sX-MA
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 09:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756922AbXFTHy5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 20 Jun 2007 03:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755748AbXFTHy5
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 03:54:57 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3848 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbXFTHy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 03:54:56 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1I0v1a-00081S-00; Wed, 20 Jun 2007 08:54:46 +0100
Content-Disposition: inline
In-Reply-To: <20070617101635.GK23473@cip.informatik.uni-erlangen.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50545>

On 2007-06-17 12:16:35 +0200, Thomas Glanzmann wrote:

> the problem is. Getting a patch into mutt takes several years. At
> least it took for the hcache. So what I do is keep my patches
> up2date on top of there HEAD. So I prefer topic branches. And my
> patches throw _once_ in 4 years a conflict that was not
> automatically resolved. I used bitkeeper before, now I use git.

=46or this use case, I'd say rebasing is the right thing to do --
otherwise you accumulate a 4-year-long history of uninteresting
merges, as Junio warned.

There are two cases where rebasing is worse than a "real" branch
that's merged instead of rebased:

  1. Other people base their work on yours, and need to be able to
     pull. They want a stable foundation to build on, one that doesn't
     move.

  2. Your work is large enough that it's too much work to rebase it.
     (This also implies that when you merge, you get interesting
     conflicts, since for the case of autoresolved conflicts, rebasing
     isn't that much more expensive than merging.)

Since you describe your work as "a patch", I'm guessing neither excuse
applies to you. :-)

> I don't push my work other than in patches that is, so I am going to
> give it a try. I always wanted to try rebase, but I never actually
> did try it.

<advertisement>
  You could also try StGIT. Rebasing a patch series on top of a git
  branch is what it does.
</advertisement>

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
