X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: David Lang <dlang@digitalinsight.com>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 09:30:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0610260929040.2424@qynat.qvtvafvgr.pbz>
References: <45354AD0.1020107@utoronto.ca>  <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
  <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au>
  <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org> 
 <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu> 
 <Pine.LNX.4.64.0610240812410.3962@g5.osdl.org> 
 <Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu> 
 <20061025084810.GA26618@coredump.intra.peff.net> 
 <Pine.LNX.4.64N.0610250157470.3467@attu1.cs.washington.edu> 
 <20061025094900.GA26989@coredump.intra.peff.net> 
 <Pine.LNX.4.64N.0610250954380.31053@attu2.cs.washington.edu> <454098EC.8040406@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
NNTP-Posting-Date: Thu, 26 Oct 2006 16:33:24 +0000 (UTC)
Cc: David Rientjes <rientjes@cs.washington.edu>,
	Jeff King <peff@peff.net>, Linus Torvalds <torvalds@osdl.org>,
	Lachlan Patrick <loki@research.canon.com.au>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <454098EC.8040406@op5.se>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30234>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd8AI-0001yJ-QD for gcvg-git@gmane.org; Thu, 26 Oct
 2006 18:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423603AbWJZQdH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 12:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161434AbWJZQdH
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 12:33:07 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:986 "HELO
 warden.diginsite.com") by vger.kernel.org with SMTP id S1161433AbWJZQdE
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 12:33:04 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com via smtpd (for
 vger.kernel.org [209.132.176.167]) with SMTP; Thu, 26 Oct 2006 09:33:04 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by
 wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Thu, 26
 Oct 2006 09:32:23 -0700
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

On Thu, 26 Oct 2006, Andreas Ericsson wrote:

>> 
>> There are _not_ scalability improvements.  There may be some slight 
>> performance improvements, but definitely not scalability.  If you have ever 
>> tried to use git to manage terabytes of data, you will see this becomes 
>> very clear.  And "rebasing with 3-way merge" is not something often used in 
>> industry anyway if you've followed the more common models for revision 
>> control within large companies with thousands of engineers.  Typically they 
>> all work off mainline.
>> 
>
> Actually, I don't see why git shouldn't be perfectly capable of handling a 
> repo containing several terabytes of data, provided you don't expect it to 
> turn up the full history for the project in a couple of seconds and you don't 
> actually *change* that amount of data in each revision. If you want a vcs 
> that handles that amount with any kind of speed, I think you'll find rsync 
> and raw rvs a suitable solution.

actually, there are some real problems in this area. the git pack format can't 
be larger then 4G, and I wouldn't be surprised if there were other issues with 
files larger then 4G (these all boil down to 32 bit limits). once these limits 
are dealt with then you will be right.

