From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Merge problems with git-mingw
Date: Tue, 9 Oct 2007 18:33:37 +0200
Message-ID: <BA71DD45-9226-4661-9C92-60EEEA8638D0@zib.de>
References: <Pine.LNX.4.64.0710081203020.29715@ds9.cixit.se>  <8c5c35580710080500n78259210v1b087e1ef506c0ee@mail.gmail.com>  <Pine.LNX.4.64.0710081333350.29715@ds9.cixit.se>  <8c5c35580710080610y739fb51aga82964e212c7917f@mail.gmail.com>  <Pine.LNX.4.64.0710081555480.29570@ds9.cixit.se> <8c5c35580710081259j6d7e8587r546d4c35d42a67a6@mail.gmail.com> <Pine.LNX.4.64.0710090800220.26773@ds9.cixit.se> <470B2F7E.4080308@viscovery.net> <Pine.LNX.4.64.0710090953240.26773@ds9.cixit.se> <470B43D2.6090307@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 18:35:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfI2w-0007K0-WD
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 18:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbXJIQeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 12:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbXJIQeq
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 12:34:46 -0400
Received: from mailer.zib.de ([130.73.108.11]:33089 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535AbXJIQep (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 12:34:45 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l99GW4o2002602;
	Tue, 9 Oct 2007 18:34:42 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l99GW4Dn012367
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 9 Oct 2007 18:32:04 +0200 (MEST)
In-Reply-To: <470B43D2.6090307@viscovery.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60421>


On Oct 9, 2007, at 11:03 AM, Johannes Sixt wrote:

> Peter Karlsson schrieb:
>> C:\Program Files\Git\bin>git var -l
>> usage: git-var [-l | <variable>]
>> C:\Program Files\Git\bin>git-var -l
>> fatal: Not a git repository
>> C:\Program Files\Git\bin>git --version
>> git version 1.5.3.mingw.1
>
> For the time being, install this beast in a path without blanks.
>
> This needs fixing, appearently. :(

I have the printf 'callstack' below from the v1.5.3.mingw.1 version  
(9c792c5)
Apparently spawnve, which is called in compat/mingw.c, corrupts argv.

I have no idea how to continue debugging. Maybe some one else can  
take over.

	Steffen


$ git var GIT_COMMITTER_IDENT

argv at git.c:429
3
C:\Program Files (x86)\Git\bin\git.exe
var
C:/Program Files (x86)/Git/bin/git-var
GIT_COMMITTER_IDENT

argv at compat/mingw.c:301
C:/Program Files (x86)/Git/bin/git-var
GIT_COMMITTER_IDENT
(null)

argv at var.c:54
4
C:/Program
Files
(x86)/Git/bin/git-var
GIT_COMMITTER_IDENT
usage: git-var [-l | <variable>]
