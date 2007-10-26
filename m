From: Olivier Ramonat <olivier@ramonat.fr>
Subject: Re: How to remove a specific hunk
Date: Fri, 26 Oct 2007 23:59:45 +0200
Message-ID: <87prz1a65q.fsf@tah.ramonat.fr>
References: <4722036E.5030204@wanadoo.fr> <472207AA.8030100@op5.se>
	<47220A05.4040705@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 00:30:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlXhB-0005Jj-2v
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 00:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757120AbXJZWaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 18:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757145AbXJZWaK
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 18:30:10 -0400
Received: from main.gmane.org ([80.91.229.2]:41851 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757091AbXJZWaI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 18:30:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IlXgp-0000NX-7y
	for git@vger.kernel.org; Fri, 26 Oct 2007 22:30:03 +0000
Received: from 48.168.102-84.rev.gaoland.net ([84.102.168.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Oct 2007 22:30:03 +0000
Received: from olivier by 48.168.102-84.rev.gaoland.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Oct 2007 22:30:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 48.168.102-84.rev.gaoland.net
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:svPZzJ89jC+HXcs1GjvAv9UtcB0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62447>

Pascal,

Pascal Obry <pascal.obry@wanadoo.fr> writes:
> Andreas,
>
>> Once you've added the other two hunks, they'll no longer show up in
>> git-diff, so you can do something like this:
>> 
>> $ git-add -i; # add the other two hunks to commit
>> $ git-diff > middle-hunk.patch
>> $ git-apply -R middle-hunk.patch
>> test, test, test
>> $ git-apply middle-hunk.patch
>
> Thanks, this will clearly work. I was expecting something more
> integrated like a "git reset --interactive" or something like that :)

A solution could be :

git add -i 
--> Add the two "good" hunks

git checkout-index file_with_bad_hunk
--> Remove the "bad" hunk by getting the staged version

And then 
git reset HEAD file_with_bad_hunk 
if you want to unstage it.

Olivier
