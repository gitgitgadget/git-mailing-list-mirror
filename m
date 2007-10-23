From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH trailing ws fixed] use only the PATH for exec'ing git
	commands
Date: Tue, 23 Oct 2007 23:12:02 +0200
Message-ID: <20071023211202.GA729@steel.home>
References: <20071022170148.GB29642@srparish.net> <20071022190102.GA23714@steel.home> <20071023040844.GQ16291@srparish.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 23:12:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkR31-0003cI-0r
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 23:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbXJWVMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 17:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbXJWVMI
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 17:12:08 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:43905 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbXJWVMH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 17:12:07 -0400
Received: from tigra.home (Fa823.f.strato-dslnet.de [195.4.168.35])
	by post.webmailer.de (mrclete mo30) (RZmta 13.6)
	with ESMTP id n06093j9NI7gYN ; Tue, 23 Oct 2007 23:12:03 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 39B13277AE;
	Tue, 23 Oct 2007 23:12:03 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id BA7BB56D22; Tue, 23 Oct 2007 23:12:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071023040844.GQ16291@srparish.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTYQtQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62159>

Scott Parish, Tue, Oct 23, 2007 06:08:45 +0200:
> We need to correctly set up PATH for non-c based git commands. Since we
> already do this, we can just use that PATH and execvp, instead of looping
> over the paths with execve.
> 
> This patch adds a setup_path() function to exec_cmd.c, which sets
> the PATH order correctly for our search order. execv_git_cmd() is
> stripped down to setting up argv and calling execvp(). git.c's main()
> only only needs to call setup_path().
> 
> Signed-off-by: Scott R Parish <srp@srparish.net>

Acked-by: Alex Riesen <raa.lkml@gmail.com>

Don't forget to mention it needs the patch from Johannes re "deducing
exec_path from calls to git with a relative path" and your
"current_exec_path"-patch. Took me a while to figure these out...
