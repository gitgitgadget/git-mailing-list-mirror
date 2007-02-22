From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git-diff{,-files} the new option `--no-index`
Date: Thu, 22 Feb 2007 21:47:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702222146280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702201944340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm76fpia.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702221724090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvehuf4ic.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702221926390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz36f1bv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702222051490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd542dji4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 22 21:48:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKKrD-0001E0-CW
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 21:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbXBVUr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 15:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbXBVUr6
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 15:47:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:39183 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751866AbXBVUr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 15:47:58 -0500
Received: (qmail invoked by alias); 22 Feb 2007 20:47:56 -0000
X-Provags-ID: V01U2FsdGVkX1+eHyVei0Sez1J06X1hCzJMOkagKmTJTdhTkvGnKH
	uhbA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vd542dji4.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40386>

Hi,

On Thu, 22 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> For one thing, I want to move read_cache() out of run_diff_files() and 
> >> run_diff_index() to their callers, so that the caller can use a 
> >> handcrafted active_cache[] that is somewhat different from what 
> >> read_cache() originally read.
> >
> > I don't understand. Would it not be easier to "return active_nr" in 
> > read_cache_from(path) _also_ when active_cache is set? Or alternatively 
> > check if active_alloc is set?
> 
> I do not understand your questions.
> 
> What I am getting at is that in the current code (without your
> patch), run_diff_files() is about diff between $GIT_DIR/index
> and working tree.  I want to make it diff between active_cache[]
> and working tree.

My point was: you could just ignore the read_cache() calls if they just 
returned, doing nothing, as long as there is an active_cache.

But that's probably too dirty.

Anyway, I restructured the patch as per your comments, and will send it 
after this mail.

Ciao,
Dscho
