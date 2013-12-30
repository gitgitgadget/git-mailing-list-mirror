From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 9/9] trailer: add tests for "git interpret-trailers"
Date: Mon, 30 Dec 2013 14:27:19 -0800
Message-ID: <20131230222719.GN6840@leaf>
References: <20131224061541.19560.17773.chriscool@tuxfamily.org>
 <20131224063726.19560.61859.chriscool@tuxfamily.org>
 <xmqq1u0utfwk.fsf@gitster.dls.corp.google.com>
 <20131230202042.GJ27213@leaf>
 <xmqqk3emqd7a.fsf@gitster.dls.corp.google.com>
 <20131230205234.GU27213@leaf>
 <xmqqfvpaqcbu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 30 23:27:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxlJL-00017i-40
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 23:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323Ab3L3W1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 17:27:41 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41327 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299Ab3L3W13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 17:27:29 -0500
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 4E6A2A80B1;
	Mon, 30 Dec 2013 23:27:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter4-d.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 8vHyBQc35Yw4; Mon, 30 Dec 2013 23:27:25 +0100 (CET)
X-Originating-IP: 50.43.14.201
Received: from leaf (static-50-43-14-201.bvtn.or.frontiernet.net [50.43.14.201])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5FB0DA80B0;
	Mon, 30 Dec 2013 23:27:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqfvpaqcbu.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239829>

On Mon, Dec 30, 2013 at 01:05:25PM -0800, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> >>  - With your scheme, if you already had _one_ trailing SPs in the
> >>    input, it would be hard to spot in the source;
> >
> > Git makes them quite difficult to miss. :)
> 
> That is irrelevant, isn't it?
> 
> This is about protecting the source in the editor, before you run
> "git show --whitespace=trailing-space", "git diff --check", etc.

That was exactly my point: such lines shouldn't exist, and rather than
including the trailing space and following it with a character that then
needs removing, it seems more sensible to me to omit the trailing space
and insert it via an almost identical sed line.  Git already helps
ensure that trailing space won't exist on *any* line, including those; I
don't see how an extra character after the space (making it no longer
trailing space) makes it any more or less likely that those lines would
have trailing space.

In any case, I don't care enough to argue the point further; it was just
a style suggestion.

- Josh Triplett
