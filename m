From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH 3/5] checkout --orphan: respect -l option always
Date: Wed, 26 May 2010 15:04:33 -0300
Message-ID: <AANLkTiksYeRzqNTdOMxb3oliuVna6kAxbHM8nxx6gNCO@mail.gmail.com>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com> 
	<1274488119-6989-4-git-send-email-erick.mattos@gmail.com> 
	<7vzkznqmir.fsf@alter.siamese.dyndns.org> <AANLkTimT3sI3yuM8RZai-eWDk8Z5Rmc28RLGOx_i-RXa@mail.gmail.com> 
	<4BFD3ED3.3000709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 26 20:11:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHL4J-0002B9-CN
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 20:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757059Ab0EZSK5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 May 2010 14:10:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36245 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081Ab0EZSK4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 14:10:56 -0400
Received: by gyg13 with SMTP id 13so3153946gyg.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 11:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+ohDP+MfUMjlDCxHmR+oMn32vxQaEQF1+PB0u7NEbhk=;
        b=W9qKU/BfrYQUJXrtdRTE1och5/W2ElmIBnL9GpujxL29eiUICzUdveQzFwwUy7dCZZ
         TR1C5xC3WD9GrRxiElosehq9xcJERMlEPzWk8EhhW5Wv/uP2INqEHqRnEkkvAvsWfwwv
         q7MCDfTQW51YyqzdHqCP2XNRMl517QmSRkN6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hpgq1JMGcx9NvLjZP3A3Qj7LGGBwjOZhy9rar3ud6yo2nfgUQHmtBIrAGQcwTen+L7
         a4FpZRBVBsEkoyWlzPMa6U6aXjHLSjpHIFP8pApuQX298uRjVG7W6dycF+dfBzFuT1lN
         xY1VY50OOi61tL6oZXm4ainLeGBJiczcNQc34=
Received: by 10.150.213.10 with SMTP id l10mr9580568ybg.351.1274897093335; 
	Wed, 26 May 2010 11:04:53 -0700 (PDT)
Received: by 10.151.39.17 with HTTP; Wed, 26 May 2010 11:04:33 -0700 (PDT)
In-Reply-To: <4BFD3ED3.3000709@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147814>

Hi,

2010/5/26 Michael J Gruber <git@drmicha.warpmail.net>:
>> But that is not a fix.
>
> There's a "-" line with "cannot" and a "+" line with "should not". So
> you certainly changed what was there before.

Everybody know what a minus or a plus sign means in a diff. ;-)

What I have meant was that I had typed the whole line myself after
some previous removal while I was making the changes during
"deletion/moving lines" actions.  No big deal, just a mistake.

The real message change here is from blocking -t an -l to blocking
only -t.  As I had told I have not realized the 'should not/cannot'
issue.

>>>> + =C2=A0 =C2=A0 git checkout master &&
>>>> + =C2=A0 =C2=A0 git checkout -l --orphan eta &&
>>>> + =C2=A0 =C2=A0 test -f .git/logs/refs/heads/eta &&
>>>> + =C2=A0 =C2=A0 test_must_fail PAGER=3D git reflog show eta &&
>>>> + =C2=A0 =C2=A0 git checkout master &&
>>>> + =C2=A0 =C2=A0 ! test -f .git/logs/refs/heads/eta &&
>>>> + =C2=A0 =C2=A0 test_must_fail PAGER=3D git reflog show eta
>>>> +'
>>>
>>> I don't quite understand the title of this test, nor am I convinced=
 that
>>> testing for .git/logs/refs/heads/eta is necessarily a good thing to=
 do
>>> here. =C2=A0"eta" branch is first prepared in an unborn state with =
the working
>>> tree and the index prepared to commit what is in 'master', and the =
first
>>> "git reflog" would fail because there is no eta branch at that poin=
t yet.
>>> Moving to 'master' from that state would still leave "eta" branch u=
nborn
>>> and we will not see "git reflog" for that branch (we will fail "git=
 log
>>> eta" too for that matter). =C2=A0Perhaps two "test -f .git/logs/ref=
s/heads/eta"
>>> shouldn't be there? =C2=A0It feels that it is testing a bit too low=
 level an
>>> implementation detail.
>>
>> So I need to explain the solution:
>>
>> When config core.logAllRefUpdates is set to false what really happen=
s
>> is that the reflog is not created and any reflog change is saved onl=
y
>> when you have an existent reflog.
>>
>> What I did was to make a "touch reflog". =C2=A0Creating it, when the=
 new
>
> You mean checkout -l --orphan does that touch? There is none in the
> test. Does ordinary checkout with -l does that, too?

This is not done by a test.  It is part of the whole implementation.
It is done only when needed: on that special corner case.

Please read the patches mainly the 2/5 and 3/5.

>> branch get eventually saved then the reflog would be written normall=
y.
>> =C2=A0But in case somebody give up this new branch before the first =
save,
>> moving back to a regular branch would leave a ghost reflog.
>
> The touched entry (is left), not a reflog, I assume, otherwise the
> reflog command should not fail.
>
>>
>> I have coded the cleaning commands for that and the test is just a
>> check of this behavior.
>
> Which command does the cleaning? "reflog show" or "checkout master"?
>
>>
>> The first "test -f .git/logs/refs/heads/eta" tests if reflog was
>> created and the second if it was deleted. =C2=A0No big deal.
>>
>> Regards
>
> I haven't followed this series due to earlier worries about --orphan =
but
> I'm wondering about this cleaning up behind the back. Maybe it's just=
 a
> matter of explanations, though.
>
> Michael
>

Your questions are too unaware of the code.  ;-)  As I don't think you
are asking me to explain each single line then I imagine you have not
read the patches, just the chat.  Please read the patch series.  I
will be very glad to answer any further questions then.

Best regards
