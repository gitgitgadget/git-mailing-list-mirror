From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [script] ge: export commits as patches
Date: Tue, 19 Apr 2005 19:03:20 +0200
Message-ID: <20050419170320.GG12757@pasky.ji.cz>
References: <20050419134843.GA19146@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 19:00:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNw4F-0008SR-JA
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 18:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVDSRDZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 13:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVDSRDZ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 13:03:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26818 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261627AbVDSRDW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 13:03:22 -0400
Received: (qmail 32669 invoked by uid 2001); 19 Apr 2005 17:03:20 -0000
To: Ingo Molnar <mingo@elte.hu>
Content-Disposition: inline
In-Reply-To: <20050419134843.GA19146@elte.hu>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 03:48:43PM CEST, I got a letter
where Ingo Molnar <mingo@elte.hu> told me that...
> is there any 'export commit as patch' support in git-pasky? I didnt find 
> any such command (maybe it got added meanwhile), so i'm using the 'ge' 
> hack below.
> 
> e.g. i typically look at commits via 'git log', and then when i see 
> something interesting, i look at the commit via the 'ge' script. E.g.  
> "ge 834f6209b22af2941a8640f1e32b0f123c833061" done in the kernel tree 
> will output a particular commit's header and the patch.

Nice idea. I will add it, probably as 'git patch'.

> TREE1=$(cat-file commit 2>/dev/null $1 | head -4 | grep ^tree | cut -d' ' -f2)
> if [ "$TREE1" = "" ]; then echo 'ge <commit-ID>'; exit -1; fi
> PARENT=$(cat-file commit 2>/dev/null $1 | head -4 | grep ^parent | cut -d' ' -f2)
> if [ "$PARENT" = "" ]; then echo 'ge <commit-ID>'; exit -1; fi
> TREE2=$(cat-file commit 2>/dev/null $PARENT | head -4 | grep ^tree | cut -d' ' -f2)
> if [ "$TREE2" = "" ]; then echo 'ge <commit-ID>'; exit -1; fi

commit-id and parent-id tools might be useful. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
