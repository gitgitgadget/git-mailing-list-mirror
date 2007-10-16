From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 09:14:03 +0200
Message-ID: <2EA3BEC9-5B13-44D3-B190-CA77499F642C@zib.de>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org> <471448D0.6080200@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eli Zaretskii <eliz@gnu.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	tsuna@lrde.epita.fr, make-w32@gnu.org, Andreas Ericsson <ae@op5.se>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 09:13:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihgbo-0001iq-J3
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 09:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209AbXJPHMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 03:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755167AbXJPHMp
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 03:12:45 -0400
Received: from mailer.zib.de ([130.73.108.11]:57802 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755177AbXJPHMo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 03:12:44 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9G7CYNe019145;
	Tue, 16 Oct 2007 09:12:34 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1b21a.pool.einsundeins.de [77.177.178.26])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9G7CXxI020452
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 16 Oct 2007 09:12:34 +0200 (MEST)
In-Reply-To: <471448D0.6080200@op5.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61099>


On Oct 16, 2007, at 7:14 AM, Andreas Ericsson wrote:

> Eli Zaretskii wrote:
>>> Date: Mon, 15 Oct 2007 20:45:02 -0400 (EDT)
>>> From: Daniel Barkalow <barkalow@iabervon.org>
>>> cc: Alex Riesen <raa.lkml@gmail.com>, Johannes.Schindelin@gmx.de,  
>>> ae@op5.se,     tsuna@lrde.epita.fr, git@vger.kernel.org, make- 
>>> w32@gnu.org
>>>
>>> I believe the hassle is that readdir doesn't necessarily report a  
>>> README in a directory which is supposed to have a README, when it  
>>> has a readme instead.
>> Sorry I'm asking potentially stupid questions out of ignorance: why
>> would you want readdir to return `README' when you have `readme'?
>
> Because it might have been checked in as README, and since git is case
> sensitive that is what it'll think should be there when it reads the
> directories. If it's not, users get to see
>
> 	removed: README
> 	untracked: readme
>
> and there's really no easy way out of this one, since users on a case-
> sensitive filesystem might be involved in this project too, so it
> could be an intentional rename, but we don't know for sure. Just
> clobbering the in-git file is wrong, but overwriting a file on disk
> is wrong too. git tries hard to not ever lose any data for the user.

Maybe we need a configuration similar to core.autocrlf (which controls
newline conversion) to control filename comparison and normalization?

Most obviously for the case (in-)sensitivity on Windows, but I also
remember the unicode normalization happening on Mac's HFS filesystem
that caused trouble in the past.

	Steffen
