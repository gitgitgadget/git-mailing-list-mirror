From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: Documentation/user-manual.txt, asciidoc and "--" escapes
Date: Mon, 10 Nov 2008 11:07:58 +0100
Message-ID: <20081110100757.GA12868@diku.dk>
References: <ddb82bf60811061904t5defc492m80cd1b759674eb6@mail.gmail.com> <ddb82bf60811061909m6f8a7b72o4b03ebcde8b9d188@mail.gmail.com> <ddb82bf60811090044l43eb4bb1ga5a16718a4176c29@mail.gmail.com> <2c6b72b30811091052k77200785j722c8aed2beb7684@mail.gmail.com> <ddb82bf60811092338m3aad8041w20de23f18aa7d56e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Piotr Findeisen <piotr.findeisen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 11:10:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzTi3-00040m-4z
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 11:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbYKJKII convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 05:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbYKJKIH
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 05:08:07 -0500
Received: from mgw2.diku.dk ([130.225.96.92]:35449 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753936AbYKJKIF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 05:08:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 0BAC019BB86;
	Mon, 10 Nov 2008 11:08:03 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32210-19; Mon, 10 Nov 2008 11:08:01 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 000F619BB72;
	Mon, 10 Nov 2008 11:08:00 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 228E46DF9AB; Mon, 10 Nov 2008 11:06:17 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id DA02E39A309; Mon, 10 Nov 2008 11:08:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ddb82bf60811092338m3aad8041w20de23f18aa7d56e@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100507>

Piotr Findeisen <piotr.findeisen@gmail.com> wrote Mon, Nov 10, 2008:
> >>> Asciidoc replaces "--" with "=E2=80=94" when not in verbatim mode=
=2E This is
> >>> sometimes unwanted -- especially when citing command line options=
 like
> >>> "git diff --cached". This commit includes proper quotes in user-m=
anual.txt.
> >
> > Newer asciidoc versions have the following "workaround". Maybe addi=
ng
> > something like this to Documentation/asciidoc.conf would be more
> > future proof.
>
> Well, this doesn't solve the problem -- I'm not talking about
> manpages, the "--" where replaced with single "=E2=80=94" on the
> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html page=
=2E

Sorry I didn't read your mail carefully enough.

> Yes, we can disable such a replacement in the config file, but take a
> look at the sentence "...how to fetch and study a project using
> git=E2=80=94read these chapters...". In this case "--" in the source =
file was
> replaced with "=E2=80=94" and this is what we want.

True.

> I noticed that all substitutions "--" -> "=E2=80=94", where "=E2=80=94=
" is a part of
> sentence punctuation, match \w--\w pattern (e.g. no spaces on both
> sides) and probably this is how it should be written in English. But
> basing on this doesn't seem to me to be fool proof.

So another option is to disable all substitution of "--" and just use
the "=E2=80=94" character when it is explicitly needed. The documentati=
on is
using UTF-8 after all. This would also fix the usage of "--" in the
manpages, e.g.

	You've now initialized the working directory--you may notice ...

in gittutorial(7). On my setup, with "--" replaced with "=E2=80=94", I =
get the
following nroff code:

	You've now initialized the working directory\(emyou may notice
	...

--=20
Jonas Fonseca
