From: Jeff King <peff@peff.net>
Subject: Re: Solaris test failure for git-1.5.4.4 -- t0021-conversion.sh
Date: Tue, 11 Mar 2008 13:35:37 -0400
Message-ID: <20080311173536.GA14687@sigill.intra.peff.net>
References: <8ec76080803110533m14041aebhc779d117a5bb6112@mail.gmail.com> <alpine.DEB.1.00.0803110954360.4428@alchemy.localdomain> <8ec76080803111014w209e1ceep9baf6d5c8c7f6a20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 18:38:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ8Ox-0004KZ-RO
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 18:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbYCKRfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 13:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752756AbYCKRfk
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 13:35:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2838 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311AbYCKRfj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 13:35:39 -0400
Received: (qmail 16358 invoked by uid 111); 11 Mar 2008 17:35:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 11 Mar 2008 13:35:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Mar 2008 13:35:37 -0400
Content-Disposition: inline
In-Reply-To: <8ec76080803111014w209e1ceep9baf6d5c8c7f6a20@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76885>

On Tue, Mar 11, 2008 at 01:14:39PM -0400, Whit Armstrong wrote:

> Thanks for the suggestion.  I found a few things in trash:
> 
> xs5-trd-p1.grn:warmstro> pwd
> /home/warmstro/download/solaris/git-1.5.4.4/t/trash
> xs5-trd-p1.grn:warmstro> cat rot13.sh
> tr '[a-zA-Z]' '[n-za-mN-ZA-M]'
> xs5-trd-p1.grn:warmstro> tr '[a-zA-Z]' '[n-za-mN-ZA-M]'
> tr: Bad string.
> xs5-trd-p1.grn:warmstro>
> 
> does that help, or do you need a bit more than that?

Looks like /usr/ucb/tr is OK with this, but /usr/bin/tr is not. Both
seem to handle the more verbose:

tr \
  'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' \
  'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'

just fine.

-Peff
