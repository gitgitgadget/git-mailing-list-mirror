From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Stop git-rev-list at sha1 match
Date: Wed, 11 May 2005 23:08:34 +0000
Organization: linutronix
Message-ID: <1115852914.22180.170.camel@tglx>
References: <1115839456.22180.79.camel@tglx>
	 <7vy8alr0mz.fsf@assigned-by-dhcp.cox.net> <1115843429.22180.90.camel@tglx>
	 <7vis1pqvi4.fsf@assigned-by-dhcp.cox.net>
	 <20050511221719.GH22686@pasky.ji.cz> <1115851742.22180.154.camel@tglx>
	 <20050511225058.GK22686@pasky.ji.cz>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 01:04:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW0FB-0005iQ-8p
	for gcvg-git@gmane.org; Thu, 12 May 2005 01:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVEKXJK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 19:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVEKXIk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 19:08:40 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:13699
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261730AbVEKXHq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 19:07:46 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 7CCDB65C003;
	Thu, 12 May 2005 01:07:41 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 26AE928204;
	Thu, 12 May 2005 01:07:43 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050511225058.GK22686@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-05-12 at 00:50 +0200, Petr Baudis wrote:
> > Rn
> > ---- Stop = Rn-1
> > Rn-1
> > ---- Stop = Rn-2
> 
> Mn
> Mn-1
> 
> > Rn-2
> > ---- Stop = Rn-3
> > 
> > The diff between Rn and Rn-1 contains always the changes merged from M
> 
> Yes, but you get the merge commits again since rev-list follows all the
> parents.

That's plain wrong. The Mn(1) change hit repository r between revision
Rn and Rn-1 and nowhere else. 

Date is irrelevant. The only relevant thing is the parent child(s)
relationship.

What you get doing this is history cluttering. In the repository R it is
completely irrelevant when Mn resp. Mn-1 was created. The only relevant
point is when it was merged into repository R.

Bitkeeper does the same bogus thing to make changesets appear in a
linear order. Look at the changeset logs. If you diff the versions
exported by bitkeeper then you get complete nonsense. 

Please do not make the same mistake. 


tglx





