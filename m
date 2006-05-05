From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 05 May 2006 18:47:35 +0200
Organization: At home
Message-ID: <e3fvj2$779$1@sea.gmane.org>
References: <20060505005659.9092.qmail@science.horizon.com> <20060505062236.GA4544@c165.ib.student.liu.se> <20060505092332.GY27689@pasky.or.cz> <7vejz8241m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri May 05 18:49:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc3UD-0001hR-2t
	for gcvg-git@gmane.org; Fri, 05 May 2006 18:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWEEQsO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 12:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWEEQr6
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 12:47:58 -0400
Received: from main.gmane.org ([80.91.229.2]:51881 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751645AbWEEQrr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 12:47:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fc3Su-0001VO-LQ
	for git@vger.kernel.org; Fri, 05 May 2006 18:47:41 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 May 2006 18:47:40 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 May 2006 18:47:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19618>

Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
> 
>> But the non-obviously important part here to note is that the branch B
>> merely "corrects a typo on a comment somewhere" - the latest versions in
>> branch A and branch B are always compared for renames, therefore if
>> branch A renamed the file and branch B sums up to some larger-scale
>> changes in the file, it still won't be merged properly.
> 
> I probably am guilty of starting this misinformation, but the
> code does not compare the latest in A and B for rename
> detection; it compares (O, A) and (O, B).
> 
> But the end result is the same - what you say is correct.  If a
> path (say O to A) that renamed has too big a change, then no
> matter how small the changes are on the other path (O to B),
> rename detection can be fooled.  We could perhaps alleviate it
> by following the whole commit chain.

Or perhaps by helper information about renames, entered either by git-mv
(and git-cp) or rename detection at commit, e.g. in the following form

        note at <commit-sha1> was-in <pathname>
        note at <commit-sha1> was-in <pathname>

(with the obvious limit of this "note header" solution is that it wouldn't
work for filenames and directory name containing "\n"). I'm not sure if
<pathname> should be just basename, of full pathname.

-- 
Jakub Narebski
Warsaw, Poland
