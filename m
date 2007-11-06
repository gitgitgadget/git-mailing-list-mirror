From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-mailsplit: with maildirs try to process new/ if
	cur/ is empty
Date: Tue, 6 Nov 2007 02:51:53 -0500
Message-ID: <20071106075150.GA21694@sigill.intra.peff.net>
References: <20071026141539.29928.qmail@d3691352d65cf2.315fe32.mid.smarden.org> <20071026160118.GA5076@ferdyx.org> <20071105124920.17726.qmail@746e9cce42b49f.315fe32.mid.smarden.org> <20071105225258.GC4208@steel.home> <635FFEC2-2489-443B-8425-DF2B58BE23C2@mac.com> <20071106072831.GA3021@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Cohen <michaeljosephcohen@mac.com>,
	Gerrit Pape <pape@smarden.org>,
	"Fernando J. Pereda" <ferdy@gentoo.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 08:52:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpJEd-0005VD-NR
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 08:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548AbXKFHwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 02:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754215AbXKFHwR
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 02:52:17 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4733 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605AbXKFHwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 02:52:16 -0500
Received: (qmail 28206 invoked by uid 111); 6 Nov 2007 07:52:11 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 06 Nov 2007 02:52:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Nov 2007 02:51:53 -0500
Content-Disposition: inline
In-Reply-To: <20071106072831.GA3021@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63636>

On Tue, Nov 06, 2007 at 08:28:31AM +0100, Alex Riesen wrote:

> > In Maildir format, cur and new hold the mails. :P
> 
> So? Why *STOP* reading the mails if just one of the directories could
> not be opened? IOW, I suggest:

Because you are then trying to apply a patch series with some patches
potentially missing? Continuing only on errno == ENOENT seems prudent.

-Peff
