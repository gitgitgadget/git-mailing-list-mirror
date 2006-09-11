From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Mon, 11 Sep 2006 16:47:26 -0700
Message-ID: <7v1wqige41.fsf@assigned-by-dhcp.cox.net>
References: <17669.8191.778645.311304@cargo.ozlabs.ibm.com>
	<20060911142644.32313.qmail@science.horizon.com>
	<7vy7sqic4e.fsf@assigned-by-dhcp.cox.net>
	<17669.55963.930152.564529@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com, git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue Sep 12 01:46:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMvU7-0006ef-6c
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 01:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWIKXqf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 19:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbWIKXqf
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 19:46:35 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:12968 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965143AbWIKXqe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 19:46:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060911234633.GIGM6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Mon, 11 Sep 2006 19:46:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MBmP1V00U1kojtg0000000
	Mon, 11 Sep 2006 19:46:24 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17669.55963.930152.564529@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Tue, 12 Sep 2006 07:52:27 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26867>

Paul Mackerras <paulus@samba.org> writes:

> Junio C Hamano writes:
>
>> That's a dubious idea.
>> 
>>  - Why assume a tag points directly at a commit, or if it is
>>    not, why assume "foo^{}" (dereferencing repeatedly until we
>>    get a non-tag) is special?
>
> Umm, I'm not sure what you're getting at here - if one shouldn't make
> those assumptions, why does git ls-remote output both the tag and
> tag^{} lines?

This was originally done to support Cogito's tag following which
was in its infancy.  So in that sense it is already special (iow
we know one user that can take advantage of it), but my point
was that its usefulness for a commit chain fetching application
(i.e. Cogito) does not automatically mean it is also useful for
visualizers like gitk and gitweb.
