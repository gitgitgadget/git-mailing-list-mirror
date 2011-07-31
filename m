From: Michael Nahas <mike.nahas@gmail.com>
Subject: RE: File Systems and a Theory of Edits
Date: Sun, 31 Jul 2011 10:15:01 -0400
Message-ID: <CADo4Y9gECLJ45g_r-uZBRnfEVXBRw2EoF2HkRu=0-eJ2YCuBLA@mail.gmail.com>
References: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com>
	<CACBZZX48aDN_Njm+qMvovfz1tjdhnmXe5-bbJe=0_Q3LbLWoPA@mail.gmail.com>
	<4E350F15.9050009@lsrfire.ath.cx>
	<CADo4Y9gU_Z73gCPCESvVZhLOJUJg+mTqHkeqpNv2L8xLJvKxEQ@mail.gmail.com>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 16:15:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnWnh-0007it-Uw
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 16:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735Ab1GaOPF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jul 2011 10:15:05 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:47197 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681Ab1GaOPD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2011 10:15:03 -0400
Received: by eye22 with SMTP id 22so4197625eye.2
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 07:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=abL9ovyRiDZjYAuKacHr6NK3hkYkh0cOblMzciDj+1s=;
        b=mxwBG9r82a0yb0jJsIzqMyEqKRCkb+5jKMMu1S390sGgY0OmC88jEaLdnF8eJMr9GJ
         70i/0TOtmJSQESccFPGBoQ1Ah9PZbaFlwLNCuALDMlh+mecdh2Y4QQRSG00yEphU+Zqt
         coe2XosY/Au37RXm9yonQTAAfkfMpXqXUQaFs=
Received: by 10.14.16.231 with SMTP id h79mr1285756eeh.0.1312121701879; Sun,
 31 Jul 2011 07:15:01 -0700 (PDT)
Received: by 10.14.53.3 with HTTP; Sun, 31 Jul 2011 07:15:01 -0700 (PDT)
In-Reply-To: <CADo4Y9gU_Z73gCPCESvVZhLOJUJg+mTqHkeqpNv2L8xLJvKxEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178260>

Rene,
I don't doubt that there exists current commands in git that can
perform operations like cat, ls, etc.=A0 My point is that git can make
it easier for new users to learn commands and existing users to
remember commands if git copies the name and sematics (as much as
possible) of cat, ls, etc.

=C6var,
The issue is what goes inside the xargs command.=A0 If it is unix's cat
command, the files listed by find will be from the commit's snapshot,
but the files read by cat will be from the working tree.

I believe the solution for xargs may be John D.'s solution - to
"mount" the snapshot as a file system.=A0 And the "mount" command in gi=
t
is "git checkout".=A0 (Now, I almost want to rename "git checkout" to
"git remount"!)


Mike Nahas


On Sun, Jul 31, 2011 at 4:15 AM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
>
> Am 30.07.2011 21:06, schrieb =C6var Arnfj=F6r=F0 Bjarmason:
> > On Sat, Jul 30, 2011 at 16:29, Michael Nahas <mike.nahas@gmail.com>=
 wrote:
> >> =A0 =A0 "git xargs <commit> ..." =A0(Is this possible?)
> >
> > I don't have comments on the rest of your proposal, but I've often
> > wanted a git-find(1) similar to git-grep(1). Which would give you t=
his
> > functionality.
> >
> > Then you could simply:
> >
> > =A0 =A0 git find <commit> <path> -type f | xargs <whatever>
> >
> > Or something like that.
>
> How about this, which should match your example:
>
> =A0 =A0 =A0 =A0git ls-tree -r --name-only <commit> <path> | xargs <wh=
atever>
>
> Ren=E9
