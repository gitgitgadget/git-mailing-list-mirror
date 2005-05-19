From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 10:31:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505191029331.2322@ppc970.osdl.org>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org> <7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 19:31:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYopa-0006ks-9z
	for gcvg-git@gmane.org; Thu, 19 May 2005 19:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVESR3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 13:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVESR3t
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 13:29:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:30179 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261178AbVESR3k (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 13:29:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4JHTYU3032661
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 May 2005 10:29:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4JHTYPZ031758;
	Thu, 19 May 2005 10:29:34 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 19 May 2005, Junio C Hamano wrote:
> 
>  - I have been assuming that diff_delta uses its two input
>    read-only but have not verified that myself yet.

Since test-delta uses mmap(PROT_READ), we'd get SIGSEGV if diff_delta 
actually wrote to the thing. So this is a safe assumption.

		Linus
