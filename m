From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -x: do not die without -i
Date: Thu, 17 Mar 2016 14:11:01 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603171406080.4690@virtualbox>
References: <1458177584-11378-1-git-send-email-sbeller@google.com> <xmqq4mc535n2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr, j6t@kdbg.org,
	Lucien.Kong@ensimag.imag.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 14:11:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agXiG-0003id-Ju
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 14:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966826AbcCQNLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 09:11:22 -0400
Received: from mout.gmx.net ([212.227.15.15]:55294 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935544AbcCQNLV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 09:11:21 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MAgzj-1aVEDz0GrL-00BsrF; Thu, 17 Mar 2016 14:11:04
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq4mc535n2.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:R47tyfQoQ8YPGIql1T3TaP1ID0gCU/HE4cey77cGjr6n4taY2nS
 2aAMARgnZGigdvA62BPG5XriFLuzMFMExma3stcMmyYQm5AYwv5chNpq1HCR0Pih7PYV8C1
 aBSQRGAn9b8jd8vg1y9sRWzyOg54jP0ru0y288P92EBQJi5fP5TRbUmISRnRIaS9VSeu95I
 6me5UG6CqallgOCpw24QQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L6Yf4Y0XNGo=:/zVKGgybPBRxUAUtWkCBtW
 7rHP9ZST6aNi7sUPMDvBs8YeS0s+AUyxlga5evHGjwL5PPnaiQ98LN9OJBN75+A7gXJh9Cf47
 9l8Tm/e0ZGGpNc/kwTr98RnfgEYdCW2XrQRXh1Zo1LkzFcDAaRtiT418osDlOhb4hfRsB4WPx
 nQLzS249K9wDouc3JGEIpxmmeVTl7RiEWObFAxZ/3CxrZiPLDosuuH2Fa3jeGs0sO5bHZomHs
 1WrKwAw2pgKvFtrazEMBA2nJGhXH+pdqK683+N8AZdZhC7jdHfZkO1WZx599Sbc1gXDoO+vOA
 2tVLeaXO2HNL8udaJisC+y4cl3RAUZWck0VQ3geJQGtga+wwPlcw0qSBXqagyShk0ILBL2Gwg
 aj1GhZz8IT8aGmUXoJaewVVl318KbUPcztBc39zPHqz/QkcelMvm/mray6EO7X73ZIgVi2eGY
 +EDdTm6Jy5mOGX2GuqMUiwiP/jtd783ssFQE6luNXeOUuT1ZfkAXNvjP7G5UHL9ZIaHAtEaWb
 JvMyRYTEWOaV3b9melxkmHlXUu2syOa4d8MHWzlCHlWT9iWdALdJWYxkaAWP/m5Wf5i+U3yzu
 SYW/G5vV8hNqXe0e+8Lkoq3/6Mcr0/huTH/RZJZAaZf4zkXpgmxGZfyTiml4CkV7IyyNagExq
 4lrou+Ylf2wuV4GMhW9poOLQjQg4l27vBCfgOXds4FJNylLjEhsvF3ESDQfKhtFVL2Oz8mjb4
 9x4RBD9QfvbqFJHsE/Lo3+rWHTuRSgqDOZkl1nA5wPQg12KPkP83O62RV7xRnBb12pX6LV82 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289111>

Hi Junio,

On Thu, 17 Mar 2016, Junio C Hamano wrote:

> I guess that may "work" but it sounds like quite a roundabout
> way to "test all commits".  "rebase" is about replaying history to
> end up with a set of newly minted commits, and being able to poke at
> the state each commit records in the working tree is a side effect.

I think there is a misunderstanding here. Stefan does not only want to
test all of the commits in the patch series. Stefan wants to make sure
that all patches in the series result in revisions that pass the test
suite.

In other words, it is not only about testing, it is also about fixing when
things break.

And that is very, very much the purpose of the interactive rebase.

>     $ git for-each-rev -x "$command" old..new
> 
> where you can write "sh -c 'git checkout $1 && make test' -" as
> your $command.

You meant

	git rev-list old...new |
	while read rev
	do
		$command || break
	done

?

Again, this might *test* the revisions. But it does nothing to help fixing
any patch in the series.

Ciao,
Dscho
