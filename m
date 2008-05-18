From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH 0/3] git-cvsserver: Add support for some binary files
Date: Sun, 18 May 2008 16:10:54 -0600
Message-ID: <20080518221053.GA880@comcast.net>
References: <1210826148-8708-1-git-send-email-mmogilvi_git@miniinfo.net> <7v7idteqzn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>,
	Frank Lichtenheld <djpig@debian.org>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 00:11:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxr6b-0004tN-7u
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 00:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821AbYERWK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 18:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbYERWK5
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 18:10:57 -0400
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:52041 "EHLO
	QMTA05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753392AbYERWK4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 May 2008 18:10:56 -0400
Received: from OMTA07.emeryville.ca.mail.comcast.net ([76.96.30.59])
	by QMTA05.emeryville.ca.mail.comcast.net with comcast
	id T9By1Z00K1GXsucA503500; Sun, 18 May 2008 22:10:55 +0000
Received: from mmogilvi.homeip.net ([75.70.160.185])
	by OMTA07.emeryville.ca.mail.comcast.net with comcast
	id TAAu1Z00740J0Bv8T00000; Sun, 18 May 2008 22:10:55 +0000
X-Authority-Analysis: v=1.0 c=1 a=o8s9G-U7OAoA:10 a=DnQ2Ju4PVaQA:10
 a=00fO1AWQ8es1UjfIrlAA:9 a=SOZsy72UqSr-f_2RiIxavZxbgMQA:4 a=3cjVDzgxsZYA:10
 a=LY0hPdMaydYA:10
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 3588389115; Sun, 18 May 2008 16:10:54 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <7v7idteqzn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82397>

On Fri, May 16, 2008 at 05:03:40PM -0700, Junio C Hamano wrote:
> Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:
> 
> > This series of patches extends git-cvsserver to support telling the
> > CVS client to set the -kb (binary) mode for files that git considers
> > to be binary (and not for text files).  It includes updates to
> > documentation and tests.
> 
> I am unfortunately not familiar with this part of the system and I'd need
> to summon help from experts, but it looks rather nicely done.
> 
> I saw a few places that said "crnl" instead of "crlf" in the
> documentation, which I munged locally before queuing.

Sounds good.

> 
> I noticed kopts_from_path in patch 3/3 takes $srcType of "sha1Or-k" but I
> could not spot which caller gives such token to the function.

Oops.  The "sha1Or-k" cases can and probably should be removed
completely.

I can generate another patch if you would like.

It's a remnant of an approach I had been working on earlier,
when I thought there might be cases when I needed to fall back on
the -k option the user specified on the command line because I didn't
have the file contents.  But careful study revealed what I needed
elsewhere in the data structures.

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]
