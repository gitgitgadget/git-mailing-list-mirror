From: Pedro Melo <melo@simplicidade.org>
Subject: git-svn and format.pretty = oneline
Date: Thu, 10 Apr 2008 17:04:29 +0100
Message-ID: <A6B16DB9-2DEA-44FC-8A36-BA979E49CD33@simplicidade.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 10 18:13:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjzNe-0006Lx-AG
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 18:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299AbYDJQLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 12:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755513AbYDJQLR
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 12:11:17 -0400
Received: from mail.sl.pt ([212.55.140.13]:44209 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752918AbYDJQLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 12:11:17 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Apr 2008 12:11:16 EDT
Received: (qmail 30949 invoked from network); 10 Apr 2008 16:04:34 -0000
Received: from unknown (HELO [10.0.0.5]) (melo@[195.23.56.60])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 10 Apr 2008 16:04:34 -0000
Received-SPF: none (mail-sl: domain of melo@simplicidade.org does not designate permitted sender hosts)
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79235>

Hi,

I was using  git-svn rebase today and I got this back:

Unable to determine upstream SVN information from working tree history

After looking through the code, I noticed that it calls the command

git log --no-color --first-parent

which gives this output with my config:

git-log --no-color --first-parent | head -
3300db99f4598ca9e532eb4a1f862c51fb0cef2af nova versao do schema. refs  
#204
1a4f243795430eafeff7c2c0715c7f1a6cc4fec5 Contratos de Publicidade:  
criar novo (pre-alpha). refs #205, #206, #207
dacd5141b4eaa8dcd8eeaf63eab28901309d0b50 Whitespace

The problem was that I had git-config format.pretty oneline earlier  
on and it seems to be incompatible with git-svn. Removing that config  
line worked.

Patch to force a --pretty=medium sent in following email.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
