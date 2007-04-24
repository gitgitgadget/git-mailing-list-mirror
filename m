From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH (WIP)] git-svn: cache SVN::Ra functions in a more Perl
 GC-friendly way
Date: Mon, 23 Apr 2007 17:50:20 -0700
Message-ID: <462D544C.8010206@midwinter.com>
References: <4623F613.5010108@midwinter.com> <20070417093743.GA9222@muzzle> <20070417094000.GA2778@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 02:50:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg9Ee-0000qz-By
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 02:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030988AbXDXAuV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 20:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031000AbXDXAuV
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 20:50:21 -0400
Received: from tater.midwinter.com ([216.32.86.90]:37551 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030988AbXDXAuV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 20:50:21 -0400
Received: (qmail 29185 invoked from network); 24 Apr 2007 00:50:20 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=Z6LuNJTxbZ0EE+2cxFGr9AchqTQtO1UN9YShfkj6grPrQR0JJS1HSxW2TNE8f+4J  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 24 Apr 2007 00:50:20 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <20070417094000.GA2778@muzzle>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45395>

FYI, with this patch, it actually dies more often. The stack seems to be 
corrupted so I can't give you a useful stack trace, but here's what gdb 
says:

Program received signal EXC_BAD_ACCESS, Could not access memory.
Reason: KERN_PROTECTION_FAILURE at address: 0x00000024
0x90002fe0 in strcmp ()
(gdb) where
#0  0x90002fe0 in strcmp ()
#1  0x004e2ac6 in get_private ()
Previous frame inner to this frame (corrupt stack?)

-Steve
