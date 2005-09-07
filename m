From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add $(LIBS) and set libiconv in tools/Makefile for Darwin
Date: Tue, 06 Sep 2005 22:47:00 -0700
Message-ID: <7v8xy9bfaj.fsf@assigned-by-dhcp.cox.net>
References: <20050907030855.9278.qmail@web34313.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Sep 07 07:47:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECsm3-00062h-M0
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 07:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVIGFrD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 01:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVIGFrD
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 01:47:03 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:63137 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750718AbVIGFrC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2005 01:47:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050907054702.WJZO3414.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Sep 2005 01:47:02 -0400
To: Mark Allen <mrallen1@yahoo.com>
In-Reply-To: <20050907030855.9278.qmail@web34313.mail.mud.yahoo.com> (Mark
	Allen's message of "Tue, 6 Sep 2005 20:08:55 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8165>

Mark Allen <mrallen1@yahoo.com> writes:

> This trivial patch creates $(LIBS) and sets it to iconv in
> tools/Makefile because MacOS 10.4 [gcc 4.0] gets cranky about
> libiconv routines referenced in mailinfo.c (convert_to_utf8)
> and no library pointer to link the symbols against.

I'd do this slightly differently.  Could you take a look at what
I have in the "proposed updates" branch, especially "Flatten
tools/ directory" commit?  What I am aiming for is to have
platform specific ifeq() thing in only one place.
