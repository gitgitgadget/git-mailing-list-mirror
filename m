From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] Custom low-level merge driver support.
Date: Wed, 18 Apr 2007 09:16:31 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704180910120.2828@woody.linux-foundation.org>
References: <11768880622402-git-send-email-junkio@cox.net>
 <Pine.LNX.4.64.0704181247410.12094@racer.site>
 <20070418153445.GC12888@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 18:17:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeCq3-0005GW-Fk
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 18:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992812AbXDRQQy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 12:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992809AbXDRQQy
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 12:16:54 -0400
Received: from smtp.osdl.org ([65.172.181.24]:37042 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992797AbXDRQQx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 12:16:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3IGGWYC019549
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Apr 2007 09:16:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3IGGVWP028958;
	Wed, 18 Apr 2007 09:16:31 -0700
In-Reply-To: <20070418153445.GC12888@admingilde.org>
X-Spam-Status: No, hits=-0.965 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44909>



On Wed, 18 Apr 2007, Martin Waitz wrote:
>
> > 	[merge.driver]
> > 		ancient = merge %A %O %B
> 
> or
> 
> [merge "ancient"]
> 	driver = merge %A %O %B

Much better. That format also allows you to add extra flags if you want. 

For example, it might be useful to add something like

	[merge "ancient"]
		name = external three-way merge
		driver = merge %A %O %B

so that you could make the merge process actually say what it is doing 
when it's merging things. Wouldn't it be nice to see

	merging file xyzzy using external three-way merge
	merging file fax.doc using word file merge
	..

when these things trigger?

So even if we do *not* care about the name, this kind of config structure 
is just more flexible. 

		Linus
