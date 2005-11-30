From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Wed, 30 Nov 2005 01:42:28 -0800
Message-ID: <7vek4yv5dn.fsf@assigned-by-dhcp.cox.net>
References: <20051130001503.28498.qmail@science.horizon.com>
	<Pine.LNX.4.64.0511291742000.3135@g5.osdl.org>
	<7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511291852530.3099@g5.osdl.org>
	<7vfypey573.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 12:19:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhOUh-0006n2-Fy
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 10:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVK3Jma (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 04:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbVK3Jma
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 04:42:30 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:59899 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750763AbVK3Jma (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 04:42:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130094159.MABJ3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 04:41:59 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12995>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> What does "git-diff-files" do? Just output a lot of nasty "unmerged" 
>> messages?
>
> That was not what was unpleasant.  What was unpleasant was those
> "unmerged" messages were buried under heap of normal diffs,
> showing the successfully merged entries as the result of merge.

Correction.  The above is a faulty memory, and does not happen,
with or without your "stage0 or stage2" patch.  Cleanly merged
paths are written out to working tree and collapsed to stage0 in
the index, so diff-files wouldn't have shown them at all.  

Sorry about the confused statement.  What I saw was my local
modifications on the paths unrelated to the merge.
