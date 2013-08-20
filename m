From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] mailmap: fix check for freeing memory
Date: Tue, 20 Aug 2013 12:12:37 -0400
Message-ID: <20130820161237.GA4332@sigill.intra.peff.net>
References: <1377004958-14489-1-git-send-email-stefanbeller@googlemail.com>
 <878uzw7a6l.fsf@linux-k42r.v.cablecom.net>
 <52137A63.3010609@googlemail.com>
 <871u5o785o.fsf@linux-k42r.v.cablecom.net>
 <52137F59.2030103@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	gitster@pobox.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 18:12:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBoY2-000647-LF
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 18:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab3HTQMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 12:12:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:38472 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339Ab3HTQMm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 12:12:42 -0400
Received: (qmail 27073 invoked by uid 102); 20 Aug 2013 16:12:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Aug 2013 11:12:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Aug 2013 12:12:37 -0400
Content-Disposition: inline
In-Reply-To: <52137F59.2030103@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232614>

On Tue, Aug 20, 2013 at 04:38:17PM +0200, Stefan Beller wrote:

> As proposed I checked recent kernel history and saw:
> 
> $ git log --min-parents=2 --oneline 
> d6a5e06 Merge git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-3.0-fixes
> 7067552 Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> e91dade Merge branch 'timers-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> fbf2184 Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied/linux
> 3387ed8 Merge tag 'drm-intel-fixes-2013-08-15' of git://people.freedesktop.org/~danvet/drm-intel
> d2b2c08 Merge branch 'drm-fixes-3.11' of git://people.freedesktop.org/~agd5f/linux
> 50e37cc Merge branch 'for-3.11-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
> a08797e Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
> 2620bf0 Merge branch 'fixes' of git://git.linaro.org/people/rmk/linux-arm
> 359d16c Merge branch 'for-3.11' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k
> 0f7dd1a Merge tag 'clk-fixes-for-linus' of git://git.linaro.org/people/mturquette/linux
> 2d2843e Merge tag 'pm-3.11-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> f43c606 Merge tag 'sound-3.11' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
> 89cb9ae Merge tag 'usb-3.11-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> 
> in their .mailmap it read:
> 	# repo-abbrev: /pub/scm/linux/kernel/git/
> 
> So the abbreviation doesn't take place, can this feature be turned off?
> I'm still confused by that feature.

It _only_ impacts git-shortlog, not git-log or other traversals. Making
it an even more dubious feature, IMHO.

-Peff
