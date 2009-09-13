From: Jeff King <peff@peff.net>
Subject: Re: Confusing git pull error message
Date: Sun, 13 Sep 2009 18:39:23 -0400
Message-ID: <20090913223923.GA8840@coredump.intra.peff.net>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <7v1vmar353.fsf@alter.siamese.dyndns.org>
 <20090913204231.GA8654@coredump.intra.peff.net>
 <7v7hw2pmtk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 00:39:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmxjK-0007zg-Si
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 00:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbZIMWjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 18:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbZIMWjZ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 18:39:25 -0400
Received: from peff.net ([208.65.91.99]:59421 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbZIMWjY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 18:39:24 -0400
Received: (qmail 21616 invoked by uid 107); 13 Sep 2009 22:39:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 13 Sep 2009 18:39:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Sep 2009 18:39:23 -0400
Content-Disposition: inline
In-Reply-To: <7v7hw2pmtk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128425>

On Sun, Sep 13, 2009 at 02:16:39PM -0700, Junio C Hamano wrote:

> I am _not_ going to commit the following patch, because it will interfere
> with this clarification effort, but I think we want to do something along
> this line after the "clarification" settles.

Please, yes. When I first suggested the advice.* mechanism, I had a
feeling in the back of my mind that there were several such messages
which had bothered me, but I didn't read through the code base looking
for them. But now that you mention it, this "no merge candidate" message
is definitely one of them (not even because it's wrong or anything, but
because of sheer _size_ of it).

> An observation I'd like to make is that this is way too ugly:
> 
> 	[advice]
>         	pullNoMergeFound = false
>                 pushNonFastForward = false
>                 statusHints = false
> 
> than
> 
> 	[IKnowWhatIAmDoingThankYouVeryMuch]
>         	pullNoMergeFound
>                 pushNonFastForward
>                 statusHints
> 
> but this feature is for people who know what they are doing, so I guess
> the current set-up would be fine.

Maybe a nice shorthand would be '!' for negative booleans. I.e.,

  [advice]
  !pullNoMergeFound
  !pushNonFastForward
  !statusHints

-Peff
