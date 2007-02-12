From: Junio C Hamano <junkio@cox.net>
Subject: Re: Efficiency of initial clone from server
Date: Sun, 11 Feb 2007 20:16:24 -0800
Message-ID: <7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
	<20070211225326.GC31488@spearce.org>
	<9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
	<Pine.LNX.4.64.0702112022430.1757@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 05:16:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGScD-0004qT-4G
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 05:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbXBLEQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 23:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932942AbXBLEQ0
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 23:16:26 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:58300 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932578AbXBLEQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 23:16:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070212041626.EXEM21668.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Feb 2007 23:16:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NUGQ1W00s1kojtg0000000; Sun, 11 Feb 2007 23:16:25 -0500
In-Reply-To: <Pine.LNX.4.64.0702112022430.1757@xanadu.home> (Nicolas Pitre's
	message of "Sun, 11 Feb 2007 20:38:09 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39357>

Nicolas Pitre <nico@cam.org> writes:

> On Sun, 11 Feb 2007, Jon Smirl wrote:
>
>> On 2/11/07, Shawn O. Pearce <spearce@spearce.org> wrote:
>> > Jon Smirl <jonsmirl@gmail.com> wrote:
>> > > remote: Total 63, written 63 (delta 0), reused 63 (delta 0)
>> > > 100% (63/63) done
>> > > fatal: pack: not a valid SHA1
>> > > New branch: 0953670fbcb75e26fb93340bddae934e85618f2e
>> >
>> > What version of git is this?  That looks like we're assuming the word
>> > pack was an object, but I'm not sure why we would do such a thing...
>
> This "pack" comes from pack-index when providing the name of the pack.
> It is either "pack" or "keep" and specifies the name of the .keep file 
> to remove in the later case.
> This is caught by git-fetch.sh with some code identified with a comment 
> that reads: "# special line coming from index-pack with the pack name"

That is true only if Jon used git-fetch, git-pull or git-clone.
Unfortunately I noticed that his commandline read "cg clone".
