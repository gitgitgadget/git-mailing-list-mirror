From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-clone: don't unpack objects
Date: Wed, 19 Oct 2005 13:31:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510191327560.3369@g5.osdl.org>
References: <20051019154341.2aed6998.tihirvon@gmail.com>
 <7v4q7d5kwo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Timo Hirvonen <tihirvon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 22:33:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESKbZ-0002U7-AL
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 22:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVJSUcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 16:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVJSUcF
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 16:32:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54192 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751309AbVJSUcE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 16:32:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9JKVsFC003340
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 19 Oct 2005 13:31:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9JKVreR018486;
	Wed, 19 Oct 2005 13:31:54 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q7d5kwo.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10304>



On Wed, 19 Oct 2005, Junio C Hamano wrote:
> 
> Are there cases where you would do 'git clone' over git native
> transport and want the resulting pack expanded?

No, I think the unconditional --keep is fine for clone.

What to do about incremental pulls is not as clear, but I think the clone 
case is pretty much obvious these days.

The main reason for unpacking was that packs used to be "strange". These 
days, packs are arguably the _common_ thing.

Now, having tons and tons of small packs is probably worse than having 
tons and tons of individual files, but if people get used to doing 
occasional full repacks, that doesn't matter.

		Linus
