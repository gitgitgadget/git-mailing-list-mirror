From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Tue, 18 Apr 2006 17:47:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604181745410.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
 <7vy7y2csv8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604181735480.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 02:48:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW0rO-0008UN-31
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 02:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWDSArz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 20:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWDSArz
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 20:47:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15011 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750780AbWDSAry (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 20:47:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3J0lptH028355
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Apr 2006 17:47:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3J0lowY000493;
	Tue, 18 Apr 2006 17:47:50 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0604181735480.3701@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18894>



On Tue, 18 Apr 2006, Linus Torvalds wrote:
> 
> And I thought we already disallowed ':' in branch names because cogito 
> uses them for the strange <rev>:<rev> syntax.. 

Btw, pathnames with ':' in them aren't a problem. It's only revision
names that can't have ':' in them and still be used together with this 
syntax.

If you have a pathname with ':', it's fine to do

	git cat-file v1.2.4:pathname:with:colon

because the magic revision parsing only cares about the _first_ colon, and 
will split that into "v1.2.4" and "pathname:with:colon" without ever even 
looking at the other ones.

		Linus
