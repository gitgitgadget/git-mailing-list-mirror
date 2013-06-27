From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 2/5] git-remote-mediawiki: new git bin-wrapper for developement
Date: Fri, 28 Jun 2013 00:21:26 +0200
Message-ID: <vpqhagj9oux.fsf@anie.imag.fr>
References: <1372354652-4147-1-git-send-email-benoit.person@ensimag.fr>
	<1372354652-4147-3-git-send-email-benoit.person@ensimag.fr>
	<7vr4fnsafy.fsf@alter.siamese.dyndns.org>
	<CAETqRCjZdv-_V3jmhjxZj+_XU7AKRvMZ3ojo7=yW3m846F4E1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Celestin Matte <celestin.matte@ensimag.fr>
To: =?iso-8859-1?Q?Beno=EEt?= Person <benoit.person@ensimag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 28 00:21:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsKZM-0003Vj-Cs
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 00:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab3F0WVb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 18:21:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42310 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033Ab3F0WVb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 18:21:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5RMLNtd004671
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 28 Jun 2013 00:21:23 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UsKZC-0007qs-DQ; Fri, 28 Jun 2013 00:21:26 +0200
In-Reply-To: <CAETqRCjZdv-_V3jmhjxZj+_XU7AKRvMZ3ojo7=yW3m846F4E1w@mail.gmail.com>
	(=?iso-8859-1?Q?=22Beno=EEt?= Person"'s message of "Thu, 27 Jun 2013
 20:53:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 28 Jun 2013 00:21:23 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229163>

Beno=EEt Person <benoit.person@ensimag.fr> writes:

>> Two possible alternatives:
>>
>>  - Is there a reason you would not want to "install" whatever Perl
>>    modules you want to "use" via GITPERLLIB mechanism to
>>    ../../perl/blib/lib?
> If we are making modifications to Git/Mediawiki.pm or even git-mw.per=
l
> / git-remote-mediawiki.perl, installing them without proper testing
> beforehand seems wrong.

That's not "installing" (i.e. not "make install"), just a copy within
the source tree. Same as what's done in Git's toplevel.

> But it was weird to work on that in this serie which initial goal was
> to add a preview tool for git-remote-mediawiki and ended up adding a
> new perl package, a new 'git mw' command which handles subcommands,
> ...

That's life ;-). Refactoring as you add new features is really importan=
t
(remember your first attempt with a huge copy/paste ... nice for
prototyping, but not acceptable in the long run).

> In the end, this patch could be removed from the serie since it is
> self-contained : it is not used by 3/5, 4/5, and 5/5.

Well, it's the one that makes them usable without "make install"-ing, s=
o
I think it should remain part of the series.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
