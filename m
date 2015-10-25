From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: git svn clone clone php/pear/Net_LDAP2 misses tags and branches
Date: Sun, 25 Oct 2015 13:25:58 -0600
Message-ID: <CAOc6etbD24Fxupb8uwp8daZP6BfViR_sN_E91mtnkL_gUgU-Mw@mail.gmail.com>
References: <20151025154325.36eddb4c@bogo>
	<CAOc6etYvzv+MFyTXk0zU673b1GypyUbTOuiVyS35PS4ROFHztg@mail.gmail.com>
	<20151025173033.28346d49@bogo>
	<20151025194851.793f8c64@bogo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Christian Weiske <cweiske@cweiske.de>
X-From: git-owner@vger.kernel.org Sun Oct 25 20:26:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqQvb-0002aH-B1
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 20:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbbJYTZ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Oct 2015 15:25:59 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35361 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbbJYTZ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2015 15:25:58 -0400
Received: by pasz6 with SMTP id z6so165275771pas.2
        for <git@vger.kernel.org>; Sun, 25 Oct 2015 12:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vGQJ+dbDXolPHZCnKwisJ9bpgM9ePk/BPHNGNpswaik=;
        b=k7NwQchO6r9rJlPFhhvAlwHxjk3G8pFcGDvqZl6/xH0epvui7Svz9hDoZrT4Nmr2ZO
         8ZNr+h75d9EvzEpGjhLAt60PexIW1SHNRoTLD+zdm1eTc5nrLb3z4ZmF4/IjPxT4ZjoK
         RaftMVWLqZiC4ltM4iy0x96jCGiI3dommzxtGPNyd3eLXvg/Oghs8sJLzkhq6GXAKKqB
         eNH3QXvJ3FHvkLUGcyUqIZYbdXA350o/DBavIQo6r2IYc9H6IVU2NAvg8GU6jTCqIKlb
         To0qigKIQ6CIK/Nxol6M526aFnpHNKLA6Fts99m3tIRLu850P1MrHFP6478Ye5uYT38g
         Wmkg==
X-Received: by 10.66.102.101 with SMTP id fn5mr17341631pab.111.1445801158153;
 Sun, 25 Oct 2015 12:25:58 -0700 (PDT)
Received: by 10.66.149.4 with HTTP; Sun, 25 Oct 2015 12:25:58 -0700 (PDT)
In-Reply-To: <20151025194851.793f8c64@bogo>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280165>

I think there's something "odd" in the way that branch was created. If
I take a look at another branch:

$ svn log -v --stop-on-copy
https://svn.php.net/repository/pear/packages/Net_LDAP2/tags/RELEASE_2_0=
_0RC2
-----------------------------------------------------------------------=
-
r255575 | cvs2svn | 2008-03-20 03:37:53 -0600 (Thu, 20 Mar 2008) | 1 li=
ne
Changed paths:
  A /pear/packages/Net_LDAP2/tags/RELEASE_2_0_0RC2 (from
/pear/packages/Net_LDAP2/trunk:255574)
  D /pear/packages/Net_LDAP2/tags/RELEASE_2_0_0RC2/LICENSE
  D /pear/packages/Net_LDAP2/tags/RELEASE_2_0_0RC2/tests/ldif_data/unso=
rted_w50_WIN.ldif

This commit was manufactured by cvs2svn to create tag 'RELEASE_2_0_0RC2=
'.
-----------------------------------------------------------------------=
-

We can see that it looks as if there was a single 'cp' operation for
the whole root of the branch from trunk.

And the log for that branch (on git) does show the history coming from =
trunk.


On the branch you are talking about:

$ svn log -v --stop-on-copy
https://svn.php.net/repository/pear/packages/Net_LDAP2/tags/Net_LDAP2-2=
=2E0.12
-----------------------------------------------------------------------=
-
r318475 | beni | 2011-10-27 07:49:00 -0600 (Thu, 27 Oct 2011) | 1 line
Changed paths:
  A /pear/packages/Net_LDAP2/tags/Net_LDAP2-2.0.12
  A /pear/packages/Net_LDAP2/tags/Net_LDAP2-2.0.12/Net
  A /pear/packages/Net_LDAP2/tags/Net_LDAP2-2.0.12/Net/LDAP2
  A /pear/packages/Net_LDAP2/tags/Net_LDAP2-2.0.12/Net/LDAP2/Entry.php
(from /pear/packages/Net_LDAP2/trunk/Net/LDAP2/Entry.php:318466)
  A /pear/packages/Net_LDAP2/tags/Net_LDAP2-2.0.12/Net/LDAP2/Filter.php
(from /pear/packages/Net_LDAP2/trunk/Net/LDAP2/Filter.php:318470)
  A /pear/packages/Net_LDAP2/tags/Net_LDAP2-2.0.12/Net/LDAP2/LDIF.php
(from /pear/packages/Net_LDAP2/trunk/Net/LDAP2/LDIF.php:318466)
  A /pear/packages/Net_LDAP2/tags/Net_LDAP2-2.0.12/Net/LDAP2/RootDSE.ph=
p
(from /pear/packages/Net_LDAP2/trunk/Net/LDAP2/RootDSE.php:318466)
=2E
=2E
=2E
   A /pear/packages/Net_LDAP2/tags/Net_LDAP2-2.0.12/tests/ldif_data/uns=
orted_w50.ldif
(from /pear/packages/Net_LDAP2/trunk/tests/ldif_data/unsorted_w50.ldif:=
318466)
  A /pear/packages/Net_LDAP2/tags/Net_LDAP2-2.0.12/tests/ldif_data/unso=
rted_w50_WIN.ldif
(from /pear/packages/Net_LDAP2/trunk/tests/ldif_data/unsorted_w50_WIN.l=
dif:3184
66)

Tagging the 2.0.12 release
-----------------------------------------------------------------------=
-


And this tells me that the way the branch was created is not the same
as in the other branch (files picked from different revisions?). I
guess that's what is making git-svn get "confused".

I guess you could just create a real git tag on a new revision coming
from trunk revision 318466, replace the files with the right revisions
(the ones that were pulled from another revision) and live with it.

On Sun, Oct 25, 2015 at 12:48 PM, Christian Weiske <cweiske@cweiske.de>=
 wrote:
> Hello Christian,
>
>
>> > Did you try with -r revision-number:HEAD?
>>
>> Good idea. I tried it, and now I have the tags and branches:
>
> Unfortunately, the tag branches only have a single commit and have no
> relation to the trunk branch:
>
> $ git log --oneline origin/tags/Net_LDAP2-2.0.12
> 0bc9db1 Tagging the 2.0.12 release
> $
>
> What can I do against that?
>
> --
> Regards/Mit freundlichen Gr=C3=BC=C3=9Fen
> Christian Weiske
>
> -=3D=E2=89=A1 Geeking around in the name of science since 1982 =E2=89=
=A1=3D-
