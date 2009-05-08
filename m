From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: Fault in curl on Ubuntu 9.04 with git 1.6.3
Date: Fri, 8 May 2009 07:39:34 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.0905080736490.22055@yvahk2.pbagnpgbe.fr>
References: <9e4733910905071907q44de8980je4008695092d4a90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 07:58:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2J64-0007ow-EP
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 07:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbZEHF5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 01:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbZEHF5d
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 01:57:33 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:37030 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbZEHF5c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 01:57:32 -0400
X-Greylist: delayed 1144 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 May 2009 01:57:32 EDT
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n485cMLY025960;
	Fri, 8 May 2009 07:38:22 +0200
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <9e4733910905071907q44de8980je4008695092d4a90@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118565>

On Thu, 7 May 2009, Jon Smirl wrote:

> It's doing a fetch of a remote http server...
> I hit this once. Then ran the gdb and hit it again.
>
> I installed libcurl3-dbg and was unable to get it to reproduce again after 
> that.

[...]

> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7f2b89134710 (LWP 22527)]
> 0x00007f2b88d299d0 in ?? () from /usr/lib/libcurl.so.4
> (gdb)  bt
> #0  0x00007f2b88d299d0 in ?? () from /usr/lib/libcurl.so.4
> #1  0x00007f2b88d2a55c in ?? () from /usr/lib/libcurl.so.4
> #2  0x00007f2b88d2a762 in ?? () from /usr/lib/libcurl.so.4
> #3  0x00007f2b88d2b24b in curl_multi_perform () from /usr/lib/libcurl.so.4

This really is too few details to work with. curl_multi_perform() is the entry 
point to a lot of code so without better pinpointing to exactly what failed 
this is next to impossible for me to guess.

Note also that we've done a few more releases from the curl project since 
7.18.2 so you may suffer from an already fixed bug.

-- 

  / daniel.haxx.se
