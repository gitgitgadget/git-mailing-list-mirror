From: Junio C Hamano <junkio@cox.net>
Subject: interim report on a big screwup with diff -M and -C.
Date: Mon, 23 May 2005 22:24:25 -0700
Message-ID: <7vk6lpyz5i.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050523090206.GJ23388@cip.informatik.uni-erlangen.de>
	<7vwtpp6goy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505231119570.2307@ppc970.osdl.org>
	<7vpsvh3hp0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505231644560.2307@ppc970.osdl.org>
	<7vll651nth.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 07:23:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaRso-00072t-Jn
	for gcvg-git@gmane.org; Tue, 24 May 2005 07:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVEXFY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 01:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVEXFY3
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 01:24:29 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:37058 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261257AbVEXFY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 01:24:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050524052425.CBS7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 01:24:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vll651nth.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 23 May 2005 17:15:38 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Regrettably this is just an interim progress report not a full
solution, but there is a big screwup between the way rename/copy
detector records detection results and the way unmodified pair
pruner removes uninteresting filepairs, which results in double
free segfaults.  This makes -M and -C flags practically unusable
and I am redoing the rename/copy detector right now.  Hopefully
you will hear back from me by tomorrow morning.

