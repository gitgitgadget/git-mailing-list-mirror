From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Stg AssertionError in sink command
Date: Sun, 16 Sep 2007 01:52:21 +0200
Message-ID: <20070915235221.GE25507@diana.vm.bytemark.co.uk>
References: <9e4733910709131308la9b3e44le70e1fac2b339189@mail.gmail.com> <b0943d9e0709151537k51f2f8d5w5a9bbfef84f82747@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 01:52:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWhRE-0002LX-DL
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 01:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbXIOXwc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Sep 2007 19:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbXIOXwc
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 19:52:32 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4399 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbXIOXwb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 19:52:31 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IWhR0-0006mF-00; Sun, 16 Sep 2007 00:52:22 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0709151537k51f2f8d5w5a9bbfef84f82747@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58283>

On 2007-09-15 23:37:21 +0100, Catalin Marinas wrote:

> The initial implementation of hide/unhide was to preserve the patch
> position in the stack. This behaviour was really confusing for
> people since pushing a patch after the hidden one actually forced
> the pushing of the hidden patch, which isn't normally shown by
> 'series'. I decided afterwards to create a third category of patches
> - 'hidden' (the other two being applied and unapplied). This cleared
> the unpredictable behaviour when pushing since hidden patches cannot
> be pushed.

I agree that the new semantics is way saner (though I'm still not
entirely convinced that hiding patches is a good idea in the first
place). But the man pages should probably point out clearly that
hidden patches must be unapplied.

> Karl's patch does the correct thing of raising an error if sinking
> below an unapplied patch.
>
> Regarding the reordering of the unapplied patches, at the moment you
> can (but I *don't* recommend) edit .git/patches/<branch>/unapplied.
> Maybe the 'float' and 'sink' functionality could be modified to also
> act on unapplied patches (with a --unapplied option). I don't think
> a separate command would be needed as it duplicates a lot of
> functionality from the above.

Why the extra option? Just do the right thing, since it's unambiguous
what the right thing is.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
