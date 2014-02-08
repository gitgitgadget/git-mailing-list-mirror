From: Carlos Pereira <jose.carlos.pereira@ist.utl.pt>
Subject: git best strategy for two version development
Date: Sat, 08 Feb 2014 02:06:41 +0000
Message-ID: <52F59131.5000808@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 03:03:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBxGo-0004lJ-28
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 03:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbaBHCDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 21:03:30 -0500
Received: from smtp2.ist.utl.pt ([193.136.128.22]:55036 "EHLO smtp2.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbaBHCD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 21:03:29 -0500
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Feb 2014 21:03:29 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id 24F8E70003D6
	for <git@vger.kernel.org>; Sat,  8 Feb 2014 01:54:12 +0000 (WET)
X-Virus-Scanned: by amavisd-new-2.6.4 (20090625) (Debian) at ist.utl.pt
Received: from smtp2.ist.utl.pt ([127.0.0.1])
	by localhost (smtp2.ist.utl.pt [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id NMuffr7JfpSJ for <git@vger.kernel.org>;
	Sat,  8 Feb 2014 01:54:12 +0000 (WET)
Received: from mail2.ist.utl.pt (mail.ist.utl.pt [IPv6:2001:690:2100:1::8])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id ECA0770003CC
	for <git@vger.kernel.org>; Sat,  8 Feb 2014 01:54:11 +0000 (WET)
Received: from [IPv6:2001:690:2100:1c0:7aac:c0ff:feff:eff7] (unknown [IPv6:2001:690:2100:1c0:7aac:c0ff:feff:eff7])
	(Authenticated sender: ist12604)
	by mail2.ist.utl.pt (Postfix) with ESMTPSA id AB8762003A3D
	for <git@vger.kernel.org>; Sat,  8 Feb 2014 01:54:11 +0000 (WET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20121215 Icedove/3.0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241817>

Hello,

I am a git and CVS newbie, I bought and red most of the excellent Pro 
Git book by Scott Chacon, but I still have a doubt. I have a package 
that I distribute in two versions differing only in one library: 
version_A uses this library, version_B uses my own code to replace it. 
For strategic reasons I want to keep it this way for the time being. 
Both versions have the same documentation, the same data files, and 99% 
of the source code is the same (a few makefile changes, two additional 
files in version_B and some minor changes: a diff -r has only 170 
lines). The question is what is the best strategy to manage a situation 
like this with git?

Shall I maintain two different repositories? I don't think so...

Apparently the best solution would be to maintain two long term 
branches, say mater_A and master_B, and merge all later developments in 
both branches, keeping the initial difference... Specifically:

1) do some new work in branch master_A, commit, etc.
2) checkout master_B and merge the new work in master_B, without merging 
the initial diff between the two versions.

What is the better way to do that?

I suppose this is a fairly common situation, for example, some 
standalone code distributed with two different GUI toolkits. I could 
carefully choose which commits should be merged in both branches (the 
changes in standalone code) and which should not (the changes in GUI 
code), but that is error-prone and seems to miss the whole point of 
using a managment system...

How shall I handle this? Thanks for your help!

Regards,
Carlos Pereira,
http://www.gamgi.org/
