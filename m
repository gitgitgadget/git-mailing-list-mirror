From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [patch] KVM: T60 resume fix
Date: Fri, 2 Mar 2007 13:39:20 +0200
Message-ID: <20070302113920.GB9367@mellanox.co.il>
References: <20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk> <20070301093450.GA8508@elte.hu> <20070301104117.GA22788@elte.hu> <20070301145204.GA25304@elte.hu> <Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org> <20070302072100.GB30634@elte.hu> <20070302080441.GA12785@elte.hu> <20070302102018.GA11549@elte.hu> <20070302102216.GA13575@elte.hu>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <jens.axboe@oracle.com>,
	Pavel Machek <pavel@ucw.cz>, Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.osdl.org,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Daniel Walker <dwalker@mvista.com>,
	Len Brown <lenb@kernel.org>, git@vger.kernel.org,
	Avi Kivity <avi@qumranet.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Mar 02 12:39:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN66Q-00061u-Jk
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 12:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422824AbXCBLjG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 06:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422830AbXCBLjF
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 06:39:05 -0500
Received: from p02c11o143.mxlogic.net ([208.65.145.66]:37876 "EHLO
	p02c11o143.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422824AbXCBLjE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 06:39:04 -0500
Received: from unknown [194.90.237.34] (EHLO p02c11o143.mxlogic.net)
	by p02c11o143.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 8dc08e54.2640964528.8642.00-503.p02c11o143.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Fri, 02 Mar 2007 04:39:04 -0700 (MST)
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o143.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 6cc08e54.1769757616.8605.00-159.p02c11o143.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Fri, 02 Mar 2007 04:38:46 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 2 Mar 2007 13:41:21 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Fri,  2 Mar 2007 13:37:29 +0200
Content-Disposition: inline
In-Reply-To: <20070302102216.GA13575@elte.hu>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 02 Mar 2007 11:41:21.0902 (UTC) FILETIME=[B33DA8E0:01C75CBF]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-15028.003
X-TM-AS-Result: No--7.728700-4.000000-31
X-Spam: [F=0.2210152620; S=0.221(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41195>

> Quoting Ingo Molnar <mingo@elte.hu>:
> Subject: [patch] KVM: T60 resume fix
> From: Ingo Molnar <mingo@elte.hu>
> 
> my T60 laptop does not resume correctly due to KVM attempting to send an 
> IPI to a CPU that might be down (or not up yet). (Doing so also triggers 
> the send_IPI_mask_bitmask() warning in arch/i386/kernel/smp.c, line 
> 732.)
> 
> with this fix applied my laptop does not hang during resume.
> 
> [ KVM will have to disable/enable virtualization on the CPU itself that
>   goes down / comes up, not via an IPI sent from the requesting CPU. ]
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Since I don't normally have kvm loaded, this patch is unlikely
to help me, is that right?

-- 
MST
