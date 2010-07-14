From: "Bernhard R. Link" <brlink@debian.org>
Subject: Re: [PATCH/RFC 4/4] Add interactive mode to git-shell for
	user-friendliness
Date: Wed, 14 Jul 2010 17:24:44 +0200
Message-ID: <20100714152444.GA26674@pcpool00.mathematik.uni-freiburg.de>
References: <1279076475-27730-1-git-send-email-gdb@mit.edu> <1279076475-27730-5-git-send-email-gdb@mit.edu> <AANLkTil4XkVXM-96Jb7UOpH2CZBmtXEf7eEIIgrsqhg5@mail.gmail.com> <4C3DC2BD.6020907@digium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 17:24:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ3pL-0002MN-4H
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 17:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757292Ab0GNPYq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 11:24:46 -0400
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:34066
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753692Ab0GNPYp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 11:24:45 -0400
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1OZ3pE-0005ST-GP
	for git@vger.kernel.org; Wed, 14 Jul 2010 17:24:44 +0200
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1OZ3pE-0006x2-EM
	for git@vger.kernel.org; Wed, 14 Jul 2010 17:24:44 +0200
Content-Disposition: inline
In-Reply-To: <4C3DC2BD.6020907@digium.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150994>

* Kevin P. Fleming <kpfleming@digium.com> [100714 15:59]:
> On 07/14/2010 04:04 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> > On Wed, Jul 14, 2010 at 03:01, Greg Brockman <gdb@mit.edu> wrote:
> >> +               execl(prog, prog, (char *) NULL);
> >
> > Why the casting of NULL? It's not done in the builtin/help.c code.
> >
> > Anyway, if it was cast it should be to (const char *), shouldn't it=
?
>
> When a NULL sentinel is passed to a varargs function that only
> understands 'char *' arguments, the NULL must be cast specifically,
> otherwise it will appear in the varargs array as an int or a long.

To be more specific: If NULL is (void *)0 then it does not need to be
cast. Sadly the standard allows to define it as 0, and so it is on
some systems. So to be portable it needs to be cast to be a pointer,
otherwise the varargs argument is assumed to be an int.

	Bernhard R. Link
