From: Tzafrir Cohen <tzafrir.cohen@xorcom.com>
Subject: git-svn and http client-side certificates
Date: Sat, 31 May 2008 10:42:42 +0300
Organization: Xorcom*
Message-ID: <20080531074240.GA13780@xorcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 31 10:13:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2MDJ-0007CW-BY
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 10:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbYEaIM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 04:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbYEaIM1
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 04:12:27 -0400
Received: from local.xorcom.com ([62.90.10.53]:34247 "EHLO local.xorcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbYEaIMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 04:12:25 -0400
X-Greylist: delayed 1778 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 May 2008 04:12:25 EDT
Received: by local.xorcom.com (Postfix, from userid 1000)
	id B84361DDC4; Sat, 31 May 2008 10:42:43 +0300 (IDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83367>

Hi

How do I make git-svn authenticate with client-side certificates?

Using strace, I can see that it reads my ~/.subversion/servers file and 
checks my (encrypted) certificate. But then ssl_client_cert_pw is called
rather than ssl_client_cert (both are from Git::SVN::Prompt).

I couldn't find any useful hints.

I had a similar problem with Svk. I ended up patching SVN::Mirror::Ra to
behave differently in the presence of a specific environment variable,
which is quite non-elegant: the subversion client should know when to
use a certificate.

-- 
               Tzafrir Cohen
icq#16849755              jabber:tzafrir.cohen@xorcom.com
+972-50-7952406           mailto:tzafrir.cohen@xorcom.com
http://www.xorcom.com  iax:guest@local.xorcom.com/tzafrir
