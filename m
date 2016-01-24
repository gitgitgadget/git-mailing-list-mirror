From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] merge-file: consider core.crlf when writing merge
 markers
Date: Sun, 24 Jan 2016 11:37:51 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601241137260.2964@virtualbox>
References: <cover.1453482052.git.johannes.schindelin@gmx.de> <c0c775ea7a9ba3244748b784241de685cefc73b1.1453482052.git.johannes.schindelin@gmx.de> <20160122195015.GA5897@flurp.local> <CAPig+cSf_Hac=4+F1bRaFeYdFrjo6SH=vApdUDkhep5BUve+Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 11:38:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNI4D-0008VT-1K
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 11:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbcAXKiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 05:38:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:50413 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbcAXKiF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 05:38:05 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lw2Sj-1a2Zix3YZJ-017nnz; Sun, 24 Jan 2016 11:37:55
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAPig+cSf_Hac=4+F1bRaFeYdFrjo6SH=vApdUDkhep5BUve+Kw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:uJVQkS5gwidia3pYHlBS/+sfY+WIp3uorkhJrxT/kc82gWSPZoM
 68/mAdQlrrmRdoy8UOQH5NTQr/zXPZR9hh7cODnky97EDcEOKsu9oJamRHAxarM05v0W0eC
 ywUygoND1Uag9KAZYlLW1PFu4gIn/0ixzj9AUei99eJGCx7QW2hFDCKT1jZJv6Gqkk/eO1n
 mA0Y+vgRJW9DUm+xNP5lA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I+LP3J8Uc4Y=:xDbPr2jPrBu1X3vFie9co7
 L/MI2mhZckbxu2P9CJCEgwgC0Rwmys9PnGcO3axHfpmtn9rkQ2F8K4B9IUD/YOTF5++GmRhxX
 piiPXmjpI2j2q0Lc1KEAjfKE/8eyvTENSGVHiWWvtUHzbBz7uYz4/HozWc9b8Hw9vrXflbiRz
 8Sq0VwOhgGmIORMGBPGOY688jdbPpEHY7oj4JkO7FKw88QTKQmxLjeTsGZDRjHt+BrcZv8Vtv
 peCtGodyVb3kCncgx0ZbtkaRLR/jZVXZZ6100j3E/ivWXztESp2OXteTRijtq2uvKYi0UNyY8
 XfaT6DMwMGEBuMUcx2OI6pVGjE/UIqFu1YulMo77eYSD89klFswIMkjwftZxZwZRsyX54chww
 mUvLPzUhFjbdVA8XxYQV2HW6R8fTyjIsmll0i85vlmrYc3rLwkOW8wiRoNG4XAfIByNImzY08
 NUu7xROMKiNWYMjAOrJOS0doJiZzvKxAiI7eM3oPXOTZYyCjSVQkw5jX20BkY9CDszgMxYJ1K
 jm3/7B65M4fkHlopELmyZ2Y3uw0aAeRoXFjMjHJbM4wNGtSGHs2/gF8KBTwNtKCrHLUrc0eEF
 sq16sfxqeqJ2dVY4J5j6TFBHCQyahbybW3yDOd8DxoqEJ5CniUXW5MBtKppWHoOayK1yE839m
 ufn+S1Tolkim6V3PjZGxr+frUrQzoJEe3g8AJt3kmx0O9IEFvahUfETCz55P+RontuWct++E/
 dmMnD5J+b+qGxXaL5zeuz9XUpMcY34IYTOz0sxU9Bs3kSqrNiO2lCfMD3/pk+SvEp/ftUktY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284638>

Hi Eric,

On Fri, 22 Jan 2016, Eric Sunshine wrote:

> On Fri, Jan 22, 2016 at 2:50 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Fri, Jan 22, 2016 at 06:01:25PM +0100, Johannes Schindelin wrote:
> >> +test_expect_success 'conflict markers contain CRLF when core.eol=crlf' '
> >> +     test_must_fail git -c core.eol=crlf merge-file -p \
> >> +             nolf-diff1.txt nolf-orig.txt nolf-diff2.txt >output.txt &&
> >> +     test $(sed -n "/\.txt\r$/p" output.txt | wc -l) = 3
> >
> > The "\r" isn't recognized by 'sed' on Mac OS X or BSD. Perhaps use
> > instead:
> >
> >     test $(cat output.txt | tr "\015" Q | sed -n "/\.txtQ$/p" | wc -l) = 3
> 
> Or the 'sed' could even become at 'grep' at this point.

Good point, thanks!

Ciao,
Dscho
