From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add an optional <mode> argument to commit/status -u|--untracked-files
 option
Date: Tue, 03 Jun 2008 23:00:23 +0200
Message-ID: <4845B0E7.2090502@trolltech.com>
References: <7viqwvk04y.fsf@gitster.siamese.dyndns.org> <c9062d05cabcbd45657e89b03eac9715a46f8b79.1212498900.git.marius@trolltech.com> <7vod6i1e3p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 23:00:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3dcB-0006Ti-E9
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 23:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbYFCU7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 16:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbYFCU7Z
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 16:59:25 -0400
Received: from hoat.troll.no ([62.70.27.150]:60848 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbYFCU7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 16:59:24 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 66F4F20A8D;
	Tue,  3 Jun 2008 22:59:18 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 38FDB205C6;
	Tue,  3 Jun 2008 22:59:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7vod6i1e3p.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83709>

Junio C Hamano said the following on 03.06.2008 22:02:
> Marius Storm-Olsen <marius@trolltech.com> writes:
> 
>> Determining untracked files can be a very slow operation on large trees.
>> This commit adds a <mode> argument, which allows you to avoid showing the
>> untracked files in a repository. Possible options are:
>>     none   - Show no untracked files
>>     normal - Show untracked files and directories
>>     all    - Show all untracked files
>>
>> If the optional argument is not specified, the option defaults to 'all'.
> 
> You got me worried.  You are defaulting the parameter of "-u" to 'all',
> not making the command default (in the absense of -u anything) to "-u
> all", which was what I misunderstood on my first reading.  "the optional
> parameter defaults to 'all'" is what you meant...

Ok, I'll rewrite it to make it more clear.

> enum {NONE,NORMAL,ALL}_UNTRACKED are named (1) too generic, in a sense
> that it is not clear _what_ is done to the class of untracked worktree
> entities, and/or (2) opposite from other enums where common prefix is
> followed by differing part.
> 
> Perhaps renaming them to SHOW_{NONE,NORMAL,ALL}_UNTRACKED would make it
> easier to read.

Sure.

> It would have been nicer if this patch was further split into two; the
> first one to introduce NORMAL and ALL without changing any behaviour, then
> the second one to add NONE to introduce a new behaviour, with tests so
> that other people will not break this new feature in their later changes.

Ok, will do.

>> @@ -150,12 +150,15 @@ but can be used to amend a merge commit.
>>  	the last commit without committing changes that have
>>  	already been staged.
>>  
>> --u|--untracked-files::
>> -	Show all untracked files, also those in uninteresting
>> -	directories, in the "Untracked files:" section of commit
>> -	message template.  Without this option only its name and
>> -	a trailing slash are displayed for each untracked
>> -	directory.
>> +-u[<mode>]|--untracked-files[=<mode>]::
>> +	Show all untracked files.
>> +	The mode parameter is optional, and is used to specify
>> +	the handling of untracked files. The possible options are:
>> +		none   - Show no untracked files
>> +		normal - Shows untracked files and directories
>> +		all    - Also shows individual files in untracked directories.
>> +	If the mode parameter is not specified, the defaults is
>> +	'all'.
> 
> Does this mark-up actually work?

I haven't actually run it through AsciiDoc. I'll make sure that it 
handles the next version of the patch(es).

Thanks for checking the patches!

--
.marius
