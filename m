From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Tue, 2 Sep 2008 23:51:18 +0200
Message-ID: <0578A0F2-F90A-4555-9B34-726F26A1CDBB@ai.rug.nl>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl> <7vk5dujn9h.fsf@gitster.siamese.dyndns.org> <20080902210524.GB7757@leksak.fem-net>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:52:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kadnn-0007wU-O5
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 23:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbYIBVvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 17:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbYIBVvh
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 17:51:37 -0400
Received: from frim.nl ([87.230.85.232]:59615 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752113AbYIBVvg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Sep 2008 17:51:36 -0400
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.11])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1Kadmc-0000p4-8y; Tue, 02 Sep 2008 23:51:30 +0200
In-Reply-To: <20080902210524.GB7757@leksak.fem-net>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94722>


On 2 sep 2008, at 23:05, Stephan Beyer wrote:

> Junio C Hamano wrote:
>> Pieter de Bie <pdebie@ai.rug.nl> writes:
>>
> [..]
>>> Vienna:git pieter$ ./git commit --allow-empty -m"test"
>>> Created commit 6ce62c8b: test
>>> You are on a detached head, so this commit has not been recorded  
>>> in a branch.
>>> If you don't want to lose this commit, checkout a branch and then  
>>> run:
>>> 	git merge 6ce62c8bfcfb341106f3587d1c141c3955c2544c
>>>
>>> Are there any comments to this / strong opinions against such a  
>>> change?
>>
>> Unconditionally doing this is too loud for my taste.  You probably  
>> can do
>> this in your post-commit hook.
>
> Well, Pieter probably can do this in his post-commit hook. But I think
> this is useful for usability... especially for beginners who might not
> even know what a hook is. ;)

Exactly..I can fix this for myself, and when things go wrong I can also
fix it, but there are people less with Git that don't understand what's
going on.

> For me this felt too loud, too, especially since "git status" and
> "git commit" (without message option) already tells the user that
> she is on a detached HEAD. And "git commit -a" is usually done after
> a "git status", too, isn't it? (I do not use "git commit -a", I *use*
> the index.)


The one in "git status" is somewhat noticeable with color highlighting,
but the "git commit" one doesn't exactly stand out:

	# Please enter the commit message for your changes. Lines starting
	# with '#' will be ignored, and an empty message aborts the commit.
	# Not currently on any branch.
	# Untracked files:
	#   (use "git add <file>..." to include in what will be committed)

It's the third line, surrounded by other lines and at the bottom of  
the window.

How about a single line then, something like

	Vienna:git pieter$ ./git commit --allow-empty -m"test"
	Created commit 6ce62c8b: test
	Remember you are on a detached head, create a new branch to not lose  
these changes
