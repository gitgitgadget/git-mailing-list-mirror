From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] fetch: Only call a new ref a "branch" if it's under
 refs/heads/.
Date: Mon, 16 Apr 2012 11:00:36 -0400
Message-ID: <20120416150036.GA15009@sigill.intra.peff.net>
References: <1334336904-18649-1-git-send-email-marcnarc@xiplink.com>
 <20120413211350.GD7919@sigill.intra.peff.net>
 <20120413215316.GA19826@burratino>
 <7vy5pz1cjk.fsf@alter.siamese.dyndns.org>
 <4F8C338D.1050805@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 17:00:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJnQ4-0005Mh-Te
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 17:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab2DPPAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 11:00:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36239
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753500Ab2DPPAk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 11:00:40 -0400
Received: (qmail 24182 invoked by uid 107); 16 Apr 2012 15:00:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Apr 2012 11:00:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Apr 2012 11:00:36 -0400
Content-Disposition: inline
In-Reply-To: <4F8C338D.1050805@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195642>

On Mon, Apr 16, 2012 at 10:58:21AM -0400, Marc Branchaud wrote:

> Git is better off describing what's appeared in the remote repo, and not
> worrying about describing how the user might've mapped those things to local
> refs.

That's my preference, as well, so it sounds like you, Junio, and I are
all in agreement.

> (That said, patching fetch.c to do that is a bit beyond me at the moment.
> Where would I find the remote's name for the ref?)

During transfer operations, the remote side of the pair is generally
pointed to by the peer_ref member of "struct ref" (so just use
"ref->peer_ref->name" instead of "ref->name").

-Peff
