From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Re: Gitk --all error when there are more than 797 refs in a repository
Date: Sat, 19 Sep 2009 10:07:22 +1000
Message-ID: <19124.8378.975976.347711@cargo.ozlabs.ibm.com>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com>
	<878wgcbb52.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Murphy, John" <john.murphy@bankofamerica.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Sep 19 02:55:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MooEs-0002YU-U1
	for gcvg-git-2@lo.gmane.org; Sat, 19 Sep 2009 02:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbZISAzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 20:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbZISAzM
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 20:55:12 -0400
Received: from ozlabs.org ([203.10.76.45]:57393 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbZISAzL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 20:55:11 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id E9E17B7B79; Sat, 19 Sep 2009 10:55:14 +1000 (EST)
In-Reply-To: <878wgcbb52.fsf@users.sourceforge.net>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128816>

Pat Thoyts writes:

> Tcl strings can eat all your memory. However, there is a limit to the
> size of the command line argument passed to CreateProcess.  MSDN says
> of the lpCommandLine parameter:
>   "The maximum length of this string is 32K characters."
> A solution for this case will be to use a pipe to read the responses
> instead of having it all returned to the caller.
> The following patch might be sufficient:

I knew about the 32k command-line limit under windows, but I don't see
how that applies in this case unless it is $revs that is too long (and
if that is the case then I don't see how your patch helps).  Is there
also a 32k limit on the size of data returned by a command executed
with [exec]?

Paul.
