From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add testcase for merging in a CRLF repo, showing that
 conflict file is in LF only
Date: Mon, 09 Jun 2008 16:46:36 +0200
Message-ID: <484D424C.3010002@trolltech.com>
References: <"Storm-Olsen*"@MHS> <26299.4828321554$1213013668@news.gmane.org> <484D3225.3020900@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 16:47:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5ien-0004bw-Fh
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 16:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428AbYFIOql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 10:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754114AbYFIOql
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 10:46:41 -0400
Received: from hoat.troll.no ([62.70.27.150]:52840 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487AbYFIOqk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 10:46:40 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id D261920A60;
	Mon,  9 Jun 2008 16:46:34 +0200 (CEST)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 82C092015E;
	Mon,  9 Jun 2008 16:46:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <484D3225.3020900@viscovery.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84388>

Johannes Sixt said the following on 09.06.2008 15:37:
> Marius Storm-Olsen schrieb:
>> An LF only conflict file results in the resolved file being in LF,
>> the commit is in LF and a warning saying that LF will be replaced
>> by CRLF, and the working dir ends up with a mix of CRLF and LF files.
> 
> After reading these 3 lines I've no idea what you are talking about. Can
> you translate this to English, please? ;-)

Certainly :-)
It means that if you work on a repo with core.autocrlf == true, you'd 
expect every text file to have CRLF EOLs. However, if you by some 
operation, get a conflict, then the conflicted file has LF EOLs.
Now, of course you'd go about resolving the files conflict, and then 
'git add <file>'. When you do that, you'll get the warning saying that 
LF will be replaced by CRLF. Then you commit. The end result is that 
you have a workingdir with a mix of LF and CRLF files, which after 
some more operations may trigger a "whole file changed" diff, due to 
the workingdir file now having LF EOLs.

>>  Sorry, no patch to actually *fix* the problem.
> 
> Then you should use test_expect_failure instead of test_expect_success.
> And maybe also mention it in the commit message.

Well, the test case is written in a way that it *should* pass (iow, it 
_expects_ a success), but it currently doesn't. So, the goal is that 
someone, who is more intimate with the code, can just run the testcase 
until it passes (fixing in between each run, of course ;-)

>> +test_expect_success 'Check that conflict file is CRLF' '
>> +	git reset --hard a &&
>> +	! git merge side &&
> 
> 	test_must_fail git merge side &&

Ah, I checked a few other testcases, where I saw the ! construct. I 
don't mind changing it, if it's important. Does it add 'feature' to 
the testcase by using test_must_fail, instead of '!' ?

>> +	cat file | remove_cr | append_cr >file.temp &&
>> +	test_cmp file file.temp
>> +'
> 
> -- Hannes

Thanks

--
.marius
