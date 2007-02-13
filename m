From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Efficiency of initial clone from server
Date: Tue, 13 Feb 2007 01:51:16 +0100
Organization: At home
Message-ID: <eqr1up$uvv$1@sea.gmane.org>
References: <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com> <Pine.LNX.4.64.0702112022430.1757@xanadu.home> <7vd54gau3r.fsf@assigned-by-dhcp.cox.net> <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com> <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net> <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com> <9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com> <20070212051108.GB699@spearce.org> <9e4733910702112117o53630946ja50572c7c7f2b2c1@mail.gmail.com> <Pine.LNX.4.64.0702121013150.1757@xanadu.home> <20070212193507.GA18730@thunk.org> <7vd54f85du.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 01:50:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGlsP-00068h-3G
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 01:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbXBMAu3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 19:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932821AbXBMAu3
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 19:50:29 -0500
Received: from main.gmane.org ([80.91.229.2]:50460 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976AbXBMAu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 19:50:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HGlrq-0002Lb-Hw
	for git@vger.kernel.org; Tue, 13 Feb 2007 01:49:58 +0100
Received: from host-81-190-26-216.torun.mm.pl ([81.190.26.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 01:49:58 +0100
Received: from jnareb by host-81-190-26-216.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 01:49:58 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-216.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39469>

Junio C Hamano wrote:

> Theodore Tso <tytso@mit.edu> writes:
> 
>> Even before we get Git 1.5.0 installed on master.kernel.org (and we
>> should really ask hpa to do that), is there a reason we haven't done
>> something like this across all of the kernel repo's on
>> master.kernel.org?
>>
>> for i in <list of kernel git repo's on master.kernel.org>
>> do
>>    pushd $i
>>    if [ ! -f objects/info/alternates ]; then
>>      echo /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects \
>>         > objects/info/alternates
>>      git repack -a -d -l
>>    fi
>>    popd
>> done
> 
> Perhaps s/<list of kernel git repo's on master.kernel.org>/& minus a few/?
> 
> "Minus a few" are (obviously) Linus's repository and bkcvs
> historical ones (I think there are two of them).
> 
> Other than that I do not think of a major problem.  Repacking
> into one would inconvenience http clients but that is not a new
> issue and would have happened when the owner of the individual
> repository chose to do so anyway.

So objects/info/http-alternates should be also set, I guess...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
