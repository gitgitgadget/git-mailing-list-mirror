From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: CFT: merge-recursive in C
Date: Mon, 26 Jun 2006 17:07:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606261704390.3927@g5.osdl.org>
References: <20060626233838.GA3121@steel.home> <Pine.LNX.4.64.0606261652350.3927@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 02:07:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv16r-0001qy-GW
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 02:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933150AbWF0AHN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 20:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933280AbWF0AHM
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 20:07:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933150AbWF0AHK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jun 2006 20:07:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5R073nW017020
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Jun 2006 17:07:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5R07227005831;
	Mon, 26 Jun 2006 17:07:03 -0700
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0606261652350.3927@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22699>



On Mon, 26 Jun 2006, Linus Torvalds wrote:
> 
> git-diff-tree is one of the simplest git operations. We've got absolutely 
> _tons_ of infrastructure in place to do it efficiently, since it's done 
> all over the map (a "git-rev-list" with path limiting will do a diff-tree 
> against all the commits).

Side note - I think merge-recursive could/should be rewritten to use 
"git-merge-tree" instead of "git-read-tree -u -m". I suspect that the 
git-merge-tree output is in fact a lot closer to what git-merge-recursive 
actually wants to have.

			Linus
