From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Allow pickaxe to be used via git log.
Date: Thu, 18 May 2006 22:56:12 -0400
Message-ID: <BAYC1-PASMTP07581788E7BAAC19B2A159AEA70@CEZ.ICE>
References: <BAYC1-PASMTP04945C92FB14DA65AB1AC7AEA70@CEZ.ICE>
	<7v4pzmn32g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 05:02:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgvFf-0003Rl-Bb
	for gcvg-git@gmane.org; Fri, 19 May 2006 05:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWESDB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 23:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWESDB4
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 23:01:56 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:47688 "EHLO
	BAYC1-PASMTP07.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932181AbWESDBz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 23:01:55 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP07.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 18 May 2006 20:05:09 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id AECB6644C28;
	Thu, 18 May 2006 23:01:53 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060518225612.16c6441f.seanlkml@sympatico.ca>
In-Reply-To: <7v4pzmn32g.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 19 May 2006 03:05:09.0796 (UTC) FILETIME=[09DF1640:01C67AF1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 18 May 2006 19:47:19 -0700
Junio C Hamano <junkio@cox.net> wrote:

> If that (specifically, "when passed to git log") is what you
> want, do all of that in "git log" please.  I haven't checked,
> but I suspect your changes would break git-rev-list and makes it
> disobey the options the user gives it.
> 

Well, it's more general than just git log, but that's primarily where one
would see it.  Essentially the patch is saying that specifying both a
"revs->diffopt.pickaxe" string and "revs->always_show_header" is illegal
and proceeds to use pickaxe instead of the other.

Is there any place that depends on the ability to specify both a pickaxe
string _and_ always_show_header?  If not, it's hard to see how this patch
could break anything.

Sean
