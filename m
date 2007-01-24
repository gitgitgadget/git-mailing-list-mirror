From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port - initial work uploaded
Date: Wed, 24 Jan 2007 11:24:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241121380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701192148.20206.johannes.sixt@telecom.at>
 <200701231506.32396.andyparkins@gmail.com>
 <Pine.LNX.4.63.0701231614490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701231624.41716.andyparkins@gmail.com>
 <Pine.LNX.4.63.0701231732120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0701230852270.32200@woody.linux-foundation.org>
 <Pine.LNX.4.63.0701231805100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vlkjtkxlm.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701240251230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk5zdhv5r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 24 11:24:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9fJ6-00024B-4F
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 11:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbXAXKYl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 05:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbXAXKYl
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 05:24:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:43090 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750975AbXAXKYk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 05:24:40 -0500
Received: (qmail invoked by alias); 24 Jan 2007 10:24:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 24 Jan 2007 11:24:39 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vk5zdhv5r.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37622>

Hi,

On Tue, 23 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Seriously again, the users of merge-index are
> >
> > git-merge, which I do not really understand
> >
> > What I am nervous about is git-merge.
> 
> I think you are referring to the "carry forward local change"
> logic in 'next'.
> 
> First of all, BAD DSCHO.  You should be looking at 'master', not
> 'next' during -rc period ;-).

Guilty on all accounts. Actually, I am not looking at 'next', but on 'my', 
which is my long-running sidebranch of next, which contains all the 
scripts I like to run manually, or in cron.

> Seriously again, the codepath is taken when the merge is a fast
> forward to another commit (iow, our HEAD is an ancestor of the
> other branch, so we will end up updating the branch tip with the
> tip of the other branch).  The use of merge-index there can be
> replaced when we use merge-recursive instead of the 3-way
> "read-tree -m" the same way as how "checkout -m" implements the
> branch switching with local changes.

Aha. The use of merge-recursive would be really easy, if we did not write 
$GIT_DIR/LOCAL_DIFF, but $GIT_DIR/TEMP_BRANCH or $GIT_DIR/LOCAL_TREE...
Just teasing you...

Ciao,
Dscho
