From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list feature request
Date: Thu, 9 Mar 2006 20:46:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603092035310.18022@g5.osdl.org>
References: <17424.53563.622642.738307@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0603091950360.18022@g5.osdl.org> <7vhd663owv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 05:46:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHZWi-0001gd-Al
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 05:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWCJEqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 23:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWCJEqx
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 23:46:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39563 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751356AbWCJEqw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 23:46:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2A4klDZ017024
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Mar 2006 20:46:48 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2A4kkBp000469;
	Thu, 9 Mar 2006 20:46:46 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd663owv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17448>



On Thu, 9 Mar 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > So phase 1 already exists and was the hard part. phase 2 is just walking 
> > the graph (that is now all in memory) from "cmit" using the "object->refs" 
> > reverse references that got built up during phase 1.
> 
> Eh,... what reverse references???

Heh. Exercise left to the reader. Right now we do only forward references 
(and rev-list.c actually turns that off, since it has no use for them). 

But doing reverse refs should be easy - in the same place we do the 
forward ones. I'd suggest making "track_object_refs == -1" mean "reverse 
refs".

(I think the only thing that uses forwards refs is fsck. Nobody else wants 
them, or would prefer the reverse kind - since forwards refs you can 
just look up yourself anyway).

		Linus
