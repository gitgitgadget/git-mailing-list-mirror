From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: EAGAIN?
Date: Mon, 19 Dec 2005 11:46:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512191142410.4827@g5.osdl.org>
References: <7vhd95h02o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 20:48:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoQyI-0006oK-Nr
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 20:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVLSTqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 14:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbVLSTqy
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 14:46:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51846 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964912AbVLSTqx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Dec 2005 14:46:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBJJkcDZ030439
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Dec 2005 11:46:38 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBJJkbcP009164;
	Mon, 19 Dec 2005 11:46:37 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd95h02o.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13834>



On Mon, 19 Dec 2005, Junio C Hamano wrote:
> 
> I was looking at "git grep -n EAGAIN" output and found that many
> places check "errno == EAGAIN" without checking "errno ==
> EINTR", both for read(2) and write(2).

I suspect it's mostly in my code. It's a stupid quirk of mine.

You might as well delete those thing, but yes, if you want to replace them 
with testing both EAGAIN and EINTR, go right ahead.

			Linus
