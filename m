From: Sham Rao <sham@styk.net>
Subject: Re: Out of memory, malloc failed
Date: Sat, 9 May 2009 00:41:52 +0000 (UTC)
Message-ID: <loom.20090509T003749-604@post.gmane.org>
References: <4A049715.10407@styk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 09 04:05:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2bwH-00015B-Pp
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 04:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbZEICFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 22:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbZEICFL
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 22:05:11 -0400
Received: from main.gmane.org ([80.91.229.2]:59473 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752423AbZEICFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 22:05:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M2agY-0001tG-5u
	for git@vger.kernel.org; Sat, 09 May 2009 00:45:02 +0000
Received: from styk.net ([65.39.84.193])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 May 2009 00:45:02 +0000
Received: from sham by styk.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 May 2009 00:45:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 65.39.84.193 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.9) Gecko/2009041500 SUSE/3.0.9-0.1.1 Firefox/3.0.9)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118646>

sham <sham <at> styk.net> writes:

> 
> Can anyone shed some light on this?  What can I do to get past this...
> 
> #0  die (err=0x4bfb09 "Out of memory, malloc failed") at usage.c:71
> #1  0x000000000049ac8c in xmalloc (size=555680492) at wrapper.c:29
> #2  0x000000000048e59f in unpack_compressed_entry (p=0x71d690,
> ...Snip...
> #8  0x000000000046b42a in checkout_entry (ce=0x7ffff4d73080,
> state=0x7fffffffdb10, topath=<value optimized out>) at entry.c:233
> #9  0x000000000041488d in cmd_checkout (argc=<value optimized out>,
> argv=<value optimized out>, prefix=0x0) at builtin-checkout.c:141
> #10 0x0000000000404843 in handle_internal_command (argc=2,
> argv=0x7fffffffdde0) at git.c:241
> #11 0x0000000000404a5c in main (argc=2, argv=0x7fffffffdde0) at git.c:481
> 
> Thanks,
> Sham
> 


I was able to resolve this issue by changing limits via the ulimit command. 
Upon increasing the values using ulimit -m WWWW and ulimit -v XXXX, the git
checkout worked (although slow).

-Sham
