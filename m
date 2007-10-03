From: Miles Bader <miles.bader@necel.com>
Subject: Re: git push (mis ?)behavior
Date: Wed, 03 Oct 2007 17:57:56 +0900
Message-ID: <buobqbgmv6z.fsf@dhapc248.dev.necel.com>
References: <20070927130447.GH10289@artemis.corp>
	<7v3awzvrpr.fsf@gitster.siamese.dyndns.org>
	<buoprzwn5qm.fsf@dhapc248.dev.necel.com>
	<20071003073554.GA8110@artemis.corp>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 10:58:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id03y-0003gk-MN
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 10:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574AbXJCI6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 04:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752936AbXJCI6b
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 04:58:31 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:43491 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbXJCI6a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 04:58:30 -0400
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l938vmiB026201;
	Wed, 3 Oct 2007 17:57:56 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay11.aps.necel.com with ESMTP; Wed, 3 Oct 2007 17:57:56 +0900
Received: from dhapc248.dev.necel.com ([10.114.98.116] [10.114.98.116]) by relay31.aps.necel.com with ESMTP; Wed, 3 Oct 2007 17:57:56 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 0A524458; Wed,  3 Oct 2007 17:57:56 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <20071003073554.GA8110@artemis.corp> (Pierre Habouzit's message of "Wed\, 03 Oct 2007 09\:35\:54 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59811>

Pierre Habouzit <madcoder@debian.org> writes:
>   There definitely is a point: with the current behaviour you sometimes
> end up pushing more than what you meant, with sometimes WIP that you
> intend to rebase, and it hurts. Git porcelains should help you avoid to
> shoot yourself in the foot, hence I think that (especially to git
> newcomers), the current default _is_ dangerous.

What's "dangerous" for newbies, often ends up being what doesn't
correspond with their mental model.  I think the current default
behavior without any <refspec> specified corresponds well to the
operation of many other git commands (and unix command) in similar
circumstances:  If you don't specify something to operate on, it
essentially uses a wild card and operates on "every reasonable thing"
(e.g., consider "git commit FILE" versus "git commit").

Even if the default were changed, it could very well end up causing many
problems because it _didn't_ push as many heads as the user thought it
would (I don't think I'm the only one that might expect the default
action to be "push everything").  When I was a git newbie, I sometimes
got into situations where I screwed something up because heads I thought
had been pushed to another system actually hadn't been.

To the extent that a command _is_ "dangerous", there's always a tradeoff
between convenience and "danger".  Some systems (e.g. those aimed at
newbies) might have as a goal to do the absolute minimum with every
command and always, always, err on the side of safety.  I don't think git
is that system.

-Miles

-- 
Yo mama's so fat when she gets on an elevator it HAS to go down.
