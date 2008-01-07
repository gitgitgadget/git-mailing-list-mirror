From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk dev branch: F5 gives error after commit
Date: Tue, 8 Jan 2008 08:35:03 +1100
Message-ID: <18306.39687.333117.276550@cargo.ozlabs.ibm.com>
References: <478258B6.20006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 07 22:36:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBzde-0001jl-Qq
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 22:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760065AbYAGVfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 16:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759797AbYAGVfM
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 16:35:12 -0500
Received: from ozlabs.org ([203.10.76.45]:40126 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759345AbYAGVfK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 16:35:10 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 1889FDDE9A; Tue,  8 Jan 2008 08:35:09 +1100 (EST)
In-Reply-To: <478258B6.20006@viscovery.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69812>

Johannes Sixt writes:

> I use the dev branch of gitk (on Windows), commit 476ca63 (gitk: Index
> [fnvr]highlights by id rather than row).
> 
> 1. Start it with:
> 
>     gitk --all -300
> 
> 2. Make a commit.
> 3. Hit F5. Here I see the error message:
> 
>    Error reading commits:
>    fatal: bad revision '^-300'

This happens because I naively thought 'git rev-parse --revs-only'
would only give me SHA1 IDs.  But in any case gitk (on the dev branch)
doesn't really do anything much to handle commit selection flags that
can't be turned into SHA1 IDs (possibly negated).

Thanks for testing.  I'll fix it.

Paul.
