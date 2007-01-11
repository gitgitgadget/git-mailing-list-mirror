From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 12:03:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701111202250.3594@woody.osdl.org>
References: <20070111125726.GJ1759@mellanox.co.il>
 <Pine.LNX.4.64.0701111023090.3594@woody.osdl.org>
 <Pine.LNX.4.64.0701111109070.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 21:04:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H569N-000155-7f
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 21:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbXAKUDq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 15:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbXAKUDq
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 15:03:46 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59053 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456AbXAKUDp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 15:03:45 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0BK3SWi003605
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Jan 2007 12:03:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0BK3R5F001770;
	Thu, 11 Jan 2007 12:03:28 -0800
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <Pine.LNX.4.64.0701111109070.3594@woody.osdl.org>
X-Spam-Status: No, hits=-0.664 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36604>



On Thu, 11 Jan 2007, Linus Torvalds wrote:
> 
> I would suggest perhaps a patch like this..

Except you need to add a semicolon after the return:

> +		if (!written) {
> +			errno = ENOSPC;
> +			return -1

otherwise it looks fine. But I obviously didn't even compile-test the 
patch I sent out, so caveat emptor.

		Linus
