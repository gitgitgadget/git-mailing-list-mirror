From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] checkout (detached): truncate list of orphaned
 commits at the new HEAD
Date: Sat, 5 May 2012 05:01:09 -0400
Message-ID: <20120505090108.GA8172@sigill.intra.peff.net>
References: <4FA41C3A.9080002@kdbg.org>
 <4FA41C98.2010105@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat May 05 11:01:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQasE-0003iL-5x
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 11:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486Ab2EEJBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 05:01:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58512
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230Ab2EEJBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 05:01:16 -0400
Received: (qmail 31219 invoked by uid 107); 5 May 2012 09:01:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 05 May 2012 05:01:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 May 2012 05:01:09 -0400
Content-Disposition: inline
In-Reply-To: <4FA41C98.2010105@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197100>

On Fri, May 04, 2012 at 08:14:48PM +0200, Johannes Sixt wrote:

> When git checkout switches from a detached HEAD to any other commit, then
> all orphaned commits were listed in a warning:
> 
>   Warning: you are leaving 2 commits behind...:
> 
>     a5e5396 another fixup
>     6aa1af6 fixup foo
> 
> But if the new commit is actually one from this list (6aa1af6 in this
> example), then the list in the warning can be truncated at the new HEAD,
> because history beginning at HEAD is not "left behind". This makes it so.

Thanks, this has bugged me a few times in the past, but I've never
gotten around to investigating and fixing it.

>  builtin/checkout.c         | 13 +++++++------
>  t/t2020-checkout-detach.sh |  2 +-
>  2 files changed, 8 insertions(+), 7 deletions(-)

The patch looks right to me.

-Peff
