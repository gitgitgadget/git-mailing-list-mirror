From: Christopher Jefferson <caj@cs.st-andrews.ac.uk>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 18:22:33 +0100
Message-ID: <submission.1M9Mpl-0001CW-M0@mail.cs.st-andrews.ac.uk>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk> <m3y6siboij.fsf@localhost.localdomain> <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain> <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 27 19:22:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Mpv-0004t5-31
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 19:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbZE0RWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 13:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752491AbZE0RWd
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 13:22:33 -0400
Received: from mail.cs.st-andrews.ac.uk ([138.251.206.35]:42185 "EHLO
	mail.cs.st-andrews.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbZE0RWd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 13:22:33 -0400
Received: by mail.cs.st-andrews.ac.uk with esmtpsa (authid caj) (TLSv1:AES128-SHA:128)
	(Exim 4.43)
	id 1M9Mpl-0001CW-M0; Wed, 27 May 2009 18:22:33 +0100
In-Reply-To: <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120080>


On 27 May 2009, at 17:59, Linus Torvalds wrote:

>
>
> On Wed, 27 May 2009, Linus Torvalds wrote:
>>
>> I'll see if I can make us handle the "big file without diff" case  
>> better
>> by chunking.

> So "don't do it then" or "make sure you are 64-bit and have lots of
> memory if you do it" may well be the right solution.

Thank you for that description of the problem, I can see how hard it is.

Perhaps it might be useful to think about how to codify "don't do it  
then" in a reasonably simple, automatic way?

I've been trying to write a pre-commit hook (I think that's the right  
place?) which would refuse commits larger than some file size (512MB  
as a random number I decided), but am having trouble getting it to  
work right, and generally. Would such a thing be easy, and would that  
be the right place to put it?

While I wouldn't suggest this become default, providing such a hook,  
and describing why you might want to use it, would seem to avoid the  
accidental part of the problem.

Of course, people should really notice that they are submitting large  
files, but it's easy(ish) to commit some output file from a program,  
without realising the file ended up being the wrong side of 1GB.

Chris
