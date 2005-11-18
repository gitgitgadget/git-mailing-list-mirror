From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH rev-list.c] max-count in terms of intersection
Date: Fri, 18 Nov 2005 15:42:12 -0800
Message-ID: <7vfyptfrqj.fsf@assigned-by-dhcp.cox.net>
References: <20051118224233.50766.qmail@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 01:02:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdFs3-0005wc-Jh
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 00:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbVKRXmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 18:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVKRXmQ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 18:42:16 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:33689 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751195AbVKRXmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 18:42:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118234138.YGPY6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 18:41:38 -0500
To: ltuikov@yahoo.com
In-Reply-To: <20051118224233.50766.qmail@web31805.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Fri, 18 Nov 2005 14:42:33 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12298>

Luben Tuikov <ltuikov@yahoo.com> writes:

>> This makes sense, but I wonder if the same logic applies to
>> max_age as well.  If we have clock-skewed commits that are
>> skipped by the DENSE processing, we probably do not want them to
>> be affecting what to do on the commits that matter.
>
> As far as I understand it, I think max-age is fine the way
> it is.  After all, max-age depends on date/time which is
> absolute (i.e. applies to commits in the whole set and in
> the intersection just the same).

It is recorded absolutely but what if committer's clock is
broken on one commit but not others, and if you are not using
the default sort_by_date() (e.g. --topo-order)?
