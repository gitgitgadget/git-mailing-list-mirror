From: Jeff King <peff@peff.net>
Subject: Re: Why a _full_ diff? (was: [PATCH] Char: serial167, cleanup (fwd))
Date: Mon, 12 Feb 2007 04:20:30 -0500
Message-ID: <20070212092028.GB12605@coredump.intra.peff.net>
References: <Pine.LNX.4.62.0702120934120.10436@chinchilla.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 10:20:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGXMe-0005tb-2n
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 10:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbXBLJUf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 04:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbXBLJUf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 04:20:35 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2874 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964813AbXBLJUe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 04:20:34 -0500
Received: (qmail 2755 invoked from network); 12 Feb 2007 04:20:37 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 12 Feb 2007 04:20:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Feb 2007 04:20:30 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0702120934120.10436@chinchilla.sonytel.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39386>

On Mon, Feb 12, 2007 at 09:39:46AM +0100, Geert Uytterhoeven wrote:

> I received the email below, showing a _full_ (i.e. every single line) diff
> between the old and the new version:

Hmm. I'm not sure what is generating this, but the diffstat in the email
is wrong (anybody know where the mailing list feeder script lives?).

> | diff --git a/drivers/char/serial167.c b/drivers/char/serial167.c
> | dissimilarity index 67%
> | index af50d32..5fd314a 100644
> | --- a/drivers/char/serial167.c
> | +++ b/drivers/char/serial167.c
> | @@ -1,2824 +1,2792 @@
> | -/*
> | - * linux/drivers/char/serial167.c
> | - *

This may or may not be related to the diffstat issue; you can get a
similar effect by asking for a lot of context. For example:

  git show --unified=150 44bafd

> | anakin$ git show 44bafdf37b30234671d4e2fb595dea4c3717d089 | diffstat
> |  serial167.c | 3322 +++++++++++++++++++++++++++++-------------------------------
> |  1 file changed, 1645 insertions(+), 1677 deletions(-)

This is also what git produces, using

  git show --stat 44bafd

I think there is probably some erroneous magic going on in whatever
script generates the mail.

-Peff
