From: Steven Grimm <koreth@midwinter.com>
Subject: Re: GIT on MinGW problem
Date: Sun, 27 May 2007 00:21:47 -0700
Message-ID: <4659318B.20801@midwinter.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org> <Pine.LNX.4.64.0705262318190.4648@racer.site> <4658BA64.2050904@xs4all.nl> <f3agkk$bhn$1@sea.gmane.org> <4659259D.4000803@xs4all.nl> <20070527063902.GB28023@spearce.org> <46592CFE.40303@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Sun May 27 09:21:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsD4e-00034M-S2
	for gcvg-git@gmane.org; Sun, 27 May 2007 09:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbXE0HVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 03:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbXE0HVu
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 03:21:50 -0400
Received: from tater.midwinter.com ([216.32.86.90]:54350 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750766AbXE0HVt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 03:21:49 -0400
Received: (qmail 15963 invoked from network); 27 May 2007 07:21:48 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO pinklady.local) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 27 May 2007 07:21:48 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <46592CFE.40303@xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48524>

Han-Wen Nienhuys wrote:
>> On systems like Cygwin the fork+exec overheads are very high
> A well written configure script is able to detect presence
> of a linkable libcurl. 
>   

IMO the reasons configure is so unwieldy, at least as it's set up in 
most open source projects, are that a) it spends 95% of its time 
checking for things that basically never vary (yes, I have stdlib.h, 
thank you) and that b) it doesn't remember the results from previous 
runs on the same host (I'm just changing the install path; my ints won't 
have stopped being 32 bits as a result.) I wonder if we could satisfy 
most people with a configure script -- maybe not based on autoconf -- 
that is limited in scope to just the things that are currently tweakable 
in the git Makefile.

If configure ran only, say, 10-15 tests, I bet the fork+exec overhead on 
Cygwin would be perfectly tolerable.

-Steve
