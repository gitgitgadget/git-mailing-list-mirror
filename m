From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] perl shebangs: Use /usr/bin/env, not /usr/bin/perl
Date: Fri, 21 May 2010 08:32:53 -0700
Message-ID: <86tyq1gti2.fsf@red.stonehenge.com>
References: <1274453455-1941-1-git-send-email-avarab@gmail.com>
	<1274454086-2312-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 17:33:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFUDc-00036o-Gt
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 17:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933561Ab0EUPcz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 11:32:55 -0400
Received: from red.stonehenge.com ([208.79.95.2]:11908 "EHLO
	red.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758226Ab0EUPcy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 11:32:54 -0400
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 53D0219C04; Fri, 21 May 2010 08:32:54 -0700 (PDT)
x-mayan-date: Long count = 12.19.17.6.15; tzolkin = 8 Men; haab = 8 Zip
In-Reply-To: <1274454086-2312-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 21 May
 2010 15:01:26 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147469>

>>>>> "=C3=86var" =3D=3D =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> writes:

=C3=86var> Change the Perl Git utilities to use #!/usr/bin/env perl as =
a shebang
=C3=86var> instead of #!/usr/bin/perl. This makes e.g. git-send-email w=
ork if
=C3=86var> your personal perl has Net::SMTP::SSL, but your system perl
=C3=86var> doesn't.

Not a good idea in general.

=C3=86var> With this change all the code in Git that uses a shebang now=
 uses
=C3=86var> /usr/bin/env, except those things that use /bin/sh and /bin/=
bash. All
=C3=86var> the Python code already used it, and some of the Perl code.

Sorry I didn't catch this earlier then.

I often have an "experimental" Perl earlier in my path than the
"official" Perl.  This would mean that I'd get different behaviors
running git from the command line than I would from automated tools, an=
d
it would be relatively confusing.

The official Perl should be in /usr/bin or /usr/local/bin, and that's
the one you should use with Git.  *Or*, give the installer a knob to
configure.

But please don't use env.  Heck, some systems might not even *have*
env.  And some systems have it in /bin and not /usr/bin.  Don't ruin
portablity at this point, please.

--=20
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 =
0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discus=
sion
