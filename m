From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] filter-branch: provide the convenience functions
 also for commit filters
Date: Thu, 19 Jul 2007 02:16:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707190215460.14781@racer.site>
References: <Pine.LNX.4.64.0707181650080.14781@racer.site>
 <7vfy3l5jo4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 03:17:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBKde-00076t-Rm
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 03:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761831AbXGSBRD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 21:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760838AbXGSBRC
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 21:17:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:55208 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760644AbXGSBRB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 21:17:01 -0400
Received: (qmail invoked by alias); 19 Jul 2007 01:16:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 19 Jul 2007 03:16:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/X+c5zJtXXOYbGCFnPRwSkZ4hpadRoNIsTpv20hU
	sQwugvaYk4SmmB
X-X-Sender: gene099@racer.site
In-Reply-To: <7vfy3l5jo4.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52920>

Hi,

On Wed, 18 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +this_script="$(cd "$(dirname "$0")"; pwd)"/$(basename "$0")
> > ...
> > +		filter_commit="SOURCE_FUNCTIONS=1 . \"$this_script\"; $OPTARG"
> 
> Hmmmmmm.
> 
> Care to enlighten why this is not just:
> 
> 	filter_commit="SOURCE_FUNCTIONS=1 . \"$0\"; $OPTARG"
> 
> Is it because you cd(1) around in the script, and it can be
> relative to where you started?

Yes.

> In either case, are you quoting potential funnies (such as '"'
> or '\\') in "$0" sufficiently?  Exporting this_script variable,
> and changing the above to
> 
> 	filter_commit='SOURCE_FUNCTIONS=1 . "$this_script";'" $OPTARG"
> 
> to arrange the shell that is invoked with 'sh -c' to expand its
> value would make it smaller problem, I suspect.

Will do.  You know, I do have my problems with correct quoting, and the 
way I did it in this patch was always good enough for me.  Which does not 
mean much...

Ciao,
Dscho
