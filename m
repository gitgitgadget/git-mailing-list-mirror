X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: reexporting git repository via git-daemon
Date: Sun, 10 Dec 2006 17:42:44 +0100
Organization: SelfOrganizing
Message-ID: <200612101742.44564.arekm@maven.pl>
References: <200612082212.09682.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 10 Dec 2006 16:43:10 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <200612082212.09682.arekm@maven.pl>
Content-Disposition: inline
X-Authenticated-Id: arekm
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33900>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtRlZ-0000Mw-Vz for gcvg-git@gmane.org; Sun, 10 Dec
 2006 17:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762257AbWLJQnD convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006 11:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762258AbWLJQnC
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 11:43:02 -0500
Received: from outgoing1.smtp.agnat.pl ([193.239.44.83]:55482 "EHLO
 outgoing1.smtp.agnat.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762257AbWLJQnA convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 11:43:00 -0500
Received: from [83.11.40.170] (helo=[192.168.0.64]) by tekla.agnat.pl with
 esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256) (Exim 4.63) (envelope-from
 <arekm@maven.pl>) id 1GtRlK-0005wu-EM for git@vger.kernel.org; Sun, 10 Dec
 2006 17:42:50 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 08 December 2006 22:12, Arkadiusz Miskiewicz wrote:

> strace on git-daemon side:
> [...]
> 18241 lstat("refs/tags/v1.4.1-rc2", {st_mode=3DS_IFREG|0644, st_size=3D=
41,
> ...}) =3D 0
> 18241 open("refs/tags/v1.4.1-rc2", O_RDONLY) =3D 7
> 18241 read(7, "33c9db007159db11c1ad5fa7101ea95853740acf\n", 255) =3D =
41
> 18241 close(7)                          =3D 0
> 18241 write(1, "004233c9db007159db11c1ad5fa7101ea95853740acf
> refs/tags/v1.4.1-rc2\n", 66) =3D 66
> 18241 write(1, "0045abc02670169cee9541793a86324a014272ca8ed5
> refs/tags/v1.4.1-rc2^{}\n", 69) =3D 69
> 18241 stat("refs/tags/v1.4.1.1", {st_mode=3DS_IFREG|0644, st_size=3D4=
1, ...}) =3D
> 0 18241 lstat("refs/tags/v1.4.1.1", {st_mode=3DS_IFREG|0644, st_size=3D=
41,
> ...}) =3D 0 18241 open("refs/tags/v1.4.1.1", O_RDONLY) =3D 7
> 18241 read(7, "8419a453dc088b25b63ab1746d3d7e679caf686d\n", 255) =3D =
41
> 18241 close(7)
> 18241 write(1, "00408419a453dc088b25b63ab1746d3d7e679caf686d
> refs/tags/v1.4.1.1\n", 64) =3D 64
> 18241 write(2, "fatal: ", 7)            =3D 7
> 18241 write(2, "corrupted pack
> file ./objects/pack/pack-0bb22295a585ac173504a2f8dfb3e31e074a8715.pac=
k",
> 85) =3D 85
> 18241 write(2, "\n", 1)
>
> 100% repeatable at this moment. Any ideas?

after:
$  git repack -a -d
Generating pack...
Done counting 33587 objects.
Deltifying 33587 objects.
 100% (33587/33587) done
Writing 33587 objects.
 100% (33587/33587) done
Total 33587, written 33587 (delta 23205), reused 33587 (delta 23205)
Pack pack-bc830a5d1c2efa3b727ef9af8faba13c3e719395 created.

the problem disapears and I can safely reexport git repository.

Does anyone care about this bug in git?

--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
