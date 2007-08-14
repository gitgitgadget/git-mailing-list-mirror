From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Improved hint on how to set identity
Date: Tue, 14 Aug 2007 07:05:59 +0200
Message-ID: <06A460CB-BF06-4D9D-9219-4D4EC656EF9B@zib.de>
References: <1187042750257-git-send-email-prohaska@zib.de> <7vbqdbf1m2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 07:05:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKobE-0003jG-TG
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 07:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764936AbXHNFFo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 01:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765142AbXHNFFn
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 01:05:43 -0400
Received: from mailer.zib.de ([130.73.108.11]:42791 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764936AbXHNFFk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 01:05:40 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7E55T2K004944;
	Tue, 14 Aug 2007 07:05:33 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db19c78.pool.einsundeins.de [77.177.156.120])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7E55Oht009998
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 14 Aug 2007 07:05:25 +0200 (MEST)
In-Reply-To: <7vbqdbf1m2.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55806>


On Aug 14, 2007, at 1:36 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> I watched someone setting up git, who never used it before.
>> The hint was leading him into the wrong direction.
>
> Real-life new user experience is a very valuable one.  Can you
> elaborate how the hint led in a _wrong_ direction?  What is the
> definition of "wrong" here?  It may be that not using --global
> is perfectly the correct thing to do.  It really depends on the
> project and the situation.

"wrong" == "more complex", "doing work twice",
            "solving a special case instead of the common case"


> The condition to cause this error message to be shown is
> probably a borderline, compared to the earlier "introductory
> part of the manual" case.  You may have set an identity in one
> repository without global, and then switched to another
> repository and saw this message.  In which case you may want to
> use a different identity or the same one and I would not say
> which one is more common in the case for such a "second
> repository".  When you work on two projects, managed by two
> different organizations, it often is that you would want
> per-repository identity.

maybe... but my feeling is that the majority of people has only
a single identity. Having multiple identities is, in my opinion,
advanced usage, and should be mentioned after the common case.

Would the majority of users want to set up a global identity
or a per repository identity?

Whatever the majority typically needs should be mentioned first.


> Was this the first repository for this person to set up?

It was the first commit.


It would even be a good idea to remove the gecos auto detection
and force _everyone_ to explicitly set the identity on the first
commit. git may derive something from gecos, but often it is
not the correct identity.

I remember when I started, I didn't immediately recognize that
I need to set my identity (or how to do it). Therefore I ended
up with different identities on different machines, because the
information derived from gecos varied. And there's still a
chance that this will happen again. The situation is quite bad,
because it is very hard, if not impossible, to solve later,
after your identity was use to build some history, which may
even have been pushed to the public.

	Steffen
