From: Jeff King <peff@peff.net>
Subject: Re: How to merge from newer branch to older branches?
Date: Wed, 22 Apr 2009 09:34:35 -0400
Message-ID: <20090422133434.GA11530@coredump.intra.peff.net>
References: <2729632a0904211224x6e2621caxf6c169d90b760530@mail.gmail.com> <20090421193615.GB7832@coredump.intra.peff.net> <7vmya946fg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: skillzero@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 15:36:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwccX-00029q-QO
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 15:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566AbZDVNej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 09:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbZDVNej
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 09:34:39 -0400
Received: from peff.net ([208.65.91.99]:35474 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753485AbZDVNei (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 09:34:38 -0400
Received: (qmail 15352 invoked by uid 107); 22 Apr 2009 13:34:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 22 Apr 2009 09:34:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2009 09:34:35 -0400
Content-Disposition: inline
In-Reply-To: <7vmya946fg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117197>

On Tue, Apr 21, 2009 at 10:13:23PM -0700, Junio C Hamano wrote:

> > Right. Junio branches all topics in git from "master", but then merges
> > promising ones into "next". When the topic is ready for master, he can
> > then just merge the topic branch, pulling in that topic but not the rest
> > of next.
> 
> No, I don't.
> 
> I often branch from somewhere older than 'master', often tip from 'maint'
> sometimes even older.  And that is not necessarily because I am better
> than other people in planning ahead.  There are branches that forked from
> older series (like 1.6.0.X) that are merged to next and then master,
> without ever getting merged to produce 1.6.0.(X+1).

Sure, but I assumed a new topic that came in would get branched from
'master', since that is presumably what the person developing it based
it on. Is that not true?

That is also what is in Documentation/howto/maintain-git.txt:

   - Anything unobvious that is applicable to 'master' (in other
     words, does not depend on anything that is still in 'next'
     and not in 'master') is applied to a new topic branch that
     is forked from the tip of 'master'.  This includes both
     enhancements and unobvious fixes to 'master'.  A topic
     branch is named as ai/topic where "ai" is typically
     author's initial and "topic" is a descriptive name of the
     topic (in other words, "what's the series is about").

   - An unobvious fix meant for 'maint' is applied to a new
     topic branch that is forked from the tip of 'maint'.  The
     topic is named as ai/maint-topic.

-Peff
