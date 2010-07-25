From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: don't include git version file on 'make clean'
Date: Sun, 25 Jul 2010 11:41:30 +0000
Message-ID: <AANLkTilHrEImfhl0YTqj0MgXFTzYmJMJrUTKkflGFwpp@mail.gmail.com>
References: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com>
	<AANLkTilYXdVI_fqG5ZvPEABTXt7fTps3ZbPiiWgVnDxS@mail.gmail.com>
	<4C4BFAA3.3050700@digium.com>
	<7F48A44C0E1FBF48B00D4DA49C85432E54F998@CORPUSMX100A.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kpfleming@digium.com, git@vger.kernel.org
To: lynn.lin@emc.com
X-From: git-owner@vger.kernel.org Sun Jul 25 13:41:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OczaO-00056X-8t
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 13:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab0GYLle convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 07:41:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64982 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab0GYLld convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 07:41:33 -0400
Received: by iwn7 with SMTP id 7so1844362iwn.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HXTW8LtCQRz5fkRsXAN8HJ2UrOAHUQO/oiPgzEtBPmk=;
        b=unN2QVWFNI7TChKO693F8XNsPW7LrVbasaCkrdsrx/DtzJcUAojVQXhPCcj55lP5q1
         X0XXp93YDn8ilZbFhOTHJ+Ni0SxPNtqdvtXw7eV28GY5gOPaa3yI+IBbQtDpcNST5Y5w
         GQAF+k1honqspHdvAUVlI4PcBbRfk3EoT5QSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Gm8SkC28cDG+3KQD3tQ+YvqrExnMOliNowf15MH4eF2eDz0Ea9SQvpqRWgQ9YN6LAy
         nuY9cTHonOsP26xAsM2A908Je6GPQQXlVmgwelJvlxwFaA0WoD6qbB3D4azaer24ed5S
         JUawcJrTzRdHqhYH/h4TS3akP3puz7lNTLPdU=
Received: by 10.231.32.200 with SMTP id e8mr6674712ibd.66.1280058090512; Sun, 
	25 Jul 2010 04:41:30 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 25 Jul 2010 04:41:30 -0700 (PDT)
In-Reply-To: <7F48A44C0E1FBF48B00D4DA49C85432E54F998@CORPUSMX100A.corp.emc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151725>

On Sun, Jul 25, 2010 at 11:28,  <lynn.lin@emc.com> wrote:
>
>
> -----Original Message-----
> From: Kevin P. Fleming [mailto:kpfleming@digium.com]
> Sent: 2010=E5=B9=B47=E6=9C=8825=E6=97=A5 16:50
> To: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> Cc: Lin, Lynn; git@vger.kernel.org
> Subject: Re: [PATCH] Makefile: don't include git version file on 'mak=
e clean'
>
> On 07/24/2010 02:36 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Sat, Jul 24, 2010 at 03:53, =C2=A0<Lynn.Lin@emc.com> wrote:
>>> From: Lynn Lin <Lynn.Lin@emc.com>
>>>
>>> ---
>>> =C2=A0Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 +++-
>>> =C2=A0git-gui/Makefile | =C2=A0 =C2=A04 +++-
>>> =C2=A02 files changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index bc3c570..eb28b98 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -238,7 +238,9 @@ all::
>>>
>>> =C2=A0GIT-VERSION-FILE: FORCE
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0@$(SHELL_PATH) ./GIT-VERSION-GEN
>>> --include GIT-VERSION-FILE
>>> +ifneq "$(MAKECMDGOALS)" "clean"
>>> + =C2=A0-include GIT-VERSION-FILE
>>> +endif
>>>
>>> =C2=A0uname_S :=3D $(shell sh -c 'uname -s 2>/dev/null || echo not'=
)
>>> =C2=A0uname_M :=3D $(shell sh -c 'uname -m 2>/dev/null || echo not'=
)
>>> diff --git a/git-gui/Makefile b/git-gui/Makefile
>>> index 197b55e..91e1ea5 100644
>>> --- a/git-gui/Makefile
>>> +++ b/git-gui/Makefile
>>> @@ -9,7 +9,9 @@ all::
>>>
>>> =C2=A0GIT-VERSION-FILE: FORCE
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0@$(SHELL_PATH) ./GIT-VERSION-GEN
>>> --include GIT-VERSION-FILE
>>> +ifneq "$(MAKECMDGOALS)" "clean"
>>> + =C2=A0-include GIT-VERSION-FILE
>>> +endif
>>>
>>> =C2=A0uname_S :=3D $(shell sh -c 'uname -s 2>/dev/null || echo not'=
)
>>> =C2=A0uname_O :=3D $(shell sh -c 'uname -o 2>/dev/null || echo not'=
)
>>> --
>>> 1.7.1
>>
>> This patch needs a rationale, why was it needed? The "-include"
>> directive will simply ignore files that don't exist (as opposed to
>> "include"), so including GIT-VERSION-FILE during "make clean'
>> shouldn't be an issue.
>
> Just guessing here, but since GIT-VERSION-FILE has a 'FORCE'
> prerequisite, that means that the operations to generate it will be r=
un
> even for 'make clean', which is not useful for the cleaning operation=
=2E
> It's probably not harmful either... but maybe the OP has some more
> significant reason for this patch.
>
>

> Yes, when we run 'make clean' ,it also generate the git version
> file,then remove it .It's not necessary to trigger the operation
> when run 'make clean' command

Sure, it's not needed. But it's OK to have a bit of redundancy for
simplicity, unless that redundancy is breaking something. Which is why
I asked whether it was actually causing a problem in any case.

With this patch we still call ./GIT-VERSION-GEN to make the
=2E/GIT-VERSION-FILE, we just aren't including it anymore, and it would
still be included on "make distclean" since you're just looking at
$(MAKECMDGOALS).
