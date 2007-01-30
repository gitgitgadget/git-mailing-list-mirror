From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 09:45:46 +0100
Organization: eudaptics software gmbh
Message-ID: <45BF05BA.4B356B37@eudaptics.com>
References: <200701292320.43888.johannes.sixt@telecom.at> <Pine.LNX.4.64.0701291438580.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 09:44:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBobm-0008IA-6e
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 09:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbXA3Iov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 03:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbXA3Iov
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 03:44:51 -0500
Received: from main.gmane.org ([80.91.229.2]:41894 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648AbXA3Iou (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 03:44:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HBobN-0002sc-N3
	for git@vger.kernel.org; Tue, 30 Jan 2007 09:44:29 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 09:44:29 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 09:44:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38139>

Linus Torvalds wrote:
> Can you elaborate about any performance differences, especially with
> cygwin? Does this make git perform reasonably on Windows, or are the
> performance problems as bad as with cygwin?

Performance is horrid, although better than I initially expected. I
don't (want to) have cygwin installed to compare it (that's why I did
the MinGW port in the first place ;) Maybe others can comment on this?

The test suite takes ~15min to complete on my box, which is an oooold
800MHz with a slow HD. (And it's still Win2K, if that matters.)

Quite frankly, the "performance boost" that I expect from this port is
that it allows me the workflow that I want, instead of constantly
banging my head against the walls of CVS/SVN/you-name-it.

> gitk really shouldn't use either. It should probably use
> 
>         git-show-ref -h -d
> 
> instead, which has the same output format (modulo a space vs tab issue),
> and is entirely local, with no silly unnecessary remote connext.

Thanks, this works (I tested Junio's version). The problem with
ls-remote was that it is a shell script, and for some reason it dumps
its output into a cmd.exe that opens and closes right away instead of to
the pipe.

-- Hannes
