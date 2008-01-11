From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: CRLF problems with Git on Win32
Date: Fri, 11 Jan 2008 17:28:47 +0100
Message-ID: <D36EB89D-11A3-4EAF-BC1C-6100383FCBFC@zib.de>
References: <C3AC3E6F.10D42%jefferis@gmail.com> <alpine.LFD.1.00.0801101556380.3148@woody.linux-foundation.org> <7EAB1DA8-627D-455E-AA23-C404FDC615D9@zib.de> <alpine.LFD.1.00.0801110756260.3148@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gregory Jefferis <jefferis@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 17:32:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDMoB-0005lw-CC
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 17:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759732AbYAKQcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 11:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759672AbYAKQcA
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 11:32:00 -0500
Received: from mailer.zib.de ([130.73.108.11]:35710 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758741AbYAKQb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 11:31:59 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0BGRhV3008991;
	Fri, 11 Jan 2008 17:27:43 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0BGRgLY013755
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 11 Jan 2008 17:27:42 +0100 (MET)
In-Reply-To: <alpine.LFD.1.00.0801110756260.3148@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70173>


On Jan 11, 2008, at 4:58 PM, Linus Torvalds wrote:

>
>
> On Fri, 11 Jan 2008, Steffen Prohaska wrote:
>>
>> Are you also for "autocrlf=input" as the default on Unix?
>
> No. What would it help?

You may later decide that you want to check out your project on Windows.
In this case your repository should not contain CRLF.  autocrlf=input
ensures this.

So given the current options, autocrlf=input is the only
reasonable default on Unix if git wants to support cross-platform
development as its default.


> "autocrlf" on Windows actually helps you (big upside, very small
> downside). On Unix or other sane systems, it has zero upside, so  
> while the
> risk is still very small, there is now no big upside to counteract it.

autocrlf=input on Unix helps cross-platform development, too.


> Again, what is "default" supposed to be? I argue that it's supposed  
> to be
> the thing that is right for 99.9% of all people. And that simply isn't
> true on Unix.

autocrlf=input is true for the very same people that need autocrlf=true
on Windows.  Every developer who ever plans to check out his code on
Windows and on Unix should have these default.

I don't think the CRLF problem is a Windows vs. Unix discussion.
In my view, the discussion is wether git will have real cross-
platform support as its default or not.  The current default is
sane for native Unix or native Windows projects.  For cross-
platform projects the default needs to be changed in the way
described above.  Git needs to ensure that CRLF never enters the
repository for text files.  If you did not set autocrlf=true,
copying source code from Windows to Unix would not be supported.
But as you earlier mentioned, this seems to be a common
operation and I am observing the same.  So I recommend
autocrlf=input on Unix if you plan to ever go cross-platform.

	Steffen
