From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: git-p4, msysgit, and crlf
Date: Fri, 11 Apr 2008 10:34:17 -0400
Message-ID: <20080411103417.xbu855kqasgw80gc@intranet.digizenstudio.com>
References: <20080410175338.1z2hb82xw4kk4k0o@intranet.digizenstudio.com>
	<1a6be5fa0804110412v5e11e761xfdf4d4c7d8545661@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 16:35:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkKLO-0005MB-1J
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 16:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760207AbYDKOeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 10:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760208AbYDKOeZ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 10:34:25 -0400
Received: from k2smtpout04-02.prod.mesa1.secureserver.net ([64.202.189.173]:40933
	"HELO k2smtpout04-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760207AbYDKOeY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Apr 2008 10:34:24 -0400
Received: (qmail 4582 invoked from network); 11 Apr 2008 14:34:23 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout04-02.prod.mesa1.secureserver.net (64.202.189.173) with ESMTP; 11 Apr 2008 14:34:23 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 2B7BB100BC1;
	Fri, 11 Apr 2008 14:34:23 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id obA7Mx2z24lF; Fri, 11 Apr 2008 10:34:17 -0400 (EDT)
Received: by ip-72-167-33-213.ip.secureserver.net (Postfix, from userid 48)
	id B6516100CAE; Fri, 11 Apr 2008 10:34:17 -0400 (EDT)
Received: from mailrelay3.private.geico.com (mailrelay3.private.geico.com
	[205.143.204.110]) by intranet.digizenstudio.com (Horde MIME library) with
	HTTP; Fri, 11 Apr 2008 10:34:17 -0400
In-Reply-To: <1a6be5fa0804110412v5e11e761xfdf4d4c7d8545661@mail.gmail.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79275>



Quoting Tor Arvid Lund <torarvid@gmail.com>:

> Well, I'm no expert, but I'll try:

Thanks. :-)

> I think if you have the core.autocrlf config option set to true, it
> should automatically convert line endings to CRLF for you when
> checking out files to your working dir, and converting it back to LF
> when committing. [snipped]

I did try exactly that - actually I tried explicitly setting it either  
way, and neither worked.  At any rate, the files in my case _have_  
CRLF in perforce, and what I want to achieve is really just to have  
everybody leave them alone, i.e., no conversions whatsoever. :-)

 From my code reading, core.autocrlf doesn't seem to be referenced  
anywhere in git-p4 anyways. In fact, besides the p4 -G issue I  
described in my first post, git-p4 itself also seems to always convert  
"\r\n" to "\n" on any Windows text files (in method P4Sync.commit()),  
prior to send them to git-fast-import.

And git-fast-import doesn't really do any conversion. The commit data  
it receives is always treated as binary (which is good). So it seems  
to me that the core git is off the hook here.

Cheers.
-- 
Jing Xue
