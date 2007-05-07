From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Mon, 7 May 2007 08:22:52 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705070821260.3802@woody.linux-foundation.org>
References: <200705012346.14997.jnareb@gmail.com> <Pine.LNX.4.64.0705020143460.4010@racer.site>
 <8fe92b430705020433v7ae5c117qdefccc791cd07fff@mail.gmail.com>
 <alpine.LFD.0.98.0705042049330.3819@woody.linux-foundation.org>
 <7vk5vl6oum.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, dev@tools.openoffice.org,
	Jan Holesovsky <kendy@suse.cz>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 07 17:24:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl54A-00027Q-Mb
	for gcvg-git@gmane.org; Mon, 07 May 2007 17:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934366AbXEGPXO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 11:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934365AbXEGPXO
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 11:23:14 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:60796 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934362AbXEGPXM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2007 11:23:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l47FMtwU005651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 7 May 2007 08:22:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l47FMqNE030782;
	Mon, 7 May 2007 08:22:52 -0700
In-Reply-To: <7vk5vl6oum.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.98 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46467>



On Mon, 7 May 2007, Junio C Hamano wrote:
> 
> Keeping fetched and updated refs in core and write a packed refs
> out in one go in git-fetch--tool (and later, git-fetch all in C)
> would be much simpler if we do not have to worry about existing
> refs (aka "git clone" special case); I am not sure if packing
> refs is desirable in general for incremental "git-fetch".

Fair enough. It's true that for the general case of "git fetch", it's much 
less obvious how to keep things packed.

So maybe the right thing really *is* to just add the

	git pack-refs --all --prune

to the git-clone wrapper.

		Linus
