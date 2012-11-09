From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] push: update remote tags only with force
Date: Fri, 9 Nov 2012 13:38:34 -0500
Message-ID: <20121109183834.GB22164@sigill.intra.peff.net>
References: <1352084908-32333-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:38:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWtTi-0004gM-Pt
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 19:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135Ab2KISik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 13:38:40 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40294 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503Ab2KISij (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 13:38:39 -0500
Received: (qmail 9392 invoked by uid 107); 9 Nov 2012 18:39:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Nov 2012 13:39:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2012 13:38:34 -0500
Content-Disposition: inline
In-Reply-To: <1352084908-32333-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209235>

On Sun, Nov 04, 2012 at 09:08:23PM -0600, Chris Rorvick wrote:

> Patch series to prevent push from updating remote tags w/o forcing them.
> Split out original patch to ease review.
> 
> Chris Rorvick (5):
>   push: return reject reasons via a mask
>   push: add advice for rejected tag reference
>   push: flag updates
>   push: flag updates that require force
>   push: update remote tags only with force
> 
>  Documentation/git-push.txt |   10 +++++-----
>  builtin/push.c             |   24 +++++++++++++++---------
>  builtin/send-pack.c        |    6 ++++++
>  cache.h                    |    7 ++++++-
>  remote.c                   |   39 +++++++++++++++++++++++++++++++--------
>  t/t5516-fetch-push.sh      |   30 +++++++++++++++++++++++++++++-
>  transport-helper.c         |    6 ++++++
>  transport.c                |   25 +++++++++++++++----------
>  transport.h                |   10 ++++++----
>  9 files changed, 119 insertions(+), 38 deletions(-)

I have not looked carefully at this topic yet, but I did try merging it
to "pu" and found that it had some textual conflicts with the
nd/builtin-to-libgit topic, which moves some builtin/send-pack.c code to
send-pack.c. Since I am graduating that topic to master, I went ahead
and just rebased your topic on top.

If you do a re-roll, please use an updated master, and feel free to
grab (and double-check!) the rebase I am about to send out in 'pu'. I
also included the minor signed/unsigned pointer warning fixup in the
rebase, too.

-Peff
