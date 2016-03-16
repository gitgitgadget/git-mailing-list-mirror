From: Jeff King <peff@peff.net>
Subject: Re: Can't git stash after using git add -N
Date: Wed, 16 Mar 2016 17:18:33 -0400
Message-ID: <20160316211833.GC2200@sigill.intra.peff.net>
References: <20160315230754.GA12058@cloud>
 <xmqq8u1j7193.fsf@gitster.mtv.corp.google.com>
 <20160316020000.GB12130@cloud>
 <xmqqvb4n58ko.fsf@gitster.mtv.corp.google.com>
 <20160316120245.GA15091@cloud>
 <20160316210535.GA2200@sigill.intra.peff.net>
 <CAPc5daVnQ94jc8pP=-FUgRA7oS=vXNGG=5Z23NWuZZScnhkQ9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:18:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agIq1-0000lG-79
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473AbcCPVSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:18:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:32805 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751510AbcCPVSg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:18:36 -0400
Received: (qmail 25498 invoked by uid 102); 16 Mar 2016 21:18:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 17:18:36 -0400
Received: (qmail 20178 invoked by uid 107); 16 Mar 2016 21:18:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 17:18:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 17:18:33 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daVnQ94jc8pP=-FUgRA7oS=vXNGG=5Z23NWuZZScnhkQ9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289041>

On Wed, Mar 16, 2016 at 02:11:19PM -0700, Junio C Hamano wrote:

> I actually think "silently ignore intent-to-add" was a mistake.
> We used to error out at write-tree time, which I think is the
> right behaviour--"I know I want to have this path, but I cannot
> yet decide with what content" is what the user is telling us when
> she says "add -N", so until that indecision is resolved, we
> shouldn't write out a tree object out of the index.

Yeah, I am inclined to agree, and I _thought_ we also used to error out
during write-tree, but I failed to find the spot where we switched
(thinking that it might provide some rationale).

I think I just didn't look far enough back, though. Commit 3f6d56d
(commit: ignore intent-to-add entries instead of refusing, 2012-02-07)
does not exactly have a sneaky title.

-Peff
