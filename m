From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] Add compat/fopen.c which returns NULL on attempt to
 open directory
Date: Tue, 12 Feb 2008 16:27:22 +0100
Message-ID: <20080212162722.1d98e05d@pc09.procura.nl>
References: <47ACFFD9.2030705@nrlssc.navy.mil>
	<47AD10CF.1040207@nrlssc.navy.mil>
	<20080211102950.122ba93d@pc09.procura.nl>
	<20080211111537.2bf47448@pc09.procura.nl>
	<7v8x1r6n62.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 16:29:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOx4g-0000Mz-Ka
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 16:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757616AbYBLP2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 10:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757956AbYBLP2z
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 10:28:55 -0500
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:2881 "EHLO
	smtp-vbr2.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756569AbYBLP2y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 10:28:54 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr2.xs4all.nl (8.13.8/8.13.8) with ESMTP id m1CFRRGC007171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2008 16:27:27 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <7v8x1r6n62.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.3.0 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73666>

On Mon, 11 Feb 2008 16:20:05 -0800, Junio C Hamano <gitster@pobox.com> wrote:

> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> 
> > No, it is not. Some shell weirdness. This fixes it. Don't know off-hand
> > if it is portable enough
> >
> > diff -pur a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
> > --- a/t/t5701-clone-local.sh  2008-02-02 05:09:01 +0100
> > +++ b/t/t5701-clone-local.sh  2008-02-11 11:13:26 +0100
> > @@ -37,8 +37,8 @@ test_expect_success 'local clone from x'
> >
> >  test_expect_success 'local clone from x.git that does not exist' '
> >         cd "$D" &&
> > -       if git clone -l -s x.git z
> > -       then
> > +       git clone -l -s x.git z
> > +       if $? ; then
> >                 echo "Oops, should have failed"
> >                 false
> >         else
> 
> I think your "git clone" is broken and I strongly suspect it is
> not your shell (at least the "if" construct in the test).

of course it should have been 'if test $?' and as $? is erroneously
equal to 0 in this case, this snippet doesn't matter

'git clone' is calling 'cit-clone' which is a shell script, that does
exit 1 in the function die:
--8<---
die() {
	echo >&2 "$@"
	exit 1
}
-->8---

but somehow that exit code gets lost

> What's 
> 
> 	if $?; then
> 
> In sane shells, I think this tries to execute 0 or perhaps 124
> or whatever the error code from clone as if it was the name of a
> command, which would most likely fail and would not take "then"
> part (which reports the error).  It did not fix, but just made
> it ignore the error from "git clone".
> 
> If it were
> 
> 	if test $? != 0
>         then
> 
> it would have made a bit more sense.
> 
> And if (this is a big "if" as I doubt any shell is so broken)
> these two are equivalent to your shell, then I do not think it
> is portable at all.

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
