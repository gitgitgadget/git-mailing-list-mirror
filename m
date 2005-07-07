From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] rev-list: add "--objects=self-sufficient" flag.
Date: Thu, 7 Jul 2005 16:58:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
 <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz>
 <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
 <7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 01:58:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqgGE-0007OT-Ev
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 01:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVGGX6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 19:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbVGGX6X
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 19:58:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262103AbVGGX6V (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 19:58:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j67NwEjA025336
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 7 Jul 2005 16:58:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j67NwDnv001793;
	Thu, 7 Jul 2005 16:58:13 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 7 Jul 2005, Junio C Hamano wrote:
>
> -		if (!strcmp(arg, "--objects")) {
> +		if (!strncmp(arg, "--objects", 9)) {
> +			if (!strcmp(arg+9, "=self-sufficient"))
> +				objects_self_sufficient = 1;

This is nasty - if you mis-spell "self-sufficient" (easy enough to do) 
you'll never know the end result isn't what you expected. It won't warn 
you in any way, it will just make a non-self-sufficient pack..

		Linus
