From: Sean <seanlkml@sympatico.ca>
Subject: Re: [RFC PATCH] Add WEBDAV timeout to http-fetch.
Date: Sun, 8 Oct 2006 09:19:32 -0400
Message-ID: <BAYC1-PASMTP053FFB92C509E9427F85B0AE110@CEZ.ICE>
References: <20061006212616.GA5175@lumumba.uhasselt.be>
	<20061006220542.GA5890@lumumba.uhasselt.be>
	<BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE>
	<BAYC1-PASMTP11CF83A008B0B3BA5F6B15AE100@CEZ.ICE>
	<7viriwsa75.fsf@assigned-by-dhcp.cox.net>
	<eg82tq$2uq$1@sea.gmane.org>
	<Pine.LNX.4.63.0610071930300.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061007223023.GI20017@pasky.or.cz>
	<Pine.LNX.4.63.0610080034490.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vbqonpfyl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 08 15:19:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWYZC-0007u0-L5
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 15:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWJHNTg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 09:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWJHNTg
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 09:19:36 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:15554 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751138AbWJHNTf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 09:19:35 -0400
X-Originating-IP: [65.93.42.136]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.42.136]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 8 Oct 2006 06:19:34 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GWYZ3-0003qQ-5y; Sun, 08 Oct 2006 09:19:33 -0400
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20061008091932.4d8e62d9.seanlkml@sympatico.ca>
In-Reply-To: <7vbqonpfyl.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 08 Oct 2006 13:19:34.0519 (UTC) FILETIME=[659DE870:01C6EADC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 07 Oct 2006 21:52:02 -0700
Junio C Hamano <junkio@cox.net> wrote:

> Using DAV, if it works with the server, has the advantage of not
> having to keep objects/info/packs up-to-date from repository
> owner's point of view.  But the repository owner ends up keeping
> up-to-date as a side effect of keeping info/refs up-to-date
> anyway (as I do not see a code to read that information over
> DAV), so there is no point doing this over DAV in practice.
> 
> Perhaps we should remove call to remote_ls() from
> fetch_indices() unconditionally, not just protected with
> NO_EXPAT and be done with it?

That makes a lot of sense.  A server really has to always provide
a objects/info/packs anyway, just to be fetchable today by clients
that are compiled with NO_EXPAT.

+1

Sean
