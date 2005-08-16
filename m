From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --signoff and --verify option to git commit.
Date: Mon, 15 Aug 2005 17:13:38 -0700
Message-ID: <7v3bpavivh.fsf@assigned-by-dhcp.cox.net>
References: <7vzmrmp5kw.fsf@assigned-by-dhcp.cox.net>
	<200508152321.17075.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 02:14:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4p5L-0004cI-By
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 02:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbVHPANk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 20:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbVHPANk
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 20:13:40 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:59052 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965044AbVHPANk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 20:13:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816001340.SPWT1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 20:13:40 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> These verification scripts should be used per default, and git-commit should 
> have an option to force bypassing verification.

I agree that it would be a good place to do a hook.  Also it may
not be a bad idea, if you volunteer to come up with a patch, to
look at an earlier thread that talks about commit message
templates and think about how these things should mesh together.

Bypassing can already be done by not giving '-v', so I do not
think you need to make things more complicated than necessary.
You can first try with a '-v', examine what it complains about,
fix only what are applicable to your change, try with '-v' again
to make sure the only complaints are from false positives, and
then you commit without '-v', bypassing the check.
