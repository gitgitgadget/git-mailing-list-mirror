From: David Lang <dlang@digitalinsight.com>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 19:43:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0609271938070.23262@qynat.qvtvafvgr.pbz>
References: <20060928024938.46785.qmail@web51009.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Sean <seanlkml@sympatico.ca>, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 04:57:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSm58-00043c-Sc
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 04:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbWI1C5A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 22:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbWI1C5A
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 22:57:00 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:46820 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S965238AbWI1C47
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 22:56:59 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Wed, 27 Sep 2006 19:56:59 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Wed, 27 Sep 2006 19:56:33 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060928024938.46785.qmail@web51009.mail.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27971>

On Wed, 27 Sep 2006, Matthew L Foster wrote:

> --- Sean <seanlkml@sympatico.ca> wrote:
>
>> On Wed, 27 Sep 2006 18:48:11 -0700 (PDT)
>> Matthew L Foster <mfoster167@yahoo.com> wrote:
>>
>>> I actually understand that and agree. All I've been saying is it (git or gitweb.cgi) should
>> prefer
>>> the local timestamp rather than any "remote" timestamps for no other reason than to minimize
>> the
>>> possibility of timestamps being grossly inaccurate.
>>
>> But any local time stamp would be a _lie_.  The time stamp in the commit records
>> when it was actually created.  And as Junio has pointed out, hundreds of commits
>> will typically arrive in a repo at the exact same time.  Your suggestion would
>> have them all showing the exact same time.  That's not helpful, and it loses
>> important factual information.
>
> How does git ensure that the timestamp in a commit records when it was actually created? I am not
> saying throw away creation time, just that local time is more preferable and relevant and
> git/gitweb.cgi should not in any way depend on time being configured correctly on each and every
> git server. I think users of kernel.org's repo (or web interface) care more about when change X
> was commited to it than when an author created/emailed change X, but perhaps I am wrong or don't
> understand git or both.

what you are missing is that there is no one true time 'when the change was 
commited' to record.

the closest that you can get in a distributed environement is 'when was this 
change created' and that is the locally defined time on the box that created it 
(or as Ted stated, some much more complicated process requireing network access 
to a certified time server)

after it has been created it has been commited (on that box). the same change 
could be commited on 50 other boxes, either by receiving it through git, or by 
receiving it via other methods.

all 51 of the boxes above are equally important to git. the fact that one or two 
of those boxes happen to have a user named Linus doesn't matter.

however, if what you want to know is 'in what order did this change get into the 
tree I am looking at compared to other changes' git can tell you that and what 
it will tell you is accurate, no matter what the clocks are set to on the 
various systems.

David Lang
