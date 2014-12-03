From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/14] lockfile: introduce flag for locks outside .git
Date: Wed, 3 Dec 2014 18:57:42 -0500
Message-ID: <20141203235742.GA7387@peff.net>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051911.GP6527@google.com>
 <xmqqvblsuy2e.fsf@gitster.dls.corp.google.com>
 <xmqqr3wguxhv.fsf@gitster.dls.corp.google.com>
 <20141203232951.GJ6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 00:57:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwJnq-0001I1-ED
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 00:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbaLCX5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 18:57:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:48070 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751959AbaLCX5p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 18:57:45 -0500
Received: (qmail 32484 invoked by uid 102); 3 Dec 2014 23:57:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Dec 2014 17:57:45 -0600
Received: (qmail 1871 invoked by uid 107); 3 Dec 2014 23:57:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Dec 2014 18:57:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Dec 2014 18:57:42 -0500
Content-Disposition: inline
In-Reply-To: <20141203232951.GJ6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260715>

On Wed, Dec 03, 2014 at 03:29:51PM -0800, Jonathan Nieder wrote:

> Junio C Hamano wrote:
> 
> > I tried to merge the 14-patch series with obvious fix-ups after
> > dropping the rerere abortion change you sent separately and in
> > duplicate and also dropping sb/copy-fd, but I've ran out of patience
> > with this step, at least for today's integration cycle.  Should we
> > also drop jk/lock-ref-sha1-basec-return-errors topic as well?
> 
> I don't mind adding it to the series.

Please do add it in, rather than dropping it. It fixes a real racy
condition in which "pack-refs --prune" wants to lock a ref only to prune
it, and it's OK to continue on if the lock fails (without that patch,
pack-refs dies prematurely).

-Peff
