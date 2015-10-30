From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Fri, 30 Oct 2015 19:25:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510301923010.31610@s15462909.onlinehome-server.info>
References: <cover.1445865176.git.johannes.schindelin@gmx.de> <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de> <20151026191724.GE7881@google.com> <alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
 <xmqqr3kge0d3.fsf@gitster.mtv.corp.google.com> <20151027232848.GA4172@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:25:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEMt-0003w2-4k
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758754AbbJ3SZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:25:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:52866 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756016AbbJ3SZe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:25:34 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0M70Td-1afMdX1OdB-00wmVP;
 Fri, 30 Oct 2015 19:25:26 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20151027232848.GA4172@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:7jAYmtfibi9gctypKWBdotVoiAohFkufyyCD0eFqC5nJ0nxKWHl
 ROEz5cNLdBG5H+sioSIGFaD20fpidOa3JiWhkOmYXsmjEQJKQ+gK6Oi/OvfrLiu5WEGtmVt
 IgKclhDVeh3AfVCoB2SjWT5qY8tAdb+cLBQc7XRmtUyXo4Qh7Khk0Y0UH++lAE9ArTq/q9O
 t/+S4bd0xqM8mpr5qIlRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rufVq1dHEbg=:JecG9jHy7tUhYHDurL9HXx
 T0vHpBKbzkisDFiv+G4X8IeDJzMgJRbHGaxetTdcNzWWpQtkcElN7z9ciejkU69R7Gb7/hEMc
 69O8YdalT6YwfFVXYW+bkkwDkLBm/L9sgy5nnoXHAmoRPnx+hxxuBZp0cvau7qvTVWzJQ9d+D
 0LuIr97s4ppjVHQdT/NZ7A5lestAx15AXeF5YSB1tYJ1t9uAkP3yQ7sJq/tBrJYiF7VL18F8b
 LnFiHG23KHhCUNy5V+maIAbRDRwHzEChbsHQRNvMejfX0U/m2LmlO3+7Merxx/I8HXRISHKWC
 1CbQuyBgTqsJorBbIoPuhNuxDRyQwqcJYh8rIHBFnOHA7cJG22xUyXFUBveLfpOWh1kf0xTR9
 Euj178AKpjyRs+s78r8u6XWoKgSc9+B9IQ94bPQywzGqhbENnairEY8axCSIAC68cpXDmRsSv
 QK1sbVkTY0bnmy0AeqChYwPCuVulPobv/3HRr3CoyqbMSB/hbYKMffIFUZsQvArfTmxNCCIT0
 h3BWACLfR2MN+kI0quoc0+bYQx8xb1cPerryKtg55uH/19amPc6XvPHrrEcDeenDbIfqIi1b/
 nP33AkV8jwhBTYOuVTkKrfDrcR/lsfEUT3/hRRL3k/38mWBnYHEhMJkpkML2psUh4iNtBBf7Z
 sInaKRQuo6KKVxYM4BebtkqXOCzfDtXY9eWJFNHzxv/POXmR6kmRAOLdpqTslIwVb5U/WkUxe
 MBtj3RYcOvGXXH5VXCDppTU4dEw8U570APISIKoi3bpwUwfv1Ok2c2H2b00e1JSh3yRMkSsT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280510>

Hi Peff,

On Tue, 27 Oct 2015, Jeff King wrote:

> On Tue, Oct 27, 2015 at 09:34:48AM -0700, Junio C Hamano wrote:
> 
> > Yeah, that was my first reaction when I saw this patch.  Instead of
> > having to munge that line to "gdb -whatever-args git", you can do a
> > single-shot debugging in a convenient way.  And quite honestly,
> > because nobody sane will run:
> > 
> >      $ cd t && TEST_GDB_GIT=1 sh ./t1234-frotz.sh
> > 
> > and can drive all the "git" running under gdb at the same time, I
> > think what you showed would be the _only_ practical use case.
> 
> I agree doing so would be crazy. But would:
> 
>   ./t1234-frotz.sh --gdb=17
> 
> be sane to run gdb only inside test 17?

It would probably be sane, but I never encountered the need for something
like that. It was always much easier to run the test using `sh -x t... -i
-v` to find out what command was behaving funnily (mind you, that can be a
pretty hard thing todo, we have some quite convoluted test scripts in our
code base) and then edit the test.

I would expect that `--gdb=<n>` thing to drive me crazy: first, I would
choose the wrong number. Next, I would probably forget that test_commit
and other commands *also* calls Git.

Ciao,
Dscho
