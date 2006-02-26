From: Andrew Morton <akpm@osdl.org>
Subject: Re: the war on trailing whitespace
Date: Sat, 25 Feb 2006 21:07:12 -0800
Message-ID: <20060225210712.29b30f59.akpm@osdl.org>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 06:08:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDE8i-0008Kz-Fs
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 06:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWBZFIH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 00:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWBZFIH
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 00:08:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19946 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751199AbWBZFIG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 00:08:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1Q581DZ025544
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 25 Feb 2006 21:08:02 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k1Q580lD031120;
	Sat, 25 Feb 2006 21:08:01 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16770>

Junio C Hamano <junkio@cox.net> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > It's invariably pointless to add lines which have trailing whitespace. 
> > Nobody cares much, but my scripts spam me when it happens, so I've become
> > obsessive....
> 
> I do not call me obsessive, but I do enable pre-commit and
> pre-applypatch hooks I ship with git myself.

It's apparent that few others do this.

> > I realise that we cannot do this when doing git fetches, but when importing
> > patches and mboxes, git ought to whine loudly about input which matches the
> > above regexp, and it should offer an option to tidy it up.  Perhaps by
> > default.
> 
> I stole the policy the sample hook scripts use from you; it is
> not enabled by default, and as the tool manufacturer I am a bit
> reluctant to do so.
> 

It's not strong enough.  I mean, if you ask a developer "do you wish to add
new trialing whitespace to the kernel" then obviously their answer would be
"no".   So how do we help them in this?

I'd suggest a) git will simply refuse to apply such a patch unless given a
special `forcing' flag, b) even when thus forced, it will still warn and c)
with a different flag, it will strip-then-apply, without generating a
warning.
