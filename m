From: Junio C Hamano <gitster@pobox.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 16:42:37 -0700
Message-ID: <7v3axshe6q.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
	<46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
	<alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
	<7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0709051634190.21186@xanadu.home>
	<7v1wdciy3w.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0709051858060.21186@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nix <nix@esperi.org.uk>, Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 01:42:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT4WC-0001fz-Pb
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 01:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535AbXIEXmj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 19:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756489AbXIEXmj
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 19:42:39 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41716 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054AbXIEXmi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 19:42:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070905234237.IMBD20651.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 5 Sep 2007 19:42:37 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id knid1X00J1gtr5g0000000; Wed, 05 Sep 2007 19:42:37 -0400
In-Reply-To: <alpine.LFD.0.9999.0709051858060.21186@xanadu.home> (Nicolas
	Pitre's message of "Wed, 05 Sep 2007 19:04:27 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57773>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 5 Sep 2007, Junio C Hamano wrote:
>
>> Nicolas Pitre <nico@cam.org> writes:
>> 
> The index?  What's that?  ;-)

Sorry, my mistake.  You are always more right than I am [tm] ;-)

> The more I think of it, the less I like automatic repack.  There is 
> always a bad case for it somewhere.

I tend to agree, but at the same time, I think the long term
goal should be not to have bad cases.

Old timers like ourselves learned to run "repack -a -d" when not
doing real work (i.e. beginning of the day while fetching
coffee, before leaving to lunch break, end of the day before
leaving) and we have been _trained_ not to feel that a choir,
but I think that is wrong.  "Sync freezes I/O for and causes my
real-time databasy job undue latency --- I would want to disable
swapper/bdflush/whatever machine-wide and prefer typing 'sync'
from the command line when it is convenient for me" is fine for
an experienced user working on a single user machine, but it
still feels wrong (we do not have "multi-user" issues in git
repository, so this analogy is not quite right, though).
