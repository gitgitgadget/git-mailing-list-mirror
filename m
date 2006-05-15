From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add "--summary" option to git diff.
Date: Sun, 14 May 2006 17:12:28 -0700
Message-ID: <7v3bfcno2b.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP0770FC4238970CB812C192AEA20@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 15 02:12:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfQhU-0003R4-6B
	for gcvg-git@gmane.org; Mon, 15 May 2006 02:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWEOAMa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 20:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWEOAMa
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 20:12:30 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:38827 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751418AbWEOAM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 20:12:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515001229.ZARQ24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 20:12:29 -0400
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP0770FC4238970CB812C192AEA20@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Sun, 14 May 2006 08:13:49 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19997>

Sean <seanlkml@sympatico.ca> writes:

> Remove the need to pipe git diff through git apply to
> get the extended headers summary.
>
> Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

Hmph...

The next branch with this and other patches applied seems to
misbehave.

It makes glibc unhappy with 

PAGER= ./git whatchanged -B -C --stat --summary --no-merges --diff-filter=RC

and "*** glibc detected *** malloc(): memory corruption: xxx ***"

but not with this:

PAGER= ./git whatchanged -B -C --no-merges --diff-filter=RC

nor with this:

PAGER= ./git whatchanged -B -C --summary --no-merges --diff-filter=RC

works just fine, so this is _not_ your fault, and I know who to
harrass ;-).
