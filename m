From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Stop git-rev-list at sha1 match
Date: Thu, 12 May 2005 00:31:13 +0000
Organization: linutronix
Message-ID: <1115857873.22180.253.camel@tglx>
References: <1115839456.22180.79.camel@tglx>
	 <7vy8alr0mz.fsf@assigned-by-dhcp.cox.net> <1115843429.22180.90.camel@tglx>
	 <7vis1pqvi4.fsf@assigned-by-dhcp.cox.net>
	 <20050511221719.GH22686@pasky.ji.cz> <1115851742.22180.154.camel@tglx>
	 <20050511225058.GK22686@pasky.ji.cz> <1115852914.22180.170.camel@tglx>
	 <20050511234455.GL22686@pasky.ji.cz>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 02:23:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW1To-0006rq-CT
	for gcvg-git@gmane.org; Thu, 12 May 2005 02:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVELAa3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 20:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVELAa3
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 20:30:29 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:51331
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261265AbVELAaW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 20:30:22 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 4ADF565C003;
	Thu, 12 May 2005 02:30:20 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 2A7D02807D;
	Thu, 12 May 2005 02:30:22 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050511234455.GL22686@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-05-12 at 01:44 +0200, Petr Baudis wrote:
> for extensive discussion on how (it is impossible or very hard) to do
> better.

:)

> So how would you order the list of commits?

Rn
  merged Mn
  merged Mn-1
Rn-1
....

That's the relevant information in repository R. Looking at it from
repository M after M updated to Rn

(Mn+1) == Rn	; Mn+1 is not created due to head forward
  merged Rn
  .. 
  merged Rn-3
Mn
Mn-1

Thats the historical correct ordering from a repository point of view.
Thats the only relevant information IMNSHO.

The dates of author and committer are retrievable in each repository,
but the order of commits are not.


tglx



