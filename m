From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 4/4] cygwin: Use native Win32 API for stat
Date: Sun, 28 Sep 2008 11:24:08 +0200
Message-ID: <200809281124.08364.johannes.sixt@telecom.at>
References: <20080927084349.GC21650@dpotapov.dyndns.org> <200809272035.03833.johannes.sixt@telecom.at> <20080927215406.GG21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Marcus Griep <marcus@griep.us>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 28 11:25:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjsWm-0005Yq-Qj
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 11:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbYI1JYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 05:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbYI1JYO
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 05:24:14 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:37367 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbYI1JYN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 05:24:13 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 580B897296;
	Sun, 28 Sep 2008 11:24:09 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 75D9A1D225;
	Sun, 28 Sep 2008 11:24:08 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080927215406.GG21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96948>

On Samstag, 27. September 2008, Dmitry Potapov wrote:
> On Sat, Sep 27, 2008 at 08:35:03PM +0200, Johannes Sixt wrote:
> > > +core.cygwinNativeStat::
> >
> > This name is *really* odd, for two reasons:
...
> It was Shawn's suggestion. I don't care much about the name as long as
> it is explained in the documentation... Therefore, I accepted what Shawn
> said without giving it any thought.

Shawn is an importen git-o-maniac, but it's certainly not blasphemy to 
question his words of wisdom ;)

> Now, when you bring this name to my 
> attention, I believe core.useCygwinStat (in the opposite to the current
> core.cygwinNativeStat) would be a better name. Your name is okay too,
> but a bit too long for my taste and not specific enough (I suppose
> Cygwin does many FS related tricks). Anyway, I don't have a strong
> opinion here, so just whatever most people like is fine with me :)

My point is that emphasis on "stat" in the name is wrong: That's about 
implementation, but not about the effect. Why wouldn't 'ignoreCygwinFSTricks' 
be specific enough? By using a native stat implementation, *all* of them are 
ignored. Yes, you fall back to Cygwin's stat sometimes, but these are cases 
where the *effect* is not that relevant. (And the length of the name doesn't 
worry me, considering how many people would want to change the default.)

-- Hannes
