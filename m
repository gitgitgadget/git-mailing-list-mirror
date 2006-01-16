From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb on kernel.org broken
Date: Mon, 16 Jan 2006 19:53:42 +0100
Message-ID: <20060116185342.GA14088@vrfy.org>
References: <43CBE993.9060701@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 16 19:54:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyZUU-0005gY-Hi
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 19:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWAPSxx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 13:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWAPSxx
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 13:53:53 -0500
Received: from soundwarez.org ([217.160.171.123]:2457 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751159AbWAPSxw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2006 13:53:52 -0500
Received: by soundwarez.org (Postfix, from userid 2702)
	id 65B907C0D4; Mon, 16 Jan 2006 19:53:42 +0100 (CET)
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <43CBE993.9060701@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14751>

On Mon, Jan 16, 2006 at 10:44:35AM -0800, H. Peter Anvin wrote:
> It seems that gitweb throws an error every time.  This means that 
> nothing gets cached, and therefore the load on the kernel.org machines 
> is driven into the high double digits:
> 
> [Mon Jan 16 10:42:01 2006] [error] [client 82.181.110.11] [Mon Jan 16 
> 10:42:01 2006] index.cgi: Use of uninitialized value in scalar 
> assignment at /home/httpd/html/git/index.cgi line 411.
> [Mon Jan 16 10:42:03 2006] [error] [client 82.181.110.11] fatal: Not a 
> git repository: '/pub/scm/linux/hotplug/hotplug-ng.git'
> [Mon Jan 16 10:42:03 2006] [error] [client 82.181.110.11] [Mon Jan 16 
> 10:42:03 2006] index.cgi: Use of uninitialized value in scalar chomp at 
> /home/httpd/html/git/index.cgi line 406.
> [Mon Jan 16 10:42:03 2006] [error] [client 82.181.110.11] [Mon Jan 16 
> 10:42:03 2006] index.cgi: Use of uninitialized value in pattern match 
> (m//) at /home/httpd/html/git/index.cgi line 407.
> 
> This is all very bad...

Junio, seems your "textual symref HEAD" change is causing this?
  http://www.kernel.org/git/?p=git/gitweb.git;a=blob;hb=HEAD;f=gitweb.cgi#l399

Thanks,
Kay
