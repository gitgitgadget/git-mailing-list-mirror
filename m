From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/3] bisect: use a detached HEAD to bisect
Date: Sun, 25 May 2008 18:11:22 -0700
Message-ID: <7v4p8lhnt1.fsf@gitster.siamese.dyndns.org>
References: <20080523012857.acce6457.chriscool@tuxfamily.org>
 <7v3ao9twfa.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0805230823330.3081@woody.linux-foundation.org>
 <18487.62245.59892.442935@cargo.ozlabs.ibm.com>
 <alpine.LFD.1.10.0805240842360.3081@woody.linux-foundation.org>
 <18490.280.325614.480038@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 26 03:12:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0RGX-0007l4-B0
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 03:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbYEZBLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 21:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbYEZBLl
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 21:11:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbYEZBLk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 21:11:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A3323DC3;
	Sun, 25 May 2008 21:11:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4D27E3D8A; Sun, 25 May 2008 21:11:30 -0400 (EDT)
In-Reply-To: <18490.280.325614.480038@cargo.ozlabs.ibm.com> (Paul Mackerras's
 message of "Mon, 26 May 2008 10:15:20 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B188CA90-2AC0-11DD-9AC8-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82885>

Paul Mackerras <paulus@samba.org> writes:

> Linus Torvalds writes:
>
>> Of course, _usually_ it's just the top commit, and it's obvious that way 
>> which one is the checked-out one, but if you do "gitk --all" or just 
>> generally have multiple branches, right now it's hard to see what commit 
>> is the checked-out one, regardless of whether it's detached or not.
>
> If it's not detached, the branch name is in bold, but evidently that's
> either not intuitive or not sufficiently distinct...
>
>> I think "HEAD" in a green box would solve that too, but on the other hand, 
>> we have a *lot* of boxes already. For people who mainly just track another 
>> repo, you already have one box saying "master", and another one saying 
>> "remotes/origin/master", and adding yet *another* box saying HEAD that 
>> just points to the same commit will work, but do we really want that?
>> 
>> I actually like the red circle for "Local uncommitted changes". Maybe we 
>> can use a similar visual clue for "currently checked out". You already 
>> picked green for the "added to the index" case, so we have the three 
>> primary RGB colors already used, but we could make it just be a deep 
>> yellow.
>> 
>> Of course, maybe people hate lots of colos already, and something more 
>> akin to the text background thing that we use for the selected commit 
>> would be better.
>> 
>> I dunno. There's so many options.
>> 
>> Here's a "make it yellow" patch.
>
> Thanks.  I have checked in something similar, that also handles the
> cases where you update the graph and the head has moved, and when you
> do a checkout or reset using the gitk menus.

Thanks.  Will pull, but it will have to miss upcoming 1.5.6-rc0,
unfortunately.
