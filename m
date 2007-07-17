From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-config: replaces ~/.gitconfig symlink with real file
Date: Tue, 17 Jul 2007 17:09:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707171708210.14781@racer.site>
References: <f158199e0707151427h52da3e38rae3be6e44e27e918@mail.gmail.com>
 <tnx4pk39mju.fsf@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bradford Smith <bradford.carl.smith@gmail.com>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 18:10:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IApcq-00011o-Kz
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 18:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758994AbXGQQKI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 12:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758001AbXGQQKG
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 12:10:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:34487 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753051AbXGQQKF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 12:10:05 -0400
Received: (qmail invoked by alias); 17 Jul 2007 16:10:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 17 Jul 2007 18:10:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jZ8sKAZcj/5dSrwCLRDtVkW1TSuv9eS98WsLl3f
	PE9uTSN9oPXQBh
X-X-Sender: gene099@racer.site
In-Reply-To: <tnx4pk39mju.fsf@arm.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52766>

Hi,

On Tue, 17 Jul 2007, Catalin Marinas wrote:

> "Bradford Smith" <bradford.carl.smith@gmail.com> wrote:
> > However, when I tried running 'git-config --global color.diff auto'
> > today, it removed my symlink and replaced it with a real file.  This
> > left me briefly a bit confused when the changes I had made didn't show
> > up in ~/etc/gitconfig, but git-config reported them anyway.
> 
> Another problem I have with 'git config --global' is that it changes
> the access permission bits of ~/.gitconfig. Since I use the same file
> to store global StGIT configuration like SMTP username and password,
> I'd like to make its access 0600 but it always goes back to 0644 after
> 'git config --global'.
> 
> Maybe fixing the symlink case would solve my problem as well.

More likely not.  The way to solve it would be to follow the link if the 
target path is one.  As such, the _file_ would be rewritten.

So your problem is unrelated, and would need a separate fix.

Ciao,
Dscho
