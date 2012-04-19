From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Help with repo management.
Date: Fri, 20 Apr 2012 09:49:39 +1000
Message-ID: <CAH5451nL+BiZPo-cWHwYC4GkA=pT3zgBXi_M-TB-qgDfmy7yow@mail.gmail.com>
References: <4F902294.10302@abemblem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mark Haney <markh@abemblem.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 01:50:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SL174-0007nn-LV
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 01:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756855Ab2DSXuE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Apr 2012 19:50:04 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:42651 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151Ab2DSXuB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2012 19:50:01 -0400
Received: by wibhj6 with SMTP id hj6so122307wib.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 16:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AKXcSMcDVeI9vB8pgCXuGKNJ0+RDFVRlZbgB6tS6Byk=;
        b=P+KBxj1Jo2GTarValr5DLelvxVJdHjDBaxL7r6+hrzh2QeYX1Hj54wmi2NQ/nXj9IN
         402rQFZQjIOCSr9J9ee5NZT5GPkmZfLfSMwyY4vw5NuuwOxLY3HnVOrMkCODR46LXqmj
         WJjnQYuszD48+/4mTcoBqscxP7Ar5LfRnnpBJ16PCCrld4U0lkldPXCkSsDUa0St5evS
         QqHTNbSYbObXGES9r+xeFg3zUXUibovaagY+XFcqOcAFL0whq8BfxmglP6mzuemUTrcI
         k+dxDLDRvRHlEC4ximpA9jx2WoQcoMdr7miA5NVotuG+eiLRiWhJ3PNQzDX3EfkADhCe
         UUAQ==
Received: by 10.180.102.3 with SMTP id fk3mr4416897wib.9.1334879399987; Thu,
 19 Apr 2012 16:49:59 -0700 (PDT)
Received: by 10.223.158.69 with HTTP; Thu, 19 Apr 2012 16:49:39 -0700 (PDT)
In-Reply-To: <4F902294.10302@abemblem.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195979>

On 20 April 2012 00:35, Mark Haney <markh@abemblem.com> wrote:
> I'm new to git and repo management and I have an issue that I can't q=
uite
> figure out. =C2=A0Here's my problem.
>
> I have a server (SERVER) with a repo on it. =C2=A0It has all my code =
and
> documentation. =C2=A0I pulled that repo onto my workstation for a loc=
al copy so I
> could work at home or wherever with needing server access. My problem=
 is I
> can /pull/ from the repo on SERVER, but I can't /push/ any local chan=
ges
> back to the server. =C2=A0I get an error message about master being c=
hecked out.
>
> I know a little about bare repos, but my understanding is that the ba=
re repo
> doesn't actually have the actual files in it, just the changes, which=
 is not
> what I want. =C2=A0I would like to have the copy on SERVER to work fr=
om if I
> want, and also be able to pull/push changes from my local copy as wel=
l.
> =C2=A0That way I have 2 copies of the data handy (not to mention the =
disc
> backups.
>
> I'm fairly sure this can be setup, but I just don't know enough to fi=
gure it
> out. =C2=A0Can someone point me in the right direction?
>

=46irst things first, don't think that just because a bare repository
does not have a working copy that it doesn't have all the data. Having
a local working copy and a bare repository on a server _is_ keeping
two separate copies of your data handy, just one is not immediately
accessible (you have to check it out first). This may be your
understanding, but it was unclear so I thought I would clarify.

In terms of pushing to a remote, it is best practice to NOT push to a
repository that has a checked out working copy. The main reason for
this is that it becomes much easier to lose data, which is bad.

Instead, if you want to work on SERVER as well as some other machine,
it is safer to checkout the bare repository to another repository on
SERVER, pulling and pushing to the bare repository in the same fashion
as you would from a remote machine.

Some more explanation can be found at
http://gitready.com/advanced/2009/02/01/push-to-only-bare-repositories.=
html
for example.

Regards,

Andrew Ardill
