From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch documentation: non-zero exit status in
 command abort the filter
Date: Tue, 26 Feb 2008 11:18:39 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802261116570.17164@racer.site>
References: <1203992071-957-1-git-send-email-cmarcelo@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 12:19:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTxqa-0006cP-NT
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 12:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbYBZLTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 06:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753103AbYBZLTI
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 06:19:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:40558 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752669AbYBZLTG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 06:19:06 -0500
Received: (qmail invoked by alias); 26 Feb 2008 11:19:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 26 Feb 2008 12:19:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ASIUzpzcAQA0qjKcJG9P8iQ72i94pvMnQOXAt/k
	kT3zMlPhS9AEB9
X-X-Sender: gene099@racer.site
In-Reply-To: <1203992071-957-1-git-send-email-cmarcelo@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75120>

Hi,

On Mon, 25 Feb 2008, Caio Marcelo de Oliveira Filho wrote:

> Since commit 8c1ce0f46b85d40f215084eed7313896300082df filter-branch 
> fails when a <command> has a non-zero exit status. This commit makes it 
> clear in the documentation and also fixes the parent-filter example, 
> that was incorrectly returning non-zero when the commit being tested 
> wasn't the one to be rewritten.

I thought that we had that already in the man page, but you're right: we 
did not.

> ---------------------------------------------------------------------------
> +----------------------------------------------------------------------------
>  git filter-branch --parent-filter \
> -	'cat; test $GIT_COMMIT = <commit-id> && echo "-p <graft-id>"' HEAD
> ---------------------------------------------------------------------------
> +	'test $GIT_COMMIT = <commit-id> && echo "-p <graft-id>" || cat' HEAD
> +----------------------------------------------------------------------------

Yes, makes sense.

Ciao,
Dscho
