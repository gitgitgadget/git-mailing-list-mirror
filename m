From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Trapping exit in tests, using return for errors
Date: Wed, 10 Aug 2005 23:22:54 -0700
Message-ID: <7vzmrpm1q9.fsf@assigned-by-dhcp.cox.net>
References: <1123732581.18644.37.camel@dv>
	<7virydnh1o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 08:23:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E36Sy-0001Ul-TB
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 08:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVHKGW4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 02:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVHKGW4
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 02:22:56 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:16882 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932075AbVHKGWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 02:22:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050811062255.DRHC1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 11 Aug 2005 02:22:55 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <7virydnh1o.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 10 Aug 2005 23:06:43 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sorry, sent it out without finishing.  The worst is "return".
With ksh, ash, and dash, the script itself exits with status
code 1 (presumably you are trapping it with trap -- exit,
though).

prompt$ bash k.sh exit
foo
prompt$ bash k.sh false
foo
status 1
prompt$ bash k.sh return
foo
k.sh: line 20: return: can only `return' from a function or sourced script
status 1
prompt$ ash k.sh exit
foo
prompt$ ash k.sh false
foo
status 1
prompt$ ash k.sh return
foo
prompt$ ksh k.sh exit
foo
prompt$ ksh k.sh false
foo
status 1
prompt$ ksh k.sh return
foo
