From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: git-daemon problem
Date: Wed, 12 Jul 2006 21:28:09 +0200
Message-ID: <E1G0kNV-0006LK-QW@moooo.ath.cx>
References: <E1G0QeX-0003hG-0I@moooo.ath.cx> <7vlkqz1lja.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 21:28:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0kNd-000259-Ud
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 21:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWGLT2O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 15:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWGLT2O
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 15:28:14 -0400
Received: from moooo.ath.cx ([85.116.203.178]:4077 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750863AbWGLT2O (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 15:28:14 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vlkqz1lja.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23796>

Junio C Hamano <junkio@cox.net> wrote:
> This breaks the newer clients that knows how to do side-band
> doesn't it?
Probably, this patch is just to give a starting point where the
problem could be.

> Would this replacement patch help?
[use write instead of safe_write]

This seems to fix it.  Perhaps it should be xwrite instead of write.

> Maybe we should check if fd 2 is sane at daemon startup, and
> otherwise open /dev/null for writing and dup2 it to fd 2?
daemon startup is probably not the right place because as long as the
terminal is open this will be fine.
