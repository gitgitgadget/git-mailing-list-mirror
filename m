From: Michael Olson <mwolson@gnu.org>
Subject: Re: git-svn: ignore-paths not enough (not ignoring refs?)
Date: Thu, 6 Oct 2011 17:41:59 -0700
Message-ID: <CAN4ruPgjPmsJ1mret9z_VfRbTivhiosErB_K=dbWn+QtsdUt6Q@mail.gmail.com>
References: <CAA01CsqEdoqSRrPDTrfOQPS7q-1tVALE_5vjeLUAeh0iXZi3_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 02:42:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RByW9-0006Lc-Gf
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 02:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796Ab1JGAmV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 20:42:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61666 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416Ab1JGAmU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 20:42:20 -0400
Received: by bkbzt4 with SMTP id zt4so4160036bkb.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 17:42:19 -0700 (PDT)
Received: by 10.204.7.133 with SMTP id d5mr940070bkd.25.1317948139333; Thu, 06
 Oct 2011 17:42:19 -0700 (PDT)
Received: by 10.204.112.79 with HTTP; Thu, 6 Oct 2011 17:41:59 -0700 (PDT)
X-Originating-IP: [99.116.250.80]
In-Reply-To: <CAA01CsqEdoqSRrPDTrfOQPS7q-1tVALE_5vjeLUAeh0iXZi3_A@mail.gmail.com>
X-Google-Sender-Auth: JZ4sXRRqVnDG2TfCb2UXCj_6WOw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183051>

I've resent my patch.  I've been using it with v1.7.4.1.

On Thu, Oct 6, 2011 at 1:43 AM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> Hi,
>
> I'm using --ignore-paths options but some paths which should be
> ignored (they math the regexp) are not ignored. I suspect this is
> because of http://thread.gmane.org/gmane.comp.version-control.git/145=
398
>
> It seems the patch from that url was never accepted to git. It does
> not apply anymore too. Is it possible to update the patch? From the
> discussion the patch looked ok (with exception to git-svn dying if a
> parent ref didn't exist :) )
>
>
> Here's my git-svn clone log, with some print lines added to is_path_i=
gnored():
>
> $ git svn clone -s --no-follow-parent =C2=A0--ignore-paths=3D'$REGEXP=
 -r 1230:1240 $URL
> [...]
> is_path_ignored: 'xtest/tags/rel1' =C2=A0# this matches the regexp an=
d
> should be ignored
> is_path_ignored: 'xtest/tags/rel1/common' # more paths which should b=
e
> ignored follow
> [...]
> r1237 =3D c660a7e6ad81cafa0a64a7ec85a3e23f0c02bc09
> (refs/remotes/tags/rel1) # but it is not!
>
> # I can see the tag:
> $ git branch -a
> =C2=A0remotes/tags/rel1
>
> # There are no changes in this change:
> $ git show -p c660a7e6ad81cafa0a64a7ec85a3e23f0c02bc09
> [...]
> =C2=A0 =C2=A0git-svn-id: $URL/rel1@1237 3e523551-a86b-4873-bcb6-76fcd=
93a4c5c
>
> # Under svn the r1237 is following:
> $ svn log -r 1237 -v $URL
> ---------------------------------------------------------------------=
---
> r1237 | ...
> Changed paths:
> =C2=A0 A /xtest/tags/rel1/common (from /xtest/branches/xtest44/common=
:1235)
>
> # The xtest/branches/xtest44/common does not match the ignore-paths
> and is not ignored.
>
>
> --
> Piotr Krukowiecki
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Michael Olson=C2=A0 |=C2=A0 http://mwolson.org/
