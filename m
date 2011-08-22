From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: [Git 1.7.6.557.gcee4] git stash
Date: Mon, 22 Aug 2011 13:15:33 -0700
Message-ID: <CAE1pOi1Et9e1g8cKUPZBykV-Y2-4UMRuxHvcDjRjEg7WxF=i1A@mail.gmail.com>
References: <CAE1pOi1D+J5_fmsdhho1FRAipyO3Ri7GS_wy4fTNtCGbatDaDg@mail.gmail.com>
	<AkGXRtqs8Fopo0L4Aw4Wa2DwgVP6ZLr_un-c4jhUixdk1LTUHK2twg@cipher.nrlssc.navy.mil>
	<CAE1pOi2OnHpu+kBj8Z47nb7C-MHFpUMAc8ArG3haWpncEDQ-jA@mail.gmail.com>
	<fbFntd6r8tmN4NcET9Ya3OWDfsrxz1tfPv7GaddGfwwdirG8AgjrG8ARoR2-ZhadzpRI2DU2ZtTGdWAUGJeUZuBXmxWX5eSmT16u5cBjtec@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Caldwell <david@porkrind.org>,
	Git Users <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Aug 22 22:15:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvauJ-0007r5-VA
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 22:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730Ab1HVUPf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Aug 2011 16:15:35 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42828 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568Ab1HVUPe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2011 16:15:34 -0400
Received: by ywf7 with SMTP id 7so3784529ywf.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=AGOKiPxexa9R/RmX7Q49TMBnaTrwudTW8vQzbEAhQrs=;
        b=vDH4V815wbZmNqWs8TVLV60z6BGPg73gBiFBSEfnsvLeME+oLoxKI6PyaAqcPv8e5v
         wMsBf3Ow4MhQwB8hPpUoMmlcUcrX1pFCugUqBj6pEiGgxPwygZkHXEWtutuwxX/LWXCr
         LJADH/evziVmkOeLJVjWqmFSkX3g6uxXMDokI=
Received: by 10.236.136.167 with SMTP id w27mr17372340yhi.102.1314044133566;
 Mon, 22 Aug 2011 13:15:33 -0700 (PDT)
Received: by 10.236.207.67 with HTTP; Mon, 22 Aug 2011 13:15:33 -0700 (PDT)
In-Reply-To: <fbFntd6r8tmN4NcET9Ya3OWDfsrxz1tfPv7GaddGfwwdirG8AgjrG8ARoR2-ZhadzpRI2DU2ZtTGdWAUGJeUZuBXmxWX5eSmT16u5cBjtec@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179887>

On 22 August 2011 12:58, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> On 08/22/2011 01:43 PM, Hilco Wijbenga wrote:
>> On 22 August 2011 10:15, Brandon Casey
>> <brandon.casey.ctr@nrlssc.navy.mil> wrote:
>>> On 08/22/2011 01:01 AM, Hilco Wijbenga wrote:
>>>> Hi David,
>>>>
>>>> I noticed your very timely change to git stash in the current mast=
er
>>>> branch. I tried it but it doesn't behave as I was expecting/hoping=
=2E
>>>
>>> It looks like it is actually creating the stash correctly, but it's
>>> just not deleting the ignored directory.
>
>>> Something like this is probably the appropriate fix:
>>>
>>> diff --git a/git-stash.sh b/git-stash.sh
>>> index f4e6f05..a2d4b4d 100755
>>> --- a/git-stash.sh
>>> +++ b/git-stash.sh
>>> @@ -240,7 +240,7 @@ save_stash () {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test "$untra=
cked" =3D "all" && CLEAN_X_OPTION=3D-x || CLEAN_X_OPTION
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test -n "=
$untracked"
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0then
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 git clean --force --quiet $CLEAN_X_OPTION
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 git clean --force --quiet -d $CLEAN_X_OPTION
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test "$ke=
ep_index" =3D "t" && test -n $i_tree
>>>
>>> Needs tests.
>>
>> I just tried it with the extra -d and it all seems to work
>> beautifully. Should your patch be sent anywhere?
>
> It needs a couple of tests added to t/t3905-stash-include-untracked.s=
h
> to demonstrate that this functionality works correctly and to ensure
> that it doesn't break in the future.
>
> Need tests at least for:
>
> =C2=A0 --all stashes untracked / ignored in subdirectory
> =C2=A0 --include-untracked stashes untracked in subdirectory, leaves =
ignored alone
>
> Do we currently test that stash leaves untracked / ignored alone when
> --all or --include-untracked are not supplied?
>
> And it needs a commit message following the guidelines in
> Documentation/SubmittingPatches. =C2=A0Then it can be submitted to th=
is list
> using format-patch and send-email. =C2=A0Interested??? :) =C2=A0other=
wise I'll try
> to get to it later tonight.

Interested? Sure. Do I have the time? Unfortunately not. I'm
overworked as it is. :-( Well, maybe in the weekend. But this would be
a major operation for me because it's all new.
