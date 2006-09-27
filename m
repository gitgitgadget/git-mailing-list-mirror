From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 11:09:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609271105430.3952@g5.osdl.org>
References: <20060927140918.65775.qmail@web51004.mail.yahoo.com>
 <Pine.LNX.4.64.0609270919220.3952@g5.osdl.org> <20060927200054.7a49b619.froese@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthew L Foster <mfoster167@yahoo.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 20:09:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSdqm-0001MS-FR
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 20:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWI0SJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 14:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030523AbWI0SJh
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 14:09:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27570 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030417AbWI0SJg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 14:09:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8RI9JnW017204
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Sep 2006 11:09:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8RI9I8O002392;
	Wed, 27 Sep 2006 11:09:18 -0700
To: Edgar Toernig <froese@gmx.de>
In-Reply-To: <20060927200054.7a49b619.froese@gmx.de>
X-Spam-Status: No, hits=-0.469 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27918>



On Wed, 27 Sep 2006, Edgar Toernig wrote:
> 
> Well, I would simply look at the filesystem's mtime of the commit object
> resp. the pack containing the commit.  IMHO good enough most of the time.

Nope. The moment you repack, you're toast. And if you don't repack, please 
don't use large repositories.

Here's a real-world example: in the week since 2.6.18 was released, the 
kernel has gotten over twenty _thousand_ new objects. If you don't repack, 
you'll have lost about 40MB of diskspace. It adds up.

So yes, mtime works for a bit. And then it stops working ;)

		Linus
