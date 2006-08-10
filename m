From: Jeff King <peff@peff.net>
Subject: Re: diff machinery cleanup
Date: Thu, 10 Aug 2006 16:10:50 -0400
Message-ID: <20060810201049.GA4759@sigio.intra.peff.net>
References: <20060810082455.GA30739@coredump.intra.peff.net> <7vejvpvsni.fsf@assigned-by-dhcp.cox.net> <20060810103836.GA1317@coredump.intra.peff.net> <7vzmecv7tp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 22:11:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBGsM-00004y-Lu
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 22:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWHJULG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 16:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWHJULF
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 16:11:05 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:7145 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751505AbWHJUKw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 16:10:52 -0400
Received: (qmail 22200 invoked from network); 10 Aug 2006 16:10:18 -0400
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by segfault.intra.peff.net with SMTP; 10 Aug 2006 16:10:18 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2006 16:10:50 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmecv7tp.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25208>

On Thu, Aug 10, 2006 at 10:06:42AM -0700, Junio C Hamano wrote:

> No, run_diff_index munges the index in-core, and it does not
> writes it out for obvious reasons.

Ah, OK, that makes more sense. Is there any reason then that this
wouldn't work (it certainly seems to, but I don't want to be causing
invisible problems that will come back later)? You seemed to outline a
much more complex procedure in your original mail.
  run_diff_index();
  discard_cache();
  ...
  run_diff_files();

I'd like to go with this simple solution at first for the C runstatus,
and then hopefully move to simultaneous diffing later.

-Peff
