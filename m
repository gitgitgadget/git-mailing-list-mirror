From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Rename handling
Date: Wed, 21 Mar 2007 01:06:33 +0100
Organization: At home
Message-ID: <etpson$qih$1@sea.gmane.org>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org> <45FED31B.8070307@midwinter.com> <200703191903.20005.andyparkins@gmail.com> <45FEE2B2.6050904@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 01:04:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HToJS-0006Fq-Sh
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 01:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbXCUAEF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 20:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbXCUAEE
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 20:04:04 -0400
Received: from main.gmane.org ([80.91.229.2]:46169 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbXCUAEB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 20:04:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HToIy-0004dm-AE
	for git@vger.kernel.org; Wed, 21 Mar 2007 01:03:52 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 01:03:52 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 01:03:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42767>

Steven Grimm wrote:

> The following is actually my biggest beef with git's rename tracking, 
> and it has nothing whatsoever to do with git-log (though I agree git-log 
> needs to track renames too):
> 
> $ ls
> dir1
> $ ls dir1
> file1 file2 file3
> $ echo "#include file1" > dir1/file4
> $ git add dir1/file4
> $ git commit
> $ git pull
> $ ls
> dir1 dir2
> $ ls dir1
> file4
> $ ls dir2
> file1 file2 file3
> 
> That's just plain broken in my opinion. One can perhaps contrive a test 
> case or two where that's the desired behavior, but in the real world it 
> is almost never what you actually want.
> 
> By the way, I don't think fixing that is necessarily related to how 
> renames get detected, so in some sense it's a different bug report / 
> feature request than the rename hints one. It would be possible to 
> figure out the directory had been renamed based purely on content 
> analysis; a bunch of files all individually renamed to the same places 
> under a new directory, and a lack of any files at all left in the old 
> one, probably means the directory got renamed. The content-based rename 
> detector could handle this case.
 
Actually this came out in some earlier talk about recording renames 
and renames detection (IIRC in the big thread about VCS comparison which
used to be on Bazaar-NG wiki). And one of the arguments about why directory
rename doesn't work as _you_ expected is (beside that it is not that
easy to code) the fact that the alternate solution (new files going
to old subdir) can be correct and expected by _others_.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
