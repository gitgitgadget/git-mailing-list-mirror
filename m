From: Petr Baudis <pasky@suse.cz>
Subject: Re: tip tree clone fail
Date: Sun, 12 Oct 2008 17:39:52 +0200
Message-ID: <20081012153952.GV10544@machine.or.cz>
References: <20081010072951.GB16016@elte.hu> <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo> <48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com> <20081012124105.GA26988@elte.hu> <48F20663.2040407@zytor.com> <20081012152427.GA4607@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Wang Chen <wangchen@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sun Oct 12 17:41:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp346-0004jW-HQ
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 17:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255AbYJLPjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 11:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754246AbYJLPjz
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 11:39:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40015 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754108AbYJLPjy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 11:39:54 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 77A90393A71E; Sun, 12 Oct 2008 17:39:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081012152427.GA4607@elte.hu>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98034>

On Sun, Oct 12, 2008 at 05:24:27PM +0200, Ingo Molnar wrote:
> hm, -tip's .git/hooks/post-update already contained this, for the last 2 
> months:
> 
>   exec git update-server-info
> 
> so ... _despite_ us having this in the git repo, the HTTP protocol still 
> does not work. Why?

I think your problem is that HTTP does not know where to look for
objects coming from alternates; IIRC this would work if you used
relative paths in objects/info/alternates, or you can create
objects/info/http-alternates like

	/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects
	/pub/scm/linux/kernel/git/sfr/linux-next.git/objects

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
