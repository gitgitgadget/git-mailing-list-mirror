From: Jeff King <peff@peff.net>
Subject: Re: git remote doesn't show remotes from .git/remotes
Date: Fri, 7 Oct 2011 11:04:24 -0400
Message-ID: <20111007150423.GA2076@sigill.intra.peff.net>
References: <26866FC7-4D4D-46D0-89DE-85AF459AC48C@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 17:04:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCByS-0005IY-Cu
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 17:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861Ab1JGPE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 11:04:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54928
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752707Ab1JGPE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 11:04:27 -0400
Received: (qmail 22352 invoked by uid 107); 7 Oct 2011 15:04:27 -0000
Received: from 208.177.47.101.ptr.us.xo.net (HELO sigill.intra.peff.net) (208.177.47.101)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 07 Oct 2011 11:04:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Oct 2011 11:04:24 -0400
Content-Disposition: inline
In-Reply-To: <26866FC7-4D4D-46D0-89DE-85AF459AC48C@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183079>

On Thu, Oct 06, 2011 at 07:33:23PM +0400, Kirill Likhodedov wrote:

> It seems that 'git remote' doesn't display remotes registered not in
> .git/config but in .git/remotes/.
> Is it a bug?

It seems to have been lost in 211c896 (Make git-remote a builtin,
2008-02-29).

It wouldn't be that hard to add it back in. I'm not sure how much we
care, though. We haven't generated .git/remotes files in a long time,
and this is the first notice of the bug after 3.5 years. Is this an old
repo that has remotes, or are you wondering if you should use them in a
new repo?

> Btw, are there advantages in using .git/remotes/ instead of .git/config ?

No. They were an older format, and were replaced by having the remote
defined in the configuration (and there are many things you can specify
in the config that you can't do via .git/remotes).

> If not, are there plans to remove .git/remotes/ support in future versions?

I don't think there is a specific plan. They're kept for backwards
compatibility. But really, there is no reason to be using them at all at
this point.

-Peff
