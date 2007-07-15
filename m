From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-config: replaces ~/.gitconfig symlink with real file
Date: Mon, 16 Jul 2007 00:30:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707160029120.14781@racer.site>
References: <f158199e0707151427h52da3e38rae3be6e44e27e918@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bradford Smith <bradford.carl.smith@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 01:31:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IADYO-0002aO-Fs
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 01:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762201AbXGOXal (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 19:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762189AbXGOXal
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 19:30:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:60403 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759979AbXGOXak (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 19:30:40 -0400
Received: (qmail invoked by alias); 15 Jul 2007 23:30:38 -0000
Received: from R04e1.r.pppool.de (EHLO noname) [89.54.4.225]
  by mail.gmx.net (mp047) with SMTP; 16 Jul 2007 01:30:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lHtQhFUvlLioJ01686gcbX/wqlIiCbgw+M/Gxaf
	EiuzGtBGS5S8OM
X-X-Sender: gene099@racer.site
In-Reply-To: <f158199e0707151427h52da3e38rae3be6e44e27e918@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52606>

Hi,

On Sun, 15 Jul 2007, Bradford Smith wrote:

> If I were to fix this, I'd be tempted to use realpath(3) to follow the 
> symlink, but I don't think it's very reliably available cross-platform.  
> Certainly, it isn't used anywhere in the current git code.  Can anyone 
> suggest a more portable fix?

I'd use readlink(2) and test for EINVAL to fall back to the current 
behaviour.

Hth,
Dscho
