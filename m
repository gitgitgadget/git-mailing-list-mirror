From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] git-rebase-interactive: do not squash commits on
 abort
Date: Wed, 10 Sep 2008 11:53:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0809101150570.13830@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1220906569-26878-1-git-send-email-dpotapov@gmail.com> <7v7i9mdvyr.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0809091616200.13830@pacific.mpi-cbg.de.mpi-cbg.de> <20080909205036.GD28210@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 11:52:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdMNO-0005Bu-Ec
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 11:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbYIJJrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 05:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbYIJJrd
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 05:47:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:59842 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751586AbYIJJrc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 05:47:32 -0400
Received: (qmail invoked by alias); 10 Sep 2008 09:47:30 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 10 Sep 2008 11:47:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zeQYuuSBzwZhzqmuFWFRn7qcXh9oRslhZnQG3sD
	7WFryLspMdMBtN
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080909205036.GD28210@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95506>

Hi,

On Wed, 10 Sep 2008, Dmitry Potapov wrote:

> On Tue, Sep 09, 2008 at 04:17:36PM +0200, Johannes Schindelin wrote:
> >_
> > It might be safer to set the variable "amend" to empty before the "if".
> 
> OK. I have added it.
> 
>  git-rebase--interactive.sh |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 929d681..aaca915 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -427,14 +427,18 @@ do
>  		else
>  			. "$DOTEST"/author-script ||
>  				die "Cannot find the author identity"
> +			amend=""

Sorry, my mistake... I should have been more explicit.  In most (if not 
all) shell scripts, we prefer to set to the empty string with the 
expression

			amend=

Sorry to be nitting here, but I think it might be desirable in the long 
run to have consistent code style, as it makes it a bigger pleasure to 
work with the code.

Ciao,
Dscho
