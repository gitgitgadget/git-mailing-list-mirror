From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: use of temporary refs in resolve
Date: Tue, 09 Aug 2005 10:07:25 +0100
Message-ID: <tnxmznr32cy.fsf@arm.com>
References: <7v3bplwmzg.fsf@assigned-by-dhcp.cox.net>
	<tnxk6iwx161.fsf@arm.com> <7vfytkdcgm.fsf@assigned-by-dhcp.cox.net>
	<tnxr7d4vi5v.fsf@arm.com> <7v1x53zuyv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 11:09:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Q5m-0000vi-30
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 11:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVHIJII (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 05:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVHIJII
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 05:08:08 -0400
Received: from fw-nat.cambridge.arm.com ([193.131.176.54]:52855 "EHLO
	ZIPPY.Emea.Arm.com") by vger.kernel.org with ESMTP id S932458AbVHIJII
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 05:08:08 -0400
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 9 Aug 2005 10:07:57 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x53zuyv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 08 Aug 2005 19:48:24 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 09 Aug 2005 09:07:57.0262 (UTC) FILETIME=[D5638EE0:01C59CC1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> If you are happy then I should not complain ;-), and I am
> certainly not complaining, but I still have this feeling that I
> do not get what you are getting at.  You can change it to
> directly use pull without intermediate fetch, in order to cope
> with what?

I shouldn't have said anything :-).

StGIT implements a pull command which pops all the patches from the
stack, pulls the latest remote changes and pushes the patches back. I
was lazy and I implemented the pulling stage by simply calling
git-fetch-script and advancing the base of the stack to the value in
FETCH_HEAD. I didn't have any special reason for this and I could have
used git-pull-script instead and not rely on the presence of
FETCH_HEAD. I don't have any preference here.

> Could you explain how you currently do things, and
> what changes I will be making would break the way you currently
> do things please?

If you plan to implement multiple values in FETCH_HEAD, StGIT won't be
able to use this since it doesn't do any merging for the base of the
stack. As I said above, this is not a problem and I was probably wrong
when decided to use git-fetch-script directly and not git-pull-script.

Please let me know if you need more info.

-- 
Catalin
