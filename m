From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add git format-patch produced patches to .gitignore
Date: Mon, 17 May 2010 09:52:33 +0200
Message-ID: <4BF0F5C1.1060309@drmicha.warpmail.net>
References: <1273958566-7328-1-git-send-email-avarab@gmail.com> <4BEFFBB5.7010808@drmicha.warpmail.net> <20100517022244.GA19141@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 17 09:52:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODv7p-0007jC-LN
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 09:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab0EQHw2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 May 2010 03:52:28 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46472 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753773Ab0EQHw2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 03:52:28 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 597EAF75F8;
	Mon, 17 May 2010 03:52:27 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 17 May 2010 03:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=XKvKlpP5LdZw61wj7J65wzBztDw=; b=VAVWvn8dPnfOJdAGrCBKSO6LVMNqnFt8yuLsEif/iCPVzmq7PeSYbUrMvLAp9ru90eKrSPhSmmGQ9WhuXzX7m37uc+uClMg9FAA2XbGRAnrZ5I21i3aMmuq6fuW5e+Eekol3CFt31PvRDgh+T/QVi+mox3oR58esck0VkJhcCK4=
X-Sasl-enc: GIsIbCAzkA5J5tpzinkQ8TaJhxfVjm04VEZYfdeb6yE3 1274082746
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 78DC0430C;
	Mon, 17 May 2010 03:52:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <20100517022244.GA19141@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147214>

Jonathan Nieder venit, vidit, dixit 17.05.2010 04:22:
> Michael J Gruber wrote:
>=20
>> If you want to ignore format patch output, simply use .git/info/excl=
udes
>> or a global excludes file, but please don't force everyone else to l=
ive
>> with that or work around it.
>=20
> Side note: I said with similar intent that this allows developers to
> work =E2=80=9Cwithout interference=E2=80=9D.  This was a poor choice =
of words on my
> part: a too-long .gitignore only prevents me from noticing and
> tracking files that others considered not worth tracking.
>=20
> From the thread I faintly remembered and then linked to[1]: ;-)
>=20
>   I earlier said that "*~" should not be in project-wide .gitignore
>   file because use of Emacs vs vi is a matter of personal taste, and
>   Emacs specific "*~" pattern does not belong to a project policy,
>   just like vim "*.swp" pattern doesn't.
>=20
>   But I think that reasoning is flawed.  The right criteria should no=
t
>   be about "use of Emacs vs vi", but about "do we in this project eve=
r
>   want to track files that match *~ or *.swp as legitimate contents".
>   If a project expects not to have a tracked file whose name ends wit=
h
>   ".swp", even if it does _not_ mean to encourage use of vim over
>   Emacs or any other editor, I think it is fine to add such to its
>   tracked .gitignore file for its developer's benefit.

I think I meant to object back then but concluded it made no difference=
=2E
My mathematically deformed^Weducated mind tells me that "do we...
contents" means we should put everything in .gitignore except what we
expect to track. So, here the literal understanding certainly differs
from the intended definition ;)

>=20
> This does not change my conclusion: there are many other reasons to
> leave files produced outside the build process unlisted:
>=20
>  . consistency: to keep the file intuitive and avoid a lot of
>    patch churn, it is nicest to choose one rule and stick to it
>=20
>  . simplicity: shorter .gitignore.  Making the appropriate content
>    of .gitignore depend on the behavior of too many text editors
>    (and IDEs, and foreign VCSes, and debugging tools, and ...)
>    makes it hard to maintain.  See qt=E2=80=99s .gitignore for an exa=
mple
>    of this.
>=20
>  . correctness: for the case of format-patch, it is hard to say
>    "we will never want to track files that match ????-*.patch as
>    legitimate contents".  In fact, it is likely such files may need
>    to be added to the test suite.
>=20
> And unlike .o files and company, it does not seem likely that
> formatted patches need to be kept around during development.
>=20
> I hope that is a little clearer.  Sorry for the ramble.
> Jonathan

I haven't found the rambling part in your post yet but agree everything
is clearer now :)

Michael

P.S.: I'm fine with =C3=86var's revised patch, of course. ACK
>=20
> [1] http://thread.gmane.org/gmane.comp.version-control.git/96220/focu=
s=3D96294
