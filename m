From: Junio C Hamano <junkio@cox.net>
Subject: Re: n-heads and patch dependency chains
Date: Thu, 20 Apr 2006 11:55:31 -0700
Message-ID: <7v4q0oyt3w.fsf@assigned-by-dhcp.cox.net>
References: <4430D352.4010707@vilain.net>
	<7vsloucuxk.fsf@assigned-by-dhcp.cox.net>
	<4431B60E.3030008@vilain.net> <44323C52.2030803@op5.se>
	<e0tjpk$ktu$1@sea.gmane.org> <44325CDB.2000101@op5.se>
	<1145556505.5314.149.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 20 20:55:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWeJY-0002KG-EY
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 20:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWDTSzd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 14:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWDTSzd
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 14:55:33 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:63656 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750742AbWDTSzc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 14:55:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060420185532.ZXAM24981.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Apr 2006 14:55:32 -0400
To: git@vger.kernel.org
In-Reply-To: <1145556505.5314.149.camel@cashmere.sps.mot.com> (Jon Loeliger's
	message of "Thu, 20 Apr 2006 13:08:25 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18990>

Jon Loeliger <jdl@freescale.com> writes:

> On Tue, 2006-04-04 at 06:47, Andreas Ericsson wrote:
>
>> No, I mean that this would commit both to the testing branch (being the 
>> result of several merged topic-branches) and to the topic-branch merged 
>> in. Commit as in regular commit, with a commit-message and a patch. The 
>> resulting repository would be the exact same as if the change was 
>> committed only to the topic-branch and then cherry-picked on to the 
>> testing-branch.

To be consistent, I think the result should be "as if the change
was commited only to the topic-branch and then the topic-branch
was *merged* into the testing-branch", since you start your
testing branch as "being the result of several merged topic-branches".

I do that (manually) all the time, with:

	$ git checkout next
        $ hack hack hack

        $ git checkout -m one/topic
        $ git commit -o this-path that-path
        $ git checkout next
        $ git pull . one/topic

Giving a short-hand for the last four-command sequence would
certainly be nice.

> I am your number one fan!  If I finish reading these 600+
> messages, will I find out you have already implemented it,
> it's committed, and you just need me to test it now? :-)

Likewise... ;-)
