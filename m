From: Nicolas Dudebout <nicolas.dudebout@gmail.com>
Subject: Re: [patch] color of branches in git status -sb
Date: Wed, 16 Nov 2011 21:25:51 -0500
Message-ID: <CA+TMmKkM0B8Bge4Jz7KVjR=F-dK0ojuVJp-fe2vj96uq5z0DrA@mail.gmail.com>
References: <CA+TMmKns-9jiedxY4FiJoBg8akkxwkPBib11EmvCD3r7mRA6vQ@mail.gmail.com>
	<7v4ny3pn4v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 03:25:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQrfq-0001ma-GI
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 03:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212Ab1KQCZx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 21:25:53 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64464 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046Ab1KQCZw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 21:25:52 -0500
Received: by fagn18 with SMTP id n18so2355947fag.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 18:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kQ3W5EGTTZLSGoFfzTvRFz+bR1SAdwsduh5c9cHpWkM=;
        b=C4WdrlnR5CB5R/DQKWqyVFKfxTsD4mZQWnasQI17Q8yLDafZzu5UuYsiNm7NatNLNv
         rMiKfv16qbOoYuYvLUQVD0z5MTMw7xJwyS06+92IR1TpV/T7z/ujPL9slhDACpxzfldT
         9ETH3AZQsvqjjY7rRSIr5t1KwHk4DY0AkAJZk=
Received: by 10.152.105.132 with SMTP id gm4mr3091119lab.39.1321496751645;
 Wed, 16 Nov 2011 18:25:51 -0800 (PST)
Received: by 10.152.13.105 with HTTP; Wed, 16 Nov 2011 18:25:51 -0800 (PST)
In-Reply-To: <7v4ny3pn4v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185569>

Please disregard this as a patch. I do not have the time to understand
how they have to be properly formatted. I just pasted the output of my
git client.
I am just letting you know that there is a problem that can be easily
fixed. I can resend a separate email if that makes it easier for your
bug tracking.

On Wed, Nov 16, 2011 at 8:13 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nicolas Dudebout <nicolas.dudebout@gmail.com> writes:
>
>> The following patch fixes the fact that two colors of the status
>> output could not be configured in .git/config.
>>
>> The color of the current branch could not be modified because of the
>> name WT_STATUS_ONBRANCH having been changed to WT_STATUS_LOCAL_BRANC=
H.
>>
>> The color of the remote branch was not defined at all.
>>
>> By the way, when I do 'git status' instead of git 'status -sb' the
>> local and remote branch do not get colored. Is this a desired
>> behavior?
>>
>> Nicolas
>
> Please follow Documentation/SubmittingPatches.
>
> Also expect that patches to add new feature this deep in the pre-rele=
ase
> feature freeze period is not likely to get reviewed by regular list
> members.
>
>>
>> =C2=A0 =C2=A0 =C2=A0 Modified =C2=A0 Documentation/config.txt
>
> Don't do this. We can tell what is modified from "diff --git" lines.
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 5a841da..7a0ddd6 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -809 +809,2 @@ color.status.<slot>::
>> - =C2=A0 =C2=A0 `branch` (the current branch), or
>> + =C2=A0 =C2=A0 `branch` (the current branch),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0`remote` (the remote branch) or
>
> Don't do this. Proper patches have context lines for good reasons.
>
>> =C2=A0 =C2=A0 =C2=A0 Modified =C2=A0 builtin/commit.c
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index c46f2d1..4674600 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1118 +1118,3 @@ static int parse_status_slot(const char *var, in=
t offset)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return WT_STATUS_ONBRANC=
H;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return WT_STATUS_LOCAL_B=
RANCH;
>> + =C2=A0 =C2=A0 if (!strcasecmp(var+offset, "remote"))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return WT_STATUS_REMOTE_=
BRANCH;
>
