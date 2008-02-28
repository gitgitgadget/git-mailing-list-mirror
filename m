From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 22/40] Windows: Implement asynchronous functions as threads.
Date: Thu, 28 Feb 2008 22:01:06 +0100
Message-ID: <200802282201.06802.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-23-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281525510.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 22:02:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUpsx-0006v3-RE
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 22:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760195AbYB1VBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 16:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760070AbYB1VBJ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 16:01:09 -0500
Received: from smtp1.srv.eunet.at ([193.154.160.119]:51166 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760051AbYB1VBI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 16:01:08 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 3EDD233EC6;
	Thu, 28 Feb 2008 22:01:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0961A5B9E3;
	Thu, 28 Feb 2008 22:01:07 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0802281525510.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75457>

On Thursday 28 February 2008 16:28, Johannes Schindelin wrote:
> Hi,
>
> On Wed, 27 Feb 2008, Johannes Sixt wrote:
> > In upload-pack we must explicitly close the output channel of rev-list.
> > (On Unix, the channel is closed automatically because process that runs
> > rev-list terminates.)
>
> When I read this patch, my impression was that it litters the source code
> with #ifdef's.  IMO this makes the code less readable, and as a
> consequence easer to fsck up.
>
> Unfortunately, I have no idea how to help that, other than implementing
> compat/thread.[ch], abstracting the thread functions, and introducing a
> NO_FORK Makefile variable and preprocessor constant.
>
> Hmpf.

The number of #ifdef/#endif is already at a minimum unless you are willing to 
have entire functions in separate #ifdef/#else/#endif branches. Whether to 
have compat/thread.[ch] or not is just a question of whether you want to have 
asynchronous functions in threads also on Unix or not.

-- Hannes
