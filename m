From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] repack: allow simultaneous packing and pruning
Date: Tue, 10 Oct 2006 14:25:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610101423561.3952@g5.osdl.org>
References: <20061010102210.568341380D6@magnus.utsl.gen.nz>
 <Pine.LNX.4.64.0610100800490.3952@g5.osdl.org> <452BF8B3.5090305@tromer.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 23:27:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXP72-00031Z-PN
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 23:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWJJV0F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 17:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbWJJV0F
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 17:26:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33942 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030417AbWJJV0C (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 17:26:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9ALPnaX020293
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Oct 2006 14:25:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9ALPnqn024577;
	Tue, 10 Oct 2006 14:25:49 -0700
To: Eran Tromer <git2eran@tromer.org>
In-Reply-To: <452BF8B3.5090305@tromer.org>
X-Spam-Status: No, hits=-2.467 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28673>



On Tue, 10 Oct 2006, Eran Tromer wrote:
> 
> Too late: "git repack -a -d" already does it, in contradiction to its 
> manpage. It creates a new pack by following .git/refs, and then deletes 
> all old pack files.

That's very different.

That just means that you should not try to do two _concurrent_ repacks. 

> Don't run it on a shared repo, then. And grab a coffee while it runs.
> But why force leaf repositories to accumulate garbage?

Nobody forces that.

You can run "git prune" if you want to. But at least we know that "git 
prune" is unsafe.

			Linus
