From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] Git 1.7.0.2
Date: Mon, 08 Mar 2010 04:51:21 +0100
Message-ID: <1268020281.6298.5.camel@marge.simson.net>
References: <7vy6i3epg0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 04:51:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoU0A-0002Se-2g
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 04:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855Ab0CHDvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 22:51:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:56183 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753313Ab0CHDvX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 22:51:23 -0500
Received: (qmail invoked by alias); 08 Mar 2010 03:51:21 -0000
Received: from p4FE1A6D5.dip0.t-ipconnect.de (EHLO [192.168.178.27]) [79.225.166.213]
  by mail.gmx.net (mp005) with SMTP; 08 Mar 2010 04:51:21 +0100
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX18p8F5rLDApXMon55akkaF7Bd0MWEuu1jsipJYGz0
	mfvx0U0uQi364k
In-Reply-To: <7vy6i3epg0.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.24.1.1 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141749>

On Sun, 2010-03-07 at 14:29 -0800, Junio C Hamano wrote:

>  * "git bisect -- pathspec..." did not diagnose an error condition properly when
>    the simplification with given pathspec made the history empty.

Would that be what led to this somewhat less than perfect tip bisection
result?  I had to repeat, leaving off the pathspec, in order to bisect
to the troublesome commit.

b4dad12cdd22f61eb093d23f11a7b09620e53aba is the first bad commit

git bisect start '--' 'tools/perf'
# good: [64ba9926759792cf7b95f823402e2781edd1b5d4] Merge branch 'for-linus' of git://git.open-osd.org/linux-open-osd
git bisect good 64ba9926759792cf7b95f823402e2781edd1b5d4
# bad: [a8313ee914acb061cacb44d0884e448760e33392] Merge branch 'perf/pebs'
git bisect bad a8313ee914acb061cacb44d0884e448760e33392
# good: [eaa5eec739637f32f8733d528ff0b94fd62b1214] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp
git bisect good eaa5eec739637f32f8733d528ff0b94fd62b1214
# bad: [b9377fc0bf1cd0b7b494337eacf8ccf0f7b52e1f] Merge branch 'perf/probes'
git bisect bad b9377fc0bf1cd0b7b494337eacf8ccf0f7b52e1f
# bad: [318794793ce30dc7000ed6992f4f81f308ae3958] manual merge of linus
git bisect bad 318794793ce30dc7000ed6992f4f81f308ae3958
# good: [617f757a1b45395ca3b11b162138ce514afc5b29] Merge branch 'perf/core'
git bisect good 617f757a1b45395ca3b11b162138ce514afc5b29
# good: [c93025db5f6d093fd00e96fde8e47d5c791a03fd] Merge branch 'perf/core'
git bisect good c93025db5f6d093fd00e96fde8e47d5c791a03fd
# good: [eb3addcb8fe9b81f47ad0f14ed0ae220f18ae83b] Merge branch 'perf/urgent'
git bisect good eb3addcb8fe9b81f47ad0f14ed0ae220f18ae83b
# bad: [b4dad12cdd22f61eb093d23f11a7b09620e53aba] Merge branch 'core/iommu'
git bisect bad b4dad12cdd22f61eb093d23f11a7b09620e53aba
