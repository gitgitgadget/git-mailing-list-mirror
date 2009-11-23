From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] pack-objects: split implications of --all-progress
 from  progress activation
Date: Mon, 23 Nov 2009 19:12:06 +0100
Message-ID: <20091123181206.GD26996@machine.or.cz>
References: <20091122145352.GA3941@debian.b2j>
 <20091123145959.GA13138@sigill.intra.peff.net>
 <20091123155043.GA28963@machine.or.cz>
 <20091123164319.GA23011@sigill.intra.peff.net>
 <alpine.LFD.2.00.0911231221320.2059@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Nov 23 19:12:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCdOl-0007Tq-4l
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 19:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754673AbZKWSMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 13:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754617AbZKWSMD
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 13:12:03 -0500
Received: from w241.dkm.cz ([62.24.88.241]:59815 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608AbZKWSMC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 13:12:02 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 33721125A0EC; Mon, 23 Nov 2009 19:12:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0911231221320.2059@xanadu.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133518>

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

Ok, but what is currently the way to force the old behaviour? I believe
that should be also part of the commit message.

Naive deduction fails:

	$ git remote update --progress
	error: unknown option `progress'

Thanks,

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
