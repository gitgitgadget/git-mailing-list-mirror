From: Michal Nazarewicz <mina86@tlen.pl>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 10:49:31 +0100
Message-ID: <8763mvoqqc.fsf@erwin.mina86.com>
References: <87ljvsjuq7.fsf@erwin.mina86.com>
	<bd6139dc0811091643m31ff6f49o55a4c581be7f38b2@mail.gmail.com>
	<87hc6gjs7v.fsf@erwin.mina86.com>
	<e3f230850811091943k63e4a93n566402458a6947dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: sverre@rabbelier.nl, git@vger.kernel.org
To: dhruva <dhruvakm@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 10:50:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzTQ9-0006Hp-Hx
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 10:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183AbYKJJtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 04:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754182AbYKJJtn
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 04:49:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:7107 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181AbYKJJtm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 04:49:42 -0500
Received: by ug-out-1314.google.com with SMTP id 39so317260ugf.37
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 01:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :x-url:x-pgp-fp:x-pgp:date:in-reply-to:message-id:user-agent
         :mime-version:content-type:sender;
        bh=+GtrYBjL/IzgXqU3i3tGQI9+3NDi+UER+1y7afKPjoU=;
        b=LSfktdaTM8/xG3b+kajmPnUZgg96S/z3hPqoVrslRVsKq/gejPmuzWf/LkYqUkFAII
         D1+MEOO4QA8yUOpkLYC8N/noXe7WtQkKyxyry6PGv+1ZNsS2SRVtuQ7S6klbI2Uh47ki
         js9DrlJNfz6VHepPpYR7mUbheKHqX4adZc8ro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:x-url:x-pgp-fp:x-pgp:date:in-reply-to
         :message-id:user-agent:mime-version:content-type:sender;
        b=ZplWLYDQN8p3F1WgCTMymxWmSQDYKaZnaM7xHYyVVAt3o+qj3F/F55RVlly3VbjBj+
         sxikxh13mcWvmC/MI6RzFCn4ek+65Q41Inuv48/bLt7kMp4joZ0PWLW5OfIk3JtyERiO
         xGBX5+qVRdJaRg4TcoWUJv7K0Pb8IvNyNWpJ4=
Received: by 10.67.90.10 with SMTP id s10mr1893819ugl.8.1226310580453;
        Mon, 10 Nov 2008 01:49:40 -0800 (PST)
Received: from erwin.piotrekn (cno208.neoplus.adsl.tpnet.pl [83.31.168.208])
        by mx.google.com with ESMTPS id m38sm3421561ugd.51.2008.11.10.01.49.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Nov 2008 01:49:39 -0800 (PST)
X-Url: http://mina86.com/
X-PGP-FP: 9134 06FA 7AD8 D134 9D0C  C33F 532C CB00 B7C6 DF1E
X-PGP: B7C6DF1E
In-Reply-To: <e3f230850811091943k63e4a93n566402458a6947dd@mail.gmail.com>
	(dhruva's message of "Mon, 10 Nov 2008 09:13:04 +0530")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0 (Slckware Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100503>

--=-=-=
Content-Transfer-Encoding: quoted-printable

> On Mon, Nov 10, 2008 at 6:46 AM, Michal Nazarewicz <mina86@tlen.pl> wrote:
>> I would like the "$Id$" sequences to be updated automatically after
>> a commit (ie. without the need to check out).

dhruva <dhruvakm@gmail.com> writes:
> There is no direct way to get this $Id$ expansion in git, however you
> can use a simple pre-commit hook (alpha state, more a proof of concept
> that happens to work for me)
>
> #!/usr/bin/env bash
>
> for file in `git diff-index --name-only --diff-filter=3DAM HEAD` ; do
>         perl -pi -e 's/(\$[ \t]*Id)(.*)([ \t]*\$)/"\$Id: git
> ".time()." \$"/e' ${file}
>         git add ${file} > /dev/null
> done

In fact the following works just as well:

#v+
files=3D$(git diff-index --name-only --diff-filter=3DAM HEAD)
perl -pi -e 's/\$\s*Id.*?\$/\$Id: git '$(TZ=3DUTC date +%s)' \$/g' $files
git add $files
#v-

But then again, it has two unpleasant side effects: (i) all modified
files are added and (ii) if I abort a commit the file stays modified.
(i) can be fixed by removing "git add" but then again (iii) even files
which are not committed will be modified.

=2D-=20
Best regards,                                         _     _
 .o. | Liege of Serenly Enlightened Majesty of      o' \,=3D./ `o
 ..o | Computer Science,  Michal "mina86" Nazarewicz   (o o)
 ooo +--<mina86*tlen.pl>--<jid:mina86*jabber.org>--ooO--(_)--Ooo--

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkkYA7AACgkQUyzLALfG3x6dKACfU+9KBooZSa/UW0yoOlZoX4Ol
R/0AoKp1vlYehDZYyGxWpUA496jFKH1U
=Iybg
-----END PGP SIGNATURE-----
--=-=-=--
