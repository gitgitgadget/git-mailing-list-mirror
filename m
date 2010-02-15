From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH 1/4] Refactoring: remove duplicated code from
 transport.c and builtin-send-pack.c
Date: Mon, 15 Feb 2010 12:30:41 -0500
Message-ID: <20100215173041.GA8215@cthulhu>
References: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com>
 <20100215052853.GJ3336@coredump.intra.peff.net>
 <7v7hqfknwz.fsf@alter.siamese.dyndns.org>
 <7v635zj8jr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Lukashov <michael.lukashov@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 18:30:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh4mX-0005AN-Ge
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 18:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521Ab0BORan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 12:30:43 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:33639 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972Ab0BORam (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 12:30:42 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 13194822226; Mon, 15 Feb 2010 12:30:42 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v635zj8jr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140018>


Weird: I only got the Cc for this, git@vger.kernel.org didnt' sent it to me.  It
doesn't seem to be on gmane either.

* Junio C Hamano (gitster@pobox.com) [100215 01:51]:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >>>  builtin-send-pack.c |   89 ++++++++++++++----------
> >>>  send-pack.h         |   20 +++++
> >>>  transport.c         |  196 ---------------------------------------------------
> >>
> >> I think this is backwards. The versions in send-pack were there first,
> >> and then were ported to transport.c so that other transports could
> >> benefit from them. And that is where they should ultimately be.
> >
> > Also the names of these functions probably need to be made more specific
> > so that people not so familiar with the transport code can tell that they
> > are from "transport" family.  The names didn't matter much while they were
> > file scope static, but this series changes that.
> 
> Ah, one more thing.  I think this patch touches somewhat overlapping areas
> the ld/push-porcelain topic in 'pu' touches.
> 
> I think Peff's "backwards" observation is correct (and Daniel can
> elaborate if he wants).  Once the direction is set on that point, you and
> Larry probably would need to coordinate to decide how to proceed.  My gut
> feeling without actually looking at the conflicts is that applying your
> code consolidation first and then doing the "porcelain" rework on top
> might be a cleaner approach, but you two are in better position to decide
> on the order, as these are your codes that will be conflicting with each
> other.

That sounds good to me.  I'll rebase the porcelain stuff off the next version of
Michael's series.

          --larry
