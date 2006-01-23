From: Alexander Litvinov <lan@ac-sw.com>
Subject: Re: Notes on Subproject Support
Date: Mon, 23 Jan 2006 12:06:53 +0600
Organization: AcademSoft Ltd.
Message-ID: <200601231206.53466.lan@ac-sw.com>
References: <7v3bjfafql.fsf@assigned-by-dhcp.cox.net> <7v7j8r7e7s.fsf@assigned-by-dhcp.cox.net> <7v64ob1omh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 23 07:07:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0ur5-0006HN-Mk
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 07:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWAWGHE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jan 2006 01:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWAWGHE
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jan 2006 01:07:04 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:32685 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S964810AbWAWGHA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jan 2006 01:07:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP id 02BFDBD41;
	Mon, 23 Jan 2006 12:06:59 +0600 (NOVT)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25766-03; Mon, 23 Jan 2006 12:06:56 +0600 (NOVT)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP id C4BC1BD3B;
	Mon, 23 Jan 2006 12:06:56 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id C0C7D8DA036F; Mon, 23 Jan 2006 12:06:56 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id C6FFF8DA0360;
	Mon, 23 Jan 2006 12:06:53 +0600 (NOVT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8
In-Reply-To: <7v64ob1omh.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15078>

In our development we use a little bit other case (it is simplified):
1. We have self written C++ library for linked list implementation. Lets call 
it liblist.
2. We have project A that use liblist as separate directory and project B that 
use this library too.

Currently we have 3 cvs projects with cvs-modules for linking liblist to A and 
B. During development of A and B we often modify liblist to fix bugs and 
these changes are immidatly visible to all projects who use liblist.

After full implementation of bind functionality I see one restriction: I have 
to use one repo for storing all three projects: A, B and liblist to make 
changes of liblist visible to all projects. The solution is to make separate 
repos and on each change of liblist in prokect A push these changes to 
liblist repo and pull them into project B again - bit hacky solution.
