From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH rev-list.c] max-count in terms of intersection
Date: Fri, 18 Nov 2005 14:18:14 -0800
Message-ID: <7v1x1dha6x.fsf@assigned-by-dhcp.cox.net>
References: <20051118214722.4449.qmail@web31813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 00:26:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdEYl-00030P-N7
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 23:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbVKRWSR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 17:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVKRWSR
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 17:18:17 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:43697 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751042AbVKRWSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 17:18:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118221714.WMGW26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 17:17:14 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20051118214722.4449.qmail@web31813.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Fri, 18 Nov 2005 13:47:22 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12283>

Luben Tuikov <ltuikov@yahoo.com> writes:

> diff-tree 768b79de9eadc38a839332df0fcce021f7174d6d (from 2e67a5f449f4026097494569f871d79bf263ab28)
> tree 6403fc730f8d5843043788f4c2f466727ba94bc0
> parent 2e67a5f449f4026097494569f871d79bf263ab28
> author Luben Tuikov <ltuikov@yahoo.com> 1132349344 -0500
> committer Luben Tuikov <ltuikov@yahoo.com> 1132349344 -0500
>
>     [PATCH rev-list.c] max-count in terms of intersection
>     

Documentation/SubmittingPatches, perhaps?

>     When a path designation is given, max-count counts the number
>     of commits therein (intersection), not globally.

This makes sense, but I wonder if the same logic applies to
max_age as well.  If we have clock-skewed commits that are
skipped by the DENSE processing, we probably do not want them to
be affecting what to do on the commits that matter.
