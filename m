From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: sha1_to_hex() usage cleanup
Date: Wed, 3 May 2006 18:27:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605031826070.4086@g5.osdl.org>
References: <Pine.LNX.4.64.0605031717190.4086@g5.osdl.org>
 <7v1wvabp7a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 03:27:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbScg-0002qq-PR
	for gcvg-git@gmane.org; Thu, 04 May 2006 03:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWEDB1P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 21:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWEDB1P
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 21:27:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30377 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750723AbWEDB1P (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 21:27:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k441R9tH027217
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 May 2006 18:27:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k441R9wJ023051;
	Wed, 3 May 2006 18:27:09 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wvabp7a.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19546>



On Wed, 3 May 2006, Junio C Hamano wrote:
> 
> Makes sort of sense in that the callers still need to be aware
> of the magic 4 limit but as long as they are they do not have to
> worry about allocation/deallocation/copying.  But is that kind
> of cheat maintainable?  I dunno.

If we just tell people that the rule is that it's still a statically 
allocated buffer, but that you can magically use two "sha1_to_hex()" calls 
in the same printf(), we'll probably get a good mix of "usable and safe".

		Linus
