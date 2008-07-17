From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-merge.txt: Expand the How Merge Works 
 section
Date: Thu, 17 Jul 2008 12:34:31 -0700
Message-ID: <7vd4lcfgoo.fsf@gitster.siamese.dyndns.org>
References: <20080717162922.12081.96582.stgit@localhost>
 <7v3am8gytp.fsf@gitster.siamese.dyndns.org>
 <20080717185451.GJ10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 17 21:35:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJZGO-0000Rh-6k
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 21:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbYGQTej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 15:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933228AbYGQTej
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 15:34:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39304 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933526AbYGQTeh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 15:34:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 74A9F2AEE9;
	Thu, 17 Jul 2008 15:34:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 91E412AEE7; Thu, 17 Jul 2008 15:34:33 -0400 (EDT)
In-Reply-To: <20080717185451.GJ10151@machine.or.cz> (Petr Baudis's message of
 "Thu, 17 Jul 2008 20:54:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 63C25060-5437-11DD-9ED4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88905>

Petr Baudis <pasky@suse.cz> writes:

>   I'm not sure if I should resend the updated patch, or if you already
> included your comments yourself.

When I send my review comments out, I generally expect an updated version,
unless I explicitly say "will apply with tweaks, no need to resend".  I am
way too lazy to munge patches myself ;-) but more importantly, unlike
Linus, I am not perfect.  My comments are _not_ "I'll show you the right
way", but more often are "Here is what I think is better, but I may well
be wrong, in which case I want you to defend your position better so that
even I can understand why you are right".

>> > +So in the above two "failed merge" case, you do not have to
>> > +worry about loss of data --- you simply were not ready to do
>> > +a merge, so no merge happened at all.  You may want to finish
>> > +whatever you were in the middle of doing, and retry the same
>> > +pull after you are done and ready.
>> 
>> I am not sure what two cases we were describing.  It could be that this
>> paragraph was taken from a mailing list message responding to a question
>> (e.g. "I got this merge failure message and my tree is screwed up.  Please
>> help me get back to a good state, I am lost...") without copying the
>> original sample failure scenario.
>
>   Yes, I got confused by this too. I would perhaps simply drop this
> paragraph altogether.

I agree this does not belong to the same "advanced details" section that
talks about a theoretical corner case where the user:

 - has a perfect foresight,
 - applies (but not commits yet) a patch and stages the change,
 - keeps the working tree and the index dirty, and then
 - pulls from somewhere else in that dirty state,

knowing what will be merged has that exact same patch to trigger that
corner case logic (yes, I am strongly hinting to drop that description; it
is not even remotely interesting).

However, I think we may want to talk about "How to tell if your merge did
not even touch your index nor working tree" somewhere in the manual.
"When there are conflicts, these things happen" part talks about how to
resolve conflicts, but when merge refuses to avoid losing local changes,
the instruction in that part does not apply.
