From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH/RFH] send-pack: fix pipeline.
Date: Sun, 31 Dec 2006 11:56:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612311155080.4473@woody.osdl.org>
References: <7v1wmjoumq.fsf@assigned-by-dhcp.cox.net> <7vzm96latb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612291307520.4473@woody.osdl.org> <7v1wmgfm4s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 20:56:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H16n5-0002Lx-Ic
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 20:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770AbWLaT4Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 14:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933206AbWLaT4Q
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 14:56:16 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51958 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932770AbWLaT4P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 14:56:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBVJuB2J025100
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 31 Dec 2006 11:56:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBVJuBl2015974;
	Sun, 31 Dec 2006 11:56:11 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wmgfm4s.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-1.178 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.165 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35706>



On Sun, 31 Dec 2006, Junio C Hamano wrote:
> 
> Thanks.  How about this?

Looks good to me. It should hopefully speed things up too, since now we 
don't need to first walk the whole object list and then _re-walk_ it when 
packing to get the size.

		Linus
