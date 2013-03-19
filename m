From: David Aguilar <davvid@gmail.com>
Subject: Re: building git ; need suggestion
Date: Mon, 18 Mar 2013 19:11:50 -0700
Message-ID: <CAJDDKr6bmH6gDSBPN+U6LbSNrFw-adsfv0ZESDAOG7H2nuZapg@mail.gmail.com>
References: <868B103B-690E-477B-BF75-8F954F893E6F@infoservices.in>
	<20130315124415.GA23122@paksenarrion.iveqy.com>
	<00107242-04EB-423F-90FE-A6DCDEE7E262@infoservices.in>
	<20130315131403.GA27022@google.com>
	<C8080BF5-DC87-421D-97A1-DF5CF403A03A@infoservices.in>
	<9E0367AC-617A-440B-925E-5796CF2E1ADF@infoservices.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?TWFnbnVzIELDpGNr?= <baeck@google.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Joydeep Bakshi <joydeep.bakshi@infoservices.in>
X-From: git-owner@vger.kernel.org Tue Mar 19 03:12:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHm2F-0006dB-Ut
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 03:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580Ab3CSCLw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Mar 2013 22:11:52 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:42576 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab3CSCLw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Mar 2013 22:11:52 -0400
Received: by mail-we0-f171.google.com with SMTP id u54so5283517wey.2
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 19:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=IGeipRgjPZDQ2vmGxLbpKCDxdCQXjs6PtDHPRR9MIh8=;
        b=ZUDA9Z+AQB2vAfjZTefYYXyaBRspUyON7icVUW9HxPULl6HCZygaR3/OCTQvLN0frK
         OcPu0Hv76lRSKVx9xYNWxk00HD3D6yAIhJvUF545wnjpFGlZ88v6O5JPDWypLvaZHn3C
         EbfvJCwgFbAtrvO2OJ0VSHRcF3jXRNwrVlCOnOS81Zrqv488Tjhy5DL3klyTEu3DVOMu
         Tsk+8TtF5hMiQNoDjxjaLbavj48z651hffgvck4aVm89YlLEm5sWc4WpROqlX4Hw0c81
         PvX+r6TltkOgeFMfCC7i3fYiCHK0CHm9sBlH3rq9fk2QO+xZPACE1IhSmcunfcvAMYRX
         RZtw==
X-Received: by 10.194.91.211 with SMTP id cg19mr144369wjb.43.1363659110584;
 Mon, 18 Mar 2013 19:11:50 -0700 (PDT)
Received: by 10.194.13.129 with HTTP; Mon, 18 Mar 2013 19:11:50 -0700 (PDT)
In-Reply-To: <9E0367AC-617A-440B-925E-5796CF2E1ADF@infoservices.in>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218472>

On Mon, Mar 18, 2013 at 5:24 AM, Joydeep Bakshi
<joydeep.bakshi@infoservices.in> wrote:
> I'm closer to my requirement. I have found gitweb simply provide a GU=
I  for history check
> and code comparison. And the git itself is good enough to do the ACL =
stuff with hooks.
>
> I already have the following code to deploy the push into its work-tr=
ee

You should try gitolite.  It has very flexible rules,
and it's already been implemented for you ;-)

https://github.com/sitaramc/gitolite



> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> #!/bin/bash
>
> while read oldrev newrev ref
> do
>   branch=3D`echo $ref | cut -d/ -f3`
>
>   if [ "master" =3D=3D "$branch" ]; then
>     git --work-tree=3D/path/under/root/dir/live-site/ checkout -f $br=
anch
>     echo 'Changes pushed live.'
>   fi
>
>   if [ "dev" =3D=3D "$branch" ]; then
>     git --work-tree=3D/path/under/root/dir/dev-site/ checkout -f $bra=
nch
>     echo 'Changes pushed to dev.'
>   fi
> done
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
> This code can be extended for as many branches as you have.
>
> I now need a mechanism to restrict the user to it's own branch so tha=
t user can't push into
> any other branch in mistake.
>
> Say I have
>
> master branch -> only admin user can push here.
> dev branch -> only user dev1 , dev2  and master can push here.
> testing branch -> only user test1 and test2 can push here.
>
> I think this can also be done with pre-receive hook. Any suggestion o=
n the hook design is
> welcome. Also this can be implemented on the above hook or in a separ=
ate hook.
> A separate hook is better due to maintainability and then I need to c=
all multiple
> pre-receive hook. Please suggest.
>
> Thanks
>
>
>
> On 18-Mar-2013, at 11:14 AM, Joydeep Bakshi <joydeep.bakshi@infoservi=
ces.in> wrote:
>
>>
>> On 15-Mar-2013, at 6:44 PM, Magnus B=C3=A4ck <baeck@google.com> wrot=
e:
>>>>
>>>
>>> Right, but that's R/W permissions. Almost any piece of Git hosting
>>> software supports restriction of pushes. Discriminating *read* acce=
ss
>>> between developers and maintenance people sounds like a disaster if=
 it's
>>> the same organisation.
>>
>> Just restriction on push access is what required.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
David
