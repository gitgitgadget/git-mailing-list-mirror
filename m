From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] apply: fall back on three-way merge
Date: Thu, 10 May 2012 18:24:20 -0400
Message-ID: <20120510222420.GA31116@sigill.intra.peff.net>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
 <1336629745-22436-7-git-send-email-gitster@pobox.com>
 <20120510203113.GB18276@sigill.intra.peff.net>
 <7vaa1fn3u8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 11 00:24:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSbn5-0002Qo-56
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 00:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761888Ab2EJWYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 18:24:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39219
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761882Ab2EJWY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 18:24:28 -0400
Received: (qmail 3418 invoked by uid 107); 10 May 2012 22:24:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 May 2012 18:24:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2012 18:24:20 -0400
Content-Disposition: inline
In-Reply-To: <7vaa1fn3u8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197636>

On Thu, May 10, 2012 at 02:06:23PM -0700, Junio C Hamano wrote:

> > Is it true that there is no point in doing a 3-way fallback when
> > patch->is_binary? What if the user has a custom merge driver?
> > ...
> > It seems like we should just keep the logic here as stupid as possible,
> 
> Actually, the motivation behind that "No point" is to keep the logic as
> stupid as possible.
> [...]
> I can buy that lifting "must not be binary" would be very cheap, but
> adding support for new/delete case would mean the index-stuffing part
> needs to gain more code, so removing the "not new, not delete"
> conditionals actually goes against keeping the logic as stupid as
> possible.

Fair enough. It's by far the minority case, so we can wait until
it is somebody's itch to scratch.

-Peff
