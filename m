From: Chris Wright <chrisw@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.11.3
Date: Thu, 9 Jun 2005 13:55:03 -0700
Message-ID: <20050609205503.GJ5324@shell0.pdx.osdl.net>
References: <20050609091909.GF29665@pasky.ji.cz> <42A81584.90605@antselovich.com> <42A83F0C.5020809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Konstantin Antselovich <konstantin@antselovich.com>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jun 09 22:53:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgU01-0001YC-TA
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 22:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbVFIUza (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 16:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVFIUza
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 16:55:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10976 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262464AbVFIUzX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 16:55:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j59Kt4jA004053
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Jun 2005 13:55:04 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j59Kt3BC021096;
	Thu, 9 Jun 2005 13:55:03 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j59Kt3dV021095;
	Thu, 9 Jun 2005 13:55:03 -0700
To: Dan Holmsand <holmsand@gmail.com>
Content-Disposition: inline
In-Reply-To: <42A83F0C.5020809@gmail.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Dan Holmsand (holmsand@gmail.com) wrote:
> Konstantin Antselovich wrote:
> >I have updated to Cogito-0.11.3, it compiles and runs
> >but make test returns multiple error messages (see below)
> 
> There's a typo in rev-list.c. This fixes the tests for me:

This patch is white space damaged.  I fixed it, and added it to the
cogito-0.11.3 rpm.  Below is the refreshed patch.

thanks,
-chris
--

From: Dan Holmsand <holmsand@gmail.com>

There's a typo in rev-list.c. This fixes the tests for me:

diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -218,7 +218,7 @@ int main(int argc, char **argv)
 			list = limit_list(list);
 		show_commit_list(list);
 	} else {
-#ifdef NO_OPENSSL
+#ifndef NO_OPENSSL
 		if (sort_list_in_merge_order(list, &process_commit)) {
 			  die("merge order sort failed\n");
 		}
