From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add a test-case for git-apply trying to add an ending
 line
Date: Tue, 23 May 2006 19:17:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605231916210.5623@g5.osdl.org>
References: <20060523214836.22628.2179.stgit@localhost.localdomain>
 <7vd5e4z2je.fsf@assigned-by-dhcp.cox.net> <7vhd3gxm73.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605231905470.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 04:18:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fiiwe-00068J-IL
	for gcvg-git@gmane.org; Wed, 24 May 2006 04:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWEXCRy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 22:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWEXCRy
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 22:17:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13477 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932550AbWEXCRx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 22:17:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4O2HktH008666
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 May 2006 19:17:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4O2Hiuc029847;
	Tue, 23 May 2006 19:17:45 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0605231905470.5623@g5.osdl.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20658>



On Tue, 23 May 2006, Linus Torvalds wrote:
>
> +	/*
> +	 * If we don't have any trailing data in the patch,
> +	 * we want to match the final ending '\0' byte in
> +	 * the file too..
> +	 */

Btw, ignore the comment. I was thinking of doing the matching differently 
(just make the source buffer include a '\0' at the end, and forcing that 
to match), but once I actually wrote it, it ended up being much easier to 
just check the offset/size difference.

So that "final ending '\0' byte in the file" part of the comment is just 
nonsense.

		Linus
