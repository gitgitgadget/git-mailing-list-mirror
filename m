From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] rebase: convert revert to squash on autosquash
Date: Thu, 7 Apr 2016 18:51:45 +0300
Message-ID: <20160407184026-mutt-send-email-mst@redhat.com>
References: <1460041965-31526-1-git-send-email-mst@redhat.com>
 <alpine.DEB.2.20.1604071720160.2967@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 07 17:51:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoCDp-0007Om-JY
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 17:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671AbcDGPvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 11:51:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54586 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbcDGPvs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 11:51:48 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF81780F92;
	Thu,  7 Apr 2016 15:51:47 +0000 (UTC)
Received: from redhat.com (vpn1-7-7.ams2.redhat.com [10.36.7.7])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u37FpjrZ026079;
	Thu, 7 Apr 2016 11:51:46 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1604071720160.2967@virtualbox>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290922>

On Thu, Apr 07, 2016 at 05:23:09PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 7 Apr 2016, Michael S. Tsirkin wrote:
> 
> > Reverts can typically be treated like squash.  Eliminating both the
> > original commit and the revert would be even nicer, but this seems a bit
> > harder to implement.
> 
> Whoa. This rings a lot of alarm bells, very loudly.

Whoa don't be alarmed. It's just a patch :).
I've been using this patch for more than a year now, so I
thought I'd post it in case it's useful for others.


> It seems you intend to
> introduce a *major* change in behavior,

Doing this automatically for all users might be a bit too drastic for
the upstream git.  So there could be an option, or something - if
there's interest I can add that. I thought I'd test the waters before
I spend time on that.

> and all we get to convince us that
> this is a good change is this puny paragraph (which, by the way, does not
> do half a good job of explaining to me what you think this patch is
> supposed to do, let alone of convincing me that what you want is a good
> change).
> 
> So. What is it again that you want to achieve? Please use plain English,
> e.g. explaining how exactly reverts are typically to be treated like
> squashes. And please make it convincing, because so far, I am far from
> convinced.
> 
> Ciao,
> Johannes

It's rather simple.

If there's a commit later followed by a revert, history can be
simplified by squashing them, and if the result is empty, removing both.

The removal part is not automatic with my patch.  If someone wants to
implement it, that would be nice and useful for me.

squashing/fixing is similar in that they are also useful to keep history
clean.
-- 
MST
