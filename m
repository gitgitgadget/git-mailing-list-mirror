From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: git-p4 fails when cloning a p4 depo.
Date: Mon, 11 Jun 2007 22:07:45 -0300
Message-ID: <466DF1E1.9060408@xs4all.nl>
References: <1621f9fa0706080941k67d2878dud8cf06436c67aea0@mail.gmail.com> <1621f9fa0706081113w7bb765ebx74f03a7407b753cb@mail.gmail.com> <200706090038.33799.simon@lst.de>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Benjamin Sergeant <bsergean@gmail.com>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 03:11:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxuuY-000820-MS
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 03:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755929AbXFLBKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 21:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755931AbXFLBKy
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 21:10:54 -0400
Received: from main.gmane.org ([80.91.229.2]:59502 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755929AbXFLBKx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 21:10:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HxuuD-0006nC-Pa
	for git@vger.kernel.org; Tue, 12 Jun 2007 03:10:45 +0200
Received: from c911deb6.bhz.virtua.com.br ([201.17.222.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 03:10:45 +0200
Received: from hanwen by c911deb6.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 03:10:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c911deb6.bhz.virtua.com.br
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <200706090038.33799.simon@lst.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49905>

Simon Hausmann escreveu:
> On Friday 08 June 2007 20:13:55 Benjamin Sergeant wrote:
>> A perforce command with all the files in the repo is generated to get
>> all the file content.
>> Here is a patch to break it into multiple successive perforce command
>> who uses 4K of parameter max, and collect the output for later.
>>
>> It works, but not for big depos, because the whole perforce depo
>> content is stored in memory in P4Sync.run(), and it looks like mine is
>> bigger than 2 Gigs, so I had to kill the process.
> 
> I'd be generally fine with splitting up the "p4 print ..." calls into chunks 
> but you have a good point with the memory usage. The old approach of calling 
> print per file did not have any of those limitations. Han-Wen, what do you 
> think? How much of a performance improvement is the batched print?

One unscientific measurement (getting 1 file vs. 30 files)
indicates that this is about 5x times faster. 

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
