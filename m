From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make reflog query '@{1219188291}' act as '@{2008/08/19
	16:24:51}'
Date: Wed, 20 Aug 2008 12:44:07 -0700
Message-ID: <20080820194407.GJ3483@spearce.org>
References: <20080819234433.GJ24212@spearce.org> <20080820193557.GB16626@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 21:45:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVtcI-00052p-1E
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 21:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbYHTToJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 15:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753948AbYHTToJ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 15:44:09 -0400
Received: from george.spearce.org ([209.20.77.23]:60821 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596AbYHTToI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 15:44:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 71B0138375; Wed, 20 Aug 2008 19:44:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080820193557.GB16626@blimp.local>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93019>

Alex Riesen <raa.lkml@gmail.com> wrote:
> Shawn O. Pearce, Wed, Aug 20, 2008 01:44:33 +0200:
> > The value 1112911993 was chosen for the limit as it is the commit
> > timestamp for e83c516331 "Initial revision of "git" ...". Any
> > reflogs in existance should contain timestamps dated later than
> > the date Linus first stored Git into itself, as reflogs came about
> > quite a bit after that.
> 
> Maybe I'm missing something, but aren't unsynchronized clocks a common
> thing in personal computing? Even maybe less common, but noticably
> frequent, the clocks with the date set way back in the past (by malice
> or accident)?

Oh, yea, clock skew is very common.  Clock skew by years is not
unexpected either.

We could pick any number for the limit, just so long as its so
large that the size of the reflog for it to be a valid @{nth}
request would be something like 1 TB, and thus be highly unlikely.

I was just trying to be cute by using the original commit timestamp
of Git itself.  Perhaps 12936648 (1TB / 83)?

-- 
Shawn.
