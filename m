From: Eugene Sajine <euguess@gmail.com>
Subject: [BUG] ? - git log :/text results are strange
Date: Fri, 19 Feb 2010 16:50:39 -0500
Message-ID: <76c5b8581002191350h61d6d8c2jd0245c0963fcc85f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 22:50:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiakH-0003wK-UU
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 22:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888Ab0BSVul convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 16:50:41 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:44089 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab0BSVuk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2010 16:50:40 -0500
Received: by gxk9 with SMTP id 9so597438gxk.8
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 13:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=muUFjEWfB2EFcqJbakBNxa5PUBL80xxfL2nZq2O2U2k=;
        b=Bw/+Yy5JU1AurGN2pkiuWW6YJyV6wERPOi0A6OtxlJFOe+uQNr8Fc7X4bPD6Tsa//j
         mVYg1S8jkbdl1OnWpVE0VACNOm9/sLwCZb5Uz2GKjIV7SSRe1hzdVw6c6X3GPXYGkDQH
         lAVSQBp+NDmePCoecUbo2OIQ0BQueNaik/zWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=mmuRJTkC/IsrOjZff7/rlDFThxO4KWZGW09AW/6uGlILZ2xFK5kmlqk4lZM86Qatqm
         i1sPVMgIR+UOR3JUxZpsJ47KPWXIUsv6cNML0ByDLFnOKshct1wTbc4Kfyr/cv/I6TjM
         y0GgXmPAZJtWR1FyXHt4CCuNdQzj2JaqRNV9k=
Received: by 10.231.169.71 with SMTP id x7mr1763142iby.18.1266616239555; Fri, 
	19 Feb 2010 13:50:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140485>

Hi,


When I=E2=80=99m executing
$ git log :/fix

I expect to see commits with messages starting from word =E2=80=9Cfix=E2=
=80=9D only
in git.git I=E2=80=99m getting a list of commits where some of messages=
 are
starting from this word and some are not

as this:

$ git log :/fix

commit a525d2a41825530c01fd5eac497df0fcd82dca0b
Author: Junio C Hamano <gitster@pobox.com>
Date: =C2=A0 Tue Dec 8 22:16:55 2009 -0800

=C2=A0 =C2=A0fixup! rebase -i --autosquash

commit 66a357d9bac24cc9b8419c256b5e35c327d2997c
Author: Nanako Shiraishi <nanako3@lavabit.com>
Date: =C2=A0 Tue Dec 8 12:13:14 2009 +0900

=C2=A0 =C2=A0rebase -i --autosquash: auto-squash commits

=C2=A0 =C2=A0Teach a new option, --autosquash, to the interactive rebas=
e.
=C2=A0 =C2=A0When the commit log message begins with "!fixup ...", and =
there
=C2=A0 =C2=A0is a commit whose title begins with the same ..., automati=
cally
=C2=A0 =C2=A0modify the todo list of rebase -i so that the commit marke=
d for
=C2=A0 =C2=A0squashing come right after the commit to be modified, and =
change
=C2=A0 =C2=A0the action of the moved commit from pick to squash.

=C2=A0 =C2=A0Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
=C2=A0 =C2=A0Signed-off-by: Junio C Hamano <gitster@pobox.com>

commit 0205e72f088322a70a77643a7cd2d8b23ee07e14
Author: Michael Haggerty <mhagger@alum.mit.edu>
Date: =C2=A0 Mon Dec 7 10:20:59 2009 +0100

=C2=A0 =C2=A0Add a command "fixup" to rebase --interactive

=C2=A0 =C2=A0The command is like "squash", except that it discards the =
commit message
=C2=A0 =C2=A0of the corresponding commit.

=C2=A0 =C2=A0Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
=C2=A0 =C2=A0Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
=C2=A0 =C2=A0Signed-off-by: Junio C Hamano <gitster@pobox.com>

commit 163f3925902446735b2f631dc44ab67882a93024
Author: Michael Haggerty <mhagger@alum.mit.edu>
Date: =C2=A0 Mon Dec 7 05:22:58 2009 +0100

=C2=A0 =C2=A0t3404: Use test_commit to set up test repository

=C2=A0 =C2=A0Also adjust "expected" text to reflect the file contents g=
enerated by
=C2=A0 =C2=A0test_commit, which are slightly different than those gener=
ated by the
=C2=A0 =C2=A0old code.

=C2=A0 =C2=A0Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
=C2=A0 =C2=A0Signed-off-by: Junio C Hamano gitster@pobox.com

And so on=E2=80=A6

This is reproducible problem on Linux env git v 1.6.5.6 and in msysgit
1.6.4.msysgit.0

Thanks,
Eugene
