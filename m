From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log: respect log.shownotes variable
Date: Thu, 8 Apr 2010 03:07:33 -0400
Message-ID: <20100408070732.GI30473@coredump.intra.peff.net>
References: <20100407204536.GA32382@coredump.intra.peff.net>
 <7vljczapzt.fsf@alter.siamese.dyndns.org>
 <4BBD390A.1030906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 08 09:07:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzlqI-0006xU-DF
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 09:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756764Ab0DHHHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 03:07:53 -0400
Received: from peff.net ([208.65.91.99]:52881 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753499Ab0DHHHx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 03:07:53 -0400
Received: (qmail 17136 invoked by uid 107); 8 Apr 2010 07:07:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Apr 2010 03:07:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 03:07:33 -0400
Content-Disposition: inline
In-Reply-To: <4BBD390A.1030906@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144338>

On Thu, Apr 08, 2010 at 10:01:46AM +0800, Michael J Gruber wrote:

> BTW: I used to keep external notes in
> refs/remotes/remotename/notes/notestree but since a while ago the notes
> code insists on refs/notes/. In some sense it is similar to tags, where
> you need to set up special refspecs if you want to have the remote
> tags/notes but don't want to mix them (and possibly have them conflict)
> with your own. But I don't know a good strategy for making this more
> user friendly.

I always assumed that the "prepend refs/notes" magic would refuse to do
so if the ref started with "notes/" (in which case it would append
"refs/") or "refs/" (in which case it would append nothing). That is how
we handle some situations where a branch head or a remote could be
used.

But I never checked, so maybe it doesn't. It probably should.

-Peff
