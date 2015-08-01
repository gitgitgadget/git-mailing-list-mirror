From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] completion: Add '--edit-todo' to rebase
Date: Sat, 01 Aug 2015 11:25:07 +0200
Message-ID: <20150801112507.Horde.r5NtLucc5RqP3Wy8gdC7CQ1@webmail.informatik.kit.edu>
References: <1436786876.6619.0.camel@virtuell-zuhause.de>
 <20150713131107.GC1451@serenity.lan>
 <1064256694.3063.1438019649384.JavaMail.open-xchange@app07.ox.hosteurope.de>
 <20150730132403.Horde.qnEThoM2W0qI-S5EDFXGDg3@webmail.informatik.kit.edu>
 <20150730112940.GL14935@serenity.lan>
 <20150731121646.Horde.Mk6NzRZAsrRNDCE_y2uEdQ1@webmail.informatik.kit.edu>
 <55BBB244.3060309@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Sat Aug 01 11:25:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLT2t-0004Yp-Q4
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 11:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbbHAJZb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Aug 2015 05:25:31 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:43713 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751140AbbHAJZ3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 1 Aug 2015 05:25:29 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ZLT2j-0000GW-Vf; Sat, 01 Aug 2015 11:25:26 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ZLT2R-0008S2-QP; Sat, 01 Aug 2015 11:25:07 +0200
Received: from x4db19570.dyn.telefonica.de (x4db19570.dyn.telefonica.de
 [77.177.149.112]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sat, 01 Aug 2015 11:25:07 +0200
In-Reply-To: <55BBB244.3060309@virtuell-zuhause.de>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1438421126.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275116>


Quoting Thomas Braun <thomas.braun@virtuell-zuhause.de>:

> Am 31.07.2015 um 12:16 schrieb SZEDER G=C3=A1bor:
>> Anyway, so this could be something like (modulo likely whitespace da=
mage):
>>
>> diff --git a/contrib/completion/git-completion.bash
>> b/contrib/completion/git-completion.bash
>> index 07c34ef913..fac01d6985 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1667,7 +1667,10 @@ _git_push ()
>>   _git_rebase ()
>>   {
>>       local dir=3D"$(__gitdir)"
>> -    if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; th=
en
>> +    if [ -f "$dir"/rebase-merge/interactive ]; then
>> +        __gitcomp "--continue --skip --abort --edit-todo"
>> +        return
>> +    elif [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; =
then
>>           __gitcomp "--continue --skip --abort"
>>           return
>>       fi
>
> This looks much better than my attempt. Thanks.
>
> How is the protocol now? Do I reroll and add
> Helped-By: John Keeping <john@keeping.me.uk>
> Completely-Overhauled-And-Properly-Implemented: SZEDER G=C3=A1bor =20
> <szeder@ira.uka.de>

Ugh :)  I'm quite happy with Helped-by, if you do a proper reroll =20
after trying it out to see that it indeed does what it should.


Thanks,
G=C3=A1bor
