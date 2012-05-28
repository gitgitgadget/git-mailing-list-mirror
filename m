From: nguyenhu@minatec.inpg.fr
Subject: Re: [PATCH 1/2] Add possibility to store configuration in
 ~/.config/git/config file
Date: Mon, 28 May 2012 18:16:50 +0200
Message-ID: <20120528181650.Horde.R4mBK3wdC4BPw6Ty4V8EreA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
Cc: git@vger.kernel.org
To: jaseemabid@gmail.com
X-From: git-owner@vger.kernel.org Mon May 28 18:17:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ2ct-00061a-IT
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 18:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656Ab2E1QQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 12:16:55 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:47340 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753252Ab2E1QQy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 May 2012 12:16:54 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 5BCF71A0275;
	Mon, 28 May 2012 18:16:51 +0200 (CEST)
Received: from 183.24.91.79.rev.sfr.net (183.24.91.79.rev.sfr.net
 [79.91.24.183]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Mon, 28 May 2012 18:16:50 +0200
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198709>


jaseem abid <jaseemabid@gmail.com>wrote:
> If a new config file gets introduced at `~/.config/git/config`, what
> will be the new order of config file precedence?
>
> `/etc/gitconfig` > `~/.gitconfig` > `~/.config/git/config`  >  
> `.git/config` or
> `/etc/gitconfig` >  `~/.config/git/config` > `~/.gitconfig` > `.git/config` ?
>
> What will be the new flag to access it? I mean anything new like
> --system / --global going to be introduced?

The new order would be:
`/etc/gitconfig` >  `~/.config/git/config` > `~/.gitconfig` > `.git/config`

There won't be new flag to access it.
You can access it with --global only if ~/.gitconfig doesn't exist.

But I will try to create another patch _only_ for reading first. So if  
git doesn't find a value in ~/.gitconfig or if this file doesn't  
exist, git will search this value in ~/.config/git/config if this file  
exists.
But for the time being, I don't know how to do it.
