From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Kill the useless progress meter in merge-recursive
Date: Fri, 20 Apr 2007 08:14:20 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704200811470.9964@woody.linux-foundation.org>
References: <20070420063718.GA8424@spearce.org>
 <7vd51z317c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 17:14:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Heuom-0007Qt-SN
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 17:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992865AbXDTPOd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 11:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993034AbXDTPOd
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 11:14:33 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:45918 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2992865AbXDTPOc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2007 11:14:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3KFENQn028980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Apr 2007 08:14:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3KFEKqw016967;
	Fri, 20 Apr 2007 08:14:21 -0700
In-Reply-To: <7vd51z317c.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-5.038 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45111>



On Fri, 20 Apr 2007, Junio C Hamano wrote:
> 
> I would propose removing the progress meter for "Checking out
> files" in unpack-trees, for the same reason.

Have you tried this with something like the kernel on a 128MB machine, or 
over NFS? Or, indeed, if you just do

	echo 5 > /proc/sys/vm/dirty_background_ratio
	echo 2 > /proc/sys/vm/dirty_ratio

or similar, to tell the kernel to not allow a lot of dirty files.

No, I've not tried it either, but you may think that checking files out is 
fast just because you're actually just writing to memory, and the 
background writeout will do the real work. That isn't always true. 
Checking files out can be very expensive indeed.

		Linus
