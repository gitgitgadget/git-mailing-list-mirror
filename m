From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/6] run-command: optimize out useless shell calls
Date: Thu, 31 Dec 2009 23:16:47 +0100
Message-ID: <200912312316.47925.j6t@kdbg.org>
References: <20091230095634.GA16349@coredump.intra.peff.net> <4B3CD74D.7020605@kdbg.org> <20091231214134.GA31399@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 31 23:18:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQTLs-00036r-9b
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 23:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbZLaWRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 17:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbZLaWRe
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 17:17:34 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:54414 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751331AbZLaWRe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 17:17:34 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 45FFCA7EB9;
	Thu, 31 Dec 2009 23:17:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 09C6419F586;
	Thu, 31 Dec 2009 23:16:48 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <20091231214134.GA31399@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135979>

On Donnerstag, 31. Dezember 2009, Jeff King wrote:
> But of course if we use your trick internally in run-command, then your
> pager-specific change can just go away.

This is what I had in mind.

> > It does assume that we are able to detect execvp failure due to
> > ENOENT which is currently proposed elsewhere by Ilari Liusvaara (and
> > which is already possible on Windows).
>
> We could also simply do the path lookup ourselves, decide whether to use
> the shell, and then exec.

I tried to convince Ilari that this is the way to go, but...

-- Hannes
