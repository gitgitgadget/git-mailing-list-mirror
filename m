From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 2/2] make init-db use GIT_TEMPLATE_DIR if --template option is not specified
Date: Sat, 27 May 2006 15:25:54 +0200
Message-ID: <20060527132554.GC10488@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 15:25:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjynL-0001td-4M
	for gcvg-git@gmane.org; Sat, 27 May 2006 15:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWE0NZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 09:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWE0NZ2
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 09:25:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32933 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751514AbWE0NZ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 09:25:28 -0400
Received: (qmail 7525 invoked by uid 2001); 27 May 2006 15:25:54 +0200
To: Matthias Lederhofer <matled@gmx.net>
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20854>

Dear diary, on Sat, May 27, 2006 at 12:25:39PM CEST, I got a letter
where Matthias Lederhofer <matled@gmx.net> said that...
> f61e19360f9b5965dda1ae762ffdab8ede860430
> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index 2a1384c..cf5bd39 100644
> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c
> @@ -253,6 +253,9 @@ int cmd_init_db(int argc, const char **a
>  			die(init_db_usage);
>  	}
>  
> +	if (!template_dir)
> +		template_dir = getenv("GIT_TEMPLATE_DIR");
> +
>  	/*
>  	 * Set up the default .git directory contents
>  	 */

Please document such changes, in the spirit of

diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 8a150d8..378810e 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -15,6 +15,8 @@ OPTIONS
 -------
 --template=<template_directory>::
 	Provide the directory from which templates will be used.
+	If not specified, the value of the `GIT_TEMPLATE_DIR` environment
+	variable is used instead.
 	The default template directory is `/usr/share/git-core/templates`.
 
 --shared::

(Signed-off-by: Petr Baudis <pasky@suse.cz>, whatever...)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
