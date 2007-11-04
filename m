From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] errors: "strict subset" -> "ancestor"
Date: Mon, 5 Nov 2007 00:13:26 +0100
Message-ID: <E7C9B9EC-F7DA-4A27-823B-5435161CBFB5@zib.de>
References: <20071103023944.GA15379@fieldses.org> <3F4A5458-AB2F-40C7-AA0E-9D26981BCE9D@zib.de> <20071104220810.GC22762@fieldses.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 00:12:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioodo-0007AC-Gt
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 00:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936AbXKDXMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 18:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbXKDXMO
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 18:12:14 -0500
Received: from mailer.zib.de ([130.73.108.11]:51701 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729AbXKDXMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 18:12:12 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA4NC66O015782;
	Mon, 5 Nov 2007 00:12:06 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1be86.pool.einsundeins.de [77.177.190.134])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA4NC56U004813
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 5 Nov 2007 00:12:06 +0100 (MET)
In-Reply-To: <20071104220810.GC22762@fieldses.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63455>


On Nov 4, 2007, at 11:08 PM, J. Bruce Fields wrote:

> On Sat, Nov 03, 2007 at 08:51:29AM +0100, Steffen Prohaska wrote:
>>
>> On Nov 3, 2007, at 3:39 AM, J. Bruce Fields wrote:
>>
>>> From: J. Bruce Fields <bfields@citi.umich.edu>
>>>
>>> The term "ancestor" is a bit more intuitive (and more consistent  
>>> with
>>> the documentation) than the term "strict subset".
>>>
>>> Also, remove superfluous "ref", capitalize, and add some carriage
>>> returns, changing:
>>>
>>> 	error: remote 'refs/heads/master' is not a strict subset of  
>>> local ref
>>> 'refs/heads/master'. maybe you are not up-to-date and need to  
>>> pull first?
>>> 	error: failed to push to 'ssh://linux-nfs.org/~bfields/exports/ 
>>> git.git'
>>>
>>> to:
>>>
>>> 	error: remote 'refs/heads/master' is not an ancestor of
>>> 	 local 'refs/heads/master'.
>>> 	 Maybe you are not up-to-date and need to pull first?
>>> 	error: failed to push to 'ssh://linux-nfs.org/~bfields/exports/ 
>>> git.git'
>>
>>
>> Junio suggested in [1] (see also earlier messages in that
>> thread) to replace the recommendation to pull with a hint
>> where to look in the user manual.
>>
>> [1] http://marc.info/?l=git&m=119398999317677&w=2
>>
>>
>> The point is, there are various ways to resolve the problem.
>> pull is not necessarily the right solution. At least, you should
>> consider to rebase. Or maybe just something else went wrong.
>
> Yeah, actually in my case I usually want to force....
>
> So I think it's a good suggestion, but I'm putting it off for now  
> as I'm
> not sure yet where to refer people to, and don't like making the  
> error a
> lot longer.

I agree. And it's probably a waste of time anyway, because
sooner or later the mega-terse fetch output will be extended
to push.


> Hm.  I wonder if extra "help" commandline flags would be a way to get
> people extra guidance on particular situations without cluttering  
> up the
> default messages ("not sure what to try next?  Try -h  
> notanancestor..."
> Maybe not.)

The first step would be to describe the error messages in the
manual (or the man pages), and provide hints how to resolve
them. Currently we have no place we could link to, even if we
had a mechanism to do so.

	Steffen
