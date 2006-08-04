From: Junio C Hamano <junkio@cox.net>
Subject: Re: Regression: git-commit no longer works from within subdirectories
Date: Thu, 03 Aug 2006 21:26:57 -0700
Message-ID: <7vy7u5nn1q.fsf@assigned-by-dhcp.cox.net>
References: <44D23B1C.80704@codeweavers.com>
	<20060803202957.GA26838@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 06:27:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8rH3-0004uI-UT
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 06:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWHDE07 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 00:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWHDE07
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 00:26:59 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:21181 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030250AbWHDE06 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 00:26:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060804042658.VXFS12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Aug 2006 00:26:58 -0400
To: Jeff King <peff@peff.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24772>

Jeff King <peff@peff.net> writes:

> The culprit is the recent changes to the builtins. cmd_read_tree now
> takes an extra parameter 'prefix' which shadows the global declaration
> in builtin-read-tree.c (and has a completely different meaning).

Thanks -- well spotted.  And of course "next" does not suffer
because the prefix global is gone and is replaced with a member
of a structure that is given as a parameter.
