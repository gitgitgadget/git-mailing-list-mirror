From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2010, #02; Sun, 07)
Date: Tue, 9 Mar 2010 18:13:07 -0500
Message-ID: <20100309231306.GD25265@sigill.intra.peff.net>
References: <7vk4tnd9wu.fsf@alter.siamese.dyndns.org>
 <7vk4tnw4nz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 10 00:13:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np8bz-00022i-B8
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 00:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145Ab0CIXNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 18:13:10 -0500
Received: from peff.net ([208.65.91.99]:37474 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab0CIXNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 18:13:09 -0500
Received: (qmail 3589 invoked by uid 107); 9 Mar 2010 23:13:32 -0000
Received: from c-71-206-173-191.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.191)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 09 Mar 2010 18:13:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Mar 2010 18:13:07 -0500
Content-Disposition: inline
In-Reply-To: <7vk4tnw4nz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141854>

On Mon, Mar 08, 2010 at 01:20:32AM -0800, Junio C Hamano wrote:

> After thinking about this a bit more, I do not think it is a good idea to
> disable configured decoration when an explicit --pretty is given.  A patch
> to do so would be a trivial two-liner:
> [...]
> but there is one big difference between notes and decoration.  Decorations
> are designed to be a small, one-per-ref tokens that would sit well on a
> line that already has other essential informations, while notes are a lot
> louder "in your face" annotations that occupy line(s) on their own.

True, but turning off configured decorations also helps scripts. I think
we can all agree that normal "git log" is not supposed to be consumed by
scripts, but should "git log --pretty=raw" turn off configured
decorations?

With the current code, gitk (which calls "log --pretty=raw") barfs on a
repository with log.decorate turned on.

-Peff
