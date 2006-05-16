From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Update the documentation for git-merge-base
Date: Tue, 16 May 2006 00:51:31 -0700
Message-ID: <7vu07qcsqk.fsf@assigned-by-dhcp.cox.net>
References: <20060516055815.GA4572@c165.ib.student.liu.se>
	<7vhd3qebuv.fsf@assigned-by-dhcp.cox.net>
	<20060516065452.GA5540@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 09:51:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfuL9-0003WU-Ft
	for gcvg-git@gmane.org; Tue, 16 May 2006 09:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbWEPHvd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 03:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbWEPHvc
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 03:51:32 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:46274 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751666AbWEPHvc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 03:51:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060516075131.OZMY15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 May 2006 03:51:31 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060516065452.GA5540@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Tue, 16 May 2006 08:54:52 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20111>

Fredrik Kuivinen <freku045@student.liu.se> writes:

>> See the big illustration at the top of the source for how you
>> can construct pathological case to defeat an attempt to
>> guarantee such.  --all guarantees that the output contains all
>> interesting ones, but does not guarantee the output has no
>> suboptimal merge bases.
>
> There are two examples at the top of the source. In the first one a
> least common ancestor is returned. As I interpret the second one, it
> is an example of how the old algorithm without the postprocessing step
> produced a common ancestor which is not least.

Ah, yes, I remember now.

The drawing was done while we were working on the solution to
that pathological case; mark_reachable_commits() solves that
horizon effect.

    http://article.gmane.org/gmane.comp.version-control.git/11410
    http://article.gmane.org/gmane.comp.version-control.git/11429
    http://article.gmane.org/gmane.comp.version-control.git/11552
    http://article.gmane.org/gmane.comp.version-control.git/11613

However, our inability to come up with one is not a nonexistence
proof of cases the current algorithm can fail, so math minded
people _might_ want to prove the algorithm is optimal.

Not me, though.
