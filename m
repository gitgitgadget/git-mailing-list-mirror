From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] pack-objects: reuse data from existing pack.
Date: Wed, 15 Feb 2006 19:55:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602151953290.916@g5.osdl.org>
References: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net> <7vbqx8m62q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 04:55:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9aF2-0002tk-9X
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 04:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWBPDzi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 22:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWBPDzh
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 22:55:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59292 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932199AbWBPDzh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2006 22:55:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1G3tXDZ028513
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 15 Feb 2006 19:55:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1G3tWJ6028551;
	Wed, 15 Feb 2006 19:55:32 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqx8m62q.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16267>



On Wed, 15 Feb 2006, Junio C Hamano wrote:
>
> When generating a new pack, notice if we have already the wanted
> object in existing packs.  If the object has a delitified
> representation, and its base object is also what we are going to
> pack, then reuse the existing deltified representation
> unconditionally, bypassing all the expensive find_deltas() and
> try_deltas() routines.

I bow down before you.

No ugly special-case caching, just automatically "the right thing", with 
very little overhead.

It just makes sense.

We have a winner.

		Linus
