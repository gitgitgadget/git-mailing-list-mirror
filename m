From: Brian Foster <brian.foster@maxim-ic.com>
Subject: Re: [Q] Comparing differences introduced by two commits?
Date: Fri, 24 Aug 2012 10:52:37 +0200
Message-ID: <5720224.TlUPhgDYky@laclwks004>
References: <2794881.R5SsgFdXjR@laclwks004> <7vharuamok.fsf@alter.siamese.dyndns.org> <CAF5DW8J8JL-jGexh+CmmCafFAREjAJrb8zzOwP8b9fEuqUB56w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Junio C Hamano <gitster@pobox.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 11:11:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4pvo-0008WE-Ui
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 11:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757828Ab2HXJLu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Aug 2012 05:11:50 -0400
Received: from antispam02.maxim-ic.com ([205.153.101.183]:59474 "EHLO
	antispam02.maxim-ic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab2HXJLr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2012 05:11:47 -0400
X-ASG-Debug-ID: 1345798363-0520cc4f1b215650001-QuoKaX
Received: from maxdalex01.maxim-ic.internal (maxdalex01.maxim-ic.internal [10.16.15.101]) by antispam02.maxim-ic.com with ESMTP id 9UxPcMi7DzqBPVK1; Fri, 24 Aug 2012 03:52:43 -0500 (CDT)
X-Barracuda-Envelope-From: brian.foster@maxim-ic.com
Received: from maxsvlex02.maxim-ic.internal (10.32.112.18) by
 maxdalex01.maxim-ic.internal (10.16.15.101) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Fri, 24 Aug 2012 03:52:40 -0500
Received: from laclwks004.localnet (10.201.0.45) by
 maxsvlex02.maxim-ic.internal (10.32.112.18) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Fri, 24 Aug 2012 01:52:39 -0700
X-ASG-Orig-Subj: Re: [Q] Comparing differences introduced by two commits?
User-Agent: KMail/4.8.4 (Linux/3.2.0-29-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <CAF5DW8J8JL-jGexh+CmmCafFAREjAJrb8zzOwP8b9fEuqUB56w@mail.gmail.com>
X-Barracuda-Connect: maxdalex01.maxim-ic.internal[10.16.15.101]
X-Barracuda-Start-Time: 1345798363
X-Barracuda-URL: http://192.168.10.183:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at maxim-ic.com
X-Barracuda-Spam-Score: 0.12
X-Barracuda-Spam-Status: No, SCORE=0.12 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=BSF_SC0_MISMATCH_TO, CN_BODY_332
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.106561
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.00 BSF_SC0_MISMATCH_TO    Envelope rcpt doesn't match header
	0.12 CN_BODY_332            BODY: CN_BODY_332
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204193>

On Wednesday 22-August-2012 10:55:29 Jonathan del Strother wrote:
> On 22 August 2012 17:58, Junio C Hamano <gitster@pobox.com> wrote:
> > Jonathan del Strother <maillist@steelskies.com> writes:
> >> On 22 August 2012 13:10, Brian Foster <brian.foster@maxim-ic.com> =
wrote:
> >> ...
> >>>  In the past I've done:
> >>>
> >>>     diff <(git show A) <(git show B)
> >>>
> >>>  which produces rather messy output [...]
> >
> > Isn't this what interdiff is for?

 I'd never(?) heard of interdiff(1) =E2=80=94  THANKS!
 With my current problem it produces  (1) Some false results,
 and  (2) Gets enough patch-rejects so as to be useful only
 in getting a 10km-high overview.   Nonetheless, it's a help.

> >>>  Some searching hasn't found any suggestions I'm too happy
> >>>  with, albeit I've very possibly overlooked something.
> >>
> >> What about cherry picking B onto A, then showing the cherry-picked=
 commit?
> >>[...]
> > I often do
> >
> >         git checkout A^
> >         git cherry-pick B
> >         git diff A
> >
> > when queuing an updated patch.

 This works fairly well.  I get conflicts (not surprising),
 which _probably_ corrolate rather well to the interdiff
 patch-rejects (not checked), but the advantage here is I
 can easily see what's going on (what the conflict _is_).

 Neither compares commit-comments, but that is a obviously
 a scriptable problem.

 As it so happens, it turns out my number of A/B pairs is
 rather less than expected (c.50 not the estimated c.90),
 of which c.10 get cherry-pick conflicts.  So the problem
 is now looking quite tractable.  Thanks for the help!

cheers,
	-blf-

--=20
Brian Foster
Principal MTS, Software        |  La Ciotat, France
Maxim Integrated Products      |  Web:  http://www.maxim-ic.com/
