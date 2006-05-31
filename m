From: Junio C Hamano <junkio@cox.net>
Subject: Re: format-patch signoff argument no longer works
Date: Wed, 31 May 2006 12:02:33 -0700
Message-ID: <7vejyayq46.fsf@assigned-by-dhcp.cox.net>
References: <93c3eada0605310332p19241861g466e1516a2aaf0df@mail.gmail.com>
	<93c3eada0605310411r712dab8au9b1c7d8ecb595a66@mail.gmail.com>
	<20060531112803.GB3877@spinlock.ch> <m2mzcycn4f.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 31 21:03:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlVxm-0005tw-03
	for gcvg-git@gmane.org; Wed, 31 May 2006 21:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWEaTCf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 15:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWEaTCf
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 15:02:35 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:6568 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751786AbWEaTCe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 15:02:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060531190233.ODKI18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 31 May 2006 15:02:33 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21074>

Seth Falcon <sethfalcon@gmail.com> writes:

> Matthias Kestenholz <lists@spinlock.ch> writes:
>
>> * Geoff Russell (geoffrey.russell@gmail.com) wrote:
>>> It appears to have got lost when the shell script got converted to C.
>>> 
>> Yes, this was intentional. You should sign off your changes while
>> committing (git commit -s|--signoff)

A bit on this later, but first to clear one thing up...

> When should one commit _without_ signoff?  
>
> The obvious answer is: when one doesn't approve of the changes in the
> commit... But in my usual workflow, commit means
> works-for-me-I-think-it-is-good. :-)

Please, calm down and read Documentation/SubmittingPatches,
item (6), to understand what sign-off means.  It does not have
anything to do with the result of the commit "working".  I do
not use -s when making commits during my day-job, for example.

We do not want to make sign-off the default.  It has to be a
concious act on the signer's part to add one.  Otherwise it
would not carry much weight.

About the droppage of "format-patch -s", I have come to think of
it as a mistake (yes, I can change my mind).  Consider:

 * You are the leader of a group of people who hack on a part of
   the kernel, internally in your company.  You and other
   developers make improvements and make commits, with "git
   commit -s".

 * As the in-company integrator, you maintain the canonical
   "company tree" by pulling from others in your group.

 * It's time to send good pieces to Linus and/or Andrew and as
   the group lead you are responsible for sending them out.  The
   commits would have Sign-off's by the original committers, but
   as the contact person (representative) of your group, your
   name is better recognizable in the outside community, and as
   the leader of your group, it is a good practice for _you_ to
   vouch for what your group did.

In that scenario, in addition to what "commit -s" gives us, it
is handy for the person who is sending the patches out via
e-mail to add his own sign-off.

Now, we could do that by re-adding "format-patch -s" option, or
alternatively we could add that to "send-email".  We might want
to do both ;-)
