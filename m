From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] Documentation/config.txt: denyDeleteCurrent applies to
 bare repos too
Date: Thu, 17 Oct 2013 16:29:35 -0700
Message-ID: <CA+sFfMfxaM7z5kWyi_5pOjSLYy3BEstUZiG759QyZfjqobCdNg@mail.gmail.com>
References: <1381886818-14337-1-git-send-email-bcasey@nvidia.com>
	<xmqq4n8fy1t3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <bcasey@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 01:29:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWx0f-0004ue-2p
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 01:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369Ab3JQX3h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Oct 2013 19:29:37 -0400
Received: from mail-qe0-f53.google.com ([209.85.128.53]:62519 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab3JQX3g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Oct 2013 19:29:36 -0400
Received: by mail-qe0-f53.google.com with SMTP id cy11so1195924qeb.40
        for <git@vger.kernel.org>; Thu, 17 Oct 2013 16:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UMMYrf9gng38Qxfs1+e8lD0/mQ6/S3dreLRgHYvCVic=;
        b=AzRoIrrV5H7AS/9csvW3eb+m3Qktmk1ga2Co7E6NKg3m7QkAM4n+W/V0iMz4wzKep8
         uj2YY3OUobkzFQ2h9A0W/ZJgEbNtGxWzi03MEK7dIWw6n32zfG2bVvxJgpTHa3meQj0B
         gaykBOq2PpG5xHDPHBl5Wl41+F4cmbZmr0HwCs39QKXJgPpnqWRmr4/fRW+7OEY94X6E
         mBrxJDxybyu17BA4UD1EDQm/Y5GUoOUQVRy9TQcm1J1htGsoquamOK62IUZyziPpO1MJ
         XtOXTEfGZD36/4zG3XSTUHU1yClc4bccUI12yrYAX5Z1iOAgSouTtVOUehE/25ZN5V64
         3I8w==
X-Received: by 10.224.137.195 with SMTP id x3mr486186qat.107.1382052575575;
 Thu, 17 Oct 2013 16:29:35 -0700 (PDT)
Received: by 10.96.211.2 with HTTP; Thu, 17 Oct 2013 16:29:35 -0700 (PDT)
In-Reply-To: <xmqq4n8fy1t3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236333>

On Thu, Oct 17, 2013 at 3:23 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Brandon Casey <bcasey@nvidia.com> writes:
>
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> The setting of denyDeleteCurrent applies to both bare and non-bare
>> repositories.  Correct the description on this point, and expand it =
to
>> provide some background justification for the current behavior and
>> describe the full suite of settings.
>>
>> Signed-off-by: Brandon Casey <drafnel@gmail.com>
>> ---
>>  Documentation/config.txt | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index c3f7002..3d416ec 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1993,8 +1993,15 @@ receive.denyDeletes::
>>       the ref. Use this to prevent such a ref deletion via a push.
>>
>>  receive.denyDeleteCurrent::
>> -     If set to true, git-receive-pack will deny a ref update that
>> -     deletes the currently checked out branch of a non-bare reposit=
ory.
>> +     If set to true or "refuse", git-receive-pack will deny a ref u=
pdate
>> +     that deletes the currently checked out branch of a non-bare re=
pository,
>> +     or the "default" branch in a bare repository.  i.e. the branch
>> +     that HEAD refers to.
>
> It reads just fine without the part that you found the need for
> clarification with "i.e.", i.e.
>
>         or the branch that HEAD points at in a bare repository.
>
> without introducing a new word "default branch" that is not defined
> in the glossary.

Either way is fine with me.  The phrase "the branch that HEAD points
at" applies to either a bare or non-bare repo though, so the "i.e."
was directed at both parts of the preceding sentence.  Guess we
haven't defined an alternative way to say "the branch that HEAD points
at" for a bare repository =C3=A0 la "currently checked out branch" for =
a
non-bare repository.

>> +     Deleting the current branch from a remote will
>> +     cause the HEAD symbolic ref to become dangling and will result=
 in the
>> +     next clone from it to not check out anything.
>
> This sentence tells truth but does not fit in the logic flow in the
> paragraph. I am reading it as primarily meant to be an explanation
> why it would be a good idea to apply this seemingly non-bare only
> option (implied by "current" in its name---it is so rare for a bare
> repository to repoint its HEAD that the concept of "current" does
> not mesh well with a bare one) to a bare one.

Yep, that's the correct reading: as an explanation for why this should
apply to bare repos as well as non-bare.

> It may be a good thing
> to have, but the thought-process may flow better if it is made as a
> FYI after the main text, i.e.
>
>                 If set to true or "refuse", `git-receive-pack` will d=
eny a
>                 ref update that deletes the branch that HAED points a=
t.  If
>                 set to "warn", ... If set to false or "ignore", ... D=
efaults
>                 to "refuse".
>         +
>         Deleting the branch that HEAD points at will cause the HEAD s=
ymbolic
>         ref to become dangling.  This causes the next commit to becom=
e a
>         "root" commit, disconnected from the old history, in a non-ba=
re
>         repository.  It also causes the next clone from such a reposi=
tory
>         (either bare or non-bare) not to check out anything.
>
> perhaps?

Yes, much better as a note following the main text.  Thanks.

-Brandon
