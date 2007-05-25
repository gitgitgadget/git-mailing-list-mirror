From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Pulling from refs/remotes/ ?
Date: Thu, 24 May 2007 22:35:17 -0300
Message-ID: <46563D55.3070607@xs4all.nl>
References: <f35d9n$21e$1@sea.gmane.org> <7v7iqxvgx8.fsf@assigned-by-dhcp.cox.net>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 03:37:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrOkF-0005dx-V8
	for gcvg-git@gmane.org; Fri, 25 May 2007 03:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbXEYBh3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 21:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbXEYBh3
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 21:37:29 -0400
Received: from main.gmane.org ([80.91.229.2]:60016 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196AbXEYBh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 21:37:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HrOjz-0003uV-0s
	for git@vger.kernel.org; Fri, 25 May 2007 03:37:15 +0200
Received: from c911deb6.bhz.virtua.com.br ([201.17.222.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 May 2007 03:37:14 +0200
Received: from hanwen by c911deb6.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 May 2007 03:37:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c911deb6.bhz.virtua.com.br
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <7v7iqxvgx8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48324>

Junio C Hamano escreveu:
> Han-Wen Nienhuys <hanwen@xs4all.nl> writes:
> 
>> why can't I pull from a remote?  I can do 
>>
>>   git log REMOTE-BRANCH
>>   git diff BRANCH REMOTE-BRANCH
>>
>> etc. But pulling yields
>>
>>  [hanwen@haring foobar]$ git pull . origin/nonrandr-setup
>>  error: no such remote ref refs/heads/origin/nonrandr-setup
>>  Fetch failure: .
>>
>> also, "Fetch failure: .", what is that supposed to mean?
> 
> You are treating your local repository as if it is a remote
> repository somewhere else, namely, '.' (current repository).
> 
> Notice "git log" and "git diff" are LOCAL operations?  "git
> pull" is "git fetch" which is a remote operation (i.e. it
> interacts with a remote repository) followed by "git merge"
> which is a local operation to merge in what was fetched or what
> you already have locally.
> 
> I think you would want:
> 
> 	git merge REMOTE-BRANCH
> 
> e.g. "git merge origin/nonrandr-setup".

Yes, that works, thanks. Wouldn't it be more consistent with this
reasoning to disallow 

  git pull . LOCAL-BRANCH 

too?

I still think that "fetch failure" is a bad error message. 
What information does it convey?


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
