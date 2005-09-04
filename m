From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-apply understand "\ No newline at end of file" in non-english locales
Date: Sun, 04 Sep 2005 12:25:16 -0700
Message-ID: <7vd5noeiub.fsf@assigned-by-dhcp.cox.net>
References: <20050904172901.GA20574@c165.ib.student.liu.se>
	<20050904184625.GB23525@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 04 21:25:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EC07W-0003MU-Ub
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 21:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVIDTZT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 15:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVIDTZT
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 15:25:19 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:62109 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751041AbVIDTZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2005 15:25:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050904192517.FCCQ18319.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Sep 2005 15:25:17 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20050904184625.GB23525@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Sun, 4 Sep 2005 20:46:25 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8069>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> The message "\ No newline at end of file" which sometimes is produced
> by diff(1) is locale dependent. We can't assume more than that it
> begins with "\ ".
>
> Signed-off-by: Fredrik Kuivinen <freku@ida.liu.se>
> ---
>
> The previous patch wasn't doing the right thing. Hopefully I have
> managed to get it right this time.

I noticed that you left 12 in the previous patch, and thought it
was a sane safety measure to make sure that the incomplete line
marker is of reasonably length, not just any line that starts
with '\ ' (i.e. "\ foobar\n", which is a tad short).
