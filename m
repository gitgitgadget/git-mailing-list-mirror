From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2010, #05; Sat, 16)
Date: Sun, 17 Jan 2010 14:40:36 -0500
Message-ID: <20100117194036.GC31536@coredump.intra.peff.net>
References: <7vljfxa1o6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 20:40:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWazM-0002uB-Pg
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 20:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571Ab0AQTkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 14:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754546Ab0AQTkk
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 14:40:40 -0500
Received: from peff.net ([208.65.91.99]:36153 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754544Ab0AQTkj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 14:40:39 -0500
Received: (qmail 27847 invoked by uid 107); 17 Jan 2010 19:45:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 17 Jan 2010 14:45:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jan 2010 14:40:36 -0500
Content-Disposition: inline
In-Reply-To: <7vljfxa1o6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137314>

On Sat, Jan 16, 2010 at 06:46:33PM -0800, Junio C Hamano wrote:

> * jc/ident (2010-01-08) 3 commits
>  - ident.c: treat $EMAIL as giving user.email identity explicitly
>   (merged to 'next' on 2010-01-10 at f1f9ded)
>  + ident.c: check explicit identity for name and email separately
>  + ident.c: remove unused variables
> 
> Opinions on the topmost one?

I don't see a problem with the top one as long as the order is (in order
of decreasing precedence):

  1. GIT_*_EMAIL
  2. git config
  3. EMAIL
  4. `whoami`@`hostname`

which from my tests seems to be the case. That is, even though
environment variables generally take precedence over config,
git-specific environment variables and config take precedence over
generic config.

Otherwise I think we may surprise some people who have EMAIL set.

-Peff
