From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff new files (without using index)
Date: Sat, 04 Aug 2007 21:20:43 -0700
Message-ID: <7vd4y2ipd0.fsf@assigned-by-dhcp.cox.net>
References: <87wswalkad.fsf@catnip.gol.com>
	<20070805035245.GE9527@spearce.org> <87r6miljfr.fsf@catnip.gol.com>
	<20070805040841.GG9527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 06:20:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHXbk-00083R-Bi
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 06:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbXHEEUp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 00:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbXHEEUp
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 00:20:45 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:53283 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbXHEEUo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 00:20:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070805042044.ULWC26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 5 Aug 2007 00:20:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y4Lj1X00E1kojtg0000000; Sun, 05 Aug 2007 00:20:44 -0400
In-Reply-To: <20070805040841.GG9527@spearce.org> (Shawn O. Pearce's message of
	"Sun, 5 Aug 2007 00:08:41 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54936>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> The above sort of quirkiness does seem kind of a wart though; in my
>> (admittedly limited, using git) experience this sort of thing really
>> reduces the utility of the index, and I often end up feeling like it's
>> just getting in the way as a result.  Does adding something like a
>> "git-diff -N" option seem a _bad_ idea?
>
> I'm not interested in such an option.  Typically if I want a
> diff on a new untracked file I actually want that file in my next
> commit anyway.

I suspect that it's probably half superstition and half disease
to wish for "diff /dev/null new-file".  Even CVS got this one
right by saying "is a new file, no diff available".  The
contents of that new file is available in "less new-file" near
you anyway and it is quite pointless while you are working
toward next commit.  It just is not interesting, until you tell
git you _care_ about that file.  And the way you tell git about
it is with "git add".

Learn to love the index, run "git-add" and view "git-diff HEAD".
