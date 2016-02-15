From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 3/3] config: add '--show-origin' option to print the
 origin of a config value
Date: Mon, 15 Feb 2016 08:53:17 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602150844110.2964@virtualbox>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com> <1455373456-64691-4-git-send-email-larsxschneider@gmail.com> <20160213174449.GH30144@sigill.intra.peff.net> <CF48D0B6-66BD-4C5D-A93B-AB0BBC00615D@gmail.com>
 <20160214161816.GC5875@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
	sschuberth@gmail.com, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, hvoigt@hvoigt.net, sbeller@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 08:54:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVDz9-0000ri-8K
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 08:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbcBOHxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 02:53:42 -0500
Received: from mout.gmx.net ([212.227.15.19]:50417 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbcBOHxl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 02:53:41 -0500
Received: from virtualbox ([37.24.143.97]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M2t0Q-1Zg0hD0fLC-00sfrd; Mon, 15 Feb 2016 08:53:21
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160214161816.GC5875@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:kpWTVlhx/uQ7HVR6NInbwKfMtvixSpU04pdVAsZKwGZ6ZfWQ8RE
 q0zf6+MoXZkvqeCJPuwM3X4+sPyJCTjlBgKr2NgQ9bMoK0evfzM9Gu4LosE/cA+zSIKsTpA
 Z6bQvoJtlmdnuDM7saFDS+7iUj96q2X1mzirKpu5m6XS70F4iOU+tSU6PmtJ7xzCROpbkSF
 IzH1P52JDzd2GO1iSr+gg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KoCC4JFRYzU=:D466YrJai3fm00aJ1cVyl9
 QHC7DCDMnk0d9+OYhl1qZiNkjH7RuHLmQ6/wil5lOppXnbF8HoNfdNl0r+nwGBS2l5LODyAff
 4AnW0NG1hX8N7x66NdhNUv0DlBDwM0uk2ewmbAGNrilqmliqtybU+Vm4XUAR4xd2uZOkIA8wM
 4fKdnQOmvbLYVbDx+6eEJ+XshNTcEa6rpNa3chsG8/oACcUv3jr8QhUCTQchbU9THCR5b+jNP
 S1W2ESaaowo8a88NA+IAIC6C2+qR9VpqohtBxlI5pkVSlR1rt3+ae64Ltt/BKP6zZ634SX9F6
 DKeEoG4Ii3ZVWADegX2XhxZz56Ef8OxsUKg9HIbliP6pFRb6ONiRL2V0xSlkcAlXetv5xkQ8x
 MJKzW3bRyqVdH/IIwgu42X/HXyjB6qFeswQawIvly5naqnSDxf8ZEA5XIGESwIEPFn7qZm24/
 iHl9xYH3ozqjlv4SvrteyX/pl9IUdrWMnmi7T4VIL2aa5/FLvD2lLIQr9pdhIijCpt7pW6q99
 dlaP96QMDyEIT7CtN0eETMBRWqdekBa8HglgSUyOZ6QYqRdDgXE9v+NknfU4bySR/KXC35Yvz
 KpIArZVEKtm1hgRSXaU7N15G9vM6yH8AWXPrqjYoCCCmfKZa27T1nKM1er3Bh2Pd9mUX1tWEC
 RUYsB3OZCmD99fr3+66HL5aEjVqWdOyRudRNeEk/E9lDhRoSJ0t+ONA2S6CXJkLLPbf8ieq5v
 vprwZGRnLv1wY1R0C5gN6MNZ3hWK7VpWVAyqy7gxnQjV5dMRx30/0uY56sm18VyXkPQJNPTG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286177>

Hi Peff,

tl;dr let's keep an eye on adding only test cases that do not depend on
earlier test cases' output ('setup' excluded, of course).

On Sun, 14 Feb 2016, Jeff King wrote:

> In general, my opinion is that skipping arbitrary leading tests is a
> losing strategy. It's just too easy to introduce hidden dependencies,
> and not worth the programmer time to make sure each test runs in
> isolation. But others on the list may disagree.

Yes, I disagree. And you would, too, if you had to run as many tests as I
had to do by way of js/mingw-tests. I did not keep precise track of time,
but I am certain that I had to run one of those bloody tests (forgot which
one) around 100 times, each taking roughly 3 minutes to complete, and of
course, it was the *last* test case failing, and *of course* it depended
on earlier tests to run.

It gets even worse when you think about those test cases that depend on
some prereq such as SYMLINKS or POSIXPERM. In *most* cases does the
developer who adds them not even notice that these prerequisites are
required. And subsequent test cases that do *not* share those
prerequisites depend (of course!) on the previous test cases' output.

Don't get me wrong, I think it would be too much pain for little gain to
clean up our act now. But I think that we have ample evidence that it
would be a plenty good idea to try pretty hard to avoid adding to the
pile.

Ciao,
Dscho
