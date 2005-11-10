From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge-one-file: use common as base, instead of emptiness.
Date: Thu, 10 Nov 2005 12:30:55 -0800
Message-ID: <7vk6fgxn28.fsf@assigned-by-dhcp.cox.net>
References: <E1EZKOB-0002j5-VY@jdl.com>
	<7vwtjjllw4.fsf@assigned-by-dhcp.cox.net>
	<20051108095600.GA1431@pasky.or.cz>
	<7v64r16ro9.fsf_-_@assigned-by-dhcp.cox.net>
	<20051110194317.GV30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 21:31:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaJ4W-00017x-RW
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 21:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVKJUa5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 15:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVKJUa5
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 15:30:57 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:40612 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932068AbVKJUa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 15:30:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051110203034.GDEY1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Nov 2005 15:30:34 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051110194317.GV30496@pasky.or.cz> (Petr Baudis's message of
	"Thu, 10 Nov 2005 20:43:17 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11519>

Petr Baudis <pasky@suse.cz> writes:

> But obviously now the trouble is opposite, when the files are completely
> unrelated, since now you likely get large conflicting areas interleaved
> with some scarce common lines... And this might get to be a big PITA to
> resolve as well.

Yeah, you can always count lines in $orig and $src2 after
two-file merge runs, and if it appears we do not have enough
common section just empty the $orig before running merge.
