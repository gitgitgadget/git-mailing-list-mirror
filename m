From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Fix interactive rebase when the editor saves with
 CR/LF
Date: Mon, 26 Oct 2015 11:43:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510261133030.31610@s15462909.onlinehome-server.info>
References: <cover.1445777347.git.johannes.schindelin@gmx.de> <cover.1445782122.git.johannes.schindelin@gmx.de> <xmqqpp02kbif.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 11:43:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqfFs-0001mx-WF
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 11:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388AbbJZKnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 06:43:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:50987 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753219AbbJZKnw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 06:43:52 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MEccf-1ZkOmw0IrR-00FiUa;
 Mon, 26 Oct 2015 11:43:47 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqpp02kbif.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:nGDWCi55iDQikSxbpEoqAOFhXHT4ffyV54b5/KtQsEuGsxO60iM
 x235+F+44r2f5oass5TpYD0ZrcqYDJO3QSkcJEycSYkBQjiG4F20q64b7J9jia+10tQn/8K
 7vk+xhQeKVkeXWlyBysRFWPACxUz8Hcx356j3CL4rJaimQrAb6JV1/aQGGImqcbvesiuZk9
 anUKvnilGIupV+ipeKI6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BGkyLo/xxTY=:wyhQWXrpaY6FQu7JBOG2ia
 Vf7N3zkWTH6jzpDFfTDs34e88PMt+mzFirCeeXfT4PKuRk4CJbHZSdsH3SrdQ0F6axyoOK2NG
 S6I9dZqMZxnRDtUEFqehwM2kbMm9s31GEdd3MmJvLptDonpaAWfSV9+7T0/26HfaelTKvHn0X
 0bVOi4+7kEydOP49B+k+967N1DN87Na7m533zxIRkM2GOBj8+i48Gih8LX+j1LBh2UB7oPL87
 +UTp7y4SVmKQ7kabsxzuvlKFNzOETvptS+/koVG/1+jJUcD1UNiKhPdGYsegQRBjQiOfiZY9k
 MRU30G3GMeMSwYNpAKzor8pBPEC4TmvKAOYK/vBYRqC8ap9dMxRrCV3CzkdzxumiHYSWjfPqk
 jD50MYDVYUnwrp2uv2su4/sBGBBBeHlwClPP1yjl1npXXFADN5CIJtYZPGds5kGhzm4kmM7oh
 eEkDCikQ7EzhvTMtYwsXw3pTroRjd4wOKVuThR1czLrIa5cFWa4CoOWL51yVY4+6SpUIMt8DC
 zfV0b/DPaEw3A4iRvp758RVQK1Yyl7FuAqnbZjrRgjIjiDJ7vC2EQwASGrnq1rheILwnjSDEr
 Bp2w+1kQ4nYC3jx9JEesC6fppNdOBFjFYIaWsr2ar4157UzRG191PwHxQA7etIHDk5bYRckjM
 xB3BskIBv+fG4JF4zw2A9/JHd3Rs73wc+1X8TPorfWhnS33ESJs8eyhunVn32qV9za1xOjZGi
 ou0V+9Pn4fcljSYVoSC+ep/06+/RzWi4LHAcbz0YdgPWUMXxN5gG0goOO9NJztpmEa7ti4Kx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280187>

Hi Junio,

On Sun, 25 Oct 2015, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Chad Boles reported that `git rebase -i` recently started producing
> > errors when the editor saves files with DOS line endings. The symptom
> > is:
> >
> > 	Warning: the command isn't recognized in the following line:
> > 	 -
> >
> > 	You can fix this with 'git rebase --edit-todo'.
> > 	Or you can abort the rebase with 'git rebase --abort'.
> >
> > The real bummer is that simply calling `git rebase --continue` "fixes"
> > it.
> 
> Two questions.
> 
>  * What does the DOS editor do to a file with ^M in the middle of a
>    line, e.g. "A^MB^M^J"?

You mean mixed line endings? At least with this Windows 10 WordPad, *all*
line endings are normalized to CR/LF. That is, if you edit a file that
contains a stray CR, it is presented as a line break.

>  * Is your shell ported correctly to the platform?

I would think so. It is an MSys2 program, therefore it uses all the POSIX
niceties, of course.

A simple test with CR/LF line endings in a script reveals that it is
pretty solid:

	x=a
	case "$x" in a) echo b;; esac

prints out 'b', as expected.

Please also note that things apparently worked alright before the patch
removing the stripspace call was applied.

> The latter may need a bit of elaboration.  "read a b c" is supposed
> to read one line of text (where the definition of line is platform
> dependent, your platform may use CRLF to signal the end of an line),
> split the characters on the line (i.e. LF vs CRLF no longer matters
> at this point) at $IFS characters and give them to $a $b and $c. If
> the platform accepts CRLF as the EOL signal, should the program still
> see CR at the end of $c?
> 
> A solution that mucks with IFS smells like fixing a wrong problem
> without addressing the real cause.

Please note that it is a bit unsettling if you use funny language like
"smells" here and then accuse me of not having an argument when I point
that the same rationale applies to having CR in IFS as applies to having
LF in IFS. Yes, that was an implicit argument, but it is a strong one, so
I do not think you are well served ignoring it.

> Also IFS is used not only by "read", so munging it globally doubly
> feels wrong.
> 
> In addition, you do not want to split at CR; what you want is to
> treat CRLF (i.e. not a lone CR) as the end-of-line separator.
> Adding CR to IFS feels triply wrong.
> 
> By the way, saying "This is right, really" makes you sound as if you
> do not have a real argument.

Again. If CR has no place in IFS, why does LF have a place in IFS? It
makes *no* sense to argue for one and against the other.

In any case, I am not interested in arguing for arguing's sake. Tell me
what you want instead of the patch to IFS, I will implement it and test
whether it fixes the bug and we will move on.

Ciao,
Johannes
