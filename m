From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: split implications of --all-progress
 from progress activation
Date: Mon, 23 Nov 2009 14:32:42 -0500
Message-ID: <20091123193242.GA3140@coredump.intra.peff.net>
References: <20091122145352.GA3941@debian.b2j>
 <20091123145959.GA13138@sigill.intra.peff.net>
 <20091123155043.GA28963@machine.or.cz>
 <20091123164319.GA23011@sigill.intra.peff.net>
 <alpine.LFD.2.00.0911231221320.2059@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Nov 23 20:32:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCeeW-00043D-OV
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 20:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457AbZKWTci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 14:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbZKWTch
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 14:32:37 -0500
Received: from peff.net ([208.65.91.99]:49404 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754234AbZKWTch (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 14:32:37 -0500
Received: (qmail 4391 invoked by uid 107); 23 Nov 2009 19:37:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Nov 2009 14:37:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Nov 2009 14:32:42 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0911231221320.2059@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133528>

On Mon, Nov 23, 2009 at 12:43:50PM -0500, Nicolas Pitre wrote:

> Currently the --all-progress flag is used to use force progress display 
> during the writing object phase even if output goes to stdout which is 
> primarily the case during a push operation.  This has the unfortunate 
> side effect of forcing progress display even if stderr is not a 
> terminal.
> 
> Let's introduce the --all-progress-implied argument which has the same 
> intent except for actually forcing the activation of any progress 
> display.  With this, progress display will be automatically inhibited 
> whenever stderr is not a terminal, or full progress display will be 
> included otherwise.  This should let people use 'git push' within a cron 
> job without filling their logs with useless percentage displays.
> 
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

Thanks,

Tested-by: Jeff King <peff@peff.net>

-Peff
