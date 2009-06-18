From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git svn: Supporting multiple branch subdirs?
Date: Thu, 18 Jun 2009 18:00:28 +0200
Message-ID: <4A3A649C.8060403@drmicha.warpmail.net>
References: <4A32CCA5.7040404@xiplink.com> <4A339182.1090204@drmicha.warpmail.net> <4A368509.9070801@xiplink.com> <4A38FCEE.2020002@drmicha.warpmail.net> <4A390AFE.5070703@xiplink.com> <4A3A4945.6050307@drmicha.warpmail.net> <4A3A4F2A.1080701@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, normalperson@yhbt.net
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 18:01:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHK2v-0004dl-L8
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 18:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbZFRQAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 12:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752334AbZFRQAu
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 12:00:50 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48581 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752022AbZFRQAt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 12:00:49 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4D5203624D2;
	Thu, 18 Jun 2009 12:00:52 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 18 Jun 2009 12:00:52 -0400
X-Sasl-enc: 3zTemp9qb5NSt5mrzLR1H3iqUqnm8ZCatZnQJlICvus8 1245340852
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A2CA72778A;
	Thu, 18 Jun 2009 12:00:51 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090617 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <4A3A4F2A.1080701@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121851>

Marc Branchaud venit, vidit, dixit 18.06.2009 16:28:
> Michael J Gruber wrote:
>>
>> Heck it's perl, so don't even try to understand the code - after all,
>> perl only barely missed the final round in the last competition for the
>> next cryptographic algorithm!
> 
> :)
> 
> Hey, I'm not gonna dis something with such great job-security potential!
> 
>> That being said, I did some clueless hacking in git-svn.perl and let it
>> run against the freebsd repo. Now, how's that:
>>
>> ~/src/git/git-svn fetch -r1:10000
>>
>> git branch -r
>>   releng/2.0.5
>>   releng/ALPHA_2_0
>>   releng/BETA_2_0
>>   stable/2.0.5
>>   stable/2.1
>>   tags/2.0
>>   tags/2.0.5
>>   trunk
>>
>> The revision graph looks OK as well. The git-svn config which I used is:
> 
> Nice!
> 
>> [svn-remote "svn"]
>>         url = svn://svn.freebsd.org/base
>>         fetch = head:refs/remotes/trunk
>>         branches = releng/*:refs/remotes/releng/*
>>         branchse = stable/*:refs/remotes/stable/*
>>         tags = release/*:refs/remotes/tags/*
>>
>> No typo there, my git svn knows about "branches" and "branchse" now ;)
>> BTW: In fact there is overlap between releng and stable branches in the
>> feebsd repo, see 2.0.5.
> 
> By "overlap" do you mean single commits that touch both branches?  FreeBSD does that a lot.

No, I just meant that there are stable and releng branches with the same
name, so that they can't both be mapped to refs/remotes/* but need
different "namespaces" (subdirs) as above.

Michael
