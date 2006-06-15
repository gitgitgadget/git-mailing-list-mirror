From: Sean <seanlkml@sympatico.ca>
Subject: Re: observations on parsecvs testing
Date: Thu, 15 Jun 2006 16:47:42 -0400
Message-ID: <BAYC1-PASMTP10021C1A6034B8753D06DDAE820@CEZ.ICE>
References: <Pine.LNX.4.64.0606151529350.16002@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: keithp@keithp.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 15 22:49:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqymD-00062M-2r
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 22:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWFOUtI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 16:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWFOUtI
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 16:49:08 -0400
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:15498 "EHLO
	BAYC1-PASMTP10.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932502AbWFOUtH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 16:49:07 -0400
X-Originating-IP: [65.93.43.191]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.191]) by BAYC1-PASMTP10.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 15 Jun 2006 13:51:24 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 0C999644C2A;
	Thu, 15 Jun 2006 16:49:05 -0400 (EDT)
To: Nicolas Pitre <nico@cam.org>
Message-Id: <20060615164742.570e33a0.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0606151529350.16002@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.9.2; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 15 Jun 2006 20:51:24.0750 (UTC) FILETIME=[77119EE0:01C690BD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 15 Jun 2006 16:37:30 -0400 (EDT)
Nicolas Pitre <nico@cam.org> wrote:

> Also rcs2git() is very inefficient especially with files having many 
> revisions as it reconstructs the delta chain on every call.  For example 
> mozilla/configure,v has at least 1690 revisions, and actually converting 
> it into GIT blobs goes at a rate of 2.4 objects per second _only_ on my 
> machine.  Can't objects be created as the delta list is walked/applied 
> instead?  That would significantly reduce the initial convertion time.

Hi Nicolas,

That was a planned optimization which I did mention to Keith previously.
Was kinda waiting to hear back how it was working for him, and if there
was an interest to put more work into it to include in his mainline.

Sean
