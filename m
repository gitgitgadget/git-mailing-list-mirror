From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] merge-file: consider core.crlf when writing merge
 markers
Date: Mon, 25 Jan 2016 08:02:02 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601250801050.2964@virtualbox>
References: <cover.1453482052.git.johannes.schindelin@gmx.de> <c0c775ea7a9ba3244748b784241de685cefc73b1.1453482052.git.johannes.schindelin@gmx.de> <20160122195015.GA5897@flurp.local> <CAPig+cSf_Hac=4+F1bRaFeYdFrjo6SH=vApdUDkhep5BUve+Kw@mail.gmail.com>
 <alpine.DEB.2.20.1601241137260.2964@virtualbox> <CAPig+cT4gQi=OhYT3AwKA=_UER4nC-wOu93U72QcSWtMoVxhMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 08:02:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNbAH-0005Cj-Ro
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 08:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641AbcAYHCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 02:02:14 -0500
Received: from mout.gmx.net ([212.227.17.22]:63988 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbcAYHCN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 02:02:13 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MRXVc-1aYYQX28ca-00SjHm; Mon, 25 Jan 2016 08:02:05
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAPig+cT4gQi=OhYT3AwKA=_UER4nC-wOu93U72QcSWtMoVxhMg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:M4ykho8EFogo02vB3F6HUZydBDi1I8wBmV7Lzjwj7K89cfn+ZK5
 bLtfuxYKToR7P94Z3MQ7ysvCQf4W6IzLP5tMxMF5fZWkfEzs87Dni/tbdWlLyZC+Gop9wEu
 ou39VywPjs6IdrDk4joAEWYYj3Aut40O6x9bZsS8+6Pl/CDRY8OsOISyyV9QQ3NI3c7+FqR
 BckXEBC6aEDx5vfznamgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7qH9rn53Ulg=:R6mgzIKNEU5/xx21PTdWeY
 LvXl771GwbuY1MXxrS7lwRxRufBwz8HPoWjWpMUczdJ6htWDOzI86J3zMxVuTJHxnh3qyso9G
 J1/OU9qpV75Ze+j+jFHo/rDImQGAWpLsQDsTXs3CPEF5UqGeIEyxca72la7kQOm4dk39N1ntw
 0QpOWKiXY4aI5rjz8ztRMiuFs+NUa1YaPtO6zGlcGR09bBRBreVtFQhP8DnPg6tmCSvbmj86U
 /IKUGndIazlxNFCQoLCjsG+y4fOoWDnPNxEqjr8drCnSeI94Q9whi5z8YEdlZgjQscnGRaLez
 5i48tMElQd7a/Sx8DkEWcBBHzomNdxmelX9TvpKo5vmiDcqVywreGoILBTZWv5bbPyEDmMGxk
 Cs8i5gKzjNzRo1cFhlkB6q47CSiQh86urw6uJMaRPlHBXQwwlr+Dog6BP/jlJJ/0KMmD89xJo
 8WCpNlt4IwhYoXsGaBUFx9VZpy2+Rd3rU1FamYEHgOzCNORdGh0r5mChncFBCEz+Sx8omOFGu
 b+Ist1/5OczjtmK2sXMUhCWVBRuavwBacZcT9jmjJkX0GLUgKZfCpkdwicphTl1PRkshcQkkX
 W/NNyM3nm2PxJiQXZbZofnWUa5u8MffLGa+4vP7ereoDhK6TjlT/w7M5319BPDFbv9y2mTYmP
 1bZ0VeTqzE0zdcnvJLEVUqReB6hmP73/sB2jLXyolw25mhj1tsc65kc62pq+GaS+/HvdW7UCT
 sHdw69NN1gdvZrBZpn9rKyCNVI1YkI/fEvYOQ7qyMiRG2swy+wOneSCnnRViFWR1QeyiVJbY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284721>

Hi Eric,

On Sun, 24 Jan 2016, Eric Sunshine wrote:

> On Sun, Jan 24, 2016 at 5:37 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Fri, 22 Jan 2016, Eric Sunshine wrote:
> >> On Fri, Jan 22, 2016 at 2:50 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> >> > On Fri, Jan 22, 2016 at 06:01:25PM +0100, Johannes Schindelin wrote:
> >> >> +test_expect_success 'conflict markers contain CRLF when core.eol=crlf' '
> >> >> +     test_must_fail git -c core.eol=crlf merge-file -p \
> >> >> +             nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
> >> >> +     test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 3
> >> >
> >> > The "\r" isn't recognized by 'sed' on Mac OS X or BSD. Perhaps use
> >> > instead:
> >> >
> >> >     test $(cat output.txt | tr "\015" Q | sed -n "/\.txtQ$/p" | wc -l) = 3
> >>
> >> Or the 'sed' could even become at 'grep' at this point.
> >
> > Good point, thanks!
> 
> And, without the unnecessary 'cat', of course (don't know what I was thinking):
> 
>     test $(tr "\015" Q <output.txt | grep "\.txtQ$" | wc -l) = 3

Heh, I automatically removed the "cat" in my mind already, and as you can
see from my v2, I used precisely the cat-less form you suggested.

Ciao,
Dscho
