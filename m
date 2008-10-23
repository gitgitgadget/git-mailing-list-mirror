From: Andreas Ericsson <ae@op5.se>
Subject: Re: git performance
Date: Thu, 23 Oct 2008 09:43:35 +0200
Message-ID: <49002B27.50201@op5.se>
References: <000801c93483$2fdad340$8f9079c0$@com> <m3d4hsi708.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Edward Ned Harvey <git@nedharvey.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 09:44:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsusI-0006lI-Mr
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 09:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbYJWHnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 03:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbYJWHnj
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 03:43:39 -0400
Received: from mail.op5.se ([193.201.96.20]:33213 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbYJWHnj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 03:43:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0B9B71B800A6;
	Thu, 23 Oct 2008 09:37:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.926
X-Spam-Level: 
X-Spam-Status: No, score=-3.926 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.473, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yBoFePXdmH1c; Thu, 23 Oct 2008 09:37:22 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 035631B8006F;
	Thu, 23 Oct 2008 09:37:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <m3d4hsi708.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98945>

Jakub Narebski wrote:
> "Edward Ned Harvey" <git@nedharvey.com> writes:
> 
>> I see things all over the Internet saying git is fast.  I'm
>> currently struggling with poor svn performance and poor attitude of
>> svn developers, so I'd like to consider switching to git.  A quick
>> question first.
>>
>> The core of the performance problem I'm facing is the need to "walk
>> the tree" for many thousand files.  Every time I do "svn update" or
>> "svn status" the svn client must stat every file to check for local
>> modifications (a coffee cup or a beer worth of stats).  In essence,
>> this is unavoidable if there is no mechanism to constantly monitor
>> filesystem activity during normal operations.  Analogous to
>> filesystem journaling.
>>
>> So - I didn't see anything out there saying "git is fast because it
>> uses inotify" or anything like that.  Perhaps git would not help me
>> at all?  Because git still needs to stat all the files in the tree?
> 
> http://git.or.cz/gitwiki/GitBenchmarks
> 
> While it should be possible to use 'assume unchanged' bit together
> with inotify / icron, it is not something tha is done; IIRC Mercurial
> had Linux-only InotifyPlugin...
> 

Well, inotify() is Linux specific, so it'd be quite hard to support on
another platform. Emulating it with a billion stat() calls feels rather
like a disk (and I/O performance) killer.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
