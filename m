From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 14:50:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281445280.18901@ppc970.osdl.org>
References: <200504271251.00635.mason@suse.com>  <200504280745.05505.mason@suse.com>
  <1114715496.4212.36.camel@localhost.localdomain>  <200504281658.39300.mason@suse.com>
 <1114723987.4212.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Mason <mason@suse.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 23:43:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRGmU-0006Hq-Su
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVD1VsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVD1VsS
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:48:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:6311 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262259AbVD1VsO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 17:48:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SLm9s4016289
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 14:48:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SLm8iD012716;
	Thu, 28 Apr 2005 14:48:09 -0700
To: Kay Sievers <kay.sievers@vrfy.org>
In-Reply-To: <1114723987.4212.51.camel@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Kay Sievers wrote:
> 
> Sure. But file-changes lists the commit:
>   c79bea07ec4d3ef087962699fe8b2f6dc5ca7754
> 
> when asked for:
>   "drivers/usb/core/usb.c"
> 
> and that file isn't touched there. Actually it lists merge-commits which
> are not related to the file.

It really _is_ touched by that commit. Look closer.

It has two parents: one that had already merged with Greg's USB tree, and 
one that had _not_ done so.

So whether it "modifies" the USB files or not really depends on which 
parent you go back. 

In general, you tend to want to ignore merge-nodes for looking at 
differences, but the differences are definitely there, and they are often 
vital (ie it's often _very_ important to know which side of a merge didn't 
change something).

		Linus
