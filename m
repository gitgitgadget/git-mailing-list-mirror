From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git cherry improvements suggestions
Date: Wed, 23 Mar 2011 20:28:02 +0100
Message-ID: <AANLkTi=7=QDh0Pe9W4bRcGY5Krg7sBqRcZ2C1YonJSRN@mail.gmail.com>
References: <AANLkTimk0bkOGVy2W+XddHRuf-1xw+d0RwzPhnk40vi8@mail.gmail.com>
	<4D89CF8E.4070100@drmicha.warpmail.net>
	<AANLkTinXh_Y9ft5Pd5SxOEXvKNm3HLmsiut8WrvFZrdQ@mail.gmail.com>
	<4D89F6BC.2040902@drmicha.warpmail.net>
	<AANLkTin7Du5RYt946hNjP-y53puNykebCjiKk5Ju_igr@mail.gmail.com>
	<4D8A0741.9000506@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 20:28:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Tj1-0000t1-5y
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 20:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688Ab1CWT2F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 15:28:05 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54634 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628Ab1CWT2E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 15:28:04 -0400
Received: by vws1 with SMTP id 1so5921637vws.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 12:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YHaVuP46zPdAKxCGhOJ2rh8mkhXATc/AI9SQs7GUbwY=;
        b=iIYFQMcHRBRLx3DfaLIT7albeuYkn1jzdlcJksQQoxAY1g3jISrE/4k1nTidgTxyxz
         AG6npHK2jFjJi0iPCN8i642U1NooUnqXQm9ojqGey0VzcZ1KT2+7YSLa9C0BmAoQmgtx
         vmBtsRom81AVa0+cr9iy45rbTMlXdizgoRFrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QCG6TIt0b6WKZMPp3JdvKhUXiSRgGyKMCDKhddp5JY0ccFY+8+rxw6jNSuSLtPCDpa
         84F+Mu0rqof0ABO68fN9mksRmnnpbs9H5rKhsyoSOj/LBBEb6h72kwchK1jBM/n9IGWq
         nCjUd61JWntyaD4+tJXebUyu1944OV3tcSSxQ=
Received: by 10.220.193.129 with SMTP id du1mr1667755vcb.66.1300908482708;
 Wed, 23 Mar 2011 12:28:02 -0700 (PDT)
Received: by 10.220.210.16 with HTTP; Wed, 23 Mar 2011 12:28:02 -0700 (PDT)
In-Reply-To: <4D8A0741.9000506@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169870>

On Wed, Mar 23, 2011 at 3:44 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Piotr Krukowiecki venit, vidit, dixit 23.03.2011 15:43:
>> On Wed, Mar 23, 2011 at 2:33 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Piotr Krukowiecki venit, vidit, dixit 23.03.2011 14:23:
>>>> Just some stats:
>>>>
>>>> =A0 =A0git log --cherry-mark --left-right --oneline --date-order b=
ranch...trunk
>>>>
>>>> lists 1004 commits, takes about 20s and memory peaks to about 670M=
B
>>>> twice during the run (I'm on linux with AMD Phenom II X4 945)
>>>>
>>>> With limit it prints X last commits (the limiting seems to take pl=
ace after all
>>>> work, on the output list only).
>>>>
>>>> branch..trunk is 551 commits, the other way is 453 commits.
>>>> 710 commits are found to be "=3D", 98 "<", 196 ">".
>>>>
>>>> Note, I'm not saying it's too slow, or that it's working incorrect=
ly, I'm just
>>>> giving real-life stats if anyone was interested.
>>>> I suspect such checks won't be done frequently.
>>>
>>> You don't need to say it's slow - I've said so already :(
>>>
>>> http://permalink.gmane.org/gmane.comp.version-control.git/169725
>>
>> In the link above:
>> =A0 git cherry A B: 0.4s
>> =A0 git rev-list --cherry A...B: 1.7s
>>
>> So rev-list is 4.25x slower.
>>
>> In my case it's only 1.23x slower:
>>
>> =A0 =A0$ time git rev-list --cherry branch...trunk =A0> /tmp/rev-lis=
t
>> =A0 =A0real =A0 =A0 =A0 0m18.627s
>> =A0 =A0user =A0 =A0 =A0 0m17.710s
>> =A0 =A0sys =A0 =A0 =A0 =A00m0.900s
>>
>> =A0 =A0$ time git cherry =A0branch trunk =A0> /tmp/cherry
>> =A0 =A0real =A0 =A0 =A0 0m15.345s
>> =A0 =A0user =A0 =A0 =A0 0m14.310s
>> =A0 =A0sys =A0 =A0 =A0 =A00m1.020s
>>
>>
>
> How's that with > /dev/null (or with --count for rev-list)? Also, how
> many merge bases do you have:
>
> git merge-base --all branch trunk | wc -l

I expect only one - there should be no merges between those two
branches.

I will do measurements tomorrow.


--=20
Piotr Krukowiecki
