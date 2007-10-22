From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Proposed git mv behavioral change
Date: Mon, 22 Oct 2007 16:08:41 +0200
Message-ID: <20071022140841.GB1992@diana.vm.bytemark.co.uk>
References: <20071019032407.GA10622@coredump.intra.peff.net> <7E3647F4-E61C-4FBE-9AA7-81CDBE324308@MIT.EDU> <20071019033500.GB10697@coredump.intra.peff.net> <93BF5798-F1C3-48EE-8233-A0F111BF8138@MIT.EDU> <20071019034704.GB11095@coredump.intra.peff.net> <1192859748.13347.146.camel@g4mdd.entnet> <20071020062400.GA30388@coredump.intra.peff.net> <20071020063628.GV14735@spearce.org> <8D972813-2D7F-4D6A-958F-B76E947E7BC3@MIT.EDU> <87ACA689-CBBD-4E6D-9BAD-B3BBA8391DB9@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@MIT.EDU>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 16:09:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijxxn-0003vU-74
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 16:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbXJVOIv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Oct 2007 10:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbXJVOIv
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 10:08:51 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2869 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbXJVOIv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 10:08:51 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IjxxR-0000fC-00; Mon, 22 Oct 2007 15:08:41 +0100
Content-Disposition: inline
In-Reply-To: <87ACA689-CBBD-4E6D-9BAD-B3BBA8391DB9@wincent.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62009>

On 2007-10-20 13:15:19 +0200, Wincent Colaiuta wrote:

> I think the issue here is that git-mv as it is currently implemented
> really conflates two things:
>
> 1. Renaming a file in the traditional "mv" sense
> 2. Staging the entire contents of the file in the index, ready or not
>
> So it's kind of like the command were called git-mv-and-add or git-
> rename-and-add. And given that the index as a staging area is such a
> central content in Git, users often want to have more control over
> what gets added to the index than that; ie. "I really just wanted to
> rename the file, and leave the staging of modifications to the
> content up to me".

I've come to that conclusion too while reading this thread. It would
make more sense for git-mv to, as others have already suggested, move
the file in the worktree and move the file in the index but _not_ add
workdir updates to the index. git-mv --cached would do only the index,
and not touch the worktree.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
