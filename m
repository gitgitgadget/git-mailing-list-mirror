From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling merge conflicts a bit more gracefully..
Date: Wed, 8 Jun 2005 17:41:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506081738000.2286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
 <7vis0o30sc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
 <7vzmu01jmc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 02:43:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgB81-0003xh-76
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 02:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVFIApJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 20:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVFIAkj
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 20:40:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:12433 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262228AbVFIAkA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 20:40:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j590dqjA008978
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Jun 2005 17:39:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j590do4O028575;
	Wed, 8 Jun 2005 17:39:51 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmu01jmc.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 8 Jun 2005, Junio C Hamano wrote:
> 
> I do not think you can, unless you are willing to parse shell
> error messages, which I do not want you to be willing to ;-).

Yeah, no. 

> I think you have a bigger problem of leading paths, BTW.

Gotcha. I committed a largely untested fix that hopefully does this all 
right.

I'm currently using your suggested thing (inside a function), but I think 
I'll instead make it do

	git-update-cache --add --cacheinfo ... &&
		git-checkout-cache -u -f "$4"

which seems even simpler.

		Linus
