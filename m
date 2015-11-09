From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Add git-grep threads param
Date: Mon, 9 Nov 2015 10:55:38 -0500
Message-ID: <20151109155538.GC27224@sigill.intra.peff.net>
References: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
 <xmqqvb9jc81q.fsf@gitster.mtv.corp.google.com>
 <20151104064021.GB16605@sigill.intra.peff.net>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA15@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Victor Leschuk <vleschuk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"john@keeping.me.uk" <john@keeping.me.uk>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 16:55:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvonJ-0002ok-Fu
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 16:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbbKIPzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 10:55:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:54958 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751586AbbKIPzl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 10:55:41 -0500
Received: (qmail 2803 invoked by uid 102); 9 Nov 2015 15:55:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Nov 2015 09:55:40 -0600
Received: (qmail 16362 invoked by uid 107); 9 Nov 2015 15:56:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Nov 2015 10:56:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Nov 2015 10:55:38 -0500
Content-Disposition: inline
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA15@mail.accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281054>

On Mon, Nov 09, 2015 at 03:36:16AM -0800, Victor Leschuk wrote:

> Yeah do also think it would be more reasonable to use "0" for
> "autodetect" default value. However chat this autodetect value should
> be?
> 
> For index index-pack and pack-objects we use ncpus() for this, however
> according to my tests this wouldn't an Ideal for all cases. Maybe it
> should be something like ncpus()*2, 
> anyway before it we even used hard-coded 8 for all systems...

Why don't we leave it at 8, then? That's the conservative choice, and
once we have --threads, people can easily experiment with different
values and we can follow-up with a change to the default if need be.

-Peff
