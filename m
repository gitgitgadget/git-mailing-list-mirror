From: Junio C Hamano <junkio@cox.net>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 09:07:29 -0700
Message-ID: <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610171134130.1971@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 18:08:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZrTb-00085P-E5
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 18:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWJQQHb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 12:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWJQQHb
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 12:07:31 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:47030 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751261AbWJQQHb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 12:07:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061017160730.GZJA13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Oct 2006 12:07:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bU7H1V0041kojtg0000000
	Tue, 17 Oct 2006 12:07:17 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610171134130.1971@xanadu.home> (Nicolas Pitre's
	message of "Tue, 17 Oct 2006 11:39:20 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29090>

Nicolas Pitre <nico@cam.org> writes:

> On Mon, 16 Oct 2006, Junio C Hamano wrote:
>
>> I'm still a bit under the weather and do not have enough
>> concentration to dig into the problem tonight, but I noticed
>> that something in "next", most likely the delta-base-offset
>> patchset, broke git-index-pack:
>> 
>> $ X=ec0c3491753e115e1775256f6b7bd1bce4dea7cd
>> $ wget http://www.kernel.org/pub/scm/git/git.git/objects/pack/pack-$X.pack
>> $ ~/git-master/bin/git-index-pack pack-$X.pack
>> ec0c3491753e115e1775256f6b7bd1bce4dea7cd
>> $ git-index-pack pack-$X.pack
>> fatal: packfile 'pack-ec0c3491753e115e1775256f6b7bd1bce4dea7cd.pack' has unresolved deltas
>
> Using the tip of the "next" branch (git version 1.4.2.4.gf9fe) I just 
> cannot reproduce this problem at all.  I always get a good index and 
> ec0c3491753e115e1775256f6b7bd1bce4dea7cd back.

Hmph.  I just got exactly the same breakage; could this be
another 64-bit breakage?  My breakage was on x86-64.
