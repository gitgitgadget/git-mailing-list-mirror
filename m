From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] binary-tree-based objects.
Date: Sat, 11 Feb 2006 22:53:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602112237580.3691@g5.osdl.org>
References: <87slqpg11q.fsf@wine.dyndns.org> <Pine.LNX.4.64.0602111803350.3691@g5.osdl.org>
 <7vslqpi9mg.fsf@assigned-by-dhcp.cox.net> <7vhd75fc6y.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602112045340.3691@g5.osdl.org> <Pine.LNX.4.64.0602112117560.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602112122400.3691@g5.osdl.org> <7v1wy9f7q4.fsf@assigned-by-dhcp.cox.net>
 <7vaccxdsaf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 12 07:53:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8B71-0008WB-C7
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 07:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWBLGxY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 01:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWBLGxY
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 01:53:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6123 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932251AbWBLGxX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 01:53:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1C6rHDZ008031
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 11 Feb 2006 22:53:18 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1C6rG5S029166;
	Sat, 11 Feb 2006 22:53:16 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vaccxdsaf.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15987>



On Sat, 11 Feb 2006, Junio C Hamano wrote:
> 
> It turns out that Johannes (with my patch to fix possible
> unsigned int alignment issue and the initial call to
> find_object()) is the clear winner.

Having looked at it, I will have to agree. Johannes' approach looks 
pretty clean, and has the same memory overhead mine has (two pointers per 
object in the hash - one used, one empty), but has a lot fewer memcmp() 
calls and pointer chasing.

So I'll growl softly but concur. Johannes' code isn't even very complex.

		Linus
