From: Junio C Hamano <junkio@cox.net>
Subject: Re: cg-clone produces "___" file and no working tree
Date: Thu, 20 Apr 2006 13:26:34 -0700
Message-ID: <7vk69kxabp.fsf@assigned-by-dhcp.cox.net>
References: <20060419053640.GA16334@tumblerings.org>
	<20060419094916.GD27689@pasky.or.cz>
	<20060419142131.GD4104@tumblerings.org>
	<20060419144827.GX27631@pasky.or.cz>
	<20060420164908.GA540@tumblerings.org>
	<7vejzsywrq.fsf@assigned-by-dhcp.cox.net>
	<20060420200849.GA3653@tumblerings.org>
	<7vslo8xaql.fsf@assigned-by-dhcp.cox.net>
	<20060420201915.GF27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 22:26:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWfjb-00029d-3v
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 22:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWDTU0g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 16:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWDTU0g
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 16:26:36 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:18131 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750953AbWDTU0g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 16:26:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060420202635.VNQO18566.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Apr 2006 16:26:35 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060420201915.GF27689@pasky.or.cz> (Petr Baudis's message of
	"Thu, 20 Apr 2006 22:19:15 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18995>

Petr Baudis <pasky@suse.cz> writes:

> Duh, but shouldn't git-init-db create .git/info at any rate, even when
> no templates are installed?

I do not think so.  We tend to lazily create necessary
directories under .git/ these days, and absolute minimum git
should not need an empty .git/info directory.

If there is something that creates files in .git/info without
making sure that leading path exists, we should fix it (maybe
update-server-info forgets it?  I haven't checked).
