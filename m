From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] git-daemon support for user-relative paths.
Date: Mon, 21 Nov 2005 01:49:28 -0800
Message-ID: <7vbr0euy8n.fsf@assigned-by-dhcp.cox.net>
References: <20051117193714.428785C7FA@nox.op5.se>
	<7voe4ird8v.fsf@assigned-by-dhcp.cox.net> <437DAA66.6070301@op5.se>
	<7voe4hfssj.fsf@assigned-by-dhcp.cox.net> <437E67AC.2010400@op5.se>
	<7vfypquz88.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 10:51:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee8JM-0005Tj-Bw
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 10:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVKUJta (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 04:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVKUJta
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 04:49:30 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:4506 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932250AbVKUJt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 04:49:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121094902.NSJ3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 04:49:02 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfypquz88.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 21 Nov 2005 01:28:07 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12435>

Junio C Hamano <junkio@cox.net> writes:

> ...So I am thinking about applying something like this patch
> on top of the last part of your patch.
>
>  - Do validation only on canonicalized paths;
>  - Run upload-pack with "." as repo, not full path;
>  - allow trailing slash under --strict-paths i.e. "git://host/my/repo.git/"

Sorry, the last piece was totally unneeded; we are operating on
return value from getcwd at this point.
