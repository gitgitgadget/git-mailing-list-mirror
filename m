From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 0/4] Ensure that we can build without libgen.h
Date: Wed, 13 Jan 2016 08:02:51 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601130759300.2964@virtualbox>
References: <cover.1452536924.git.johannes.schindelin@gmx.de> <cover.1452585382.git.johannes.schindelin@gmx.de> <56959DFA.9000704@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 08:03:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJFSZ-0001nn-C2
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 08:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062AbcAMHDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 02:03:06 -0500
Received: from mout.gmx.net ([212.227.17.22]:50459 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbcAMHDE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 02:03:04 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lfolq-1Zr1792ZgI-00pKUY; Wed, 13 Jan 2016 08:02:53
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56959DFA.9000704@ramsayjones.plus.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:nV6NPNejpfoux7xGn/+/Uvrz5NAOL8IvXtYPP3mCVukxESJ6SE9
 EdUgMHHjdKiId4QGIFOa+uw0sQijtqsw6dqi1JRADpkqdlzLxBzEdSL35qUteU79lr7W9+T
 DqVMTaNc0v29HdkFCB7gU/y8fJwGBOJ90KbcdhFVftIHpryig9FRU32Gq4KdnzwYu+0zGhu
 0hRrZYQRvSKFQ5UiexpbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5SJM8i6t3Jo=:9oguD2Q2kKSafTMs+z8RWn
 mNGBxckU9vPe9Kgz/rasu7jBhFu/KkG0jhXq1Pz21GGqehtvvKiroM8/WLsiF6XnJ3PamWOTB
 vs74AWxXYy7Jf9QiBDvsj8zHOnzB+Vr6K13XAtXkdlblIimoGxl+4jLJjr35KAZJPr6hxjwaC
 0x44m7OqnZXAbR7Tg8tPaz65oGL2gWl2NEg6hS4HX/4wdSwld2aakH6ykLvvkhJvnjShwh0jN
 S2gHU72I3c2b7r3g91bD/mW6iMEro5wZB1A5pbL14+ljyA7B28dTWo1P4As32E3Dj8SoVVhcT
 F4zAmAdYtu+G6q3fo4/cufHXK7TtTPTLOCiPNV+uLXUkodZtsQ1KrNqaaNlU5JehIKfHFrLnK
 q99lTY9h9muwJrvCA3uuYzLbuerWUhQ5J64u1TFgjYpb2c+JQhpdQ7MrvM0LIc2C92zO0Em50
 3gEw+JEKW4HPu8cQM3uSRMeTWjdWRSy4UXYVjDo0e9wGJpWXKYn0dvhItLQkk/7zTrvsGqaWz
 PPHDAQJCU1JmjSr2c2EdzTFIQ/67AyUqlZBTRoV3xgRBKSwgmT5gzXPPPQVyz9J/eplJ1G4Wy
 y7K/WC0tZnMR2f2Uym3Fp9rL3Y/QI4ym7/1H9onV8GWDWPkpCUKJW/uaGysU3bVm0PINBYFIb
 Fg2r1w36lygsnUoaQNamzoKQ4pwP/kLF8jwcN5WoGu0ume38ZRiFiRYZSzWZcnmmwZYoeIKRD
 flTWc9wiU4bldqu6rpuWzu1oAekxO/D8XjVGp3h3avQpZ3w0sU+6CEEOuJVcxuKQVoQ+JsEv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283890>

Hi Ramsay,

On Wed, 13 Jan 2016, Ramsay Jones wrote:

> On 12/01/16 07:57, Johannes Schindelin wrote:
> > This mini series adds a fall-back for the `dirname()` function that we use
> > e.g. in git-am. This is necessary because not all platforms have a working
> > libgen.h.
> > 
> > While at it, we ensure that our basename() drop-in conforms to the POSIX
> > specifications.
> 
> I was somewhat disappointed that you ignored the implementation of
> gitbasename() and gitdirname() that was included in the test-libgen.c
> file that I sent you.

I am sorry you feel that I ignored your work!

My line of reasoning, however, was to go with the existing gitbasename()
and with the gitdirname() I had come up with, because I was already
familiar with them.

Your tests included a couple of corner cases that neither handled
correctly, and I was able to fix that, so I was happy.

To be quite honest, I blindly deleted everything but the tests, noticed
that the remaining code looked eerily similar to test-path-utils, and
merged it there.

Ciao,
Dscho
