From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] Git 1.7.0.2
Date: Mon, 08 Mar 2010 06:55:58 +0100
Message-ID: <1268027758.6298.109.camel@marge.simson.net>
References: <7vy6i3epg0.fsf@alter.siamese.dyndns.org>
	 <1268020281.6298.5.camel@marge.simson.net>
	 <7vbpez4cr6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 06:56:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoVwy-0004ho-7p
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 06:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024Ab0CHF4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 00:56:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:46455 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750917Ab0CHF4B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 00:56:01 -0500
Received: (qmail invoked by alias); 08 Mar 2010 05:55:59 -0000
Received: from p4FE1A6D5.dip0.t-ipconnect.de (EHLO [192.168.178.27]) [79.225.166.213]
  by mail.gmx.net (mp053) with SMTP; 08 Mar 2010 06:55:59 +0100
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX18PGbZWWn8PtdKVk4AXmOpPhv8lkSgV376hUoMMU+
	c1IK5yyKmcUgBi
In-Reply-To: <7vbpez4cr6.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.24.1.1 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141752>

On Sun, 2010-03-07 at 21:13 -0800, Junio C Hamano wrote:
> Mike Galbraith <efault@gmx.de> writes:
> 
> > On Sun, 2010-03-07 at 14:29 -0800, Junio C Hamano wrote:
> >
> >>  * "git bisect -- pathspec..." did not diagnose an error condition properly when
> >>    the simplification with given pathspec made the history empty.
> >
> > Would that be what led to this somewhat less than perfect tip bisection
> > result?
> 
> The bugfix was about the case where there was no change between the bad
> and good commit with respect to the given pathspec, so I suspect your case
> was irrelevant.

Oh, ok.  Thanks.

> Your case probably was coming from that you originally suspected one of
> the commits that touch tools/perf was a culprit, but because that initial
> suspicion was wrong, bisection didn't find anything useful.

Hm, the successfully bisected and verified culprit was pure tools/perf.

marge:..git/linux-2.6 # git show 804b36068eccd8163ccea420c662fb5d1a21b141|grep diff
diff --git a/tools/perf/Makefile b/tools/perf/Makefile
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h

Oh well.  Something went wonky.. I'll survive :)

	-Mike
