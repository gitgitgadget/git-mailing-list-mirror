From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 2/6] Don't try to merge files that merge-recursive already merged
Date: Wed, 22 Aug 2007 11:59:54 +0200
Message-ID: <20070822095954.GE30748@diana.vm.bytemark.co.uk>
References: <11875975232619-git-send-email-davidk@lysator.liu.se> <1187597523433-git-send-email-davidk@lysator.liu.se> <11875975232734-git-send-email-davidk@lysator.liu.se> <20070822092152.GB30748@diana.vm.bytemark.co.uk> <87sl6bewqo.fsf@morpheus.local> <20070822094413.GC30748@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, catalin marinas <catalin.marinas@gmail.com>
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed Aug 22 12:00:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INn0P-00018p-Lj
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 12:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbXHVJ77 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 22 Aug 2007 05:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752297AbXHVJ77
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 05:59:59 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3389 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbXHVJ76 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 05:59:58 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1INn0E-0008Eg-00; Wed, 22 Aug 2007 10:59:54 +0100
Content-Disposition: inline
In-Reply-To: <20070822094413.GC30748@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56362>

On 2007-08-22 11:44:13 +0200, Karl Hasselstr=F6m wrote:

> On 2007-08-22 11:37:03 +0200, David K=E5gedal wrote:
>
> > I think that the push(c) commits will never happen with my
> > patches, so the test case needs an update.
>
> Actually, the failure vanishes once the next patch in the series is
> applied. I thought this was a good thing, but if they're never
> supposed to happen, maybe the test is still broken, just not in a
> way that's detected?

No, after path 2 we don't get a push(c) entry, and the test fails, but
after patch 3 we get it again and the test succeeds.

Looking at the code (the string "push(c)" occurs exactly once, so it's
easy to find), it seems the log stuff continues to work as expected
after patch 3: it writes a "push(c)" entry when the patch becomes
empty due to conflicts, and its entire contents are dumped in the wd
(or the index+wd with your patches). So it is just patch 2 that needs
fixing -- and I suspect the fix might be to merge it with patch 3.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
