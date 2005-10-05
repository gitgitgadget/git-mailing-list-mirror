From: Junio C Hamano <junkio@cox.net>
Subject: Re: clone: I'm only doing a max of 256 requests
Date: Wed, 05 Oct 2005 12:42:20 -0700
Message-ID: <7virwbu4wz.fsf@assigned-by-dhcp.cox.net>
References: <20051005191300.GC17475@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 05 21:43:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENFA3-0000iH-Jh
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 21:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbVJETm2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 15:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbVJETm2
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 15:42:28 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:8065 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030343AbVJETm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 15:42:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051005194216.YITF19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Oct 2005 15:42:16 -0400
To: git@vger.kernel.org
In-Reply-To: <20051005191300.GC17475@hexapodia.org> (Andy Isaacson's message
	of "Wed, 5 Oct 2005 12:13:00 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9728>

Andy Isaacson <adi@hexapodia.org> writes:

> ...  (And how should I be starting to
> debug this?  The git programs don't seem to have a useful --verbose
> option.  It would be nice if "git -v clone" would tell me what it is
> doing.)

$ git grep -n 'max of .* requests'
upload-pack.c:141:			die("I'm only doing a max of %d requests", MAX_NEEDS);

I suspect that the repository you are cloning has too many
branch heads and tags under .git/refs/.
