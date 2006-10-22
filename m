From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/2] New stg command: assimilate
Date: Sun, 22 Oct 2006 20:12:56 +0200
Message-ID: <20061022181256.GA30295@diana.vm.bytemark.co.uk>
References: <20061022130559.17015.51385.stgit@localhost> <20061022130802.17015.50188.stgit@localhost> <20061022174308.GQ20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 20:13:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbhot-0000tP-9W
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 20:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWJVSNG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Oct 2006 14:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWJVSNG
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 14:13:06 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:65290 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1750816AbWJVSNF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 14:13:05 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Gbhoe-0007u6-00; Sun, 22 Oct 2006 19:12:56 +0100
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20061022174308.GQ20017@pasky.or.cz>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29769>

On 2006-10-22 19:43:08 +0200, Petr Baudis wrote:

> Dear diary, on Sun, Oct 22, 2006 at 03:08:02PM CEST, I got a letter
> where Karl Hasselstr=F6m <kha@treskal.com> said that...
>
> > Introduce an "assimilate" command, with no options. It takes any
> > GIT commits committed on top of your StGIT patch stack and
> > converts them into StGIT patches.
>
> Hmm, isn't this what stg uncommit does?
>
> Well, I'm not sure if what uncommit takes is from below the stack or
> above the stack, but if it's the former, it would still IMHO make
> more sense to just tell that StGIT with a switch or something.

Yes, you're correct in that uncommit and assimilate add existing
commits to the StGIT stack, but in different ends: uncommit grows the
stack by incorporating commits that precede it, while assimilate grows
the stack by incorporating commits that follows it.

The reason I decided to make a separate command is that the two
actions have different use cases: uncommit is for when you want to use
StGIT to manipulate commits that are already made; whereas assimilate
is for the case when you were happily using StGIT to manage a patch
series, and for whatever reason some regular GIT commits were made on
top of that stack, jamming any further StGIT manipulation.

The UIs are slightly different as a consequence: for uncommit, you
tell the command explicitly how many commits you want it to convert,
while assimilate will simply eat as much as it can (if it didn't,
there would still be git commits on top of your StGIT series, and it'd
still be jammed).

uncommit is really the opposite of commit. assimilate might just as
well have been called "fsck" or "cleanup".

Of course, my usability study had only one participant, and he was
rather biased since he's also the patch author, so this need not be
the final word on the matter.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
