From: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] show-diff shell safety
Date: Sat, 16 Apr 2005 18:00:55 -0700
Organization: SGI
Message-ID: <20050416180055.76cb8a25.pj@sgi.com>
References: <7vbr8e44u1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 02:57:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMy6O-0001V7-73
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 02:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVDQBBO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 21:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVDQBBO
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 21:01:14 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:44173 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261227AbVDQBBL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 21:01:11 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3H1OViT026519;
	Sat, 16 Apr 2005 18:24:31 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3H10xlU15249101;
	Sat, 16 Apr 2005 18:00:59 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr8e44u1.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio wrote:
> The command line for running "diff" command is built without
> taking shell metacharacters into account. 

Ack - you're right.  One should avoid popen and system
in all but personal hacking code.  There are many ways,
beyond just embedded shell redirection, to cause problems
with these calls.

One should directly code execve(), execv(), or execl().

Search for "popen system IFS PATH"

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
