From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase behaviour changed?
Date: Tue, 17 Jan 2006 00:56:21 -0800
Message-ID: <7vhd83b5ca.fsf@assigned-by-dhcp.cox.net>
References: <43CC695E.2020506@codeweavers.com>
	<7vslrnh080.fsf@assigned-by-dhcp.cox.net>
	<43CC89DC.5060201@codeweavers.com>
	<46a038f90601162252y7e2d9227p4eb4091b653d5c6d@mail.gmail.com>
	<7v8xtfclyx.fsf@assigned-by-dhcp.cox.net>
	<46a038f90601170033y334d111fjed277fc787a2e523@mail.gmail.com>
	<7vvewjb5xz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike McCormack <mike@codeweavers.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 09:56:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eymdj-0007Qo-As
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 09:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWAQI4X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 03:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWAQI4X
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 03:56:23 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:48590 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932351AbWAQI4X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 03:56:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060117085511.GDYB6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 Jan 2006 03:55:11 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <7vvewjb5xz.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 17 Jan 2006 00:43:20 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14790>

Junio C Hamano <junkio@cox.net> writes:

> You are right.  We will lose #1 and #2, (although the "already
> up to date" might catch some cases) and this _is_ dangerous.  I
> need to do something about this soon.

Actually, I think we are OK; I do not think we would lose any
commits.  git-format-patch (actually, git-cherry called from
there) does the right thing.  It does not use the merge base
done in git-rebase in any way.

In any case, we _do_ need an explanation and error-out upon
finding a merge, as we discussed.  If somebody really wants to
rebase a merge, he can do that by hand, as Mike easily
demonstrated.
