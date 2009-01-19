From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: [PATCH] git-svn: fix SVN 1.1.x compatibility
Date: Mon, 19 Jan 2009 10:17:01 +0100
Message-ID: <4974450D.4090608@statsbiblioteket.dk>
References: <496722CF.1060802@statsbiblioteket.dk> <20090112010354.GB23377@yp-box.dyndns.org> <496AF964.1070208@statsbiblioteket.dk> <20090117105811.GB15801@dcvr.yhbt.net> <20090119004556.GA25038@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jan 19 10:18:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOqH7-00025U-Le
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 10:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152AbZASJRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 04:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755114AbZASJRH
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 04:17:07 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:41580 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755077AbZASJRF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 04:17:05 -0500
Received: from [130.225.25.159] (130.225.25.159) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.1.336.0; Mon, 19 Jan 2009 10:17:01 +0100
User-Agent: Thunderbird 2.0.0.18 (X11/20081124)
In-Reply-To: <20090119004556.GA25038@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106339>

Eric Wong wrote:
> The get_log() function in the Perl SVN API introduced the limit
> parameter in 1.2.0.  However, this got discarded in our SVN::Ra
> compatibility layer when used with SVN 1.1.x.  We now emulate
> the limit functionality in older SVN versions by preventing the
> original callback from being called if the given limit has been
> reached.  This emulation is less bandwidth efficient, but SVN
> 1.1.x is becoming rarer now.
> 
> Additionally, the --limit parameter in svn(1) uses the
> aforementioned get_log() functionality change in SVN 1.2.x.
> t9129 no longer depends on --limit to work and instead uses
> Perl to parse out the commit message.
> 
> Thanks to Tom G. Christensen for the bug report.
> 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>

I applied this to 1.6.1 and the testsuite now passes using SVN 1.1.4 on 
RHEL 4/i386 (t9106 still fails on RHEL 4/x86_64).

-tgc
