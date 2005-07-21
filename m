From: Junio C Hamano <junkio@cox.net>
Subject: Re: Should cg-mkpatch output be usable with cg-patch?
Date: Wed, 20 Jul 2005 20:57:49 -0700
Message-ID: <7vackgerpe.fsf@assigned-by-dhcp.cox.net>
References: <20050720234904.B3ED735267C@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 21 05:58:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvSCD-00045E-Fe
	for gcvg-git@gmane.org; Thu, 21 Jul 2005 05:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVGUD5w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jul 2005 23:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVGUD5w
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jul 2005 23:57:52 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:16865 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261348AbVGUD5v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2005 23:57:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050721035750.MMCI17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Jul 2005 23:57:50 -0400
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050720234904.B3ED735267C@atlas.denx.de> (Wolfgang Denk's message of "Thu, 21 Jul 2005 01:49:04 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Wolfgang Denk <wd@denx.de> writes:

> I wander what I should do with "cg-mkpatch" generated output;  I  had
> the  impression that this should be usable with "cg-patch", but these
> are incompatible with each other. Forexample. if  a  commit  contains
> permission changes, my generated patch may look like this:

Yes, cg-patch does grok git extended diff headers, but does it
by hand and missing corner cases like this is understandable.

I only briefly looked at cg-patch, but I suspect that it can
lose 90% lines of its code by just using "git-apply --index".

I see cg-patch wants to be able to do reverse patch, which is
not supported by git-apply currently.

Do people find "cg-patch -R" useful?
