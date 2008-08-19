From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 00:25:06 -0700
Message-ID: <7vbpzph3fx.fsf@gitster.siamese.dyndns.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 09:26:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVLbd-00015J-TW
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 09:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbYHSHZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 03:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbYHSHZO
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 03:25:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbYHSHZN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 03:25:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A9B8259ED0;
	Tue, 19 Aug 2008 03:25:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id ECCD359EC9; Tue, 19 Aug 2008 03:25:08 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0808181628420.19665@iabervon.org> (Daniel
 Barkalow's message of "Mon, 18 Aug 2008 17:31:21 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F58D069C-6DBF-11DD-A4C5-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92820>

Daniel Barkalow <barkalow@iabervon.org> writes:

> .... For most systems, "diff" without options is a preview of 
> what would be in the patch if you were to commit; "git diff", on the other 
> hand, shows what would be left out of the patch.

That is true, but I also think that is because (1) on other systems, you
cannot even choose to select changes to "leave out of the patch", so they
have no option other than showing "what could be committed", and (2) by
definition active use of index means that you are staging incrementally,
and it is natural to expect you to want to view "changes since the last
staging" much more often than "what would be committed" when you are
staging incrementally, so the current default is the _right_ one.

So I'd say the below is a faulty argument:

> ...  So, even given that 
> people understand the meaning of the index, they can fail to understand 
> what "diff" will tell them.

If they understand "the meaning of the index", not just as literal reading
of the manual page "it is a staging area to prepare for the next commit",
but including the reason why there is a "staging area" and how it is to be
used, they would reach the conclusion that "diff by default will show the
leftover from incremental staging and it is the right thing".

> ... And diff is a bit unhelpful in that it 
> generates headers as for "diff -r a b", regardless of what the things are.

We have a separate thread on this now ;-)

>> (2) Some concepts in git are different from what they are used to, without
>>     any good reason.  IOW, the concepts have room for improvement, and our
>>     UI is based on these faulty concepts.
>> 
>> (3) Some concepts in git may be exactly the same with other systems, yet
>>     our UI may operate differently from them without any good reason.
>> 
>> I'd be surprised if there is _no_ UI element that falls into the latter
>> two categories, but obviously I would not be able to list examples.  If I
>> could, they instead would have long been fixed already.
>
> You've got to include the class of "The concepts in git are exactly the 
> same as with other systems (although git also has additional concepts), 
> and commands from other systems do not do the same thing in git (with or 
> without good reason)."

Isn't it the same as (3)?

> E.g., git has a working directory, and git has a committed state, and CVS 
> has both of these, and "cvs diff" compares the working directory with the 
> committed state, but "git diff" does a different operation.

Ah, Ok, that is not the same as (3), but "although git has more" makes it
totally different.

Your example sounds like comparing a car and a motorcycle.  Yes they both
share two tyres, but the former having two more tyres makes the driving
technique of the whole thing quite different, doesn't it?
