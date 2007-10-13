From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Port builtin-add.c to use the new option parser.
Date: Sat, 13 Oct 2007 15:47:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710131544030.25221@racer.site>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org>
 <1192282153-26684-2-git-send-email-madcoder@debian.org>
 <1192282153-26684-3-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Oct 13 16:47:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgiHP-0002HZ-Q1
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 16:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762367AbXJMOra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 10:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762521AbXJMOr2
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 10:47:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:60083 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762729AbXJMOrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 10:47:25 -0400
Received: (qmail invoked by alias); 13 Oct 2007 14:47:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 13 Oct 2007 16:47:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19vJAQu1vRvdPEauurTs5/H6P5nkBB7jlP5XWL6dd
	05RtlvP49rP9oJ
X-X-Sender: gene099@racer.site
In-Reply-To: <1192282153-26684-3-git-send-email-madcoder@debian.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 13 Oct 2007, Pierre Habouzit wrote:

> +static struct option builtin_add_options[] = {
> +	OPT_BOOLEAN('i', "interactive", &add_interactive, "interactive picking"),
> +	OPT_BOOLEAN('n', NULL, &show_only, "dry-run"),
> +	OPT_BOOLEAN('f', NULL, &ignored_too, "allow adding otherwise ignored files"),
> +	OPT_BOOLEAN('v', NULL, &verbose, "be verbose"),
> +	OPT_BOOLEAN('u', NULL, &take_worktree_changes, "update only files that git already knows about"),
> +	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh stat() informations in the index"),
> +};

I see you terminate the list by a ",".  How does this play with the option 
parser?

Thinking about this more, I am reverting my stance on the ARRAY_SIZE() 
issue.  I think if you introduce a "OPTION_NONE = 0" in the enum, then 
this single last comma should be enough.

In the same vein, you would not need the NULL in builtin_add_usage[], 
right?

Ciao,
Dscho
