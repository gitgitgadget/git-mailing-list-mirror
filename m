X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Wed, 29 Nov 2006 17:22:12 -0800
Message-ID: <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
	<87bqmswm1e.wl%cworth@cworth.org>
	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>
	<87ac2cwha4.wl%cworth@cworth.org>
	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>
	<878xhwwdyj.wl%cworth@cworth.org>
	<7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
	<7vd5786opj.fsf@assigned-by-dhcp.cox.net>
	<871wnnwi3k.wl%cworth@cworth.org>
	<7virgzuf38.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611282322320.9647@xanadu.home>
	<7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
	<87ejrlvn7r.wl%cworth@cworth.org>
	<7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 01:22:50 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 29 Nov 2006 17:03:51 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32693>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpacz-0003Oa-5f for gcvg-git@gmane.org; Thu, 30 Nov
 2006 02:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967789AbWK3BWO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 20:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967790AbWK3BWO
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 20:22:14 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:62859 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S967789AbWK3BWN
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 20:22:13 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061130012212.BPTE9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Wed, 29
 Nov 2006 20:22:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id spMf1V00p1kojtg0000000; Wed, 29 Nov 2006
 20:21:40 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> ...  Rather,
> "building your next commit incrementally in the index is the
> workflow git is designed to support, but you are not required to
> do that _incrementally_.  Until you encounter a complex
> situation such as resolving a large conflicting merge, doing
> that incrementally does not buy you anything as long as you work
> in a clean working tree.

Side note.  I think the above "Until..." is an overstatement,
and maybe the readers of the tutorial can be taught a lot
earlier how the index can help them.  Maybe the following
sequence can be added to an early part of the tutorial sequence?

 $ edit hello.c
 $ make test
 $ git diff
 $ git update-index hello.c; # ok, that is good so far.
 $ edit hello.c; # hack more
 $ make test; # oops, does not work
 $ git diff; # ah, that overeager edit broken what was good
 $ git checkout hello.c; # get the last good one back

