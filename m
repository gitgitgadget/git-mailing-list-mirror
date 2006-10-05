From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] pack-refs: use lockfile as everybody else does.
Date: Wed, 4 Oct 2006 19:55:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610041954480.3952@g5.osdl.org>
References: <7v7izhrc2v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 05 04:55:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVJOr-0006lV-T6
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 04:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWJECzu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 22:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWJECzu
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 22:55:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47232 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751333AbWJECzt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Oct 2006 22:55:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k952thaX018849
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 4 Oct 2006 19:55:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k952tgj2003060;
	Wed, 4 Oct 2006 19:55:42 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7izhrc2v.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.459 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28344>



On Tue, 3 Oct 2006, Junio C Hamano wrote:
> 
>  Also I am not sure about the "fsync(fd); fclose(refs_file)"
>  sequence I did not touch with this patch.  Doesn't stdio still
>  have stuff buffered when you run fsync()?  Would adding fflush()
>  in between help?

Yes, there should be a fflush() there before the fsync.

		Linus
