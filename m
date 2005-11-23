From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Cogito documentation updates
Date: Wed, 23 Nov 2005 09:29:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511230923131.13959@g5.osdl.org>
References: <20051120101112.GA2302@diku.dk> <86veyn49gc.fsf@blue.stonehenge.com>
 <20051123121651.GB19302@diku.dk> <8664qjph7d.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonas Fonseca <fonseca@diku.dk>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 18:32:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeyRK-0002ig-9Z
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 18:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVKWR3r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 12:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVKWR3r
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 12:29:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59072 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751264AbVKWR3q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 12:29:46 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jANHTanO030565
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 23 Nov 2005 09:29:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jANHTYx0013233;
	Wed, 23 Nov 2005 09:29:35 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <8664qjph7d.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12640>



On Wed, 23 Nov 2005, Randal L. Schwartz wrote:
> 
> Delete the -d switch, or explain to me why it is there, and let's work
> out a POSIX workaround.

It's

       -d:     same as --no-dereference --preserve=link

       --no-dereference
              never follow symbolic links

       --preserve[=ATTR_LIST]
              preserve   the   specified   attributes   (default:  mode,owner-
              ship,timestamps) and security contexts, if  possible  additional
              attributes: links, all

so it's basically making sure that the copy copies the _link_, not the 
file it points to.

I think you may have to use "cpio -p" instead of "cp" to be portable. 
Something like

	cpio -plmu $src $dst

might do it.

		Linus
