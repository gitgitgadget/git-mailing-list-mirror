From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 17:33:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506221729520.11175@ppc970.osdl.org>
References: <42B9E536.60704@pobox.com> <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 02:26:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlFXY-0002xI-Qc
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 02:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVFWAb6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 20:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVFWAb6
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 20:31:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51598 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261878AbVFWAbp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 20:31:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5N0V9jA006709
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 17:31:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5N0V8It015784;
	Wed, 22 Jun 2005 17:31:08 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <Pine.LNX.4.58.0506221603120.11175@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 22 Jun 2005, Linus Torvalds wrote:
> 
> A few notes on these things:
> 
> 	git-apply --index /tmp/my.patch
> 
> will not only apply the patch (unified patches only!), but will do the
> index updates for you while it's at it, so if the patch contains new files
> (or it deletes files), you don't need to worry about it.

Btw, if the patch contains rename/copy-patches or mode updates, you _need_
to use git-apply, since regular "patch" doesn't know about file modes and
can't handle file renames or copies.

Now, the rename/copy patches are easy to avoid by just not asking git to
generate them (so they'll show up as just straight file creates, with a
delete of the old file for a rename), but the file mode part in particular
is useful as more than just a way to create smaller (and more
human-readable) patches.

		Linus
