From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: GIT - breaking backward compatibility
Date: Mon, 19 Sep 2005 21:33:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509192131260.2553@g5.osdl.org>
References: <7vpsr4cx0f.fsf@assigned-by-dhcp.cox.net> <432F8C33.5080603@didntduck.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 06:33:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHZoq-0003Bh-O8
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 06:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVITEdW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 00:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbVITEdW
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 00:33:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16359 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964881AbVITEdV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 00:33:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8K4XGBo002180
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 21:33:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8K4XFZm002366;
	Mon, 19 Sep 2005 21:33:16 -0700
To: Brian Gerst <bgerst@didntduck.org>
In-Reply-To: <432F8C33.5080603@didntduck.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8971>



On Tue, 20 Sep 2005, Brian Gerst wrote:
> 
> Essentially what I want to do is:
> 
> git-ls-files --others | xargs git-update-index --add --
> git-ls-files --deleted | xargs git-update-index --remove --
> git-ls-files --modified | xargs git-update-index --
> 
> This will completely resync the index and cache to the working tree 
> state after applying a patch.

It will also be extremely inefficient.

If you really have a _patch_, then "git-apply --index" is what you want to 
apply it with. It applies a patch _and_ updates the index as appropriate. 
It's how git-applymbox can apply hundreds of patches in short order.

		Linus
