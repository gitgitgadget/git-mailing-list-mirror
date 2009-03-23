From: Pieter de Bie <pieter@frim.nl>
Subject: Re: Importing Bzr revisions
Date: Mon, 23 Mar 2009 14:18:08 +0000
Message-ID: <4123DB23-39C4-4651-A3B5-C7876A781365@frim.nl>
References: <90DBD254-1810-4B11-AA9F-C5661A028FA5@gmail.com> <7veiwo8xz7.fsf@gitster.siamese.dyndns.org> <03AC7EDA-2A9F-4626-A67B-CE9F2A88FC7D@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Reitter <david.reitter@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 15:20:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lll0b-0002G4-4i
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 15:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757532AbZCWOSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 10:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755773AbZCWOSZ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 10:18:25 -0400
Received: from frim.nl ([87.230.85.232]:53701 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757532AbZCWOSY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 10:18:24 -0400
Received: from cnat117.wlan.net.ed.ac.uk ([129.215.5.117] helo=[172.20.196.7])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pieter@frim.nl>)
	id 1Llkyl-0005ix-Di; Mon, 23 Mar 2009 15:18:15 +0100
In-Reply-To: <03AC7EDA-2A9F-4626-A67B-CE9F2A88FC7D@gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114312>


On Mar 23, 2009, at 1:27 PM, David Reitter wrote:

> On Mar 23, 2009, at 4:06 AM, Junio C Hamano wrote:
>>
>>> Suppose I have a bzr branch that has been converted (somehow) to a  
>>> git
>>> branch, is it then possible to merge new revisions from the bzr  
>>> branch
>>> into the git one?
>>
>> It entirely depends on how that "somehow" goes.
>>
>> If that "somehow" procedure performs a reliably reproducible  
>> conversion
>> (i.e. not only it will produce the identical git history when you  
>> feed the
>> same bzr history to the procedure twice, but it will produce the  
>> identical
>> git history followed by new history if you feed the bzr history  
>> after new
>> commits are added to the bzr history), you should be able to re- 
>> convert
>
> I'm just experimenting with "bzr fast-export", which converts to  
> git, and it seems to take about 4 minutes for 1000 revisions on our  
> (modern) server.  That would be around 7 hours for my emacs  
> repository; I can't do that daily.
>
> I wonder if there's a way for (bzr) fast-export / (git) fast-import  
> to work incrementally, i.e. for selected or most recent revisions.
>
> Or, one could do something like  bzr diff -r $REV.. $BBRANCH |  (cd  
> $GBRANCH; patch -p0; git commit), plus preserving authors and log  
> messages.   Is this roughly what the fast-export format does anyways?


You might want to take a look at git-bzr (http://github.com/pieter/git-bzr/tree/master 
) it allows incremental bidirectional interaction between git and bzr  
using the fast-export/import, so it might just work in your case.  
There are some issues with it, so you might want to check the  
'network' part on github and use one of the other variants.

That said, it's a 100 line script that hasn't been used much, so good  
luck :)

- Pieter
