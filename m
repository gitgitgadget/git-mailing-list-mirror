From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: Wed, 26 Oct 2005 13:08:12 -0700
Message-ID: <7vr7a8ca8j.fsf@assigned-by-dhcp.cox.net>
References: <200510261722.j9QHMLGY006576@laptop11.inf.utfsm.cl>
	<86mzkwdsef.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 22:10:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUrZJ-0003cP-DS
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 22:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbVJZUIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 16:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVJZUIO
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 16:08:14 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:27783 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964909AbVJZUIO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 16:08:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051026200755.DCSP4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Oct 2005 16:07:55 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86mzkwdsef.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "26 Oct 2005 11:50:32 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10689>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> It's cleaner to test for the ones that work, building up an OR'ed expression.

You are right.  In this case the only thing we care about is if
it failed because of EEXIST, so checking that and trying to fall
back on rename() otherwise seems cleanest, as Linus and others
suggests.

I swallowed Linus version.  Thanks for reporting (and also ctype
fix the other day).
