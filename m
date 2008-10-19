From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] feature request: git-mergetool --force
Date: Sun, 19 Oct 2008 07:47:23 -0400
Message-ID: <20081019114722.GA30412@coredump.intra.peff.net>
References: <48F91E59.50202@gmail.com> <20081018154824.GA20185@coredump.intra.peff.net> <48FA2E9F.3090305@gmail.com> <20081018205443.GA29534@coredump.intra.peff.net> <48FA6E55.9030101@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Pursell <bill.pursell@gmail.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 07:50:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrWlz-00010q-RC
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 13:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbYJSLr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 07:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbYJSLr1
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 07:47:27 -0400
Received: from peff.net ([208.65.91.99]:4982 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbYJSLr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 07:47:26 -0400
Received: (qmail 7071 invoked by uid 111); 19 Oct 2008 11:47:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 19 Oct 2008 07:47:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Oct 2008 07:47:23 -0400
Content-Disposition: inline
In-Reply-To: <48FA6E55.9030101@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98617>

On Sun, Oct 19, 2008 at 12:16:37AM +0100, Charles Bailey wrote:

> I've recently been using git mergetool quite a bit and I'm currently
> cooking a couple of patches. The first, by coincidence, was a "-n"
> option which disabled the hit-return-to-actually-do-anything prompt. I,
> also, used the variable "NOPROMPT" to describe this behaviour.
> 
> The other change that I am working was more of an issue for me. When I
> have a fair number of files to merge I sometimes want to skip a merge.
> Perhaps it's a tricky one and I want do the easy wins first.
> [...]
> Thoughts?

I think those are both reasonable behaviors. I also thought instantly of
the issue you mentioned, that people who really did want to abort would
get stuck in a loop of spawning the merge resolver. For that reason, I
think it makes sense to have both of them as options (either config,
command-line, or both). And if you do "git mergetool --no-prompt
--keep-going", then you are accepting the fact that you won't have a
chance to ask it to stop.

And I would suggest "-k, --keep-going" for the second option, as it
reminds me of the similar "make" option.

-Peff
