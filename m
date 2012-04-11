From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 2/5] Provide branch name in error message when using @{u}
Date: Thu, 12 Apr 2012 00:13:36 +0200
Message-ID: <4F860210.5030409@in.waw.pl>
References: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl> <1334161035-26355-3-git-send-email-zbyszek@in.waw.pl> <7v7gxmkv1m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 00:13:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI5nU-0002w2-0O
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 00:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933450Ab2DKWNr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 18:13:47 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:34707 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753943Ab2DKWNr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 18:13:47 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SI5nK-0007yW-As; Thu, 12 Apr 2012 00:13:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <7v7gxmkv1m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195275>

On 04/11/2012 08:00 PM, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>  writes:
>
>> diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstr=
eam.sh
>> index 1342915..a00b689 100755
>> --- a/t/t1507-rev-parse-upstream.sh
>> +++ b/t/t1507-rev-parse-upstream.sh
>> @@ -135,7 +135,7 @@ test_expect_success 'branch@{u} error message wh=
en no upstream' '
>>
>>   test_expect_success '@{u} error message when no upstream' '
>>   	cat>expect<<-EOF&&
>> -	error: No upstream branch found for ${sq}${sq}
>> +	error: No upstream branch found for ${sq}master${sq}
>>   	fatal: Needed a single revision
>>   	EOF
>>   	test_must_fail git rev-parse --verify @{u} 2>actual&&
>
> I am not sure if saying "... for 'master'" is better or "... for the
> current branch" is better.  Using different wording reflects the fact=
 that
> the user gave "@{u}" and not "master@{u}".
Hi,

I think that explicitly providing the name of the branch is useless whe=
n
the user has a properly configured git prompt which always shows the=20
current branch. But not everybody does that, and for such people=20
providing the name in the error message could be useful.

> But I do not care too deeply.
I don't either. I'll wait to see if other people chime in.

 > Either way, it is a vast improvement over
 > the current "... for ''" output.
> And the "detached" case is definitely better.
Thanks!

Thank you for the review. I'll send a reroll taking into account your=20
and Matthieu's comments in a day or two if nobody else comments.

Zbyszek
