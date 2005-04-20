From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: on when to checksum
Date: Wed, 20 Apr 2005 15:41:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504201539180.6467@ppc970.osdl.org>
References: <200504202225.PAA15992@emf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 00:36:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DONnF-0001MX-04
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 00:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVDTWjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 18:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVDTWjx
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 18:39:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:9928 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261723AbVDTWjw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 18:39:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KMdns4012304
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 15:39:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KMdm0H000561;
	Wed, 20 Apr 2005 15:39:48 -0700
To: Tom Lord <lord@emf.net>
In-Reply-To: <200504202225.PAA15992@emf.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Tom Lord wrote:
> 
> I think you have made a mistake by moving the sha1 checksum from the
> zipped form to the inflated form.  Here is why:

I'd have agreed with you (and I did, violently) if it wasn't for the
performance issues. It makes a huge difference for write-tree, and to me,
clearly performance _does_ matter.

Fractions of seconds may not sound like a lot, but they add up. I work 
with 200-patch series myself all the time, so I'm very sensitive to a 0.3 
second difference in performance.

		Linus
