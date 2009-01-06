From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Error: unable to unlink ... when using "git gc"
Date: Tue, 6 Jan 2009 15:33:57 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngm6uf5.vuo.sitaramc@sitaramc.homelinux.net>
References: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com>
 <20090106072253.GA9920@coredump.intra.peff.net>
 <488807870901052352w585da727r6d4a1e4ca4238cab@mail.gmail.com>
 <20090106080300.GA10079@coredump.intra.peff.net>
 <slrngm6hoj.n4a.sitaramc@sitaramc.homelinux.net>
 <488807870901060705m49419ec1he14aace5caaa3d89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 16:35:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKDxq-0004P0-VF
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 16:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbZAFPeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 10:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbZAFPeL
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 10:34:11 -0500
Received: from main.gmane.org ([80.91.229.2]:51121 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836AbZAFPeK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 10:34:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LKDwT-0003ls-J8
	for git@vger.kernel.org; Tue, 06 Jan 2009 15:34:05 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 15:34:05 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 15:34:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104694>

On 2009-01-06, Johnny Lee <johnnylee194@gmail.com> wrote:

> On Tue, Jan 6, 2009 at 7:57 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:

>> If you're not worried about the finer-grained access control
>> that acl(5) gives you, just do what "git init
>> --shared=group" does:
>>
>>    git config core.sharedrepository 1 # as mentioned above
>>    chmod g+ws .git
>>
>> Now set the group to something (I use "gitpushers" ;-)
>>
>>    chgrp -R gitpushers .git
>>
>> amd make sure all your users are part of that group.

> We also plan to do it in this way, just a small wondering that it
> looks a kind of workaround instead of a more graceful solution.

I wouldn't consider it a workaround.  It uses normal Unix
permissions the way they were designed to, including setgid
for directories.

Actually, I am yet to come up with a situation where I
actually needed ACLs, though they are more generalised, and
fine-grained.

And the maint is all eminently scriptable.
