From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add an optional <mode> argument to commit/status -u|--untracked-files
 option
Date: Tue, 03 Jun 2008 23:17:28 +0200
Message-ID: <4845B4E8.1040402@trolltech.com>
References: <7viqwvk04y.fsf@gitster.siamese.dyndns.org> <c9062d05cabcbd45657e89b03eac9715a46f8b79.1212498900.git.marius@trolltech.com> <20080603201421.GB17260@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 03 23:17:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3dsh-0004Lf-CZ
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 23:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbYFCVQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 17:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbYFCVQa
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 17:16:30 -0400
Received: from hoat.troll.no ([62.70.27.150]:48700 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbYFCVQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 17:16:29 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id BA0F420ABE;
	Tue,  3 Jun 2008 23:16:23 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 8CDFA20A8D;
	Tue,  3 Jun 2008 23:16:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <20080603201421.GB17260@sigill.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83712>

Jeff King said the following on 03.06.2008 22:14:
> On Tue, Jun 03, 2008 at 03:09:10PM +0200, Marius Storm-Olsen wrote:
> 
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
> Hmm. Doesn't this change bundling semantics of "git commit -us"? Do we
> care?

You are right. This is the joy of the parse-options() handling of 
short-options with optional arguments.

-us before meant:
     1) commit
     2) show all untracked files
     3) sign-of the commit

I guess it would be possible to reparse the options without the -u, if 
the argument is not one of the three (none,normal,all), but I'm not 
sure it's _that_ critical. Opinions?

--
.marius
