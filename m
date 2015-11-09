From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: [PATCH v4] Add git-grep threads param
Date: Mon, 9 Nov 2015 11:52:24 -0800
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA1A@mail.accesssoftek.com>
References: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
	<xmqqvb9jc81q.fsf@gitster.mtv.corp.google.com>
	<20151104064021.GB16605@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA15@mail.accesssoftek.com>
	<20151109155538.GC27224@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA17@mail.accesssoftek.com>
	<20151109165343.GA29179@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA18@mail.accesssoftek.com>
	<CA+55aFzHic5AN05QkbERFszRC=i3aDDGy9yhXEjgzZjwzFVBLQ@mail.gmail.com>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA19@mail.accesssoftek.com>,<CA+55aFwV7c6=4mXPuB0c21rK3TSVWEw9JT-kiu35RuMzuHxoVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Victor Leschuk <vleschuk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"john@keeping.me.uk" <john@keeping.me.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Nov 09 20:52:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvsUV-0001tK-8h
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 20:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbbKITwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 14:52:31 -0500
Received: from mail.accesssoftek.com ([12.202.173.171]:44626 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbKITwa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 14:52:30 -0500
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Mon, 9 Nov 2015 11:52:25 -0800
Thread-Topic: [PATCH v4] Add git-grep threads param
Thread-Index: AdEbI5FS/iOijK04Rw6nMeHtT5XlOQAA6Bs6
In-Reply-To: <CA+55aFwV7c6=4mXPuB0c21rK3TSVWEw9JT-kiu35RuMzuHxoVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281080>

.

> In the meantime I'd argue for just getting rid of the online_cpu's
> check, because

>  (a) I think it's actively misleading

>  (b) the threaded grep probably doesn't hurt much even on a single
> CPU, and the _potential_ upside from IO could easily dwarf the cost.

>  (c) do developers actually have single-core machines any more?

                  Linus

So as far as I understood your point at current moment would be better to leave online_cpus() check behind,
keep the default threads value (and do so for other threaded programs, in separate patches of course).

After that we may focus (in future) on developing smarter heuristics for parallelity-relationed params.

Also we should specify in documentation that number of your CPUs may not the optimal value and customer should find his own best values based on other circumstances.

Correct?
